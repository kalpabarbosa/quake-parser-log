#!/usr/bin/ruby -W

load 'game.rb'

WORLD = 1022

class QuakeLog

	def initialize(arquivo)
		@arq = File.readlines(arquivo)
		@game_num = 0 # qtd de jogos
		@games = Array.new
	end

	def getGames
		@arq.each do |line|

			if line.include? 'InitGame'
				newGame # inicia novo jogo
			end

			if line.include? 'ClientUserinfoChanged'
				id = line.split(' ')[2]
				nome = line.split('\\')[1]
				@games[@game_num-1].pushPlayer(id, nome);
			end

			if line.include? 'Kill'
				@games[@game_num-1].total_kills += 1
				killer = line.split(' ')[2]
				killed = line.split(' ')[3]
				#weapon = line.split(' ')[4]

				if killer.to_i == WORLD
					@games[@game_num-1].pullKill(@games[@game_num-1].players[killed])
				else
					@games[@game_num-1].pushKill(@games[@game_num-1].players[killer])
				end
			end
		end
	end

	def newGame
		@game_num += 1 # incrementa o index de @games
		@games.push(Game.new(@game_num))
	end

	def printGames
		@games.each do |game|
			game.printGame
		end
	end

end

log = QuakeLog.new('../documentacao/games.log')
log.getGames
log.printGames


