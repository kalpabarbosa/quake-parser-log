#!/usr/bin/ruby -W

load 'means_of_death.rb'

class Game

	attr_accessor :game_num
	attr_accessor :total_kills
	attr_accessor :players
	attr_accessor :kills
	attr_accessor :death_reasons

	def initialize(game_num)
		@game_num = game_num
		@total_kills = 0
		@players = Hash.new # id, nome
		@kills = Hash.new # player_id, qtd_mortes
		@death_reasons = Hash.new # motivo_morte, qtd_mortes
	end

	def pushPlayer(player_id, player_nickname)
		@players[player_id] = player_nickname
		@kills[player_nickname] = 0
	end

	def pushKill(killer)
		@kills[killer] = @kills.fetch(killer) + 1
	end

	def pullKill(killed)
		if @kills.fetch(killed) == 0
		else
			@kills[killed] = @kills.fetch(killed) - 1
		end
	end

	def deathLog(reason)
		if @death_reasons.include? reason
			@death_reasons[reason] = @death_reasons[reason] + 1
			puts @death_reasons[reason]
		else
			@death_reasons[reason] = 1
		end
	end

	def printDeathReport
		death = MeansOfDeath.new
		puts "game_#{@game_num}:"
		if @death_reasons.empty?
			puts "\tNão houve nenhuma morte."
		else
			@death_reasons.each do |key, value|
				puts "\t" + death.means.at(key.to_i).ljust(20) + value.to_s
			end
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