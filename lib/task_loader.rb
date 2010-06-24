class TaskLoader

  def initialize(task_as_string)
    @task_as_string = task_as_string
  end


  def lines_array
    lines_array = [[]]
    @task_as_string.each_line { |line|
      lines_array << [TaskLoader.indent_level(line), line_to_task(line)]
    }
    return lines_array
  end

  def add_sub_task(entry, lines)
    if entry[0].to_i > 0
      lines[entry[0]-1].add_task(entry[1])
    end
  end

  def load_task
    lines = {}
    lines_array().each { |entry|
      add_sub_task(entry, lines)
      lines[entry[0]] = entry[1]
    }
    lines[0]
  end

  def line_to_task(string)
    task = string.split(Task::SEPARATOR)
    Task.new(remove_indention(task[0]), task[1], task[2].strip)
  end

  def remove_indention(string)
   string[TaskLoader.indent_level(string)..string.length]
  end

  def self.indent_level(line, indention_level = 0)
    indention_level = indent_level(line, indention_level+1) if line =~ /^#{Task::INDENTION*(indention_level+1)}/
    indention_level
  end
end