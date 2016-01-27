module Openfire
  module Service
    class Group < Base

      config.path = 'plugins/groupService/groupservice'
      config.exceptions = %w(
        GroupServiceDisabled
        RequestNotAuthorised
        IllegalArgumentException
        GroupNotFoundException
        GroupAlreadyExistsException
      )

      class HTTPException < StandardError; end
      class InvalidResponseException < StandardError; end
      class GroupServiceDisabledException < StandardError; end
      class RequestNotAuthorisedException < StandardError; end
      class IllegalArgumentException < StandardError; end
      class GroupNotFoundException < StandardError; end
      class GroupAlreadyExistsException < StandardError; end

      def add_group!(opts)
        submit_request(opts.merge(:type => :add))
      end

      def delete_group!(opts)
        submit_request(opts.merge(:type => :delete))
      end

      def update_group!(opts)
        submit_request(opts.merge(:type => :update))
      end

      def lock_group!(opts)
        submit_request(opts.merge(:type => :disable))
      end

      def unlock_group!(opts)
        submit_request(opts.merge(:type => :enable))
      end

    end
  end
end
