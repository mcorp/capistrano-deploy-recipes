# reference: http://va.mu/hPOY
if ENV['TRAVIS']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start

  require 'simplecov'
  SimpleCov.start
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rspec'
require 'fuubar'

RSpec.configure do |config|
  config.color     = true
  config.formatter = Fuubar
end
