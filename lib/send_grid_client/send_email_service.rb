# frozen_string_literal: true

module SendGridClient
  class SendEmailService < BaseService
    # @param email_to [String] receiver email address
    # @param template_id [String] SendGrid template identifier
    # @param template_data [Hash] SendGrid template payload
    # @param attachments [Array<SendGrid::Attachment>] (Optional) array of SendGrid attachments
    # @param reply_to [String] (Optional) reply to email
    def initialize(email_to:, template_id:, template_data:, attachments: [], reply_to: nil)
      @email_to = email_to
      @template_id = template_id
      @template_data = template_data
      @attachments = attachments
      @reply_to = reply_to
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
                                                      attachments: @attachments,
                                                      reply_to: @reply_to)
    end
  end
end
