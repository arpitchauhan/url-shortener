class ShortenedUri < ApplicationRecord
  include UriHelper
  after_validation :assign_shortened_relative_uri_if_required
  validates :original_uri, uniqueness: true, presence: true
  validate :original_uri_is_valid, if: :original_uri_changed?
  validates :shortened_relative_uri, uniqueness: true

  def self.generate_short_uri(uri)
    loop do
      generated = random_url_safe_string
      break generated unless exists?(shortened_relative_uri: generated)
    end
  end

  def as_json(options = {})
    attrs = [:original_uri, :shortened_relative_uri]
    super options.reverse_merge(only: attrs)
  end

  private

  def assign_shortened_relative_uri_if_required
    self.shortened_relative_uri ||= self.class.generate_short_uri(original_uri)
  end

  def original_uri_is_valid
    unless self.class.valid_uri?(original_uri)
      errors.add(:original_uri, 'is not a valid URI')
    end
  end
end
