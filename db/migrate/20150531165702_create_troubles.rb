class CreateTroubles < ActiveRecord::Migration
  def change
    create_table :troubles do |t|
      t.text :question, :null => false
      t.string :encrypt_question, :null => false
      t.text :answers , :null => false
      t.string :correct , :null => false
      t.timestamps null: false
    end
    add_index :troubles, :encrypt_question
  end
end
