class UpdateStackStatusJob < ApplicationJob
  queue_as :default

  def perform(stack)
    stack.getSpinnakerStack
    # Do something later
  end
end
