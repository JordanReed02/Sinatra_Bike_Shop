require 'pry'
class PartsController < ApplicationController
  get '/projects/:id/parts/new' do
    if logged_in?
      @project = Project.find(params[:id])
      erb :'parts/new'
    else
      erb :'users/login', locals: {message: "You don't have access, please login"}
    end
  end

  post '/projects/:id' do
    if params.values.any? {|value| value == ""}
      redirect to "/projects/#{params[:id]}/parts/new"
    else
      @project = Project.find(params[:id])
      @part = Part.new(name: params[:name], price: params[:price])
      @part.save
      @project.parts << @part
      redirect to "/projects/#{@project.id}"
    end
  end

  delete '/projects/:id/parts/:part_id/delete' do 
    @project = Project.find(params[:id])
    @part = Part.find(params[:part_id])
    if logged_in?
      @project = Project.find(params[:id])
      if @project.user_id == session[:user_id]
        @part = Part.find(params[:part_id])
        @part.delete
        redirect to "/projects/#{@project.id}"
      else
        redirect to "/projects/#{@project.id}"
      end
    else
      erb :'users/login', locals: {message: "You don't have access, please login"}
    end
  end

end
