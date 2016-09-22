get '/users' do
  data = open("https://www.zipcodeapi.com/rest/KCU6dzg4gdRJy4xhUBqypOe3w2nAhTX2wS9KrpOIDGscKZtFBUd1Is4fvrPNlNPS/radius.json/#{current_user.zip_code}/#{params[:distance]}/mile").read
  #parse zipcodes
  #display how far away user is?
  #get instrument & genre params
  erb :'/users/index'
end

get '/users/new' do
  erb :'/users/new'
end

post '/users' do
  if params[:password] != params[:confirm_pw]
    @errors = ["Passwords must match"]
    return erb :'/users/new'
  end
  user = User.new(params[:user])
  user.password = params[:password]
  if user.save
    session['user'] = user.id
    redirect "/users/#{user.id}"
  else
    @errors = user.errors.full_messages
    erb :'/users/new'
  end
end

get '/users/:id' do
  erb :'/users/show'
end

get '/users/:id/edit' do
  #form to edit your profile when logged in
end

put '/users/:id' do
  #edit your profile
  #redirect
end

delete '/users/:id' do
  #delete your own profile when logged in
end
