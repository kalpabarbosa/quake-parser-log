#!/usr/bin/ruby -W

load 'game.rb'

class QuakeLog

	def initialize(arquivo)
		@arq = File.readlines(arquivo)
		@game_num = 0
		@games = Array.new
	end

	def getGame		
		@arq.each do |line|
			if line.include? 'InitGame'
				@game_num += 1
				#fecha jogo anterior
				endGame
				#inicia novo jogo
				newGame
			end
		end
		puts "#{@games}"
	end

	def newGame
		#puts "Game #{@game_num}"
		@games.push(@game_num)
	end

	def endGame
	end

end

log = QuakeLog.new('../documentacao/games.log')
log.getGame
#game_01 = Game.new
