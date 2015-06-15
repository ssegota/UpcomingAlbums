#!/usr/bin/ruby

require 'sinatra'
require 'mysql'

#sinatra setup
set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

#mysql setup
con = Mysql.new 'localhost', 'root', 'sandisegota1995', 'albums'

#start values setup
default_value = ''
loggedIn=false

#selectquery 

def queryAdd(query, standardQuery, attributeName, queryAddition)
		
 	default_value = ''	
	if queryAddition != default_value
		#if query != standardQuery
		#	query += " AND "
		#end
		query += " AND (#{attributeName} = '#{queryAddition}')"
	end
	return query
end

def queryAddTime(query, standardQuery, attributeName, queryAddition)

        default_value = ''
        if queryAddition != default_value
                #if query != standardQuery
                #       query += " AND "
                #end
                query += " AND (#{attributeName} <= '#{queryAddition}')"
        end
        return query
end


def createSelectQuery(band, location, album, outTime, genre, subGenre)
	selectQueryBase = "SELECT name, albumname, genre, subgenre, nofsongs, date, location FROM album, musician WHERE (authorID=bandID) "
	query=selectQueryBase
	default_value = ''

	if band != default_value
		query += "AND (name = '#{band}')"
	end
	
	query = queryAdd(query, selectQueryBase, "location", location)
	query = queryAdd(query, selectQueryBase, "albumname", album)
	query = queryAddTime(query, selectQueryBase, "date", outTime)
	query = queryAdd(query, selectQueryBase, "genre", genre)
	query = queryAdd(query, selectQueryBase, "subGenre", subGenre)
	query += ";"
	return query
end

#Landing page ERB
get '/' do
	upcomingQuery="SELECT name, albumname, date FROM musician, album WHERE (authorID=bandID) ORDER BY date LIMIT 5"
 	upcomingResults=con.query(upcomingQuery)	
   	n_rows=upcomingResults.num_rows
	upcomingForPrint=""
	upcomingResults.each_hash do |row|
		upcomingForPrint+="<tr><td>" + row['name'] + "</td><td>" + row['albumname'] + "</td><td>" + row['date'] + "</td></tr>"
	end
	erb :form,:locals => {'top' => upcomingForPrint}	    
end

#POST ERB
post '/' do
	#Getting parameters from form
	band = params[:band] || default_value
	location = params[:location] || default_value
	album = params[:album] || default_value
	outTime = params[:outTime] || default_value
	genre = params[:genre] || default_value
	subGenre = params[:subGenre] || default_value
	
	band = band.downcase
	location = location.downcase
	album = album.downcase
	genre = genre.downcase
	subGenre = subGenre.downcase
	#getting date
	if(outTime!="")
		timenow=Time.now
		time = timenow + (outTime.to_i * 86400)
		outTime=time.strftime("%Y-%m-%d")
	end
	query = createSelectQuery(band, location, album, outTime, genre, subGenre)
	puts query	
	results=con.query(query)	
	n_rows=results.num_rows
	
	forPrint = ""
	puts "There are #{n_rows} rows in the result set"
	results.each_hash do |row|
       		#puts row['location'] + " " +row['name']
    		forPrint+="<tr>"+"<td>"+row['name'].split.map(&:capitalize)*' ' + "</td>"+"<td>" +row['albumname'].split.map(&:capitalize)*' ' + "</td>"+"<td>" + row['genre'].capitalize + "</td>"+"<td>" + row['subgenre'].capitalize + "</td>" + "<td>" + row['nofsongs'] + "</td>"+"<td>" + row['date'] +"</td>"+"<td> " + row['location'].upcase + "</td>" + "</tr>"
	end    
	puts forPrint
	erb:index,:locals => {'query' => forPrint}
	
end

get '/login' do
	login="Please Login"
	erb :login, :locals => {'login' => login}
end

post '/login' do
	username = params[:username]
	password = params[:password]
        usernameTestQuery="SELECT EXISTS(SELECT * FROM korisnik WHERE (username = '#{username}'));"     
        test=con.query(usernameTestQuery).fetch_row.join("\s")
	if(test.to_i == 1)
		#username OK
		passTestQuery="SELECT password FROM korisnik WHERE (username = '#{username}')"
		test=con.query(passTestQuery).fetch_row.join("\s")
		puts test.to_s
		puts password
		if(password==test.to_s)
			#Password OK
			loggedIn=true;
			msg="Sucesfull login.<br><a href=\"/add\">Click here to add an album.</a><br><a href=\"/vote\">Click here to give scores to musicians.</a>"
		else
			msg="Wrong Password."
		end
	else
		msg="Wrong username."
	end	
	erb :postlogin, :locals => {'msg' => msg}
end
get '/signup' do
	signup="Please enter your information"
	erb :signup, :locals => {'signup' => signup}
end

post '/signup' do
	username = params[:username]
	password = params[:password]
	#Username check
	usernameTestQuery="SELECT EXISTS(SELECT * FROM korisnik WHERE (username = '#{username}'));"	
	test=con.query(usernameTestQuery).fetch_row.join("\s")
	if(test.to_i == 0)
		userIDRes=con.query("SELECT MAX(userID) FROM korisnik")
		userID = userIDRes.fetch_row.join("\s")
		newUID=userID.to_i + 1
		userNew="INSERT INTO korisnik VALUES ('" + newUID.to_s + "', '" + username + "', '" + password + "');"
		con.query(userNew);
		msg = "Congratulations #{username} you've created an account!"
	else
		msg= "That username is taken, please pick another."
	end
	erb :postsignup, :locals => {'msg' => msg}
end
get '/add' do
	logged="You're Logged In!"
	puts "add page reached"
	erb :add, :locals => {'logged' => logged}
end

post '/add' do
	                #Getting parameters from form
        band = params[:band] || default_value
        location = params[:location] || default_value
        members = params[:members] || default_value
        album = params[:album] || default_value
        day = params[:day] || default_value
        month = params[:month] || default_value
        year = params[:year] || default_value
        genre = params[:genre] || default_value
        subGenre = params[:subGenre] || default_value
        nofsongs = params[:nofsongs] || default_value
        albumID = ""
	bandID = ""
	date = ""
	date = year + "-" + month + "-" + day
	albumIDRes=con.query("SELECT MAX(albumID) FROM album")
        bandIDRes=con.query("SELECT MAX(bandID) FROM musician")
        albumID = albumIDRes.fetch_row.join("\s")
    	bandID = bandIDRes.fetch_row.join("\s")
	newAlbumID=albumID.to_i + 1
	newBandID=bandID.to_i + 1
		
	ident=newAlbumID.to_s + ' ' + newBandID.to_s + date.to_s
	#insert musician
	musician="INSERT INTO musician VALUES('" +  newBandID.to_s + "', '" + members.to_s.downcase + "', '" + location.to_s.downcase + "', '" + band.to_s.downcase + "');"

	con.query(musician);
	#insert album
	albumNew="INSERT INTO album VALUES('" + newAlbumID.to_s + "', '" + newBandID.to_s + "', '" + genre.to_s.downcase + "', '" + subGenre.to_s.downcase + "', '"+nofsongs.to_s.downcase + "', '" + date.to_s  + "', '" + album.to_s.downcase+"');";
	con.query(albumNew);
	erb :addRes, :locals => {'ident' => albumNew};
	
end

get '/vote' do
	vote = "Input your username, name of musician you want to vote for and a grade (from 1 to 5)"
	erb :vote, :locals => {'vote' => vote};
end

post '/vote' do
	username = params[:username]
	musician = params[:musician]
	musician = musician.downcase
	grade = params[:vote]
	#check if username exists
        usernameTestQuery="SELECT EXISTS(SELECT * FROM korisnik WHERE (username = '#{username}'));"
        test=con.query(usernameTestQuery).fetch_row.join("\s")
	puts "TEST" + test
	if(test.to_i == 1)
		#username OK	
		#get userID from username
		userID=con.query("SELECT userID FROM korisnik WHERE (username = '#{username}');").fetch_row.join("\s")
			#check if musician exists
			if(con.query("SELECT EXISTS(SELECT * FROM musician WHERE (name='#{musician}'));").fetch_row.join("\s").to_i==1)
				#get bandID from musician
				bandID=con.query("SELECT bandID from musician where (name='#{musician}');").fetch_row.join("\s")
				#Create input query
				voteQuery="INSERT INTO vote VALUES(" + bandID.to_s + "," + userID.to_s + "," + grade.to_s + ");"
				puts "VOTEQUERY: " + voteQuery;
				#insert into table
        			con.query(voteQuery)
				msg = "sucessfuly inputed vote for #{musician} by #{username}"	
			else
				msg="Musician doesn't exist."
			end
	else
		msg="Wrong Username."
	end
	erb :postvote, :locals => {'msg' => msg}
end
