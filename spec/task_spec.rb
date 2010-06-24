require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Task do

  before(:each) do
    @time = Time.now
    @task    = Task.new("description", 1, @time)
    @parent  = Task.new("parent", 1, @time)
    @child_a = Task.new("child_a", 1, @time)
    @child_b = Task.new("child_b", 1, @time)
    @parent.add_task(@child_a)
    @parent.add_task(@child_b)
  end

  describe "#add_task" do
    it "should add tasks" do
      @task.tasks.size.should == 0
      @task.add_task(@task)
      @task.tasks.size.should == 1
      @task.add_task(@task)
      @task.tasks.size.should == 2
    end
  end

  describe "#to_s" do
    it "should format a single task as required" do
      Task.new("name", 10, @time).to_s.should == "name, 10, #{@time.to_s}\n"
    end
  end

  describe "#recursive_to_s" do
    it "should format nested tasks as required" do
      @parent.recursive_to_s.should == "#{@parent}#{Task::INDENTION}#{@child_a}#{Task::INDENTION*2}#{@child_b}"
    end
  end

#  describe "#to_file" do
#    it "should write recursive_to_s result to file" do
#      file  = mock(File)
#      @task.to_file("todo.txt")
#      File.stub!(:open).with("todo.txt", "w").and_return(file)
#      file.should_receive(:write).with(@task.recursive_to_s)
#    end
#  end

end