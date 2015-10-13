require 'json'

module WorkGuide
  class Storage
    WORK_GUIDE_DIR = Pathname.new(Dir.home).join('.work_guide').tap do |dir|
      dir.mkpath
    end

    def initialize(name)
      @path = WORK_GUIDE_DIR.join(name.to_s)
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
  end
end
