# frozen_string_literal: true

SendGridClient.setup do |config|
  # Ensure you have these ENV variables from your SendGrid settings
  # Or update the following three lines with your own values if ENV variables aren't used
  config.api_key = ENV.fetch('SENDGRID_API_KEY')
  config.email_from = ENV.fetch('SENDGRID_EMAIL_FROM')

  # By default, the gem utilizes the Rails logger, but this can be customized as needed
  config.logger = Rails.logger
  # The gem will write the request payload and response body to the logs if this setting is enabled
  config.debug_mode = !Rails.env.production?
end
