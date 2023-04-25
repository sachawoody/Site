CREATE TABLE utilisateurs(
   id_utilisateur int primary key auto_increment not null,
   mail_utilisateur VARCHAR(50) NOT NULL,
   password_utilisateur VARCHAR(100) NOT NULL,
   description_utilisateur TEXT NOT NULL,
   id_role int not null,
);

CREATE TABLE roles(
   id_role int primary key auto_increment not null,
   nom_role VARCHAR(50) NOT NULL,
   description_role TEXT NOT NULL,
);

CREATE TABLE jeux(
   id_jeu int primary key auto_increment not null,
   nom_jeu VARCHAR(50) NOT NULL,
   description_jeu TEXT NOT NULL,
   sortie_jeu DATETIME NOT NULL,
   createur_jeu VARCHAR(50) NOT NULL,
   en_ligne_jeu LOGICAL NOT NULL,
   hors_ligne_jeu LOGICAL NOT NULL,
   id_category int not null,
);

CREATE TABLE categories(
   id_category int primary key auto_increment not null,
   nom_category VARCHAR(50) NOT NULL,
   description_category TEXT NOT NULL,
);

CREATE TABLE articles(
   id_article int primary key auto_increment not null,
   nom_article VARCHAR(50) NOT NULL,
   contenu_article TEXT NOT NULL,
   date_article DATETIME NOT NULL,
   id_utilisateur int not null,
);

CREATE TABLE commentaires(
   id_commentaire int primary key auto_increment not null,
   contenu_commentaire TEXT NOT NULL,
   date_commentaire DATETIME NOT NULL,
   id_article int not null,
   id_utilisateur int not null,
);

CREATE TABLE messages(
   id_message int primary key auto_increment not null,
   contenu_message TEXT NOT NULL,
   date_message DATETIME NOT NULL,
   id_utilisateur int not null,
);

CREATE TABLE classements (
   id_classement int primary key auto_increment not null,
   nom_classement varchar(50) not null,
   contenu_classement text not null,
   update_classement datetime not null
)

ALTER TABLE utilisateurs 
add constraint fk_own_role
foreign key (id_role)
references roles(id_role);

alter table jeux
add constraint fk_own_category
foreign key (id_category)
references categories(id_category);

alter table articles
add constraint fk_own_creator
foreign key (id_utilisateur)
references utilisateurs(id_utilisateur);

alter table commentaires
add constraint fk_own_author
foreign key (id_utilisateur)
references utilisateurs(id_utilisateur);

alter table commentaires
add constraint fk_own_article
foreign key (id_article)
references articles(id_article);

alter table messages
add constraint fk_own_author
foreign key (id_utilisateur)
references utilisateurs(id_utilisateur);