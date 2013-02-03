module Openlibrary

  class Lists
    attr_accessor :links, :size, :entries

    def self.find_by_user(user)
      request_url = "http://openlibrary.org/people/#{user}/lists.json"
      lists = new
      begin
        response = RestClient.get request_url
        response_data = JSON.parse(response)
        lists.entries = response_data['entries'].collect {|entry| List.new(entry)}
        lists.size = response_data['size']
        lists.links = response_data['links']
        lists
      rescue Exception => e
        e = e.http_code if e.is_a?(RestClient::Exception)
        puts "Unable to get lists for user '#{user}': #{e}"
        return nil
      end
    end

    def self.find_by_seed(seed)
    end
  end

  class List
    attr_accessor :url
    attr_accessor :links, :meta, :name, :description, :seed_count, :edition_count
    attr_accessor :seeds, :editions, :subjects

    def initialize(entry)
      @url = entry["url"]
      request_url = "http://openlibrary.org#{@url}.json"
      begin
        response = RestClient.get request_url
        response_data = JSON.parse(response)
        @name = response_data['name']
      rescue Exception => e
         puts "Something went wrong: #{e}"
      end
    end
  end
end
