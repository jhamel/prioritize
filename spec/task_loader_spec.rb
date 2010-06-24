require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

def should_indent_level(level, string)
  it "should return indention #{level} for '#{string}'" do
    TaskLoader.indent_level(string).should == level
  end
end

describe TaskLoader do

  before(:each) do
    setup_tasks
  end

  describe "#load_task" do
    it "should init single task by string" do
      TaskLoader.new(@task.recursive_to_s).load_task.recursive_to_s.should == @task.recursive_to_s
    end

    it "should init task recursivly" do
      TaskLoader.new(@parent.recursive_to_s).load_task.recursive_to_s.should == @parent.recursive_to_s
    end
  end

  describe "#indent_level" do
    should_indent_level(0, "")
    should_indent_level(1, "#{Task::INDENTION}task")
    should_indent_level(2, "#{Task::INDENTION*2}task")
    should_indent_level(2, "#{Task::INDENTION*2}task#{Task::INDENTION}")
  end
end