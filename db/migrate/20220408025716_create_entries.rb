class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|

      t.timestamps
      t.references :user
      t.references :room

    end
  end
end
