# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

rails new -d postgresql Eventbrite
sudo service postgresql start
cd Eventbrite
ajouter la gem "letter_opener_web" dans "group :development do" (dans le Gemfile)
bundle install

cliquer en bas à gauche de VSC sur "WSL : Ubuntu" puis sur "Nouvelle fenêtre WSL".
Sur la nouvelle fenêtre, cliquer en bas à gauche de VSC sur "WSL : Ubuntu", puis sur "Fermer la connexion à distance".
Dans la nouvelle fenêtre, aller dans le dossier Eventbrite et créer à la racine un fichier "Eventbrite.plantuml".
y créer un squelette:
  @startuml Eventbrite

  Class User{
    email: string
    encrypted_pasword: string
    description: text
    first_name: string
    last_name: string
  }

  Class Event{
    start_date: datetime
    duration: integer
    title: string
    description: text
    price: integer
    location: string
  }

  Class Attendance{
    stripe_customer_id:string
  }

  ' User "*" - "*" Event : a plusieurs
  User "1" - "*" Attendance : a plusieur
  Event "1" -- "*" Attendance : a plusieur

  @enduml
Et pour le lancer: [alt] + d

rails g model User email:string encrypted_password:string description:text first_name:string last_name:string
rails g model Event start_date:datetime duration:integer title:string description:text price:integer location:string
rails g model Attendance stripe_customer_id:string

Dans db/migrate/xxxxxx_create_users.rb, remplacer les 2 lignes d'origine (email, encrypted_password) par:
  t.string :email, null: false, default: ""
  t.string :encrypted_password, null: false, default: ""

dans app/models/user.rb, ajouter les lignes:
  class User < ApplicationRecord
    has_many :attendances
    has_many :events, through: :attendances
  end

dans app/models/attendance.rb, ajouter les lignes:
  class Attendance < ApplicationRecord
    belongs_to :user
    belongs_to :event
  end

dans app/models/event.rb, ajouter les lignes:
  class Event < ApplicationRecord
    has_many :attendances
    has_many :users through: :attendances
  end

dans db/migrate/xxxxxx_create_attendances.rb, ajouter les lignes:
  t.belongs_to :user, index: true
  t.belongs_to :event, index: true

dans app/models/event.rb, (toujours dans la "class Event < ApplicationRecord", à la suite) ajouter les lignes:
  validates :start_date, presence: true, comparison: { greater_than: Date.time.now }
  validates :duration, presence: true, numericality: { equal_to: %5 = 0 && > 0}
  validates :title, presence: true, length: 5..140
  validates :description, presence: true, length: 20..10000
  validates :price, presence: true, length: 1..10000
  validates :location, presence: true

dans app/controllers/application_controller.rb, ajouter:
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
  end

rails g mailer UserMailer

dans app/mailer.user_mailer.rb, remplacer le code par:
  class UserMailer < ApplicationMailer
  default from: 'no-reply@monsite.fr'

    def welcome_email(user)
      #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
      @user = user 

      #on définit une variable @url qu'on utilisera dans la view d’e-mail
      @url  = 'http://monsite.fr/login' 

      # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
      mail(to: @user.email, subject: 'Bienvenue chez nous !') 
    end
  end

dans app/views/user_mailer, créer les 2 fichiers:
  welcome_email.html.erb
  welcome_email.txt.erb

Coller dans welcome_email.html.erb:
  <!DOCTYPE html>
  <html>
    <head>
      <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
    </head>
    <body>
      <h1>Salut <%= @user.first_name %> et bienvenue chez nous !</h1>
      <p>
        Tu t'es inscrit sur monsite.fr en utilisant l'e-mail suivant : <%= @user.email %>.
      </p>
      <p>
        Pour accéder à ton espace client, connecte-toi via : <%= @url %>.
      </p>
      <p> À très vite sur monsite.fr !
    </body>
  </html>

Coller dans welcome_email.txt.erb:
  Salut <%= @user.first_name %> et bienvenue chez nous !
  ==========================================================

  Tu t'es inscrit sur monsite.fr en utilisant l'e-mail suivant : <%= @user.email %>.

  Pour accéder à ton espace client, connecte-toi via : <%= @url %>.

  À très vite sur monsite.fr !

Ecrire juste après l'ouverture de la class dans app/models/user.rb:
  after_create :welcome_send

Ecrire juste avant la fermeture (end) de la class dans app/models/user.rb:
  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

dans config/routes.rb, ajouter:
   mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

dans config/environments/development.rb, copier (tout en bas, juste avant le "end"):
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.perform_deliveries = true

rails db:create db:migrate

ouvrir une nouvelle console, lancer "rails s" (dans le dossier du projet) et aller sur "http://localhost:3000/letter_opener" pour voir si le mail s'affiche
rails c (sur la fenêtre sans server)
user = User.create(first_name: "Alec", email: "alec@mail.fr")

curl -L https://fly.io/install.sh | sh

