require 'forwardable'

module Openlibrary
  module Lists
    include Enumerable
    extend Forwardable
    attr_accessor :links, :size, :entries
    def_delegators :@entries, :each, :[], :last

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
    attr_accessor :url, :name, :seed_count, :edition_count

    def initialize(entry)
      @url = entry['url']
      @name = entry['name']
      @seed_count = entry['seed_count']
      @edition_count = entry['edition_count']
    end

    def initialize_from_api
      request_url = "http://openlibrary.org#{@url}.json"
      begin
        response = RestClient.get request_url
        response_data = JSON.parse(response)
        @description = response_data['description']
        @meta = response_data['meta']
        @links = response_data['links']
      rescue Exception => e
        puts "Something went wrong: #{e}"
      end
    end

    def links
      initialize_from_api if @links.nil?
      @links
    end

    def description
      initialize_from_api if @description.nil?
      @description
    end

    def meta
      initialize_from_api if @meta.nil?
      @meta
    end

    def seeds
      @seeds ||= initialize_attribute('seeds')
    end

    def editions
      @editions ||= initialize_attribute('editions')
    end

    def subjects
      @subjects ||= initialize_attribute('subjects')
    end

    def initialize_attribute(name)
      begin
        JSON.parse(RestClient.get('http://openlibrary.org'+@links[name]+'.json'))
      rescue Exception => e
        puts "Unable to retrieve #{name}: #{e}"
      end
    end
  end
end
