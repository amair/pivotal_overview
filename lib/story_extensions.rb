module PivotalTracker
  class Story
    element :div_class, String

    def label_list
      return "" if !self.respond_to?(:labels) || self.labels.nil? || self.labels.empty?
      labels.force_encoding("UTF-8")
    end

    def task_list
      all_tasks = self.tasks.all #Retrieve the tasks from the network
      return "" if !self.respond_to?(:tasks) || all_tasks.nil?
      task_string=""
      all_tasks.each do |task|
        if (!task.complete)
          task_string = task_string << "* " << task.description.force_encoding("UTF-8") << "\n"
        end
      end
      task_string
    end

    def points
      return nil unless self.story_type.eql?("feature")
      "Points: " + (self.respond_to?(:estimate) && !self.estimate.eql?(-1) ? self.estimate.to_s : "Not yet estimated")
    end

    def colour
      return "0000FF" if self.div_class.eql? "project0"
      return "FFFF00" if self.div_class.eql? "project1"
      return "00FF00" if self.div_class.eql? "project2"
      return "00FFFF" if self.div_class.eql? "project3"
      return "FF0000" if self.div_class.eql? "project4"
      return "ffb500" if self.div_class.eql? "project5"
      return "000000" # For Unknown
    end

    private

    ["feature", "bug", "chore", "release"].each do |type_str|
      class_eval <<-EOS
      def #{type_str}?
      self.story_type == "#{type_str}"
    end
      EOS
    end

  end
end
