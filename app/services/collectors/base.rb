# frozen_string_literal: true

module Collectors
  class Base < ::ServiceObject::Base
    attr_reader :isbn, :max_results, :url, :response

    def initialize(isbn, opts = {})
      super(opts)

      @isbn = isbn
      @max_results = opts[:max_results] || 10
    end

    def perform_call
      prepare_params()
      make_request()
      save_results()
    end

    def prepare_params
      @url = prepare_url()
      @source = source_name()
    end

    def prepare_url
      raise "Please provide an implementation that builds the collector's target URL."
    end

    def source_name
      raise "Please provide an implementation that returns the name of the collector's target source."
    end

    def make_request
      # TODO Handle "too many request", time outs, and friends.
      @response = HttpClient.get(url)
    end

    def save_results
      SearchResult.create!(isbn: isbn, source: @source, payload: @response)
    end
  end
end
