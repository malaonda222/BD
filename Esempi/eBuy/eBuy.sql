begin transaction;

create domain StringaM as varchar(100);
create domain Voto as integer check (value between 0 and 5);
create domain IntGEZ as integer check (value >= 0);
create domain IntG1 as integer check (value > 1);
create domain URL as varchar check (value ~ "^https?:\\/\\/(?:www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{1,256}\\.[a-zA-Z0-9()]{1,6}\\b(?:[-a-zA-Z0-9()@:%_\\+.~#?&\\/=]*)$");
create domain RealGEZ as real check (value >= 0);
create domain RealGZ as real check (value > 0);
create type Condizione as enum ('ottimo', 'buono', 'discreto', 'da sistemare');
create type Popolarita as enum ('Bassa', 'Media', 'Alta');


create table Utente (
    username StringaM not null,
    registrazione timestamp not null,
    username primary key
);

create table VenditoreProfessionale (
    utente StringaM not null,
    vetrina URL not null,
    unique (vetrina),
    primary key (utente),
    foreign key (utente) references Utente(username)
);

create table Privato (
    utente StringaM not null,
    primary key (utente),
    foreign key (utente) references Utente(username)
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
    check (
        ha_feedback = true
        =
        voto is not null AND istante_commento is not null
        )
    check (commento is null OR ha_feedback = true),

    -- v.inclusione: [V.inclusione PostOggetto(id) occorre in pubblica(postoggetto)]
    foreign key Postoggetto(id) references pubblica(postoggetto) DEFERRABLE INITIALLY DEFERRED,
    -- v.inclusione: [V.inclusione PostOggetto(id) occorre in met_post(postoggetto)]

    -- v.inclusione: [V.inclusione PostOggetto(id) occorre in cat_post(postoggetto)]
    foreign key Postoggetto(id) references cat_post(postoggetto) DEFERRABLE INITIALLY DEFERRED
); 

create table OggettoUsato (
    postoggetto IntGEZ not null, 
    condizione Condizione not null,
    anni_garanzia IntGEZ not null,
    primary key (postoggetto),
    foreign key (postoggetto) references PostOggetto(id)
);

create table PostOggettoNuovo (
    postoggetto IntGEZ not null,
    anni_garanzia IntG1 not null,
    primary key (postoggetto),
    foreign key (postoggetto) references PostOggetto(id),
    foreign key PostOggettoNuovo(postoggetto) references pubblica_nuovo(postoggettonuovo) DEFERRABLE INITIALLY DEFERRED
);

create table pubblica_nuovo (
    postoggettonuovo IntGEZ not null,
    venditoreprofessionale StringaM not null,
    primary key (postoggettonuovo),
    foreign key (postoggettonuovo) references PostOggettoNuovo(postoggetto),
    foreign key (venditoreprofessionale) references VenditoreProfessionale(utente)
);

create table pubblica (
    utente StringaM not null,
    postoggetto IntGEZ not null,
    primary key (postoggetto),
    foreign key (postoggetto) references PostOggetto(id),
    foreign key (utente) references Utente(username)
);

create table MetodoDiPagamento (
    nome StringaM not null,
    primary key nome
)

create table met_post ( 
    metodo StringaM not null,
    postoggetto IntGEZ not null,
    primary key (metodo, postoggetto),
    foreign key (metodo) references MetodoDiPagamento(nome),
    foreign key (postoggetto) references PostOggetto(id)
);

create table Categoria (
    nome StringaM not null, 
    super StringaM, 
    check (nome <> super)
);

alter table add foreign key (super) references Categoria(nome)

create table cat_post (
    categoria StringaM not null,
    postoggetto IntGEZ not null,
    primary key (postoggetto),
    foreign key (categoria) references Categoria(nome),
    foreign key (postoggetto) references PostOggetto(id)
);

create table Asta (
    postoggetto IntGEZ not null,
    prezzo_bid RealGZ not null,
    scadenza timestamp not null,
    prezzo_base RealGEZ not null,
    primary key postoggetto,
    foreign key (postoggetto) references PostOggetto(id)
);

create table CompraloSubito (
    postoggetto IntGEZ not null,
    prezzo RealGZ not null,
    privato StringaM,
    acquirente_istante timestamp,  
    primary key (postoggetto),
    foreign key (postoggetto) references PostOggetto(id),
    foreign key (privato) references Privato(utente),
    check((privato is null)=(acquirente_istante is null))
);

create table Bid (
    codice serial not null,
    istante timestamp not null,
    primary key (codice),
    unique (istante),
    -- v.inclusione: [V.inclusione Bid(codice) occorre in asta_bid(bid)]
    foreign key Bid(codice) references asta_bid(bid) DEFERRABLE INITIALLY DEFERRED,
    --v.inclusione: [V.inclusione Bid(codice) occorre in bid_ut(bid)]
    foreign key Bid(codice) references bid_ut(bid) DEFERRABLE INITIALLY DEFERRED
);

create table asta_bid (
    bid IntGEZ not null,
    asta IntGEZ not null,
    primary key (bid),
    foreign key (bid) references Bid(codice);
    foreign key (asta) references Asta(postoggetto)
);

create table bid_ut (
    bid IntGEZ not null,
    privato StringaM not null,
    primary key (bid),
    foreign key (bid) references Bid(codice),
    foreign key (privato) references Privato(utente)
);

commit;



