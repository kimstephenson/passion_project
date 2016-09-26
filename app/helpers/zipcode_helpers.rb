helpers do
  def zipcodes_in_range(zipcode)
    JSON.parse(open("https://www.zipcodeapi.com/rest/#{ENV["ZIP_CODE_KEY"]}/radius.json/#{zipcode}/#{params[:distance]}/mile").read)
  end
end