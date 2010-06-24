class Task

  INDENTION = "#"
  SEPARATOR = ", "
  attr_accessor :description, :priority, :due_date, :tasks, :indent_level

  def initialize(description, priority, due_date)
    @description, @priority, @due_date =  description, priority, due_date
    @tasks = []
    @indent_level = 0
  end

  def add_task(task)
    task.indent_level = indent_level + 1
    @tasks << task
  end

  def list
    tasks
  end

  def indent_task(indent_level)
    INDENTION*indent_level
  end

  def to_s
    [self.description.to_s, self.priority.to_s, self.due_date.to_s] * SEPARATOR << "\n"
  end

  def recursive_to_s(indent_level = 0)
    @tasks.inject(to_s) { |string, task| string << (indent_task(indent_level += 1)) << task.recursive_to_s(indent_level) }
  end


  def to_file(filename)
    File.open(filename, 'w') { |f| f.write(recursive_to_s) }
  end
end



