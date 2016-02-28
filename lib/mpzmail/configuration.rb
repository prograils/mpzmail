module Mpzmail
  class Configuration
    attr_accessor :base_uri

    def initialize
      @base_uri = 'https://mpzmail.com'
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration
  end
end
