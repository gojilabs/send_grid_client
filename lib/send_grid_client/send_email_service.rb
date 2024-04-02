# frozen_string_literal: true

module SendGridClient
  class SendEmailService < BaseService
    # @param email_to [String] receiver email address
    # @param template_id [String] SendGrid template identifier
    # @param template_data [Hash] SendGrid template payload
    # @param attachments [Array<SendGrid::Attachment>] (Optional) array of SendGrid attachments
    def initialize(email_to:, template_id:, template_data:, attachments: [])
      @email_to = email_to
      @template_id = template_id
      @template_data = template_data
      @attachments = attachments
      super
    end

    def call
      ApiClient.call(mail)
    end

    private

    def mail
      @mail ||= PayloadGenerators::MailGenerator.call(email_to: @email_to,
                                                      template_id: @template_id,
                                                      template_data: @template_data,
                                                      attachments: @attachments)
    end
  end
end
