get '/sessions/new' do
  erb :'/sessions/new'
end

post '/sessions' do
  user = User.authenticate(params[:email], params[:password])
  redirect '/' unless user
  session[:user_id] = user.id
  redirect "/users/#{user.id}"
end

delete '/sessions' do
  session[:user_id] = nil
  redirect '/'
end
