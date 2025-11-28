create type strutturato as enum ('Ricercatore', 'Professore Associato', 'Professore Ordinario');

create type LavoroProgetto as enum ('Ricerca e Sviluppo', 'Dimostrazione', 'Management', 'Altro');

create type LavoroNonProgettuale as enum ('Didattica', 'Ricerca', 'Missione', 'Incontro Dipartimentale', 'Incontro Accademico', 'Altro');

create type CausaAssenza as enum ('Chiusura Universitaria', 'Maternita', 'Malattia');


create domain PosInteger as integer check (value >= 0);

create domain StringaM as varchar(100);

create domain NumeroOre as integer check (value >= 0 and value <= 8);

create domain Denaro as real ≥ 0;



create table Persona(
    id PosInteger primary key, 
    nome StringaM not null,
    cognome StringaM not null, 
    posizione Strutturato not null,
    stipendio Denaro not null
);

create table Progetto(
    id PosInteger not null,
    nome StringaM not null,
    inizio date not null,
    fine date not null,
    budget Denaro not null,
    primary key (id),
    unique (nome),
    check (inizio < fine)
);

create table WP(
    progetto PosInteger not null,
    id PosInteger not null,
    nome StringaM not null,
    inizio date not null,
    fine date not null,
    unique (progetto, nome),
    primary key (progetto, id),
    foreign key (progetto) references Progetto(id),
    check (inizio < fine)
);

create table AttivitaProgetto(
    id PosInteger not null,
    persona PosInteger not null,
    progetto PosInteger not null,
    wp PosInteger not null,
    giorno date not null,
    tipo LavoroProgetto not null,
    oreDurata NumeroOre not null,
    primary key (id),
    foreign key (persona) references Persona(id),
    foreign key (progetto, wp) references WP(progetto, id)
);

create table AttivitaNonProgettuale(
    id PosInteger primary key,
    persona PosInteger not null, 
    tipo LavoroNonProgettuale not null,
    giorno date not null,
    oreDurata NumeroOre not null,
    foreign key (persona) references Persona(id)
);

create table Assenza(
    id PosInteger primary key,
    persona PosInteger not null,
    tipo CausaAssenza not null,
    giorno date not null,
    unique (persona, giorno),
    foreign key (persona) references Persona(id)
);


insert into Persona(id, nome, cognome, posizione, stipendio) values (48965, 'Dino', 'Campana', 'Ricercatore', 1500);
insert into Persona(id, nome, cognome, posizione, stipendio) values (59648, 'Giorgia', 'Milo', 'Professore Associato', 1900);
insert into Persona(id, nome, cognome, posizione, stipendio) values (49562, 'Viola', 'Ricci', 'Professore Ordinario', 1980);
insert into Persona(id, nome, cognome, posizione, stipendio) values (13246, 'Daniele', 'Pinto', 'Ricercatore', 1600);


insert into Persona(id, nome, cognome, posizione, stipendio) values 
(931031, 'Elisa', 'Greco', 'Professore Ordinario', 35206),
(153936, 'Marco', 'Conti', 'Ricercatore', 36347),
(389167, 'Alessandro', 'De Luca', 'Professore Associato', 44619),
(988801, 'Elisabetta', 'Moretti', 'Professore Associato',92182),
(982878, 'Davide', 'Rinaldi', 'Professore Ordinario', 95213),
(641047, 'Danilo', 'Vocioni', 'Ricercatore', 45809),
(825284, 'Riccardo', 'Viti', 'Professore Associato', 29867),
(937387, 'Marta', 'Leone', 'Professore Associato', 80531),
(596434, 'Laura', 'Costa', 'Professore Ordinario', 98033),
(654523, 'Sara', 'Marchetti', 'Ricercatore', 43827),
(203826, 'Federico', 'Ricci', 'Ricercatore', 78653),
(540413, 'Lina', 'Benedetti', 'Professore Associato', 78466),
(205307, 'Alessia', 'Pellegrini', 'Professore Associato', 78411),
(764511, 'Beatrice', 'Mancini', 'Professore Ordinario', 75946),
(897031, 'Francesca', 'Galli', 'Professore Ordinario', 93964),
(796973, 'Nicola', 'Parisi', 'Professore Associato', 51195);

insert into Progetto(id, nome, inizio, fine, budget) values 
(47889, 'Security', '02/11/2025', '09/03/2026', 25000),
(42163, 'R3', '18/05/2025', '16/10/2025', 14000),
(49631, 'Tor93', '17/07/2025', '19/09/2026', 18000),
(85946, 'Roma69', '15/04/2025', '03/07/2025', 16000),
(85947, 'Giga71', '20/10/2024', '18/04/2025', 22000);

insert into WP(progetto, id, nome, inizio, fine) values 
(47889, 5, 'Dissemination', '29/01/2023', '19/07/2025'),
(42163, 3, 'Main Activity', '15/09/2024', '12/05/2025'),
(49631, 1, 'Main Research', '04/11/2024', '15/03/2026'),
(85946, 2, 'WP1', '18/05/2025', '16/10/2025'),
(85947, 4, 'WP2', '17/08/2024', '19/09/2025');

insert into Assenza(id, persona, tipo, giorno) values
(594, 931031, 'Malattia', '05/02/2025'),
(542, 153936, 'Chiusura Universitaria', '18/03/2025'),
(84, 389167, 'Malattia', '17/11/2024'),
(863, 988801, 'Maternita', '19/06/2024'),
(936, 982878, 'Chiusura Universitaria', '16/09/2024')
(7, 931031, 'Malattia', '15/11/2024'),
(8, 153936, 'Maternita', '14/03/2024');

insert into AttivitaProgetto(id, persona, progetto, wp, giorno, tipo, oreDurata) values 
(162, 540413, 47889, 5, '18/06/2025', 'Ricerca e Sviluppo', 8),
(158, 205307, 47889, 5, '25/09/2024', 'Dimostrazione', 8),
(52, 764511, 42163, 3, '06/03/2024', 'Management', 6),
(198, 897031, 42163, 3, '18/05/2022', 'Altro', 5),
(536, 796973, 49631, 1, '19/02/2025', 'Ricerca e Sviluppo', 7);

insert into AttivitaNonProgettuale(id, persona, tipo, giorno, oreDurata) values
(264, 825284, 'Didattica', '14/11/2024', 4),
(259, 937387, 'Missione', '18/03/2023', 2),
(96, 596434, 'Didattica', '15/06/2024', 4),
(399, 654523, 'Ricerca', '25/06/2025', 5),
(564, 203826, 'Incontro Accademico', '04/08/2025', 6);
