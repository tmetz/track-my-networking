require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "networkallthethings"
  end

  get "/" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :welcome
    end
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
