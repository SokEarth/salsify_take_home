class Init < ActiveRecord::Migration[6.0]
  def change
    create_table "gifs", force: :cascade do |t|
      t.string "url"
      t.string "who"
      t.datetime "when"
      t.string "meme_top"
      t.string "meme_bottom"
    end
  end
end
