require File.expand_path("../instagram/error", __FILE__)
require File.expand_path("../instagram/configuration", __FILE__)
require File.expand_path("../instagram/api", __FILE__)
require File.expand_path("../instagram/client", __FILE__)
require File.expand_path("../instagram/response", __FILE__)

require "hashie"
require "hashie/logger"
Hashie.logger = Logger.new(nil)

module Instagram
  extend Configuration

  # Alias for Instagram::Client.new
  #
  # @return [Instagram::Client]
  def self.client(options = {})
    Instagram::Client.new(options)
  end

  # Delegate to Instagram::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to Instagram::Client
  def self.respond_to?(method, include_all = false)
    client.respond_to?(method, include_all) || super
  end
end
