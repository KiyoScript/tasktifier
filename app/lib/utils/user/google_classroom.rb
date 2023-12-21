class Utils::User::GoogleClassroom
  def initialize(user)
    @user = user
    @classroom_service = Google::Apis::ClassroomV1::ClassroomService.new
    @classroom_service.authorization = @user.google_token
  end

  def course_work
    courses = get_courses

    courses.each do |course|
      works = @classroom_service.list_course_works(course[:id])
      category = Category.find_or_create_by( name: 'GoogleClassroom', user_id: @user.id ) if works.present?
      if works.present?
        works.course_work.each do |work|
          due_date = work.due_date.to_h
          year = due_date[:year]
          next unless year == Date.today.year
          task = Task.where(
            title: work.title,
            due_date: parse_date(work.due_date.to_h),
            notes: work.description,
            url: work.alternate_link,
            status: course[:status],
            category_id: category.id,
            user_id: @user.id
          ).first_or_create
        end
      end
    end
  end


private

  def parse_date(hash)
    Date.new(hash[:year], hash[:month], hash[:day])
  end

  def get_courses
    begin
      list_course = @classroom_service.list_courses
      return [] if list_course.courses.nil?
      courses = []

      if list_course.courses.present?
        list_course.courses.each do |course|
          course_details = {
            id: course.id,
            name: course.name,
            status: course.course_state.downcase,
            description: course.description,
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
