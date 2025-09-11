class UpdateSkuJob < ApplicationJob
  queue_as :default

  def perform(book_name)
    # Do something later
    puts "Working on #{book_name} in the background..."
  end
end
