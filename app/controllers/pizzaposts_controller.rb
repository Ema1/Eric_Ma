class pizzapostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
  end
  
  def create
    @pizzapost = current_user.pizzaposts.build(pizzapost_params)
    if @pizzapost.save
      flash[:success] = "Pizza created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @pizzapost.destroy
    redirect_to root_url
  end

  private

    def pizzapost_params
      params.require(:pizzapost).permit(:content)
    end
	    
	def correct_user
      @pizzapost = current_user.pizzaposts.find_by(id: params[:id])
	rescue
	  redirect_to root_url
	end
end