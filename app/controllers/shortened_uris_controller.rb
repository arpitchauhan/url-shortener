class ShortenedUrisController < ApplicationController

  def create
    shortened_uri = ShortenedUri.new(shortened_uri_params)
    if shortened_uri.save
      render json: shortened_uri, status: :created
    else
      render json: shortened_uri.errors, status: :unprocessable_entity
    end
  end

  def access_uri
    record = ShortenedUri.find_by!(shortened_relative_uri: params[:path])
    redirect_to record.original_uri
  end

  private

  def shortened_uri_params
    params.permit(:original_uri)
  end
end
