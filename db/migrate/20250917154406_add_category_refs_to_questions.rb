class AddCategoryRefsToQuestions < ActiveRecord::Migration[7.2]
  def change
    add_reference :questions, :industry_category,   null: true, foreign_key: true
    add_reference :questions, :occupation_category, null: true, foreign_key: true

    add_index :questions, [:industry_category_id, :status_label, :created_at],   name: "idx_q_indcat_status_created"
    add_index :questions, [:occupation_category_id, :status_label, :created_at], name: "idx_q_occucat_status_created"
  end
end

