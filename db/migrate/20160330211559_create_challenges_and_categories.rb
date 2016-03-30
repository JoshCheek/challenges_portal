class CreateChallengesAndCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string  :name
      t.integer :parent_id
    end

    create_table :challenges do |t|
      t.string  :name
      t.integer :parent_id
    end
  end
end
