class VideosController < ApplicationController
  require 'open-uri'

  def index
    @search_terms = params[:video][:list].split("\r\n")
  end

  def viewer
    set_session_videos_and_urls

    video_list = session[:video_list]
    attempt_number = session[:attempt_number]
    @video = "https://www.youtube.com/embed/#{video_list[attempt_number]}?rel=0&autoplay=true"

    respond_to do |format|
      format.html
      format.js
    end
  end

  def accept
    search_terms = session[:search_terms]
    video_list = session[:video_list]
    attempt_number = session[:attempt_number]
    session[:accepted] << video_list[attempt_number]

    advance_search_term

    attempt_number = session[:attempt_number]
    offset = session[:offset]

    redirect_to videos_finalize_path unless offset < search_terms.length

    current_search = search_terms[offset]
    video_list = set_video_list(current_search)

    @video = "https://www.youtube.com/embed/#{video_list[attempt_number]}?rel=0&autoplay=true"

    respond_to do |format|
      format.html {redirect_to videos_viewer_path}
      format.js
    end
  end

  def reject
    search_terms = session[:search_terms]
    video_list = session[:video_list]
    offset = session[:offset]
    session[:rejected] << search_terms[offset]

    advance_search_term

    attempt_number = session[:attempt_number]
    offset = session[:offset]

    redirect_to videos_finalize_path unless offset < search_terms.length

    current_search = search_terms[offset]
    video_list = set_video_list(current_search)

    @video = "https://www.youtube.com/embed/#{video_list[attempt_number]}?rel=0&autoplay=true"

    respond_to do |format|
      format.html {redirect_to videos_viewer_path}
      format.js
    end
  end

  def retry
    video_list = session[:video_list]
    attempt_number = (session[:attempt_number] += 1)

    redirect_to videos_reject_path unless attempt_number < video_list.length

    @video = "https://www.youtube.com/embed/#{video_list[attempt_number]}?rel=0&autoplay=true"

    respond_to do |format|
      format.html {redirect_to videos_viewer_path}
      format.js
    end
  end

  def finalize
    @search_terms = session[:search_terms]
    @accepted = session[:accepted]
    @rejected = session[:rejected]

    respond_to do |format|
      format.html { redirect_to videos_viewer_path }
      format.js
    end
  end

  def download
    yt_options = {"audio-format"=>"mp3", "extract-audio"=>true, "o"=>"public/%(title)s.%(ext)s"}
    dl_options = {"filename"=>"Celebrate", "disposition"=>"attachment"}
    audio = YoutubeDL.download("https://www.youtube.com/watch?v=k2EVsIfq0Y8", yt_options)
    dl_path = Rails.root + "public/" + File.basename(audio.filename, File.extname(audio.filename))
    dl_path = [dl_path, ".mp3"].join('')

    send_file(dl_path, dl_options)
#     send_data("lasso", filename: 'lass.txt')
  end

  private
  def set_session_videos_and_urls
    search_terms = params[:video][:list].split("\r\n")
    offset = 0
    attempt_number = 0
    video_list = []

    current_search = search_terms[offset]

    video_list = set_video_list(current_search)

    initialize_session_variables(search_terms, video_list, offset, attempt_number)
  end

  def set_video_list(current_search)
    image_url_list = []
    video_list = []
    search_results = Nokogiri::HTML(open("http://www.youtube.com/results?search_query=#{current_search}"))

    search_results.xpath("//img").each do |image|
      image_url_list << (image.values.select { |v| v[/https:\/\/i.ytimg.com\/vi\/*/]}[0]) unless image.values.select { |v| v[/https:\/\/i.ytimg.com\/vi\/*/]}.empty?
    end

    image_url_list.each do |url|
      video_list << url[/https:\/\/i.ytimg.com\/vi\/(.*)\//, 1]
    end
    session[:video_list] = video_list

    return video_list
  end

  def initialize_session_variables(st, vl, o, an)
    session[:search_terms] = st
    session[:video_list] = vl
    session[:offset] = o
    session[:attempt_number] = an
    session[:accepted] = []
    session[:rejected] = []
  end

  def advance_search_term
    session[:attempt_number] = 0
    session[:offset] += 1
  end

  def videos_params
    params.permit(:list)
  end

end
