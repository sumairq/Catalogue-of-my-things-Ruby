require_relative 'item'
require_relative 'music_album'
require_relative 'genre'
require_relative 'book'
require_relative 'label'
require_relative './storage/author_method'
require_relative './storage/games_method'
require_relative './storage/book_method'
require_relative './storage/genre_method'
require_relative './storage/label_method'
require_relative './storage/music_album_method'

class App
  include AuthorsDataController
  include GamesDataController
  include BooksDataController
  include MusicAlbumDataController
  include GenreDataController
  include LabelsDataController

  def initialize
    @music_albums = load_music_albums
    @games = load_games
    @load_genres = load_genres
    @books = load_books
    @authors = load_authors
    @labels = load_labels
  end

  def option_selector(user_input)
    case user_input
    when '1'
      list_books
    when '2'
      list_music_albums
    when '3'
      puts 'list all games method here'
    when '4'
      list_genres
    when '5'
      list_labels
    when '6'
      list_all_authors
    when '7'
      add_book
    when '8'
      add_music_album
    when '9'
      puts add_game
    end
  end

  def list_music_albums
    puts 'Music Albums'
    @music_albums.each do |music_album|
      puts "Name: #{music_album.name}, Publish Date: #{music_album.published_date}, On Spotify: #{music_album.on_spotify}"
    end
  end

  def list_genres
    puts 'Genres:'
    @load_genres.each do |genre|
      puts "Genre Name: #{genre.name}"
    end
  end

  def list_all_authors
    puts 'Authors:'
    @authors.each do |author|
      puts "First Name: #{author.first_name} "
      puts "Last Name: #{author.last_name} "
    end
  end

  def list_authors
    puts 'There are no authors yet!' if @authors.empty?
    @authors.each do |author|
      puts "first name: #{author.first_name}, last name #{author.last_name}}"
    end
  end

  def list_all_games
    puts 'Music Albums:'
    @games.each do |games|
      puts "Multiplayer: #{games.multiplayer}, Publish Date: #{games.published_date},
      Last played date: #{games.last_played_date}"
    end
  end

  def add_music_album
    puts 'Album Name: '
    name = gets.chomp

    puts 'Date of publish [Enter date in format (yyyy-mm-dd)]'
    published_date = gets.chomp

    puts 'Is it available on Spotify? Y/N'
    on_spotify = gets.chomp.downcase == 'y' || false

    @music_albums.push(MusicAlbum.new(name, published_date, on_spotify))
    puts 'Music album created'
  end

  def add_book
    print 'Please, enter the book title: '
    title = gets.chomp

    print 'Please, enter the book publisher: '
    publisher = gets.chomp

    print 'Please, enter the book cover state: '
    cover_state = gets.chomp

    print 'Published Date [Enter date in format (yyyy-mm-dd)]: '
    published_date = gets.chomp
    return unless published_date

    @books.push(Book.new(title, publisher, cover_state, published_date))
    puts 'Book created successfully'
  end

  def add_game
    puts 'Please write multiplayer: '
    multiplayer = gets.chomp

    puts 'Please write date of publish [Enter date in format (yyyy-mm-dd)]'
    published_date = gets.chomp

    puts 'Please write last played date [Enter date in format (yyyy-mm-dd)]'
    last_played_date = gets.chomp

    @games.push(Game.new(multiplayer, published_date, last_played_date))
    puts 'Game is created'
  end

  def list_books
    puts 'There are no books yet! Please add books.' if @books.empty?
    @books.each do |book|
      puts "Name: #{book.name}, Publish Date: #{book.published_date}, cover_state: #{book.cover_state}"
    end
  end

  def list_labels
    puts 'There are no labels yet!' if @labels.empty?
    @labels.each do |label|
      puts "ID: #{label['id']}, Title: #{label['title']}, Color: #{label['color']}"
    end
  end
end
