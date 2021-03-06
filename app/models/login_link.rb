# frozen_string_literal: true

module LoginLink
  def self.create!(email)
    auht_code = AuthCode.create!

    url = Rails.application.routes.url_helpers.verify_email_url(email:, code: auht_code.code)

    SignedURL.call(url, key: Lens::Config.signed_url_secret)
  end

  def self.valid?(signed_url)
    return unless SignedURL.verified?(signed_url, key: Lens::Config.signed_url_secret)

    uri = URI(signed_url)
    params = Rack::Utils.parse_query(uri.query)

    return unless params['code']

    code_digest = AuthCode.keyring.digest(params['code'])

    auth_code = AuthCode.lock.find_by(code_digest:)

    return unless auth_code
    return if auth_code.expired?

    matched = ActiveSupport::SecurityUtils.secure_compare(params['code'], auth_code.code)

    auth_code.destroy!

    matched
  end
end
