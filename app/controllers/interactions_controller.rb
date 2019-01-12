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
            if !params[:person][:name].empty?
                @interaction.person = Person.find_or_create_by(:name => params[:person][:name])
            else
                @interaction.person = Person.find_by_id(params[:interaction][:person_id])
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

end