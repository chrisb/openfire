module Openfire
  module Service
    class Base
      include ActiveSupport::Configurable

      config.path = '/'
      config.exceptions = []

      def initialize(options={})
        @options = { path: config.path }.merge(options)
      end

      private

        def build_query(params)
          "#{build_query_uri}?#{build_query_params(params)}"
        end

        def build_query_uri
          URI.parse(@options[:url]).tap do |u|
            u.path = File.join(u.path, config.path)
          end
        end

        def build_query_params(params)
          params.merge!(secret: @options[:secret])
          params.map{ |k,v| "#{k}=#{v}" }.join('&')
        end

        def submit_request(params)
          data = submit_http_request(build_query_uri, build_query_params(params))
          parse_response(data)
        end

        def submit_http_request(uri, params_as_string)
          uri.query = URI.encode(params_as_string)
          res = Net::HTTP.get_response(uri)

          return res.body
        rescue Exception => e
          raise HTTPException, e.to_s
        end

        def parse_response(data)
          error = data.match(/<error>(.*)<\/error>/)
          if error && config.exceptions.include?(error[1])
            exception_klass = "#{self.class}::#{error[1].gsub('Exception', '')}Exception"
            raise exception_klass.constantize
          end
          raise InvalidResponseException unless data.match(/<result>ok<\/result>/)
          return true
        end

    end
  end
end
