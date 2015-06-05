class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :item, :null => false
      t.string :encrypt_item
      t.integer :code
      t.boolean :checked
      t.timestamps null: false 
    end
    add_reference :answers, :question, index: true
    add_index :answers, :encrypt_item
    add_index :answers, :code
  end

end
