class CreateJoinTableCoursesCompetences < ActiveRecord::Migration[7.2]
  def change
    create_join_table :courses, :competences do |t|
      t.index [ :course_id, :competence_id ]
      t.index [ :competence_id, :course_id ]
    end
  end
end
