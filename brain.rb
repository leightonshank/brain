require 'fileutils'
require 'rugged'
require 'colored'

class Brain
  def initialize
    @repo = Rugged::Repository.new(File.dirname(__FILE__))
  end

  def brain_path
    @brain_path ||= File.expand_path('_brain', @repo.workdir)
  end

  def exists?
    Dir.exists?(brain_path)
  end

  def create!
    FileUtils.mkdir_p(brain_path)
    FileUtils.touch(File.expand_path('.keep', brain_path))
  end
end

# If I only had a brain...

def success(msg)
  check = "\u2714".green
  puts "#{check}  #{msg}"
end

def failure(msg)
  x = "\u2718".red
  puts "#{x}  #{msg}"
end

brain = Brain.new
if !brain.exists?
  failure "Brainless!"
  brain.create!
  success "You now have a brain."
end

success "Connected to your brain."
