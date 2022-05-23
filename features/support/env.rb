require 'cucumber'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'rake/file_utils'
require 'rspec'
require 'rspec/expectations'
require "rubygems"
require "capybara"
require 'capybara/dsl'
require 'yaml'
require 'site_prism'
require_relative 'environment'
require_relative '../../libs/report_builder/lib/report_builder'

World(Capybara::DSL)
Capybara.threadsafe = true
$environment = Environment.new

Before do
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end

  if ENV["BROWSER"] == "chrome"
    Capybara.default_driver = :chrome
    $driver = Capybara::Session.new(:chrome)
    Capybara.javascript_driver = :chrome
    Capybara.current_session.driver.browser.manage.window.maximize

  elsif ENV["BROWSER"] == "firefox"
    Capybara.default_driver = :firefox
    Capybara.register_driver :firefox do |app|
      options = {
          :js_errors => true,
          :timeout => 360,
          :debug => false,
          :inspector => false,
      }
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
  end
end


at_exit do
  platform_name = $environment.platform_name
  input_path = 'output'
  reportTime = Time.now.strftime("%d/%m/%Y %H:%M")
  options = {
      input_path: input_path,
      html_report_path: 'output/report/automation-report-' + platform_name,
      report_types: ['JSON', 'HTML'],
      report_title: ' ['+reportTime+'] Automation Report ' + platform_name,
      additional_info: {'Platform' => platform_name},
      color: 'indigo'
  }
  ReportBuilder.build_report options
end
