module Grape
  class API
    extend NamedRoutes::NamedPathHelper

    class << self
      alias_method :original_reset!, :reset!
      def reset!
        original_reset!
        @named_route_seeker = nil
      end
    end
  end
end