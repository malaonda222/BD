create table categoria (
	nome stringa primary key,
	super stringa,
	check (nome <> super)
);

alter table add foreign key (super)
		references categoria(nome);

-- WITH RECURSIVE


create table utente (
	username stringa primary key,
	registrazione timestamp
);

create table privato (
	utente stringa primary key,
	foreign key (utente)
		references utente(username) deferrable
);

create table venditoreprof (
	utente stringa primary key,
	vetrina URL not null,
	unique(vetrina),
	foreign key (utente)
		references utente(username)
);

-- [V.Utente.compl] e [V.Utente.disj] non ancora implementati


create table PostOggetto (
	id serial primary key,
	pubblica StringaM not null,
	descrizione StringaM not null,
	unique(id, pubblica), --chiave non-minimale
	pubblicazione timestamp not null,
	ha_feedback boolean not null default false,
	voto Voto,
	commento StringaM,
	istante_feedback timestamp,
	categoria StringaM not null,
	-- vincoli di ennupla per modellare [V.PostOggetto.feedback]
	check(
		(ha_feedback = true)
		=
		(voto is not null and istante_feedback is not null)
		),
	-- se c'è il commento allora ha_feedback è true
	check (commento is null OR ha_feedback=true),
	foreign key (categoria)
		references categoria(nome),


	-- v.incl. (id) occorre in met_post(postoggetto)

	foreign key (pubblica)
		references utente(username)
	check(commento is null or commento > pubblicazione) 
);


create table postoggettonuovo (
	postoggetto integer primary key,
	pubblica_nuovo stringa not null,
	anni_garanzia IntGE2 not null,

	foreign key (pubblica_nuovo) 
		references venditoreprof(utente),


	# implementa [V.PostOggettoNuovo.pubblica.isa]
	foreign key (postoggetto, pubblica_nuovo)
		references postoggetto(id, pubblica) deferrable,
);

create table PostOggettoUsato (
	postoggetto integer primary key,
	condizione Condizione not null,
	anni_garanzia IntGEZ not null,
	foreign key (postoggetto) references Postoggetto(id)
)	

-- I vincoli {complete, dijoint} su PostOggetto nuovo/usato non sono ancora implementati
-- I vincoli {complete, dijoint} su PostOggetto asta/compralosubito non sono ancora implementati 


create table metodopagamento (
	nome StringaM primary key
);

create table met_post (
	postoggetto integer not null,
	metodo StringaM not null,
	primary key (postoggetto, metodo),
	foreign key (postoggetto)
		references Postoggetto(id) deferrable,
	foreign key (metodo)
		references metodopagamento(nome)
);

create table PostOggettoCompraloSubito (
	postoggetto integer primary key,
	prezzo RealGZ not null,
	acquirente StringaM,
	istante_acquisto timestamp, 
	foreign key (postoggetto) references Postoggetto(id),
	foreign key (acquirente) references Privato(utente),
	check (acquirente is null) == (istante_acquisto is null)
	
);

create table PostOggettoAsta (
	postoggetto integer primary key,
	prezzo_base RealGEZ not null,
	prezzo_bid RealGZ not null,
	scadenza timestamp not null,
	foreign key (postoggetto) references Postoggetto(id) deferrable
);

create table Bid (
	codice serial primary key,
	istante timestamp not null,
	asta IntGEZ not null,
	privato StringaM not null,
	foreign key (privato) references Privato(utente),
	foreign key (asta) references PostOggettoAsta(postoggetto),
	unique(istante, asta) --questo implementa {id2}
);
