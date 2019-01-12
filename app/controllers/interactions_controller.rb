class InteractionsController < ApplicationController

    get '/interactions' do
        if logged_in?
            @user = current_user
            erb :'/interactions/index'
        else
            redirect '/login'
        end
    end

    get "/interactions/:id" do
        if logged_in?
            @interaction = Interaction.find_by_id(params[:id])
            if @interaction.user_id == current_user.id
                erb :'/interactions/show'
            else
                redirect '/failure'
            end
        else
            redirect '/login'
        end
    end

end