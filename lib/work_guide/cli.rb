require 'thor'
require 'text-table'

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
      table = Text::Table.new
      table.head = %w(index cycle description)
      table.rows = Guide.all.map.with_index do |guide, index|
        [index, guide.cycle, guide.description]
      end
      puts table.to_s
    end

    desc "delete [index]", "Delete a guide"
    def delete(index)
      guide = Guide.all.delete_at(index.to_i)
      Guide.save
      puts "Deleted [#{index}]#{guide}"
    end
  end
end
