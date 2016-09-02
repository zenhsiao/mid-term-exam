class MessagesController < ApplicationController
	before_action :authenticate_user! , :except=>[:index,:show]
	before_action :set_message, :only=>[:edit,:update,:destroy]
	
	def index
		@messages=Message.page(params[:page]).per(5)
	end

	def new
		@message=Message.new
	end

	def create
		@message=Message.new(message_params)
        @message.user=current_user
        @message.save
        redirect_to message_path(@message)
	end

	def show
		@message=Message.find(params[:id])
	end

	def edit
		@message=current_user.messages.find_by_id(params[:id])
		unless @message.user==current_user
			flash[:notice]="you are not allowed"
			redirect_to messages_path
			return
		end
	end

	def update
		
		@message.update(message_params)
		redirect_to message_path(@message)

	end

	def destroy
		
		@message.delete
		redirect_to messages_path
	end

	private
	def message_params
		params.require(:message).permit(:title,:content,:category_id)
	end

	def set_message
		@message=current_user.messages.find_by_id(params[:id])
		unless @message
			flash[:notice]="you are not allowed"
			redirect_to messages_path
			return
		end
		
	end
end
