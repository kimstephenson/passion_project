get '/sessions/new' do
  erb :'/sessions/new'
end

post '/sessions' do
  #log in & authenticate user
  #if there was a problem, erb w/ errors
  #else, redirect to profile page
end

delete '/sessions' do
  #log out
  #redirect home
end
