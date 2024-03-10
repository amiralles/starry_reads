# frozen_string_literal: true

module Collectors
  class OpenLibrary < Base
    def prepare_url
      "https://openlibrary.org/search.json?isbn=#{isbn}"
    end

    def source_name
      File.basename(__FILE__).gsub(".rb", "")
    end
  end
end
