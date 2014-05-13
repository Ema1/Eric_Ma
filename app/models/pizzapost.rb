class Pizzapost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 100 }
  validates :user_id, presence: true
  
  private 
  
    def pizzapost_params
      params.require(:micropost).permit(:content)
    end
end