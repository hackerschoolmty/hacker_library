class NotificationJob < ActiveJob::Base
  queue_as :default

  def perform book_id, comment_id
    book = Book.find(book_id)
    comment = Comment.find(comment_id)
    NotificationMailer.add_comment_notification(book, comment).deliver_later
    # Do something later
  end
end
