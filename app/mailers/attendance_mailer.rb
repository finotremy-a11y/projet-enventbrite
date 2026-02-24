class AttendanceMailer < ApplicationMailer
  default from: ENV["GMAIL_USERNAME"]

  def new_attendance_email(attendance)
    @attendance = attendance
    @event = attendance.event
    @admin = @event.admin
    @participant = attendance.user

    mail(to: @admin.email, subject: "Nouvelle participation à ton événement !")
  end
end
