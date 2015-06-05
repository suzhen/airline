class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :stem, :null => false
      t.string :encrypt_stem
      t.integer :code
      t.timestamps null: false 
    end
    add_index :questions, :encrypt_stem
    add_index :questions, :code
  end
end
