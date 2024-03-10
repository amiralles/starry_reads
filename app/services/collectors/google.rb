# frozen_string_literal: true

module Collectors
  class Google < Base
    def prepare_url
      "https://www.googleapis.com/books/v1/volumes?q=#{isbn}&maxResults=#{max_results}&key=#{api_key}"
    end

    def source_name
      File.basename(__FILE__).gsub(".rb", "")
    end

    private

    def api_key
      ENV["GOOGLE_API_KEY"] || (raise "Please configure GOOGLE_API_KEY")
    end
  end
end
