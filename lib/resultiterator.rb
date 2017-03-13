module Wonde
  class ResultIterator < Endpoints
    include Enumerable
    attr_accessor :myarray, :meta, :token
    def initialize(myhashostruct, token)
      super
      p myhashostruct if ENV["debug_wonde"]
      self.token = token
      self.myarray = myhashostruct.data
      self.meta = myhashostruct.meta unless myhashostruct.meta.nil?
    end

    def <<(val)
      @myarray << val
    end

    def length
      return self.count()
    end

    def each
      original_length = @myarray.length - 1
      @myarray.each_with_index do |val,index|
        if index >= original_length and self.meta.pagination.more
          resp = self.getUrl(self.meta.pagination.next).body
          jsonized = resp.to_json
          nextResponse = JSON.parse(jsonized, object_class: OpenStruct)
          p nextResponse if ENV["debug_wonde"]
          self.meta  = nextResponse.meta unless nextResponse.meta.nil?
          nextResponse.data.each do |element|
            @myarray.push(element)
          end
          original_length += nextResponse.data.count
        end
        yield val
      end
    end
  end
end
