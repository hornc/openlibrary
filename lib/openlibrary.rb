require 'openlibrary/version'
require 'json'
require 'rest-client'
require 'uri'

module Openlibrary

  autoload :Data, 'openlibrary/data'
  autoload :View, 'openlibrary/view'
  autoload :List, 'openlibrary/list'

  def self.version_string
    "Openlibrary version #{Openlibrary::VERSION}"
  end


end
