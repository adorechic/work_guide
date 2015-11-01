$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'work_guide'

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require 'fakefs/safe'
