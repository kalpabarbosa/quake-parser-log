#!/usr/bin/ruby -W

load 'game.rb'

WORLD = 1022

class QuakeLog

	def initialize(arquivo)
		@arq = File.readlines(arquivo)
		@game_num = 0 # qtd de jogos
		@games = Array.new
		@ranking = Hash.new
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

	def makeRanking
		@games.each do |game|
			game.players.each do |kills, player|
				if @ranking.include?(player)
					@ranking[player] = @ranking.fetch(player).to_i + kills.to_i
				else
					@ranking[player] = kills.to_i
				end

			end
		end
		@ranking = @ranking.sort_by {|k, v| v}.reverse
		print "\n### Ranking ###\n\n"
		@ranking.each do |player, kills|
			puts player.ljust(20) + kills.to_s
		end
	end

end

log = QuakeLog.new('games.log')
log.getGames
log.printGames #Task 2
log.makeRanking #Task 2
