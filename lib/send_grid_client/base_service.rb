# frozen_string_literal: true

module SendGridClient
  class BaseService
    def initialize(*, **); end

    class << self
      def call(*, **)
        new(*, **).call
      end
    end

    def call
      raise NotImplementedError, 'Abstract method was called.'
    end
  end
end
