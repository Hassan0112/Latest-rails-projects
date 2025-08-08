require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


#Rails has a system for this called Active Job, which is like a job manager.
#But Active Job doesn’t do the work itself—it hands it off to
#a worker (like Sidekiq, Resque, or DelayedJob).

#"Whenever I use perform_later, send the job to Sidekiq to do the background work."
#Without this line, Rails might default to something slower or simpler like :async, which isn’t good for production.



module Marketplace
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    #Hey Rails, when I run background jobs, use Sidekiq to handle them.
    config.active_job.queue_adapter = :sidekiq
    #"Whenever I use perform_later, send the job to Sidekiq to do the background work."
    #Without this line, Rails might default to something slower or simpler like :async, which isn’t good for production.

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
