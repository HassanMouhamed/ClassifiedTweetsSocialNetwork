module ApplicationHelper

	def breaking_wrap_wrap(txt, col = 80)
  		txt.gsub(/(.{1,#{col}})( +|$\n?)|(.{1,#{col}})/,"\\1\\3\n") 
	end
end
