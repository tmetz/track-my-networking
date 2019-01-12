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
            @user = current_user
            @person = Person.find_by_id(params[:id])
            if @user.persons.include?(@person)
                @interactions = Interaction.where("person_id = ? and user_id = ?", params[:id], @user.id)
                erb :'/persons/show'
            else
                flash[:message] = "This is not one of your connections, sorry."
                redirect '/failure'
            end
        else
            redirect '/login'
        end
    end

end