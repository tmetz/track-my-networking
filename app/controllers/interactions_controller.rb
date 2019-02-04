class InteractionsController < ApplicationController

    get '/interactions' do
        if logged_in?
            @user = current_user
            erb :'/interactions/index'
        else
            redirect '/login'
        end
    end

    get '/interactions/new' do
        @user = current_user
        @people = @user.persons.uniq
        erb :'/interactions/new'
    end

    get "/interactions/:id" do
        if logged_in?
            @user = current_user
            @interaction = Interaction.find_by_id(params[:id])
            if @interaction.user_id == @user.id
                erb :'/interactions/show'
            else
                flash[:message] = "That interaction belongs to another user"
                redirect '/failure'
            end
        else
            redirect '/login'
        end
    end

    post '/interactions' do
        if (!params[:interaction][:year].empty? && !params[:interaction][:month].empty?)
            int_date = Interaction.create_formatted_date(params[:interaction][:year], params[:interaction][:month], params[:interaction][:day])
            @interaction = Interaction.create(:date => int_date, :user_id => current_user.id)
            if params[:interaction][:person_id] == "0"
                @interaction.person = Person.create(params[:person])
            elsif !params[:interaction][:person_id].empty?
                @interaction.person = Person.find_by_id(params[:interaction][:person_id])
            else
                @interaction.delete
                flash[:message] = "You must associate your interaction with a professional contact."
                redirect '/failure'
            end
            if !params[:interaction][:notes].empty?
                @interaction.notes = params[:interaction][:notes]
            end
            @interaction.save
            flash[:message] = "Successfully logged interaction."
            redirect to ("/interactions/#{@interaction.id}")
        else
            flash[:message] = "All interactions need at least a month and year.  Please try again."
            redirect '/failure'
        end
    end

    get '/interactions/:id/edit' do
        if logged_in?
            @user = current_user
            if (Interaction.find(params[:id]).user == @user)
                @interaction = Interaction.find_by_id(params[:id])
                @people = @user.persons.uniq
                erb :'/interactions/edit'
            else
                flash[:message] = "You do not have access to this interaction."
                redirect '/failure'
            end
        else
            flash[:message] = "You must be logged in to edit this interaction."
            redirect '/login'
        end
    end

    patch '/interactions/:id' do
        @interaction = Interaction.find_by_id(params[:id])
        if (@interaction.user == current_user)  
            int_date = Interaction.create_formatted_date(params[:interaction][:year], params[:interaction][:month], params[:interaction][:day])
            if @interaction.date != int_date
                @interaction.date = int_date
            end
            if params[:interaction][:person_id] == "0"
                @interaction.person = Person.create(params[:person])
            elsif !params[:interaction][:person_id].empty? && params[:interaction][:person_id] != nil
                @interaction.person = Person.find_by_id(params[:interaction][:person_id])
            else
                flash[:message] = "You must associate your interaction with a professional contact."
                redirect '/failure'
            end
            if @interaction.notes != params[:interaction][:notes]
                @interaction.notes = params[:interaction][:notes]
            end
            @interaction.save
            flash[:message] = "Successfully updated interaction."
            redirect to ("/interactions/#{@interaction.id}")
        else
            flash[:message] = "You may not edit somebody else's interaction."
            redirect '/failure'
        end
    end

    delete '/interactions/:id/delete' do
        @interaction = Interaction.find_by_id(params[:id])
        if logged_in? && current_user.interactions.include?(@interaction)
            @interaction.delete
            flash[:message] = "Successfully deleted interaction."
            redirect to '/interactions'
        else
          redirect to ("/login")
        end
    end

end