begin transaction;

set constraints all deferred;

create domain CAP char(5) check (value ~ '^[0-9]{5}$');

create domain Stringa as varchar(100);

create domain CodiceFiscale as varchar(16) check (value ~ '^[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]$');

create domain PosInteger as integer check (value >= 0);

create domain Real_0_1 as real check (value between 0 and 1);

create domain PartitaIVA as char(11) check (value ~ '^\d{11}$');

create domain Importo as integer check (value >= 0);

create domain Email as varchar(255) check (value ~* '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

create domain Telefono as varchar(15) check (value ~ '^\+?[0-9]{6,15}$');

create type Indirizzo as (
    via Stringa, 
    civico Stringa,
    cap CAP
);

create type Stato as enum ('in preparazione', 'inviato', 'da saldare', 'saldato');


create table Nazione (
    nome Stringa not null,
    primary key (nome) 
);

create table Regione (
    nome Stringa not null,
    nazione Stringa not null,
    primary key (nome, nazione),
    foreign key (nazione) references Nazione(nome)
);

create table Citta (
    id PosInteger not null,
    nome Stringa not null,
    regione Stringa not null,
    nazione Stringa not null,
    primary key (id),
    foreign key (regione, nazione) references Regione(nome, nazione),
    unique (nome, regione, nazione)
);

create table Direttore (
    id PosInteger not null, 
    cf CodiceFiscale not null,
    nome Stringa not null,
    cognome Stringa not null, 
    data_nascita date not null,
    anni_servizio PosInteger not null,
    citta PosInteger not null,
    primary key (id),
    unique (cf),
    foreign key (citta) references Citta(id)
);

create table Dipartimento (
    id PosInteger not null,
    nome Stringa not null,
    indirizzo Indirizzo not null,
    direttore PosInteger not null,
    primary key (id),
    unique (nome),
    foreign key (direttore) references Direttore(id)
);

create table Ordine (
    id PosInteger not null,
    data_stipula date not null,
    descrizione_bene Stringa not null,
    importo Importo not null,
    aliquota_IVA Real_0_1 not null,
    stato Stato not null,
    dipartimento PosInteger not null,
    fornitore PosInteger not null,
    primary key (id),
    foreign key (dipartimento) references Dipartimento(id)
);

create table Fornitore (
    id PosInteger not null,
    ragione_sociale Stringa not null,
    partita_iva PartitaIVA not null,
    indirizzo Indirizzo not null,
    telefono Telefono not null,    
    email Email not null,
    primary key (id)
);

alter table Ordine add
foreign key (fornitore) references Fornitore(id) deferrable;

commit;