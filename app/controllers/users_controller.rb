class UsersController < ApplicationController

    get '/signup' do
      if logged_in?
        redirect '/persons'
      else
        erb :'users/signup'
      end
    end

    post '/signup' do
      if !params[:email].empty? && !params[:password].empty? && unique_em?(params[:email])
        @user = User.create(email: params[:email], password: params[:password])
        session[:user_id] = @user.id
        redirect "/persons"
      else
        redirect "/signup"
      end
    end

    get "/login" do
        if logged_in?
            redirect "/users/#{current_user.slug}"
        else
            erb :"/users/login"
        end
    end

    post "/login" do
        user = User.find_by(:email => params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/users/#{user.slug}"
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
        if logged_in?
          @user = User.find_by_slug(params[:slug])
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

    helpers do
      def logged_in?
        !!session[:user_id]
      end
  
      def current_user
        # only looks for the user if it's not already populated
        # if it is populated, returns the cached result
        # Otherwise looks for the user
        # this is called memoization
        @current_user ||= User.find(session[:user_id])
      end

      def unique_em?(email)
        if User.find_by_email(email) == nil
          return true
        else
          return false
        end
      end
    end

end