# frozen_string_literal: true

module SendGridClient
  class Configuration
    attr_accessor :api_key,
                  :email_from,
                  :logger,
                  :debug_mode

    def initialize
      @api_key = nil
      @email_from = nil
      @logger = nil
      @debug_mode = false
    end
  end
end
