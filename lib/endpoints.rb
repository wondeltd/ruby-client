module Wonde
  # Top level Endpoints class, most of our classes inherit from this
  # Some methods use this directly
  class Endpoints
    require 'rest-client'
    require 'ostruct'
    require "addressable/uri"
    require 'json'
    attr_accessor :endpoint, :uri, :token, :version
    # Main endpoint, base URI
    @@endpoint = Wonde::BASE_ENDPOINT

    def initialize(token, uri = false, endpoint = nil)
      self.endpoint = endpoint || @@endpoint
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
      getUrl(self.endpoint + endpoint)
    end

    # Forwards request info to unirest
    #
    # @param url [String]
    # @return [Object]
    def getUrl(url)
      RestClient::Request.execute(
        method: :get,
        url: url,
        headers: {
          "Authorization" => "Bearer #{self.token}",
          "User-Agent" => "wonde-rb-client-#{self.version}"
        }
      )
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
      response = getRequest(uri).body
      puts response if ENV["debug_wonde"]
      object = JSON.parse(response, object_class: OpenStruct)
      puts object if ENV["debug_wonde"]
      object.data
    end

    def postRequest(endpoint, body=Hash.new())
      puts "self.endpoint:\n " + self.endpoint if ENV["debug_wonde"]
      puts "endpoint:\n" + endpoint if ENV["debug_wonde"]
      puts "body:\n" + body.to_json if ENV["debug_wonde"]
      postUrl(self.endpoint + endpoint, body)
    end

    def postUrl(url, body=Hash.new())
      puts body.to_json if ENV["debug_wonde"]
      RestClient::Request.execute(
        method: :post,
        url: url,
        headers: {
          "Authorization" => "Basic #{self.token}",
          "User-Agent" => "wonde-rb-client-#{self.version}",
          "Accept" => "application/json",
          "Content-Type" => "application/json",
        },
        payload: body.to_json,
      )
    end

    def post(body=Hash.new())
      hash_response = JSON.parse(self.postRequest(self.uri, body).body)
      if hash_response.nil?
        return Hash.new()
      end
      OpenStruct.new hash_response
    end

    def deleteRequest(endpoint, body=Hash.new())
      puts "self.endpoint: " + self.endpoint if ENV["debug_wonde"]
      puts "endpoint:" + endpoint if ENV["debug_wonde"]
      puts "body:" + body.to_json if ENV["debug_wonde"]
      deleteUrl(self.endpoint + endpoint, body)
    end

    def deleteUrl(url, body=Hash.new())
      puts body.to_json if ENV["debug_wonde"]
      RestClient::Request.execute(
        method: :delete,
        url: url,
        headers: {
          "Authorization" => "Basic #{self.token}",
          "User-Agent" => "wonde-rb-client-#{self.version}",
          "Accept" => "application/json",
          "Content-Type" => "application/json",
        },
        payload: body.to_json,
      )
    end

    def delete(body=Hash.new())
      hash_response = self.deleteRequest(self.uri, body).body
      if hash_response.nil?
        return Hash.new()
      end
      OpenStruct.new hash_response
    end

    def all(includes = Array.new(), parameters = Hash.new())
      setup_uri(includes, parameters)

      response = getRequest(uri).body
      puts response if ENV["debug_wonde"]
      object = JSON.parse(response, object_class: OpenStruct)
      puts object if ENV["debug_wonde"]
      ResultIterator.new(object,self.token)
    end

    def each_page(includes = Array.new(), parameters = Hash.new())
      old_uri = @uri

      setup_uri(includes, parameters)

      response = JSON.parse(getRequest(@uri).body, object_class: OpenStruct)
      @next_page = response.meta.pagination.next

      yield response.data

      while @next_page
        response = JSON.parse(getUrl(@next_page).body, object_class: OpenStruct)
        @next_page = response.meta.pagination.next

        yield response.data
      end

      @uri = old_uri

      self
    end

    private
      def setup_uri(includes, parameters)
        parameters['include'] = includes.join(",") unless includes.nil? || includes.empty?

        unless parameters.nil? || parameters.empty?
          uriparams = Addressable::URI.new
          uriparams.query_values = parameters
          uriparams.query
          @uri = self.uri + '?' + uriparams.query
        else
          @uri = self.uri
        end
      end
  end
end
