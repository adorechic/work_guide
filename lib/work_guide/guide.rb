require 'active_support'
require 'active_support/core_ext'

module WorkGuide
  class Guide
    attr_accessor :description

    class << self
      def create(args)
        all << new(args)
        save
      end

      def all
        @all ||= Storage.new(:guide).load.map { |h| new(h.symbolize_keys) }
      end

      def save
        Storage.new(:guide).store(to_json)
      end

      private

      def to_json
        all.map(&:to_h).to_json
      end
    end

    def initialize(description: )
      @description = description
    end

    def to_h
      { description: description }
    end
  end
end
