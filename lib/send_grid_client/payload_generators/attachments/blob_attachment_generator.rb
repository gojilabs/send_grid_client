# frozen_string_literal: true

module SendGridClient
  module PayloadGenerators
    module Attachments
      class BlobAttachmentGenerator < BaseService
        # @param blob [ActiveStorage::Blob] Active Storage blob record
        def initialize(blob:, disposition:, content_id:)
          @blob = blob
          @disposition = disposition
          @content_id = content_id
          super
        end

        # @return [SendGrid::Attachment]
        def call
          attachment = ::SendGrid::Attachment.new

          attachment.disposition = @disposition
          attachment.content_id = @content_id
          attachment.type = @blob.content_type
          attachment.filename = @blob.filename.to_s
          attachment.content = Base64.strict_encode64(@blob.download)

          attachment
        end
      end
    end
  end
end
