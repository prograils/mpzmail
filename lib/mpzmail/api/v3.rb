require 'httparty'
require 'gyoku'
module Mpzmail
  module Api
    class V3
      include HTTParty
      base_uri Mpzmail.configuration.base_uri
      headers 'Accept' => 'text/xml'
      format :xml
      debug_output $stdout
      def initialize(api_key)
        @api_key = api_key
      end

      def account_createaccount(options = {})
        options = setup_options(options, %w( emailaddress password fullname ))
        options = self.class.get_xml(options)
        self.class.post('/api/v3.0/account/createaccount/', body: options)
      end

      def groups_addgroup(options = {})
        options = setup_options(options, %w( groupName ))
        options = self.class.get_xml(options)
        self.class.post('/api/v3.0/groups/addGroup/', body: options)
      end

      def subscribers_addsubscribers(options = {})
        options = setup_options(options, %w( groupID ))
        options = self.class.get_xml(options)
        self.class.post('/api/v3.0/subscribers/addSubscribers/', body: options)
      end

      def self.auth(username, password)
        options = { username: username, password: password }
        options = get_xml(options)
        post('/api/v3.0/auth/', body: options)
      end

      def self.get_xml(options)
        Gyoku.xml xml: options
      end

      private

      def setup_options(options, default_keys = [])
        opts = {}
        default_keys.each { |k| opts[k] = '' }
        opts.merge(options).merge('apiKey' => @api_key)
      end
    end
  end
end
