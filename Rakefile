# frozen_string_literal: true

require 'bundler/setup'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

desc 'Test Echo'
namespace :test do
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new do |task|
    task.rspec_opts = %(--format documentation --color --require spec_helper)
  end

  desc 'Test Echo and calculate test coverage'
  task :coverage do
    ENV['COVERAGE'] = 'true'
    Rake::Task['test:spec'].invoke
  end
end

desc 'Run RuboCop'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.options << '--display-cop-names'
end

desc 'Run all spec tests and linters'
task check: %w[test:spec rubocop]

task default: :check
