class ProductionAdditions
  def initialize(app)
    @app = (production?) ?  build_extended_app(app) : app
  end

  def call(env)
    @app.call(env)
  end

  private

  def production?
    ENV['RACK_ENV'] == 'production'
  end

  def build_extended_app(app)
    require 'rack/tracker'
    require 'rollbar'

    Rack::Builder.new do
      use Rack::ContentLength
      use(Rack::Tracker) { handler :google_analytics, { tracker: 'UA-2495676-17' } }
      run app
    end
  end
end
