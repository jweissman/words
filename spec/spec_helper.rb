require 'rspec'
require 'pry'

require 'words'

Pry.config.input = STDIN
Pry.config.output = STDOUT

STDOUT.sync = true

include Words
