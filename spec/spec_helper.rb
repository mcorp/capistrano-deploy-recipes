# runs only on CI
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rspec'
require 'fuubar'

RSpec.configure do |config|
  config.color     = true
  config.formatter = Fuubar
end
