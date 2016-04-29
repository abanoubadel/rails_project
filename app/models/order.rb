class Order < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :restaurant
  has_many :items_orders
  has_and_belongs_to_many :users
  has_and_belongs_to_many :items
  belongs_to :owner, :class_name => "User", foreign_key: :owner_id

  Meals={1 => 'breakfast', 2 => 'lunch', 3 => 'dinner'}
  Status={0 => 'inactive', 1 => 'active'}

  def get_meal
    Meals[self.meal]
  end

  def get_status
    Status[self.status]
  end

  def is_owner?(user)
    if self.owner_id?
      self.owner == user
    else
      true
    end
  end

  def is_user_allowed?(user)
    if (is_owner? user)
      true
    else
      self.users.include? user
    end
  end

end
