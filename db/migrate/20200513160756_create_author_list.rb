class CreateAuthorList < ActiveRecord::Migration[6.0]
  def change
    create_table :author_lists do |t|
      t.integer :records, null: false
      t.string :original_list, array: true , null: false
      t.string :formatted_list, array: true
    end
  end
end
