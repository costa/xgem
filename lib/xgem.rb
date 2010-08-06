require 'pathname'

module Kernel
  alias :require_b4_xgem :require

  def require(s)
    dum, xfile = */^x\/([^\/]+)$/.match(s)

    if xfile
      Xgem.x_require xfile
    elsif s == 'xgem'
      Xgem.path!
    else
      require_b4_xgem s
    end
  end
end

module Xgem
  class << self
    def x_require(s)
      @required ||= []
      @path.any? { |d| @required << s if require d + s } unless
        @required.include? s
    end
    def path!
      @path ||= []
      xdir = nil
      caller.each do |c|
        dum, file = */^([^:]+):/.match(c)
        xdir = Enumerable::Enumerator.
          new(Pathname.new(file).dirname.expand_path, :ascend).
          find { |d| File.directory? d + 'x' } if file
        xdir += 'x' and break if xdir
      end
      if xdir
        @path << xdir unless @path.include? xdir
      else
        warn "xgem warning: no x/ found"
      end
    end
  end
end

Xgem.path!
