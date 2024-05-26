ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/rails"
require 'database_cleaner/active_record'


module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    DatabaseCleaner.strategy = :transaction

    class Minitest::Spec

      before :suite do
        DatabaseCleaner.clean_with :truncation  # clean DB of any leftover data
        DatabaseCleaner.strategy = :transaction # rollback transactions between each test
        Rails.application.load_seed # (optional) seed DB
      end

      before :each do
        DatabaseCleaner.start
        Rake::Task["db:seed"].invoke # seed after starting
      end

      after :each do
        DatabaseCleaner.clean
      end
    end
  end

end
