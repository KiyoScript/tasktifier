class Google::GoogleClassroom # INP
  def initialize(token)
    @classroom_service = Google::Apis::ClassroomV1::ClassroomService.new
    @classroom_service.authorization = token
  end

  def get_courses(args*)
    courses = @classroom_service.list_courses.courses
    courses.reject { |course| course.course_status != "ACTIVE" }
  end
end