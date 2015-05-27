require 'sinatra'
require 'mysql'

#sinatra setup
set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

#start values setup
default_value = ''

#selectquery 

def queryAdd(query, standardQuery, attributeName, queryAddition)
		
 	default_value = ''	
	if queryAddition != default_value
		if query != standardQuery
			query += " AND "
		end
		query += "(#{attributeName} = #{queryAddition})"
	end
	return query
end

def createSelectQuery(band, location, album, outTime, genre, subGenre)
	selectQueryBase = "SELECT * FROM musicians WHERE "
	query=selectQueryBase
	default_value = ''

	if band != default_value
		query += "(band = #{band})"
	end
	
	query = queryAdd(query, selectQueryBase, "location", location)
	query = queryAdd(query, selectQueryBase, "album", album)
	query = queryAdd(query, selectQueryBase, "outTime", outTime)
	query = queryAdd(query, selectQueryBase, "genre", genre)
	query = queryAdd(query, selectQueryBase, "subGenre", subGenre)

	return query
end

#Landing page ERB
get '/' do
   	erb :form	    
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
	
	erb:index,:locals => {'query' => query}
end
