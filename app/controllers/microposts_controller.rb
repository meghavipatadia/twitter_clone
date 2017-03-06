class MicropostsController < ApplicationController
    

def create 
  @micropost = current_user.microposts.build(micropost_params)
  if @micropost.save
    flash[:success] = "Micropost created..."
    redirect_to root_url
  else
     @feed_items = current_user.microposts.paginate(page: params[:page])
      render 'static_pages/home'
  end
end

def destroy
  if @micropost.nil?
   @micropost = current_user.microposts.find_by(id: params[:id])
   @micropost.destroy
   flash[:success] = "Micropost deleted"
   redirect_to request.referer || root_url
  else
    redirect_to root_url
  end
end

private
  def micropost_params
      params.require(:micropost).permit(:content, :picture)
  end
end
