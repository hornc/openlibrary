module Openlibrary

  class Lists
    attr_accessor :entries

    def self.find_by_user(user)
      request_url = "http://openlibrary.org/people/#{user}/lists.json"
      response = RestClient.get request_url
      response_data = JSON.parse(response)
      entries = response_data['entries']
      if entries
        list_entries = new
        list_entries.entries = entries.collect {|e| List.new(e)}
        list_entries
      else
        puts "OPENLIBRARY: No lists found for user #{user} on Openlibrary.org"
        nil
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
