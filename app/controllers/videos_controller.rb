class VideosController < ApplicationController
  def index
    @search_terms = params[:list].split("\r\n")
  end

  def show
  end

  def accept
  end

  def reject
  end

  def retry
  end

  private
  def videos_params
    params.permit(:list)
  end
end
