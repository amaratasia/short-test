class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
  end

  def create
    short_url = ShortUrl.new(short_urls_create_params)
    if short_url.save
      render json: short_url.object, status: :ok
    else
      render json: {errors: short_url.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def short_urls_create_params
    params.permit(:full_url)
  end

end
