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
topTableDef="asdasdasdads"
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

def createSelectQuery(band, location, album, outTime, genre, subGenre)
	selectQueryBase = "SELECT name, albumname, genre, subgenre, nofsongs, date, location FROM album, musician WHERE (authorID=bandID) "
	query=selectQueryBase
	default_value = ''

	if band != default_value
		query += "AND (name = '#{band}')"
	end
	
	query = queryAdd(query, selectQueryBase, "location", location)
	query = queryAdd(query, selectQueryBase, "albumname", album)
	query = queryAdd(query, selectQueryBase, "outTime", outTime)
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

	query = createSelectQuery(band, location, album, outTime, genre, subGenre)
	puts query	
	results=con.query(query)	
	n_rows=results.num_rows
	
	forPrint = ""
	puts "There are #{n_rows} rows in the result set"
	results.each_hash do |row|
       		#puts row['location'] + " " +row['name']
    		forPrint+="<tr>"+"<td>"+row['name'] + "</td>"+"<td>" +row['albumname'] + "</td>"+"<td>" + row['genre'] + "</td>"+"<td>" + row['subgenre'] +"</td>"+"<td>" + row['nofsongs'] + "</td>"+"<td>" + row['date'] +"</td>"+"<td> " + row['location'] +" <\td>" + "</tr>"
	end    
	puts forPrint
	erb:index,:locals => {'query' => forPrint}
	
end

get '/login' do
	login="Please Login"
	erb :login, :locals => {'login' => login}
end
get '/signup' do
	signup="Please neter your information"
	erb :login, :locals => {'signup' => signup}
	
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

