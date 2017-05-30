require 'rails_helper'

RSpec.describe UriHelper, type: :class do
  before :each do
    @klass = Class.new { include UriHelper }
  end

  describe '.valid_uri?' do
    it "returns true if provided a valid uri" do
      expect(@klass.valid_uri?('http://example.com')).to be true
    end

    it "returns false if provided an invalid uri" do
      expect(@klass.valid_uri?('abcd')).to be false
    end
  end
end
