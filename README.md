# Grape::NamedRoutes

It is an extenstion for API creating framework [Grape](https://github.com/intridea/grape).
With this gem you can create named routes to call them later without hardcoding pathes.

## Installation

Add these lines to your application's Gemfile:

```ruby
gem 'grape'
gem 'grape-named_routes'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grape
    $ gem install grape-named_routes

## Usage

These endpoints simply return their URLs.

```ruby
module Twitter
  class API < Grape::API
    resource :statuses do
      desc 'Endpoint without params'
      get :home_timeline, as: :home_timeline do
        Twitter::API.home_timeline_path
      end

      desc 'Endpoint with route param'
      params do
        requires :id, type: Integer
      end
      route_param :id do
        get as: :status do
          Twitter::API.status_path(id: params[:id])
        end
      end

      desc 'Endpoint with inline param'
      params do
        requires :param, type: String
      end
      get '/custom_route/:param', as: :inline do
        Twitter::API.inline_path(param: params[:param])
      end
    end
  end
end
```

If you somewhy need to get `endpoint` object instead of compiled path, you can use following:

```ruby
  Twitter::API.find_endpoint(:home_timeline) # returns Grape::Endpoint instance

  # also supports "dangerous" version (raises an error if route is not declared)
  Twitter::API.find_endpoint!(:home_timeline)
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hedgesky/grape-named_routes.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

