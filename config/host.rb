# frozen_string_literal: true

Rails.env.on(:development) do
  config.hosts << 'ari.dev'
end
