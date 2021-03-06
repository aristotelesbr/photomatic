# frozen_string_literal: true

module Lens
  Config =
    SuperConfig.new(raise_exception: false) do
      mandatory :tz, string
      credential :encryptor_secret
      credential :signed_url_secret
      credential :auth_code_encryption_key
      credential :auth_code_digest_salt
      credential :user_encryption_key
      credential :user_digest_salt
      mandatory :database_url, string
      optional :app_host, string, 'example.com'
      optional :default_email_sender, string, 'hi@example.com'
      optional :force_ssl, bool, true
      optional :email_verification_ttl, int, 10.minutes
    end

  public_constant :Config
end
