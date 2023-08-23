class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user,                   null: false, foreign_key: true
      t.string     :title,                  null: false
      t.text       :text,                   null: false
      t.integer    :category_id,            null: false
      t.integer    :sales_status_id,        null: false
      t.integer    :shipping_cost_id,       null: false
      t.integer    :prefecture_id,          null: false
      t.integer    :scheduled_delivery_id,  null: false
      t.integer    :shipping_date_id,       null: false, default: 1
      t.integer    :price,                  null: false
      t.timestamps
    end
  end
end