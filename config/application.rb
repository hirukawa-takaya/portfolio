require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Portfolio
  class Application < Rails::Application
    #kaminari japanise
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    
    # タイムゾーンを日本時間に設定
    config.time_zone = 'Asia/Tokyo'
    # デフォルトのロケールを日本（ja）に設定
    config.i18n.default_locale = :ja
    
    #rspec
    config.generators do |g|
      g.test_framework :rspec,
      view_specs: false,
      helper_specs: false,
      routing_specs: false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.active_storage.service = :amazon
  end
end