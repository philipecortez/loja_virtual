require File.expand_path 'lib/active_file'

class Revista

  include ActiveFile

  field :titulo, required: true
  field :valor
end
