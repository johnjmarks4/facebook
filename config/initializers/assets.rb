# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w( css_reset.css )

Rails.application.config.assets.precompile += %w( users.css )

Rails.application.config.assets.precompile += %w( registrations.css )

Rails.application.config.assets.precompile += %w( user_form.css )

Rails.application.config.assets.precompile += %w( posts.css )

Rails.application.config.assets.precompile += %w( wall_posts.css )

Rails.application.config.assets.precompile += %w( profile_options.css )

Rails.application.config.assets.precompile += %w( navbar.css )

Rails.application.config.assets.precompile += %w( notifications.js )

Rails.application.config.assets.precompile += %w( comment.js )

Rails.application.config.assets.precompile += %w( text_value.js )

Rails.application.config.assets.precompile += %w( message.js )

Rails.application.config.assets.precompile += %w( likes.js )