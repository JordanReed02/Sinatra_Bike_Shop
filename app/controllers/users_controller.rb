require 'pry'
class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to '/projects'
    end
  end

  post '/signup' do
    if params.values.any? {|value| value == ""}
      erb :'users/signup', locals: {message: "You can't do that!"}
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/projects'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/projects'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/projects'
    else
      erb :'users/login', locals: {message: "You credentials are incorrect!"}
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to '/'
    else
      redirect to '/projects'
    end
  end

end
