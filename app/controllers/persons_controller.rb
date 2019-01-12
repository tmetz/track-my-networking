class PersonsController < ApplicationController

    get '/persons' do
        if logged_in?
            @user = current_user
            @persons = @user.persons
            erb :'/persons/index'
        else 
            redirect '/login'
        end
    end

    get "/persons/:id" do
        if logged_in?
            @person = Person.find_by_id(params[:id])
            erb :'/persons/show'
        else
            redirect '/login'
        end
    end

end