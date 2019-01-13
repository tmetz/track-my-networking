class PersonsController < ApplicationController

    get '/persons' do
        if logged_in?
            @user = current_user
            @persons = @user.persons.uniq
            erb :'/persons/index'
        else 
            redirect '/login'
        end
    end

    get "/persons/recent" do
        if logged_in?
            @user = current_user
            @persons = @user.persons.where("updated_at > ?", 7.days.ago).uniq
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

    get '/persons/:id/edit' do
        if logged_in?
            @user = current_user
            @person = Person.find_by_id(params[:id])
            if @user.persons.include?(@person)
                erb :"/persons/edit"
            else
                flash[:message] = "This is not one of your connections, sorry."
                redirect '/failure'
            end
        else
            redirect '/login'
        end
    end

    patch '/persons/:id' do
        @person = Person.find_by_id(params[:id])
        if @person.name != params[:person][:name]
            @person.name = params[:person][:name]
        end
        if @person.company_name != params[:person][:company_name]
            @person.company_name = params[:person][:company_name]
        end
        if @person.subjects != params[:person][:subjects]
            @person.subjects = params[:person][:subjects]
        end
        if @person.meeting_place != params[:person][:meeting_place]
            @person.meeting_place = params[:person][:meeting_place]
        end
        if @person.linkedin != params[:person][:linkedin]
            @person.linkedin = params[:person][:linkedin]
        end
        if @person.email != params[:person][:email]
            @person.email = params[:person][:email]
        end
        if @person.phone != params[:person][:phone]
            @person.phone = params[:person][:phone]
        end
        @person.save
        flash[:message] = "Successfully updated professional contact."
        redirect to ("/persons/#{@person.id}")
    end

    delete '/persons/:id/delete' do
        @person = Person.find_by_id(params[:id])
        if logged_in? && current_user.persons.include?(@person)
            @person.delete
            flash[:message] = "Successfully deleted #{@person.name}"
            redirect to '/persons'
        else
          redirect to ("/login")
        end
    end

end