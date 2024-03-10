class HttpClient
  class << self
    delegate :get, to: :http_party
  end

  private

  def self.http_party
    HTTParty
  end
end
