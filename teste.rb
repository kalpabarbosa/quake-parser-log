#!/usr/bin/ruby -W

class QuakeLog

	def initialize(arquivo)
		@index = 0
		@arq = File.readlines(arquivo)
	end

	def nextLine
		puts @arq.at(@index)
		@index += 1
	end
end

log = QuakeLog.new("../documentacao/games.log")
log.nextLine
log.nextLine
log.nextLine
log.nextLine
