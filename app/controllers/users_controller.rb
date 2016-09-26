get '/users' do
  data = zipcodes_in_range(current_user.zip_code)
  zip_code_info = data["zip_codes"]
  @users = []
  @distances = {}
  zip_code_info.each do |hash|
    @users += User.where(zip_code: hash["zip_code"])
    @distances[hash["zip_code"]] = hash["distance"]
  end
  if params[:instrument] != ""
    @users = @users.select { |user| user.instruments.include? Instrument.find_by(name: params[:instrument].downcase) }
  end
  if params[:genre] != ""
    @users = @users.select { |user| user.genres.include? Genre.find_by(name: params[:genre].downcase) }
  end
  if request.xhr?
    erb(:'/users/index', layout: false, locals: {users: @user, distances: @distances})
  else
    erb :'/users/index'
  end
end

get '/users/new' do
  erb :'/users/new'
end

post '/users' do
  if params[:user][:password] != params[:confirm_pw]
    @errors = ["Passwords must match"]
    return erb :'/users/new'
  end
  user = User.new(params[:user])
  user.city_state
  if user.save
    session[:user_id] = user.id
    redirect "/users/#{user.id}"
  else
    @errors = user.errors.full_messages
    erb :'/users/new'
  end
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :'/users/show'
end

get '/users/:id/edit' do
  erb :'/users/edit'
end

put '/users/:id' do
  #edit your profile
  #redirect
end

get '/users/:id/instruments/edit' do
  erb :'users/_instruments_edit'
end

put '/users/:id/instruments/edit' do
  #update instruments
end

get '/users/:id/genres/edit' do
  erb :'users/_genres_edit'
end

put '/users/:id/instruments/edit' do
end

delete '/users/:id' do
  #delete your own profile when logged in
end
