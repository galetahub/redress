# frozen_string_literal: true

begin
  require "gemsmith/rake/setup"
  require "git/cop/rake/setup"
  require "rspec/core/rake_task"
  require "reek/rake/task"
  require "rubocop/rake_task"
  # require "scss_lint/rake_task"

  RSpec::Core::RakeTask.new(:spec)
  Reek::Rake::Task.new
  RuboCop::RakeTask.new
  # SCSSLint::RakeTask.new { |task| task.files = ["app/assets"] }
rescue LoadError => error
  puts error.message
end

desc "Run code quality checks"
task code_quality: %i[git_cop reek rubocop]

task default: %i[code_quality spec]
