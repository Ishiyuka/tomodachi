class MessagesController < ApplicationController
    before_action :set_message, only: [:show, :edit, :update,:destroy]
    
    def index
      @messages = Message.all
      binding.pry
    end
  
    def new
      @message = Message.new
      @message.image.build
    end
  
    def create
      @message = Message.new(message_params)
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
      if @message.update(post_params)
        redirect_to messages_path, notice: "投稿を編集しました！"
      else
        render :edit
      end
    end
  
    def destroy
      @post.destroy
      redirect_to messages_path, notice:"投稿を削除しました！"
    end
  
    def confirm
      @message = Message.new(message_params)
      render :new if @message.invalid?
    end
  
      private
  
      def message_params
        params.require(:message).permit(:content)
      end
  
      def set_message
        @message = Message.find(params[:id])
      end
  end
  