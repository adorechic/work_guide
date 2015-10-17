require 'thor'

module WorkGuide
  class CLI < Thor
    desc "add [guide description]", "Add a new guide"
    option :cycle, default: 'daily', banner: '[hourly|daily|weekly|monthly]', aliases: :c
    def add(description)
      Guide.create(
        description: description,
        cycle: options[:cycle]
      )
    end

    desc "list", "List guides"
    def list
      Guide.all.each_with_index do |guide, index|
        puts "[#{index}]#{guide}"
      end
    end

    desc "delete [index]", "Delete a guide"
    def delete(index)
      guide = Guide.all.delete_at(index.to_i)
      Guide.save
      puts "Deleted [#{index}]#{guide}"
    end
  end
end
