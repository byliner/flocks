require 'flocks/configuration'
include Flocks::Configuration

String.class_eval do
  def score
    # Selects the number of characters to be evaluated for sorting
    percision_index = string_score_percision - 1

    # Base score
    score = 0

    # Get the first 5 characters in an array
    characters = downcase[0..percision_index].split('')

    # If the username is short, tack on the lowest ascii value
    characters << '0' until characters.size == string_score_percision

    # Reverse them for easy multiplication scoring
    characters.reverse.each_with_index do |char, i|

      # Use the mutiplier, increase magnitude for weighting first letters more
      # multiplier = (character_multiplier[0..(i + 1)].to_i)

      multiplier = 10 ** i
      # Square the multiplier to avoid large ascii values from thwrowing off calculations
      char_score = "#{char}"[0].ord * multiplier * multiplier

      # Aggregate the swcore
      score += char_score
    end

    score
  end
end
