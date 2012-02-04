require 'openlibrary/version'
require 'json'
require 'rest-client'
require 'uri'

module Openlibrary

  autoload :Data, 'openlibrary/data'
  autoload :View, 'openlibrary/view'
  autoload :Lists, 'openlibrary/lists'

  def self.version_string
    "Openlibrary version #{Openlibrary::VERSION}"
  end


end
