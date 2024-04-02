# frozen_string_literal: true

module SendGridClient
  module PayloadGenerators
    module Attachments
      class FileAttachmentGenerator < BaseService
        # @param file_path [Pathname] fill path to file
        def initialize(file_path:, disposition:, content_id:)
          @file_path = file_path
          @disposition = disposition
          @content_id = content_id
          super
        end

        # @return [SendGrid::Attachment]
        def call
          attachment = ::SendGrid::Attachment.new

          attachment.disposition = @disposition
          attachment.content_id = @content_id
          attachment.type = Marcel::MimeType.for(@file_path)
          attachment.filename = @file_path.basename.to_s
          attachment.content = File.open(@file_path, 'rb') { |img| Base64.strict_encode64(img.read) }

          attachment
        end
      end
    end
  end
end
