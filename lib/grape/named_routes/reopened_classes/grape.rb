require 'active_support/dependencies/autoload'
module Grape
  module NamedRoutes
    extend ActiveSupport::Autoload
    autoload :NamedRouteNotFound
    autoload :NamedRouteSeeker
    autoload :PathCompiler
    autoload :MissedRequiredParam
    autoload :NamedPathHelper
  end
end