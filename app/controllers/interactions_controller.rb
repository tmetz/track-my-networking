class InteractionsController < ApplicationController

    get '/interactions' do
        if logged_in?
            @user = current_user
            @persons = Person.where(["user_id = ?", @user.id])
            @interactions = Interaction.where(["user_id = ?", @user.id])
            erb :'/interactions/index'
        else
            redirect '/login'
        end
    end

end