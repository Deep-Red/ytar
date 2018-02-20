class VideosController < ApplicationController
  require 'open-uri'
  before_action :sanitize_page_params, only: [:viewer, :accept, :reject, :retry]

  def index
    @search_terms = params[:video][:list].split("\r\n")
  end

  def show
    @params = params[:search_terms]
  end

  def viewer
    @search_terms = params[:video][:list].split("\r\n")
    @offset = params[:video][:offset].to_i || @offset = 0
    @attempt_number ||= 0

    set_videos_and_urls if (@image_url_list.nil? || @image_url_list.empty?)

    @video = "https://www.youtube.com/embed/#{@video_list[@attempt_number]}?rel=0&autoplay=true"

    respond_to do |format|
      format.html
      format.js
    end

  end

  def accept
    @search_terms = params[:video][:list].split("\r\n")
    @offset = 1 + params[:video][:offset]
    @attempt_number = 0
    set_videos_and_urls

    @video = "https://www.youtube.com/embed/#{@video_list[@attempt_number]}?rel=0&autoplay=true"

    respond_to do |format|
      format.html {redirect_to videos_viewer_path}
      format.js
    end
  end

  def reject
    @search_terms = params[:video][:list].split("\r\n")
    @offset = 1 + params[:video][:offset]
    @attempt_number = 0
    set_videos_and_urls

    @video = "https://www.youtube.com/embed/#{@video_list[@attempt_number]}?rel=0&autoplay=true"

    respond_to do |format|
      format.html {redirect_to videos_viewer_path}
      format.js
    end
  end

  def retry
    @video_list = params[:video][:list].split("\r\n")
    @attempt_number = params[:video][:list].to_i
    @offset = params[:video][:list].to_i

    @video = "https://www.youtube.com/embed/#{@video_list[@attempt_number]}?rel=0&autoplay=true"

    respond_to do |format|
      format.html {redirect_to videos_viewer_path}
      format.js
    end
  end

  private
  def set_videos_and_urls
    @video_list ||= []
    @image_url_list ||= []
    @search_terms ||= params[:video][:list]
    @offset = params[:video][:offset].to_i
    @attempt_number = params[:video][:attempt_number].to_i

    current_search = @search_terms[@offset]
    search_results = Nokogiri::HTML(open("http://www.youtube.com/results?search_query=#{current_search}"))

    search_results.xpath("//img").each do |image|
      @image_url_list << (image.values.select { |v| v[/https:\/\/i.ytimg.com\/vi\/*/]}[0]) unless image.values.select { |v| v[/https:\/\/i.ytimg.com\/vi\/*/]}.empty?
    end

    @image_url_list.each do |url|
      @video_list << url[/https:\/\/i.ytimg.com\/vi\/(.*)\//, 1]
    end
  end

  def videos_params
    params.permit(:list, :offset, :attempt_number)
  end

  def sanitize_page_params
    params[:offset] = params[:offset].to_i
    params[:attempt_number] = params[:attempt_number].to_i
  end

end
