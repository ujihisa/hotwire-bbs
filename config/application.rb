require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HotwireBbs
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    require 'google/cloud/firestore'
    # if File.exist?('devs-sandbox-5941dd8999bb.json')
    #   config.firestore = ::Google::Cloud::Firestore.new(
    #     project_id: 'devs-sandbox',
    #     credentials: 'devs-sandbox-5941dd8999bb.json',
    #   )
    if ENV['CREDENTIALS_JSON']
      config.firestore = ::Google::Cloud::Firestore.new(
        project_id: 'devs-sandbox',
        credentials: JSON.parse(ENV['CREDENTIALS_JSON']),
      )
    else
      # It's likely asset:precompile. Simply ignore that.
      # Use emulator
      ENV['FIRESTORE_EMULATOR_HOST'] = "firestore-emulator:8080"
      config.firestore = ::Google::Cloud::Firestore.new(
        project_id: 'devs-sandbox',
      )
    end
  end
end
