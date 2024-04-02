# frozen_string_literal: true

module SendGridClient
  module PayloadGenerators
    class PersonalizationGenerator < BaseService
      # @param email_to [String] receiver email address
      # @param template_data [Hash] SendGrid template payload
      def initialize(email_to:, template_data:)
        @email_to = email_to
        @template_data = template_data
        super
      end

      def call
        personalization = ::SendGrid::Personalization.new
        personalization.add_to(receiver_email)
        personalization.add_dynamic_template_data(@template_data)
        personalization
      end

      private

      def receiver_email
        @receiver_email ||= ::SendGrid::Email.new(email: @email_to)
      end
    end
  end
end
