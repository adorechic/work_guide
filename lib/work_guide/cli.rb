require 'thor'

module WorkGuide
  class CLI < Thor
    desc "add [guide description]", "Add a new guide"
    def add(description)
      Guide.create(description: description)
    end
  end
end
