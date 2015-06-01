configure do
  # = Configuration =
  set :run,             false
  set :show_exceptions, development?
  set :raise_errors,    development?
  set :logging,         true
  set :static,          false # your upstream server should deal with those (nginx, Apache)
end

configure :production do
end  

# initialize log
require 'logger'
Dir.mkdir('log') unless File.exist?('log')
class ::Logger; alias_method :write, :<<; end
case ENV["RACK_ENV"]
when "production"
  logger = ::Logger.new("log/production.log")
  logger.level = ::Logger::WARN
when "development"
  logger = ::Logger.new(STDOUT)
  logger.level = ::Logger::DEBUG
else
  logger = ::Logger.new("/dev/null")
end
# use Rack::CommonLogger, logger

# initialize json
# ActiveSupport::JSON::Encoding.escape_html_entities_in_json = true

# initialize ActiveRecord
ActiveRecord::Base.establish_connection YAML::load(File.open('config/database.yml'))[ENV["RACK_ENV"]]
# ActiveRecord::Base.logger = logger
ActiveSupport.on_load(:active_record) do
  self.include_root_in_json = false
  self.default_timezone = :local
  self.time_zone_aware_attributes = false
  self.logger = logger
  # self.observers = :cacher, :garbage_collector, :forum_observer
end

# Set autoload directory
%w{models controllers libs}.each do |dir|
  Dir.glob(File.expand_path("../#{dir}", __FILE__) + '/**/*.rb').each do |file|
    require file
  end
end