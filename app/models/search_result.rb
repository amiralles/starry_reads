class SearchResult < ApplicationRecord
  before_save :normalize_source

  validates :isbn, :source, :payload, presence: true

  private

  def normalize_source
    return unless attribute_present?("source")

    self.source = source.downcase.gsub(" ", "_")
  end
end
