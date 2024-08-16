[
  ['Курс математики', 'Иванов Иван', ['Математика']],
  ['Курс физики', 'Петров Пётр', ['Физика', 'Математика']],
  ['Курс химии', 'Сидоров Сидор', ['Химия', 'Математика']],
  ['Курс программирования', 'Иванов Иван', ['Программирование', 'Математика', 'Физика']],
  ['Курс английского языка', 'Петров Пётр', ['Английский язык']],
].each do |course_title, author_name, competences|
  course = Course.find_or_initialize_by(title: course_title)

  course.author = Author.find_or_create_by(name: author_name)

  course.competences =
    competences.map do |competence_title|
      Competence.find_or_create_by(title: competence_title)
    end

  course.save!
end
