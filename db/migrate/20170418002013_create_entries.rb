class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.references :user, foreign_key: true
      t.string :term
      t.string :slug
      t.string :definition
      t.string :formatted_definition

      t.timestamps
    end
  end
end
