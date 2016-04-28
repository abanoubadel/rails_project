class Order < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :restaurant
  has_many :items_orders
  has_and_belongs_to_many :users
  has_and_belongs_to_many :items
  belongs_to :owner, :class_name => "User", foreign_key: :owner_id

  Meals={1=>'breakfast',2=>'lunch',3=>'dinner'}
  Status={0=>'inactive',1=>'active'}

  def get_meal
    Meals[self.meal]
  end
  def get_status
    Status[self.status]
  end
end
