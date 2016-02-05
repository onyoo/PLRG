class Category < ActiveRecord::Base
  has_many :topics, dependent: :destroy

  def self.in_alphabetical_order
    order(:name)
  end

  def self.delete_all(params)
    params[:delete_categories].each{ |k,v| Category.destroy(k) }
  end

end