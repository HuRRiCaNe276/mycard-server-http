#encoding: UTF-8
class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :comments
  has_many :attachments
  accepts_nested_attributes_for :attachments
  
  validates :content,  :presence => true
  validates :user_id, :numericality => { :greater_than => 0, :message => "发帖请先登录" }
  def user
    super || User::Guest
  end
  def self.today
    Post.where(['created_at > ?',  Time.now.beginning_of_day ])
  end
  def self.yesterday
    Post.where(['created_at < ? and created_at > ?', Time.now.beginning_of_day, Time.now.yesterday.beginning_of_day ])
  end
  def to_s
  	  "#{topic}, <a href=/topics/#{topic.id}#post#{id}>#{displayorder}#</a>".html_safe
  end
end
