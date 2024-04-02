# frozen_string_literal: true

module SendGridClient
  module PayloadGenerators
    class AttachmentGenerator < BaseService
      DEFAULT_DISPOSITION = 'inline'

      # @param file_path_or_blob [Pathname, ActiveStorage::Blob] full path to file or Active Storage blob record
      # @param disposition [String] (Optional) attachment disposition, inline by default
      # @param content_id [String] (Optional) attachment unique content identifier
      def initialize(file_path_or_blob:, disposition: nil, content_id: nil)
        @file_path_or_blob = file_path_or_blob
        @disposition = disposition || DEFAULT_DISPOSITION
        @content_id = content_id || random_content_id
        super
      end

      # @return [SendGrid::Attachment]
      def call
        case class_name
        when Pathname.to_s
          Attachments::FileAttachmentGenerator.call(file_path: @file_path_or_blob,
                                                    disposition: @disposition,
                                                    content_id: @content_id)
        when ActiveStorage::Blob.to_s
          Attachments::BlobAttachmentGenerator.call(blob: @file_path_or_blob,
                                                    disposition: @disposition,
                                                    content_id: @content_id)
        else
          raise NotImplementedError, "Unexpected attachment class: #{class_name}"
        end
      end

      private

      def class_name
        @class_name ||= @file_path_or_blob.class.name
      end

      def random_content_id
        SecureRandom.uuid
      end
    end
  end
end
