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

			game = @games[@game_num-1]

			if line.include? 'InitGame'
				newGame; next # inicia novo jogo
			end

			if line.include? 'ClientUserinfoChanged'
				id = line.split(' ')[2]
				nome = line.split('\\')[1]
				game.pushPlayer(id, nome);
				next
			end

			if line.include? 'Kill'
				game.total_kills += 1
				l = line.split(' ')
				killer = l[2]
				killed = l[3]
				death_reason = l[4]
				game.deathLog(death_reason)

				if killer.to_i == WORLD
					game.pullKill(game.players[killed])
				else
					game.pushKill(game.players[killer])
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

	def deathReport
		@games.each do |game|
			game.printDeathReport
		end
	end

end

log = QuakeLog.new('games.log')
log.getGames #task 1
log.printGames #task 2
log.makeRanking #task 2
log.deathReport #plus
