class UsersController < ApplicationController

    get '/signup' do
      if logged_in?
        redirect '/persons'
      else
        erb :'users/signup'
      end
    end

    post '/signup' do
      if !params[:email].empty? && !params[:password].empty?
        @user = User.create(email: params[:email], password: params[:password])
        session[:user_id] = @user.id
        redirect "/persons"
      else
        redirect "/signup"
      end
    end

    get "/login" do
        if logged_in?
            redirect "/persons"
        else
            erb :"/users/login"
        end
    end

    post "/login" do
        user = User.find_by(:email => params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/persons"
        else
            redirect "/failure"
        end
    end

    get '/logout' do
      if logged_in?
        session.clear
        redirect '/login'
      else
        redirect '/failure'
      end
    end


    get "/users/:slug" do
        @user = User.find_by_slug(params[:slug])
        @persons = Person.where(["user_id = ?", @user.id])
        erb :'/users/show'
    end

    get "/failure" do
        erb :failure
    end

end