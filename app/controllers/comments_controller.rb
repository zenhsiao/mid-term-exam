class CommentsController < ApplicationController
	before_action :authenticate_user! , :except=>[:index,:show]
	def create
		@message=Message.find(params[:message_id])
		@comment=@message.comments.build(params.require(:comment).permit(:content))
		@comment.save
		redirect_to message_path(@message)
	end

	def destroy
		@message=Message.find(params[:message_id])
		@comment=@message.comments.find(params[:id])
		
		if current_user.id==@comment.user_id
		 @comment.delete
		 redirect_to message_path(@message)
		else
		 flash[:notice]="you are not allowed"
	    end
				
	end
end
