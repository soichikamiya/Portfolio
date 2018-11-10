# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Post < ActiveRecord::Base
    belongs_to :user
    
    validates :content, {presence: true, length: {maximum: 200}}
    validates :user_id, {presence: true}
    
    def user
        return User.find_by(id: self.user_id)
    end
    
    def like
        return Like.find_by(post_id: self.id)
    end
    
end
