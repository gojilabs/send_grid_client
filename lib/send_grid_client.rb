# frozen_string_literal: true

# dependencies
require 'sendgrid-ruby'
# gem files
require_relative 'send_grid_client/version'
require_relative 'send_grid_client/base_service'
require_relative 'send_grid_client/configuration'
require_relative 'send_grid_client/payload_generators/attachments/blob_attachment_generator'
require_relative 'send_grid_client/payload_generators/attachments/file_attachment_generator'
require_relative 'send_grid_client/payload_generators/attachment_generator'
require_relative 'send_grid_client/payload_generators/personalization_generator'
require_relative 'send_grid_client/payload_generators/mail_generator'
require_relative 'send_grid_client/api_client'
require_relative 'send_grid_client/send_email_service'

module SendGridClient
  class << self
    attr_accessor :configuration

    def setup
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end
end
