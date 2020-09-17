class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  before_action :short_url, only: :show

  def index
    url_objects = ShortUrl.top_urls
    render json: { urls: url_objects }, status: :ok
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
    if short_url.nil?
      render json: {message: 'not found'}, status: 404
    else
      short_url.increment_visit!
      redirect_to short_url.full_url
    end
  end

  private

  def short_urls_create_params
    params.permit(:full_url)
  end

  def short_url
    @short_url ||= ShortUrl.find_by(short_code: params[:id])
  end

end
