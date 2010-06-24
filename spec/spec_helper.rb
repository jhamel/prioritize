$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")
require 'rubygems'
require 'spec'
require 'task'
require 'task_loader'


def setup_tasks
  @time = Time.now
  @task    = Task.new("description", 1, @time)
  @parent  = Task.new("parent", 1, @time)
  @child_a = Task.new("child_a", 1, @time)
  @child_b = Task.new("child_b", 1, @time)
  @parent.add_task(@child_a)
  @parent.add_task(@child_b)
end