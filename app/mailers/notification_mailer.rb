class NotificationMailer < ApplicationMailer

  def add_comment_notification book, comment
    @book = book
    @comment = comment
    mail(to: @book.author_email, subject: "[HackerLibrary]- You have a new comment!" )
  end
end
