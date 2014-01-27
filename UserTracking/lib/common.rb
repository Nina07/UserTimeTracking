module Common
	def avg_times(var)
    begin
         grand_total=0
         size=var.size 
         puts "size #{size}"
         
         avg_minutes=var.map do|x| 
           hour,minute=x.split(':')
           puts "size1"
           total_minutes=hour.to_i*60+minute.to_i 
           puts "total_minutes #{total_minutes}"
           grand_total=grand_total+total_minutes
         end
          puts "avg_minutes #{avg_minutes}"
          puts "grand_total #{grand_total}"
          avg_value=grand_total/size
          average_time=avg_value.to_f/60
    rescue ZeroDivisionError
          redirect_to users_path, :notice=> "None of the users have logged in yet so can't provide you an average login time."
    end 
  end
end