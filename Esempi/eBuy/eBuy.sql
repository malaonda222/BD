begin transaction;
 
create table Utente (
    username StringaM not null,
    registrazione timestamp not null,
    primary key (username)
);
 
create table VenditoreProfessionale (
    vetrina URL not null,
    utente StringaM not null,
    primary key (utente),
    unique (vetrina),
    foreign key (utente) references Utente(username) deferrable
);
 
create table Privato (
    utente StringaM not null,
    primary key (utente),
    foreign key (utente) references Utente(username) deferrable
);
 
create table PostOggetto (
    id serial not null,
    descrizione StringaM not null,
    pubblicazione timestamp not null,
    ha_feedback boolean not null, 
    voto Voto,
    istante_commento timestamp,
    commento StringaM,
    primary key (id),
    check ((ha_feedback = true) = (voto is not null and istante_commento is not null)),
    check (commento is null or ha_feedback = true)
-- v. inclusione: PostOggetto(id) occorre in met_post(postoggetto)
 
);
 
create table PostOggettoUsato (
    postoggetto IntGEZ not null,
    condizione Condizione not null,
    anni_garanzia IntGEZ not null,
    primary key (postoggetto),
    foreign key (postoggetto) references PostOggetto(id) deferrable
);
 
create table PostOggettoNuovo (
    postoggetto IntGEZ not null,
    anni_garanzia IntGE2 not null,
    primary key (postoggetto),
    foreign key (postoggetto) references PostOggetto(id) deferrable
);
 
create table pubblica (
    utente StringaM not null,
    postoggetto IntGEZ not null,
    primary key (postoggetto),
    foreign key (postoggetto) references PostOggetto(id) DEFERRABLE INITIALLY DEFERRED,
    foreign key (utente) references Utente (username) deferrable
);
 
alter table PostOggetto
add foreign key (id) references pubblica(postoggetto) DEFERRABLE INITIALLY DEFERRED;
 
create table pubblica_nuovo (
    postoggettonuovo IntGEZ not null,
    venditoreprofessionale StringaM not null,
    primary key (postoggettonuovo),
    foreign key (postoggettonuovo) references PostOggettoNuovo(postoggetto) deferrable,
    foreign key (venditoreprofessionale) references VenditoreProfessionale(utente) deferrable
);
 
alter table PostOggettoNuovo
add foreign key (postoggetto) references pubblica_nuovo(postoggettonuovo) DEFERRABLE INITIALLY DEFERRED;
 
create table MetodoDiPagamento (
    nome StringaM not null,
    primary key (nome)
);
 
create table met_post(
    metodo StringaM not null,
    postoggetto IntGEZ not null,
    primary key (metodo, postoggetto),
    foreign key (metodo) references MetodoDiPagamento(nome) deferrable,
    foreign key (postoggetto) references PostOggetto(id) deferrable
);
 
create table Categoria (
    nome StringaM not null,
    super StringaM,
    primary key (nome),
    check (nome <> super)
);
 
alter table Categoria
add foreign key (super) references Categoria(nome) deferrable;
 
create table cat_post (
    categoria StringaM not null,
    postoggetto IntGEZ not null,
    primary key (postoggetto),
    foreign key (categoria) references Categoria(nome) DEFERRABLE INITIALLY DEFERRED,
    foreign key (postoggetto) references PostOggetto(id) DEFERRABLE INITIALLY DEFERRED
);
 
alter table PostOggetto
add foreign key (id) references cat_post(postoggetto) DEFERRABLE INITIALLY DEFERRED;
 
create table Asta (
    postoggetto IntGEZ not null,
    prezzo_bid RealGZ not null,
    scadenza timestamp not null,
    prezzo_base RealGEZ not null,
    primary key (postoggetto),
    foreign key (postoggetto) references PostOggetto(id) deferrable
);
 
create table CompraloSubito (
    postoggetto IntGEZ not null,
    prezzo RealGZ not null,
    privato StringaM,
    acquirente_istante timestamp,
    primary key (postoggetto),
    foreign key (postoggetto) references PostOggetto(id) deferrable,
    foreign key (privato) references Privato(utente) deferrable,
    check ((privato is null) = (acquirente_istante is null))
);
 
create table Bid (
    codice serial not null,
    istante timestamp not null,
    primary key (codice),
    unique (istante)
);
 
create table asta_bid (
    bid IntGEZ not null,
    asta IntGEZ not null,
    primary key (bid),
    foreign key (bid) references Bid(codice) DEFERRABLE INITIALLY DEFERRED,
    foreign key (asta) references Asta(postoggetto) DEFERRABLE INITIALLY DEFERRED
);
 
alter table Bid
add foreign key (codice) references asta_bid(bid) DEFERRABLE INITIALLY DEFERRED;
 
create table bid_ut (
    privato StringaM not null,
    bid IntGEZ not null,
    primary key (bid),
    foreign key (privato) references Privato(utente) DEFERRABLE INITIALLY DEFERRED,
    foreign key (bid) references Bid(codice) DEFERRABLE INITIALLY DEFERRED
);
 
alter table Bid
add foreign key (codice) references bid_ut(bid) DEFERRABLE INITIALLY DEFERRED;
 
commit;




BEGIN;
 
INSERT INTO Utente(username, registrazione) VALUES
  ('Alice', '2025-01-10 10:00:00'),
  ('Carlo',   '2025-02-15 14:30:00'),
  ('Milena', '2025-03-05 09:45:00');
 
INSERT INTO VenditoreProfessionale(utente, vetrina) VALUES
  ('Alice', 'https://shop.alice.com'),
  ('Carlo',   'https://carlo-store.example.com');
 
INSERT INTO Privato(utente) VALUES
  ('Milena');
 
INSERT INTO MetodoDiPagamento(nome) VALUES
  ('CartaCredito'), ('PayPal'), ('Bonifico');
 
INSERT INTO Categoria(nome, super) VALUES
  ('Elettronica', NULL),
  ('Cellulari', 'Elettronica'),
  ('Abbigliamento', NULL),
  ('AbitiUomo', 'Abbigliamento');
 
INSERT INTO PostOggetto(id, descrizione, pubblicazione, ha_feedback, voto, istante_commento, commento)
VALUES
  (1, 'iPhone 12 usato', '2025-08-01 12:00:00', true, 4, '2025-08-05 15:30:00', 'Bello e in buone condizioni'),
  (2, 'Samsung Galaxy nuovo', '2025-08-02 13:15:00', false, NULL, NULL, NULL),
  (3, 'Giacca invernale taglia L', '2025-08-03 09:20:00', true, 5, '2025-08-04 10:00:00', 'Perfetta');
 
INSERT INTO OggettoUsato(postoggetto, condizione, anni_garanzia) VALUES
  (1, 'buono', 1),
  (3, 'ottimo', 2);
 
INSERT INTO PostOggettoNuovo(postoggetto, anni_garanzia) VALUES
  (2, 1);
 
INSERT INTO pubblica_nuovo(postoggettonuovo, venditoreprofessionale)
VALUES
  (2, 'Carlo');
 
INSERT INTO pubblica(utente, postoggetto) VALUES
  ('Alice', 1),
  ('Carlo', 2),
  ('Milena', 3);
 
INSERT INTO met_post(metodo, postoggetto) VALUES
  ('CartaCredito', 1),
  ('PayPal', 2),
  ('Bonifico', 3),
  ('CartaCredito', 3);
 
INSERT INTO cat_post(categoria, postoggetto) VALUES
  ('Cellulari', 1),
  ('Cellulari', 2),
  ('AbitiUomo', 3);
 
INSERT INTO Asta(postoggetto, prezzo_bid, scadenza, prezzo_base) VALUES
  (1, 120.5, '2025-09-01 12:00:00', 100.0);
 
INSERT INTO CompraloSubito(postoggetto, prezzo, privato, acquirente_istante) VALUES
  (3, 80.0, 'Milena', NULL);
 
INSERT INTO Bid(codice, istante) VALUES
  (1, '2025-08-10 11:00:00'),
  (2, '2025-08-15 16:20:00');
 
INSERT INTO asta_bid(bid, asta) VALUES
  (1, 1),
  (2, 1);
 
INSERT INTO bid_ut(bid, privato) VALUES
  (1, 'Milena'),
  (2, 'Milena');
 
COMMIT;



