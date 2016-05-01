class ProjectsController < ApplicationController
  get '/projects' do
    if logged_in?
      @projects = Project.all
      erb :'projects/index'
    else
      erb :'users/login', locals: {message: "You don't have access, please login"} 
    end
  end

  get '/projects/new' do
    if logged_in?
      erb :'projects/new'
    else
      erb :'users/login', locals: {message: "You don't have access, please login"}
    end
  end

  post '/projects' do
    if params.values.any? {|value| value == ""}
      erb :'projects/new', locals: {message: "Your missing information!"}
    else
      user = User.find(session[:user_id])
      @project = Project.create(title: params[:title], budget: params[:budget], user_id: user.id)
      redirect to "/projects/#{@project.id}"
    end
  end

  get '/projects/:id' do 
    if logged_in?
      @project = Project.find(params[:id])
      erb :'projects/show'
    else 
      erb :'users/login', locals: {message: "You don't have access, please login"}
    end
  end

  get '/projects/:id/edit' do
    if logged_in?
      @project = Project.find(params[:id])
      if @project.user_id == session[:user_id]
       erb :'projects/edit'
      else
      erb :'projects', locals: {message: "You don't have access to edit this project"}
      end
    else
      erb :'users/login', locals: {message: "You don't have access, please login"}
    end
  end

  patch '/projects/:id' do 
    if params.values.any? {|value| value == ""}
      @project = Project.find(params[:id])
      erb :'projects/edit', locals: {message: "You're missing information"}
      redirect to "/projects/#{params[:id]}/edit"
    else
      @project = Project.find(params[:id])
      @project.title = params[:title]
      @project.budget = params[:budget]
      @project.save
      redirect to "/projects/#{@project.id}"
    end
  end

  delete '/projects/:id/delete' do 
    @project = Project.find(params[:id])
    if session[:user_id]
      @project = Project.find(params[:id])
      if @project.user_id == session[:user_id]
        @project.delete
        redirect to '/projects'
      else
        redirect to '/projects'
      end
    else
      redirect to '/login'
    end
  end

end
