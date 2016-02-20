# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview

  def add_comment_notification
    NotificationMailer.add_comment_notification(Book.first, Comment.first)
  end
end
