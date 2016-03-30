class Challenge < ActiveRecord::Base
  belongs_to :parent,
             class_name: 'Category',
             inverse_of: :children_challenges
end
