class VideosController < ApplicationController
  require 'open-uri'

  def index
    @search_terms = params[:video][:list].split("\r\n")
  end

  def show
    @params = params[:search_terms]
  end

  def viewer
    @search_terms = params[:video][:list].split("\r\n")
    @offset = params[:video][:offset].to_i || @offset = 0
    @video_list = []
    @image_url_list = []

    current_search = @search_terms[@offset]
    search_results = Nokogiri::HTML(open("http://www.youtube.com/results?search_query=#{current_search}"))

    search_results.xpath("//img").each do |image|
      @image_url_list << (image.values.select { |v| v[/https:\/\/i.ytimg.com\/vi\/*/]}[0]) unless image.values.select { |v| v[/https:\/\/i.ytimg.com\/vi\/*/]}.empty?
    end

    @image_url_list.each do |url|
      @video_list << url[/https:\/\/i.ytimg.com\/vi\/(.*)\//, 1]
    end
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
