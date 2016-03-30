class Category < ActiveRecord::Base
  belongs_to :parent,            class_name: 'Category',  inverse_of: :children_categories
  has_many :children_categories, class_name: 'Category',  inverse_of: :parent, foreign_key: :parent_id
  has_many :children_challenges, class_name: 'Challenge', inverse_of: :parent, foreign_key: :parent_id
end
