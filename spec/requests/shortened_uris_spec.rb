require 'rails_helper'

RSpec.describe "ShortenedUris", type: :request do
  describe "POST /create" do
    before :each do
      @payload = attributes_for(:shortened_uri)
    end

    context "when given a new valid URI to shorten" do
      it "creates a new shortened uri" do
        post '/shortened_uris', params: @payload
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to have_key('shortened_relative_uri')
      end
    end

    context "when given a new invalid URI to shorten" do
      it "responds with appropriate error" do
        post '/shortened_uris', params: @payload.merge(original_uri: 'abcd')
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['original_uri']).to eq(['is not a valid URI'])
      end
    end

    context "when given an already present URI to shorten" do
      it "responds with appropriate error" do
        create(:shortened_uri, original_uri: @payload[:original_uri])
        post '/shortened_uris', params: @payload
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['original_uri']).to eq(['has already been taken'])
      end
    end
  end

  describe "GETting a shortened uri" do
    context "when given a valid shortened uri" do
      it "redirects to the corresponding original uri" do
        record = create(:shortened_uri)
        get "/#{record.shortened_relative_uri}"
        expect(response).to redirect_to(record.original_uri)
      end
    end

    context "when given an invalid shortened uri" do
      it "says not found" do
        get "/ifjoBEFo9"
        expect(response).to have_http_status(404)
      end
    end
  end
end
