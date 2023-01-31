class TicTacToe
    def initialize
        @board = [" "," "," "," "," "," "," "," "," "]
    end

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2]
    ]

    def display_board
        first_row = " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        second_row = " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        third_row = " #{@board[6]} | #{@board[7]} | #{@board[8]} "

        puts first_row
        puts "-----------"
        puts second_row
        puts "-----------"
        puts third_row
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] == "X" || @board[index] == "O"
    end

    def valid_move?(index)
        !position_taken?(index) && index.between?(0,8)
    end

    def turn_count
        @board.count { |square| square == "X" || square == "O"}
    end

    def current_player
        turn_count.odd? ? "O" : "X"
    end

    def turn
        puts "Specify a position between 1-9:"
        position = gets.strip
        index = input_to_index(position)
        if valid_move?(index)
            token = current_player
            move(index, token)
        else
            turn
        end
        display_board
    end

    def won?
        WIN_COMBINATIONS.any? do |combo|
          if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
            return combo
          end
        end
      end

    # def won?
    #     o_indexes = []
    #     @board.each do |value| 
    #         if value == "O"
    #             o_indexes.push(@board.find_index(value))
    #         end
    #     end
    #     x_indexes = []
    #     @board.each do |value| 
    #         if value == "X"
    #             x_indexes.push(@board.find_index(value))
    #         end
    #     end
    #     matching_combo = WIN_COMBINATIONS.filter { |combo| (combo & o_indexes) == combo || (combo & x_indexes) == combo }
    #     if matching_combo.empty?
    #         false
    #     else
    #         matching_combo
    #     end
    # end

    def full?
        filled_in = @board.filter { |value| value == "X" || value == "O"}
        filled_in.length == 9
    end

    def draw?
        full? && !won?
    end

    def over?
        draw? || won?
    end

    def winner
        if combo = won?
            @board[combo[0]]
        end
    end

    # def winner
    #     if won?
    #         o_indexes = @board.filter { |value| value == "O"}
    #         x_indexes = @board.filter { |value| value == "X"}
    #         matching_o_combo = WIN_COMBINATIONS.filter { |combo| (combo & o_indexes) == combo }
    #         matching_x_combo = WIN_COMBINATIONS.filter { |combo| (combo & x_indexes) == combo }
    #         if matching_o_combo.empty? == false
    #             "O"
    #         elsif matching_x_combo.empty? == false
    #             "X"
    #         end
    #     end
    # end

    def play
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end
end
