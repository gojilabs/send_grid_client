# frozen_string_literal: true

module SendGridClient
  class ApiClient < BaseService
    # @param mail [Mail] mail instance
    def initialize(mail)
      @mail = mail
      super
    end

    def call
      client = ::SendGrid::API.new(api_key: configuration.api_key)
      response = client.client.mail._('send').post(request_body: request_body_json)

      log_response(payload: request_body_json, response:) if configuration.debug_mode
      raise ApiError, response.body unless success?(response)
    end

    private

    def success?(response)
      response.status_code == '202'
    end

    def request_body_json
      @request_body_json ||= @mail.to_json
    end

    def log_response(payload:, response:)
      configuration.logger&.info "[SEND_GRID_CLIENT] response #{response.status_code} body: #{response.body} data: #{payload}" # rubocop:disable Layout/LineLength
    end

    # @return [SendGridClient::Configuration] gem configuration
    def configuration
      @configuration ||= ::SendGridClient.configuration
    end
  end
end
