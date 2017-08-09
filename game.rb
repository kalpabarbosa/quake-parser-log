#!/usr/bin/ruby -W

class Game

	attr_accessor :game_num
	attr_accessor :total_kills
	attr_accessor :players
	attr_accessor :kills

	def initialize(game_num)
		@game_num = game_num
		@total_kills = 0
		@players = Hash.new # id, nome
		@kills = Hash.new # id, qtd mortes
	end

	def pushPlayer(player_id, player_nickname)
		@players[player_id] = player_nickname
		@kills[player_nickname] = 0
	end

	def getPlayer(player_id)
		@players[player_id]
	end

	def pushKill(killer)
		if killer.nil?
		else
			@kills[killer] = @kills.fetch(killer) + 1
		end
	end

	def pullKill(killed)
		if @kills.fetch(killed) == 0
		else
			@kills[killed] = @kills.fetch(killed) - 1
		end
	end

	def printGame
		puts "game_#{@game_num}:"

		puts "\ttotal_kills: #{@total_kills};"

		players = Array.new
		print "\tplayers: "
		@players.each_pair { |key, v| players.push(@players[key]) }
		puts "#{players}"

		puts "\tkills: "
		@kills.each do |kill|
			print "\t\t#{kill}\n"
		end
	end
end