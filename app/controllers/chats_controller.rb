class ChatsController < ApplicationController

    before_action :authenticate_user

    def show

        @chat = Chat.find_by(id: params[:id])

        @messages = @chat.messages
        @message = Message.new
    end

    def new
        @chat = Chat.new
    end

    def create

        other_user = User.find_by(screen_name: params[:chat][:screen_name])

        if other_user
        
            @chat = Chat.create(name: "Chat with #{@authenticated_user.screen_name} and #{other_user.screen_name}")
            @chat.users << @authenticated_user
            @chat.users << other_user
            @chat.messages.create(
                user_id: @authenticated_user.id,
                chat_id: @chat.id,
                content: "#{@authenticated_user.screen_name} invited #{other_user.screen_name} to a chat!"
            )
            redirect_to @chat
        else

            redirect_to @authenticated_user, notice: "Screen Name '#{params[:chat][:screen_name]}' not found"
        end

    end

    def update

    end

    def destroy
    
    end
end
