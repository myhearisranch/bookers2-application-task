class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|

      t.timestamps
      t.references :user
      t.references :room
      t.text :message

    end
  end
end
