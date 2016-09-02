class CommentsController < ApplicationController
	before_action :authenticate_user! , :except=>[:index,:show]
	def create
		@message=Message.find(params[:message_id])

		@comment=@message.comments.build(params.require(:comment).permit(:content))
		@comment.user_id=current_user.id
		@comment.save
		redirect_to message_path(@message)
	end

	def destroy
		@message=Message.find(params[:message_id])
		@comment=@message.comments.find(params[:id])
		
		if @comment.user_id==current_user.id
		  flash[:notice]="刪除成功"
		 @comment.delete
		 redirect_to message_path(@message)

	    end
				
	end
end
