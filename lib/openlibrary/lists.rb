module Openlibrary

  class Lists
    attr_accessor :links, :size, :entries

    def self.find_by_user(user)
      request_url = "http://openlibrary.org/people/#{user}/lists.json"
      lists = new
      begin
        response = RestClient.get request_url
        response_data = JSON.parse(response)
        lists.entries = response_data['entries'].collect {|e| List.new(e)}
        lists.size = response_data['size']
        lists.links = response_data['links']
        lists
      rescue Exception => e
        puts "Unable to get lists for user '#{user}': #{e.http_code}"
        return nil
      end
    end

    def self.find_by_seed(seed)
    end
  end

  class List

    def seeds
    
    end
  end
end
