# frozen_string_literal: true

module SendGridClient
  module PayloadGenerators
    class MailGenerator < BaseService
      # @param email_to [String] receiver email address
      # @param template_id [String] SendGrid template identifier
      # @param template_data [Hash] SendGrid template payload
      # @param attachments [Array<SendGrid::Attachment>] array of SendGrid attachments
      # @param reply_to [String] (Optional) reply to email
      def initialize(email_to:, template_id:, template_data:, attachments:, reply_to: nil)
        @email_to = email_to
        @template_id = template_id
        @template_data = template_data
        @attachments = attachments
        @reply_to = reply_to
        @mail = ::SendGrid::Mail.new
        super
      end

      def call
        setup_mail
        setup_personalization
        add_attachments

        @mail
      end

      private

      def setup_mail
        @mail.from = sender_email
        @mail.template_id = @template_id
        add_reply_to
      end

      def add_reply_to
        return unless @reply_to

        @mail.reply_to = ::SendGrid::Email.new(email: @reply_to)
      end

      def setup_personalization
        personalization = PersonalizationGenerator.call(email_to: @email_to, template_data: @template_data)
        @mail.add_personalization(personalization)
      end

      def add_attachments
        @attachments.each { |attachment| @mail.add_attachment(attachment) }
      end

      def sender_email
        @sender_email ||= ::SendGrid::Email.new(email: configuration.email_from)
      end

      # @return [SendGridClient::Configuration] gem configuration
      def configuration
        @configuration ||= ::SendGridClient.configuration
      end
    end
  end
end
