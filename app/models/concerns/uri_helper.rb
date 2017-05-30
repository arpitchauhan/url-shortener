module UriHelper
  extend ActiveSupport::Concern

  class_methods do
    def random_url_safe_string(input = 5)
      SecureRandom.urlsafe_base64(input)
    end

    def valid_uri?(uri)
      parsed_uri = Addressable::URI.parse(uri)
      parsed_uri && [ 'http', 'https'].include?(parsed_uri.scheme)
    rescue Addressable::URI::InvalidURIError
      false
    end
  end
end
