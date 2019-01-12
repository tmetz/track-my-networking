class PersonsController < ApplicationController

    get '/persons' do
        if logged_in?
            @user = User.find_by_slug(params[:slug])
            if current_user == @user # don't want a user to be able to see another user's activity
              @persons = @user.persons
              erb :'/persons/index'
            else
              redirect '/login'
            end
        else 
            redirect '/login'
        end
    end

end