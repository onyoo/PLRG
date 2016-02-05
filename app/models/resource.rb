class Resource < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user


  def self.in_alphabetical_order
    order(:name)
  end

  def self.delete_all
    params[:delete_resources].each{|k,v| Resource.delete(k)}
  end

  def self.not_empty?(params)
    params[:name] != "" && params[:url] != "" && params[:description] != "" && params[:id] != ""
  end

  def self.in_alphabetical_order
    order(:name)
  end

end