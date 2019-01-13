class UsersController < ApplicationController

    get '/signup' do
      if logged_in?
        @user = current_user
        redirect "/users/#{@user.id}"
      else
        erb :'users/signup'
      end
    end

    post '/signup' do
      if !params[:email].empty? && !params[:password].empty? && !params[:name].empty? && unique_em?(params[:email])
        @user = User.create(name: params[:name], email: params[:email], password: params[:password])
        session[:user_id] = @user.id
        redirect "/users/#{@user.id}"
      else
        if !unique_em?(params[:email])
          flash[:message] = "That email address is already in use."
          redirect "/signup"
        elsif params[:email].empty?
          flash[:message] = "You must enter an email address."
          redirect "/signup"
        else
          flash[:message] = "You must enter a password."
          redirect "/signup"
        end
      end
    end

    get "/login" do
        if logged_in?
            redirect "/users/#{current_user.id}"
        else
            erb :"/users/login"
        end
    end

    post "/login" do
        user = User.find_by(:email => params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/users/#{user.id}"
        else
          flash[:message] = "Username and password combination was not found."
            redirect "/failure"
        end
    end

    get '/logout' do
      if logged_in?
        session.clear
        redirect '/login'
      else
        flash[:message] = "You are already logged out."
        redirect '/failure'
      end
    end


    get "/users/:id" do
        if logged_in?
          @user = User.find_by_id(params[:id])
          if current_user == @user # don't want a user to be able to see another user's activity
            erb :'/users/show'
          else
            flash[:message] = "You are not logged in as this user.  Please log in."
            redirect '/failure'
          end
        else 
          redirect '/login'
        end
    end

    get "/failure" do
        erb :failure
    end

end