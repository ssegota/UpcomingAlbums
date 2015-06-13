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
	
   	erb :form,:locals => {'top' => topTableDef}	    
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



