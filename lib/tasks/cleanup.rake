task :cleanup do
  test_code = (Time.now.to_f * 1000000).to_i
  too_long = 200000000000
  Dir.glob("#{Rails.root}/public/ytar*.zip") do |item|
    file_code = item[/(?<=ytar-)\d+(?:(?!\.zip).)*/,0].to_i
    if ((test_code - file_code) > too_long)
      File.delete(item)
    end
  end
end
