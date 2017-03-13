module Wonde
  # Top level Endpoints class, most of our classes inherit from this
  # Some methods use this directly
  class Endpoints
    require 'unirest'
    require 'ostruct'
    require "addressable/uri"
    require 'json'
    attr_accessor :endpoint, :uri, :token, :version
    # Main endpoint, base URI
    @@endpoint = 'https://api.wonde.com/v1.0/'


    def initialize(token, uri=false)
      self.endpoint = @@endpoint
      self.uri = String.new()
      self.version = '0.0.1'
      self.token = token
      self.uri = uri if uri
    end

    # Forwards request info, eventually to unirest
    #
    # @param endpoint [String]
    # @return [Object]
    def getRequest(endpoint)
      puts "self.endpoint: " + self.endpoint if ENV["debug_wonde"]
      puts "endpoint:" + endpoint if ENV["debug_wonde"]
      return getUrl(self.endpoint + endpoint)
    end

    # Forwards request info to unirest
    #
    # @param url [String]
    # @return [Object]
    def getUrl(url)
      return _client().get(url)
    end

    # Builds get request and passes it along
    #
    # @param id [String]
    # @param includes [Hash]
    # @param parameters [Hash]
    # @return [Object]
    def get(id, includes = Hash.new(), parameters = Hash.new())
      unless includes.nil? or includes.empty?
        parameters['include'] = includes.join(",")
      end
      unless parameters.empty?
        uriparams = Addressable::URI.new
        uriparams.query_values = parameters
        uri = self.uri + id + "?" + uriparams.query
      else
        uri = self.uri + id
      end
      response = getRequest(uri).body["data"]
      puts response if ENV["debug_wonde"]
      jsonized = response.to_json
      puts jsonized if ENV["debug_wonde"]
      object = JSON.parse(jsonized, object_class: OpenStruct)
      puts object if ENV["debug_wonde"]
      return object
    end

    def postRequest(endpoint, body=Hash.new())
      puts "self.endpoint:\n " + self.endpoint if ENV["debug_wonde"]
      puts "endpoint:\n" + endpoint if ENV["debug_wonde"]
      puts "body:\n" + body.to_json if ENV["debug_wonde"]
      return postUrl(self.endpoint + endpoint, body)
    end

    def postUrl(url, body=Hash.new())
      puts body.to_json if ENV["debug_wonde"]
      return _client().post(url, headers:{ "Accept" => "application/json",
                                          "Content-Type" => "application/json"},
                        parameters:body.to_json)
    end

    def post(body=Hash.new())
      hash_response = self.postRequest(self.uri, body).body
      if hash_response.nil?
        return Hash.new()
      end
      return OpenStruct.new hash_response

    end

    def deleteRequest(endpoint, body=Hash.new())
      puts "self.endpoint: " + self.endpoint if ENV["debug_wonde"]
      puts "endpoint:" + endpoint if ENV["debug_wonde"]
      puts "body:" + body.to_json if ENV["debug_wonde"]
      return deleteUrl(self.endpoint + endpoint, body)
    end

    def deleteUrl(url, body=Hash.new())
      puts body.to_json if ENV["debug_wonde"]
      return _client().delete(url, headers:{ "Accept" => "application/json",
                                          "Content-Type" => "application/json"},
                        parameters:body.to_json)
    end

    def delete(body=Hash.new())
      hash_response = self.deleteRequest(self.uri, body).body
      if hash_response.nil?
        return Hash.new()
      end
      return OpenStruct.new hash_response

    end

    def all(includes = Array.new(), parameters = Hash.new())
      unless includes.nil? or includes.empty?
        parameters['include'] = includes.join(",")
      end

      unless parameters.nil? or parameters.empty?
        uriparams = Addressable::URI.new
        uriparams.query_values = parameters
        uriparams.query
        uri = self.uri + '?' + uriparams.query
      else
        uri = self.uri
      end
      response = getRequest(uri).body
      puts response if ENV["debug_wonde"]
      jsonized = response.to_json
      puts jsonized if ENV["debug_wonde"]
      object = JSON.parse(jsonized, object_class: OpenStruct)
      puts object if ENV["debug_wonde"]
      return ResultIterator.new(object,self.token)
    end

    private
      def _client()
        Unirest.default_header('Authorization', ('Basic ' + self.token))
        Unirest.default_header("User-Agent", ("wonde-rb-client-" + self.version))
        return Unirest
      end
  end
end
