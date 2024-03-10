# frozen_string_literal: true

module Collectors
  class Google < ::ServiceObject::Base
    attr_reader :isbn, :max_results, :url, :response, :source

    def initialize(isbn, opts = {})
      super(opts)

      @isbn = isbn
      @source = "Google"
      @max_results = opts[:max_results] || 10
      @result = []
    end

    def perform_call
      prepare_url()
      make_request()
      save_results()
    end

    def make_request
      # TODO Handle "too many request", time outs, and friends.
      @response = HttpClient.get(url)
    end

    def save_results
      SearchResult.create!(isbn: isbn, source: source, payload: @response)
    end

    def api_key
      ENV["GOOGLE_API_KEY"] || (raise "Please configure GOOGLE_API_KEY")
    end

    def prepare_url
      @url = "https://www.googleapis.com/books/v1/volumes?q=#{isbn}&maxResults=#{max_results}&key=#{api_key}"
    end
  end
end
