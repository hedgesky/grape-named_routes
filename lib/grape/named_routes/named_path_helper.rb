module Grape
  module NamedRoutes
    module NamedPathHelper
      def get_named_path(route_name, route_params = {})
        endpoint = named_route_seeker.find_endpoint!(route_name)
        NamedRoutes::PathCompiler.compile_path(endpoint.routes.first, route_params)
      end

      def find_endpoint(route_name)
        named_route_seeker.find_endpoint(route_name)
      end

      def find_endpoint!(route_name)
        named_route_seeker.find_endpoint!(route_name)
      end

      def method_missing(method_name, *arguments)
        if method_is_named_path?(method_name)
          route_name = method_name.to_s.sub(/_path$/, '')
          get_named_path(route_name, arguments.first || {})
        else
          super
        end
      end

      def respond_to_missing?(method_name, include_private = false)
        method_is_named_path?(method_name) || super
      end

      private

      def named_route_seeker
        @named_route_seeker ||= NamedRoutes::NamedRouteSeeker.new(self)
      end

      def method_is_named_path?(method_name)
        if method_name.to_s.end_with?('_path')
          route_name = method_name.to_s.sub(/_path$/, '')
          return true if named_route_seeker.named_endpoint_present?(route_name)
        end
        false
      end
    end
  end
end
