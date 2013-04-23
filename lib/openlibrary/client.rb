require 'openlibrary/request'
require 'openlibrary/client/books'
require 'openlibrary/client/authors'
require 'openlibrary/client/history'
require 'openlibrary/client/recent'
require 'openlibrary/client/editions'
require 'openlibrary/client/login'
require 'openlibrary/client/save'
require 'openlibrary/client/lists'

module Openlibrary
  class Client
    include Openlibrary::Request
    include Openlibrary::Books
    include Openlibrary::Authors
    include Openlibrary::History
    include Openlibrary::Recent
    include Openlibrary::Editions
    include Openlibrary::Login
    include Openlibrary::Save
    include Openlibrary::Lists

    # Initialize an Openlibrary::Client instance
    #
    def initialize(options={})
      unless options.kind_of?(Hash)
        raise ArgumentError, "Options hash required."
      end
    end
  end
end
