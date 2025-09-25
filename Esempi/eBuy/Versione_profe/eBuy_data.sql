begin transaction;

insert into Categoria(nome, super)
values 
('Elettronica', NULL),
('Informatica', 'Elettronica'),
('Laptop', 'Informatica'),
('Casa e giardino', NULL), 
('Arredamento', 'Casa e giardino'),
('Giardinaggio', 'Casa e giardino');

commit; 


begin transaction;
    set constraints all deferred;

insert into Utente(username, registrazione)
values 
('U1001', current_timestamp),
('U1002', current_timestamp),
('U1003', current_timestamp),
('U1004', current_timestamp);

insert into Privato(utente)
values
('U1001'),
('U1002');

insert into VenditoreProfessionale(utente, vetrina)
values 
('U1003', 'https://www.example.com'),
('U1004', 'http://blog.site-name.org/articles/2023/page.html');

commit;


insert into MetodoDiPagamento(nome)
values
('Carta'),
('Bonifico'),
('PayPal');


begin transaction;
    set constraints all deferred;

insert into PostOggetto(id, descrizione, pubblicazione, pubblica, categoria)
values
(1001, 'IKEA Kallax 4x4', current_timestamp, 'U1004', 'Arredamento'),
(1002, 'Apple MacBook Pro M4 12 core', current_timestamp, 'U1003', 'Laptop'),
(1003, 'Zappa deluxe', current_timestamp, 'U1002', 'Giardinaggio'),
(1004, 'Annaffiatoio deluxe', current_timestamp, 'U1002', 'Giardinaggio'),
(1005, 'Rastrello semi-nuovo', current_timestamp, 'U1002','Giardinaggio'),
(1006, 'Comodino Stockholm', current_timestamp, 'U1004', 'Arredamento');

insert into PostOggettoUsato(postoggetto, condizione, anni_garanzia)
values 
(1003, 'ottimo', 0),
(1004, 'ottimo', 0),
(1005, 'buono', 0),
(1006, 'discreto', 1);

insert into PostOggettoNuovo(postoggetto, anni_garanzia, pubblica_nuovo)
values 
(1001, 2, 'U1004'),
(1002, 5, 'U1003');

insert into CompraloSubito(postoggetto, prezzo)
values 
(1005, 10),
(1002, 2499.99),
(1001, 174.00);

insert into Asta(postoggetto, prezzo_bid, scadenza, prezzo_base)
values 
(1003, 1.00, current_timestamp + interval '7 day', 5.00),
(1004, 0.50, current_timestamp + interval '4 day', 1.00),
(1006, 2.00, current_timestamp + interval '3 day', 10.00);


commit;

begin transaction
    set constraints all deferred;

insert into Utente(username, registrazione)
values 
('U1005', current_timestamp);
 
insert into Privato(utente)
values
('U1005');


begin transaction;
    set constraints all deferred;

insert into Bid(codice, istante, asta, privato)
values
(99001, current_timestamp, 1003, 'U1001');

commit;


begin transaction;
    set constraints all deferred;

insert into Bid(codice, istante, asta, privato)
values
(99002, current_timestamp, 1003, 'U1005');

insert into Bid(codice, istante, asta, privato)
values
(99003, current_timestamp, 1003, 'U1001');

insert into Bid(codice, istante, asta, privato)
values
(99004, current_timestamp, 1003, 'U1005');

insert into Bid(codice, istante, asta, privato)
values
(99005, current_timestamp, 1003, 'U1001');

insert into Bid(codice, istante, asta, privato)
values
(99006, current_timestamp, 1003, 'U1005');

insert into Bid(codice, istante, asta, privato)
values
(99007, current_timestamp, 1003, 'U1001');

insert into Bid(codice, istante, asta, privato)
values
(99008, current_timestamp, 1003, 'U1005');

insert into Bid(codice, istante, asta, privato)
values
(99009, current_timestamp, 1004, 'U1001');

insert into Bid(codice, istante, asta, privato)
values
(99010, current_timestamp, 1004, 'U1005');

commit;

-- insert into postoggetto(id )

-- values
-- (1001)
-- (1002)
-- (1003)
-- (1004)
-- (1005)
-- (1006)
-- (1007)
-- (10011)
-- (10012)
-- (10013)

