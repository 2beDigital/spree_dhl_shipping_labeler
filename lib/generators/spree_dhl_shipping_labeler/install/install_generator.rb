module SpreeDhlShippingLabeler
  module Generators
    class InstallGenerator < Rails::Generators::Base

      class_option :auto_run_migrations, :type => :boolean, :default => false
      class_option :auto_run_tasks, :type => :boolean, :default => false
      source_root File.expand_path('../../templates', __FILE__)

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_dhl_shipping_labeler'
      end

      def copy_initializer_file
        copy_file 'config/initializers/spree_dhl_shipping_labeler.rb', "config/initializers/spree_dhl_shipping_labeler.rb"
      end

      def copy_conection_params_file
        copy_file 'config/dhl_api_conection.yml', "config/dhl_api_conection.yml"
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask 'Would you like to run the migrations now? [Y/n]')
        if run_migrations
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end
      def run_tasks
        run_tasks = options[:auto_run_tasks] || ['', 'y', 'Y'].include?(ask 'Would you like to run the default dhl shipping boxes now? [Y/n]')
        if run_tasks
          run 'bundle exec rake shipping_dhl_boxes:create'
        else
          puts 'Skipping shipping dhl types, don\'t forget to run it!'
        end
      end
    end
  end
end