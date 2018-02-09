module GDS
  module Metrics
    class Middleware
      attr_accessor :wrapped_app

      def initialize(app)
        self.wrapped_app = Rack::Builder.app do
          use Prometheus::Client::Rack::Collector
          use Prometheus::Client::Rack::Exporter
          run app
        end
      end

      def call(env)
        wrapped_app.call(env)
      end
    end
  end
end