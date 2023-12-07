class CreateFunds < ActiveRecord::Migration[7.1]
  def change
    create_table :funds do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total_amount

      t.timestamps
    end
  end
end
