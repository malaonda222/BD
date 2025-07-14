begin transaction;

set constraints all deferred;

create domain Stringa as varchar;

create domain IntGEZ as integer
    check (value >= 0);

create domain IntGZ as integer
    check (value > 0);

create domain Real_0_10 as real
    check (value >= 0 and value <= 10);

create type colore as ENUM 
('Bianco', 'Nero');

create type indirizzo as (
    via Stringa, 
    civico Stringa
);




create table nazione (
    nome Stringa primary key
);

create table regione (
    nome Stringa not null 
    -- accorpa reg_naz
    nazione Stringa not null, 
    foreign key(nazione) references nazione(nome),
    primary key(nome, nazione)
);

create table citta (
    id integer primary key,
    nome Stringa not null
    regione Stringa not null,
    nazione Stringa not null,
    foreign key (regione, nazione) references regione(nome, nazione)
    unique (nome, regione, nazione)
);

create table giocatore (
    nickname Stringa primary key,
    nome Stringa not null,
    cognome Stringa not null,
    indirizzo Indirizzo not null,
    rank IntGZ not null,
    citta integer not null, 
    foreign key (citta) references citta(id)
);

create table torneo (
    id integer primary key,
    nome Stringa not null,
    descrizione Stringa not null,
    edizione integer not null
);

create table partita (
    id integer primary key,
    data date not null,
    indirizzo Indirizzo not null,
    komi Real_0_10 not null, 
    citta integer not null, 
    foreign key (citta) references citta(id),

    -- accorpa bianco 
    bianco Stringa not null,
    foreign key (bianco)
        references giocatore(nickname)

    torneo integer, 
    foreign key (torneo)
        references torneo(id)

    -- posticipiano la definizione della foreign key verso nero
    -- perché questa ancora non esiste 
);

create table nero (
    partita integer not null,
    giocatore Stringa not null,
    primary key (partita), -- perché può avere un solo giocatore nero!
    foreign key (giocatore)
        references giocatore(nickname)
    foreign key (partita)
        references partita(id) deferrable
);

alter table partita
    add constraint partita_nero_fkey
    -- vincolo di inclusione
    foreign key (id) references nero (partita);

create table regole (
    nome Stringa primary key 
);

insert into regole(nome) values
('Giapponesi'),
('Cinesi');

create table PartitaConRinuncia (
    partita integer primary key,
    foreign key (partita) references partita(id),
    rinunciatario colore not null
);

create table PartitaConPunteggio (
    partita integer primary key,
    foreign key (partita) references partita(id),
    punteggio_bianco IntGEZ not null,
    punteggio_nero IntGEZ not null
);


commit; 


begin transaction;
set constraints all deferred;
insert into partita(...)
insert into nero (...)
commit; -- solo adesso vengono effettivamente valutati i vincoli