module Openfire
  module Service
    class Room < Base

      config.path = 'plugins/roomService/roomservice'
      config.exceptions = %w(
        RoomServiceDisabled
        RequestNotAuthorised
        NotAllowedException
        IllegalArgumentException
        AlreadyExistsException
        NotFoundException
      )

      class HTTPException < StandardError; end
      class InvalidResponseException < StandardError; end
      class RoomServiceDisabledException < StandardError; end
      class RequestNotAuthorisedException < StandardError; end
      class NotAllowedException < StandardError; end
      class IllegalArgumentException < StandardError; end
      class AlreadyExistsException < StandardError; end
      class NotFoundException < StandardError; end

      def add_room!(opts)
        submit_request(opts.merge(:type => :add))
      end

      def delete_room!(opts)
        submit_request(opts.merge(:type => :delete))
      end

      def create_muc_service!(opts)
        submit_request(opts.merge(:type => :createMultiUserChatService))
      end

      def rename_muc_service!(opts)
        submit_request(opts.merge(:type => :updateMultiUserChatService))
      end

      def delete_muc_service!(opts)
        submit_request(opts.merge(:type => :removeMultiUserChatService))
      end

    end
  end
end
