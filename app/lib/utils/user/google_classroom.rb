class Utils::User::GoogleClassroom
  def initialize(user)
    @user = user
  end

  def course_work
    google_oauth2_token = @user.google_token

    classroom_service = Google::Apis::ClassroomV1::ClassroomService.new
    classroom_service.authorization = google_oauth2_token

    category = Category.create( name: 'GoogleClassroom', user_id: @user.id ) if classroom_service.present?

    courses.each do |course|
      works = classroom_service.list_course_works(course[:id])
      if works.present?
        works.course_work.each do |work|
          due_date = work.due_date.to_h
          year = due_date[:year]
          next unless year == Date.today.year

          Task.create(
            title: work.title,
            due_date: work.due_date,
            notes: work.description,
            url: work.alternate_link,
            category_id: category.id,
            user_id: @user.id
          )
        end
      end
    end
  end


  private
  def courses
    begin
      google_oauth2_token = @user.google_token

      classroom_service = Google::Apis::ClassroomV1::ClassroomService.new
      classroom_service.authorization = google_oauth2_token

      list_course = classroom_service.list_courses

      return [] if list_course.courses.nil?
      courses = []

      if list_course.courses.present?
        list_course.courses.each do |course|
          course_details = {
            id: course.id,
            name: course.name,
            alternate_link: course.alternate_link
          }
          courses << course_details
        end
      end
      courses
    rescue Google::Apis::AuthorizationError => e
      puts "Unauthorized: #{e.message}"
      return []
    end
  end
end
