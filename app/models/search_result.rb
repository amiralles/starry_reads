class SearchResult < ApplicationRecord
  before_save :normalize_source
  before_save :normalize_isbn

  validates :isbn, :source, :payload, presence: true
  validate :isbn_length

  private

  def normalize_source
    return unless attribute_present?("source")

    self.source = source.downcase.gsub(" ", "_")
  end

  def normalize_isbn
    return unless attribute_present?("isbn")

    self.isbn = isbn.gsub(/\D/, "")
  end

  def isbn_length
    return unless isbn.present?

    unless [ 10, 13 ].include? isbn.length
      errors.add(:isbn, "length must be either 10 or 13 numbers")
    end
  end
end
