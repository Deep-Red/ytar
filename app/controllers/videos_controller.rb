class VideosController < ApplicationController
  def index
    @search_terms = params[:video][:list].split("\r\n")
  end

  def show
    @params = params[:search_terms]
  end

  def viewer
    @search_terms = params[:video][:list].split("\r\n")
    @offset = params[:video][:offset].to_i || @offset = 0
  end

  def accept
  end

  def reject
  end

  def retry
  end

  private
  def videos_params
    params.permit(:list, :offset)
  end
end
