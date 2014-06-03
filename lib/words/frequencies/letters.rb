module Words
  module Frequencies
    module Letters
      def common_starting_letters
	%w[ t o a w b c d s f m ]
      end

      def common_ending_letters
	%w[ e t d s ]
      end

      def vowels
        %w[ a e i o u y ]
      end

      def vowel?(letter)
        vowels.include?(letter)
      end

      def overall_letter_frequencies
	{
	  'a' => 8.167,
	  'b' => 1.492,
	  'c' => 2.782,
	  'd' => 4.253,
	  'e' => 13,
	  'f' => 2.228,
	  'g' => 2.015,
	  'h' => 6.094,
	  'i' => 6.966,
	  'j' => 0.153,
	  'k' => 0.772,
	  'l' => 4.025,
	  'm' => 2.406,
	  'n' => 6.749,
	  'o' => 7.507,
	  'p' => 1.929,
	  'q' => 0.095,
	  'r' => 5.987,
	  's' => 6.327,
	  't' => 9.056,
	  'u' => 2.758,
	  'v' => 0.978,
	  'w' => 2.360,
	  'x' => 0.150,
	  'y' => 1.974,
	  'z' => 0.074
	}
      end
    end
  end
end
