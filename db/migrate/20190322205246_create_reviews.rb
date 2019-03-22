class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :product, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :description
      t.integer :rating
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false

      t.timestamps null: false
    end
  end
end
