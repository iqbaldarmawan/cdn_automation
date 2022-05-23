# frozen_string_literal: true

require 'cucumber/rake/task'
require 'yaml'
require 'rake/file_utils'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :clean do
  FileUtils.rm_rf('output')
  FileUtils.mkdir('output')
  FileUtils.mkdir('output/report')
  FileUtils.mkdir('output/screenshots')
end

namespace :platform do
  YAML.load_file('cucumber.yml').each do |profile_name, opts|
    Cucumber::Rake::Task.new(profile_name.to_sym) do |task|
      Rake::Task['clean'].invoke
      task.cucumber_opts = "
        --verbose -f pretty
        -f html -o output/cucumber-results.html
        -f json -o output/cucumber-results.json
        -f rerun -o output/cucumber-rerun.txt features #{opts}
      "
    end
  end
end
