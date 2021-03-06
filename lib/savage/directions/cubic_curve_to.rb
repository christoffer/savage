module Savage
  module Directions
    class CubicCurveTo < QuadraticCurveTo
      attr_accessor :control_1
    
      def initialize(*args)
        raise ArgumentError if args.length < 4
        case args.length
        when 4
          super(args[0],args[1],args[2],args[3],true)
        when 5
          raise ArgumentError if args[4].kind_of?(Numeric)
          super(args[0],args[1],args[2],args[3],args[4])
        when 6
          @control_1 = Point.new(args[0],args[1])
          super(args[2],args[3],args[4],args[5],true)
        when 7
          @control_1 = Point.new(args[0],args[1])
          super(args[2],args[3],args[4],args[5],args[6])
        end
      end
    
      def to_command
        command_code << ((@control_1) ? "#{@control_1.x} #{@control_1.y} #{@control.x} #{@control.y} #{@target.x} #{@target.y}".gsub(/ -/,'-') : super().gsub(/[A-Za-z]/,''))
      end
    
      def control_2; @control; end
      def control_2=(value); @control = value; end
  
      def command_code
        return (absolute?) ? 'C' : 'c' if @control_1
        (absolute?) ? 'S' : 's'
      end
    end
  end
end