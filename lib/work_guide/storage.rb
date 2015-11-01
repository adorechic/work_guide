require 'json'
require 'pathname'

module WorkGuide
  class Storage

    def initialize(name)
      @path = work_guide_dir.join(name.to_s)
    end

    def load
      if @path.exist?
        JSON.parse(@path.read)
      else
        []
      end
    end

    def store(json)
      @path.open('w') do |f|
        f.puts json
      end
    end

    private

    def work_guide_dir
      Pathname.new(Dir.home).join('.work_guide').tap do |dir|
        dir.mkpath
      end
    end
  end
end
