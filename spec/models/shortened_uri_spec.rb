require 'rails_helper'

RSpec.describe ShortenedUri, type: :model do
  context 'validations' do
    before :each do
      @shortened_uri = build(:shortened_uri)
    end

    it 'has a valid factory' do
      expect(@shortened_uri).to be_valid
    end

    it 'is not valid without original uri' do
      @shortened_uri.original_uri = nil
      expect(@shortened_uri).to be_invalid
      expect(@shortened_uri.errors[:original_uri].first).to eq("can't be blank")
    end

    it 'is not valid when original uri is not a valid uri' do
      @shortened_uri.original_uri = 'abcd'
      expect(@shortened_uri).to be_invalid
      expect(@shortened_uri.errors[:original_uri].first).to eq("is not a valid URI")
    end

    it 'is not valid when original uri is a duplicate' do
      @shortened_uri.save!
      new_shortened_uri = build(:shortened_uri, original_uri: @shortened_uri.original_uri)
      expect(new_shortened_uri).to be_invalid
      expect(new_shortened_uri.errors[:original_uri].first).to eq("has already been taken")
    end
  end
end
