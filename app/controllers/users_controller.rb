class UsersController < ApplicationController

    get '/signup' do
      if logged_in?
        redirect '/persons'
      else
        erb :'users/signup'
      end
    end

    post '/signup' do
      if !params[:email].empty? && !params[:password].empty? && !params[:name].empty? && unique_em?(params[:email])
        @user = User.create(name: params[:name], email: params[:email], password: params[:password])
        session[:user_id] = @user.id
        redirect "/persons"
      else
        redirect "/signup"
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


    get "/users/:id" do
        if logged_in?
          @user = User.find_by_id(params[:id])
          if current_user == @user # don't want a user to be able to see another user's activity
            @persons = Person.where(["user_id = ?", @user.id])
            erb :'/users/show'
          else
            redirect '/login'
          end
        else 
          redirect '/login'
        end
    end

    get "/failure" do
        erb :failure
    end

end