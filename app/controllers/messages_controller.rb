class MessagesController < ApplicationController
    before_action :set_message, only: [:show, :edit, :update,:destroy]
    
    def index
      @messages = Message.all
    end
  
    def new
      if params[:back]
        @message = Message.new(message_params)
      else
        @message = Message.new
      end
    end
  
    def create
      @message = current_user.messages.build(message_params)
      if params[:back]
        render :new
      else
        if @message.save
        redirect_to messages_path, notice: "投稿しました！"
        else
          render :new
        end
      end
    end
  
    def show
      @message = Message.find(params[:id])
    end
  
    def edit
      @message = Message.find(params[:id])
    end
  
    def update
      @message = Message.find(params[:id])
      if @message.update(message_params)
        redirect_to messages_path, notice: "投稿を編集しました！"
      else
        render :edit
      end
    end
  
    def destroy
      @message.destroy
      redirect_to messages_path, notice:"投稿を削除しました！"
    end
  
    def confirm
      @message = current_user.messages.build(message_params)
      render :new if @message.invalid?
    end
  
    def image
      @messages = Message.where(user_id: current_user.id).where.not(image: nil)
    end

      private
  
      def set_message
        @message = Message.find(params[:id])
      end

      def message_params
        params.require(:message).permit(:title, :content, :image, :image_cache)
      end
  end
  