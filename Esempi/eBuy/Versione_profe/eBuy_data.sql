insert into Categoria(nome, super)
values 
('Elettronica', NULL),
('Informatica', 'Elettronica'),
('Laptop', 'Informatica'),
('Casa e giardino', NULL), 
('Arredamento', 'Casa e giardino'),
('Giardinaggio', 'Casa e giardino');

begin transaction;
    set constraints all deferred;

insert into Utente(username, registrazione)
values 
('U1001', current_timestamp),
('U1002', current_timestamp),
('U1003', current_timestamp),
('U1003', current_timestamp);

insert into Privato(utente)
values
('U1001'),
('U1002');

insert into VenditoreProfessionale(utente, vetrina)
values 
('U1003', 'www.example.u3.com'),
('U1004', 'www.mystore.u4.it');

commit;


insert into MetodoPagamento(nome)
values
('Carta'),
('Bonifico'),
('PayPal');


begin transaction;
    set constraints all deferred;

insert into PostOggetto(id, pubblica, descrizione, pubblicazione, categoria)
values
(1001, 'U1004', 'IKEA Kallax 4x4', current_timestamp, 'Arredamento'),
(1002, 'U1003', 'Apple MacBook Pro M4 12 core', current_timestamp, 'Laptop'),
(1003, 'U1002', 'Zappa deluxe', current_timestamp, 'Giardinaggio'),
(1004, 'U1002', 'Annaffiatoio deluxe', current_timestamp, 'Giardinaggio'),
(1005, 'U1002', 'Rastrello semi-nuovo', current_timestamp, 'Giardinaggio'),
(1006, 'U1004', 'Comodino Stockholm', current_timestamp, 'Arredamento');

insert into PostOggettoUsato(postoggetto, condizione, anni_garanzia)
values 
(1003, 'Ottimo', 0),
(1004, 'Ottimo', 0),
(1005, 'Buono', 0),
(1006, 'Discreto', 1);

insert into PostOggettoNuovo(postoggetto, pubblica_nuovo, anni_garanzia)
values 
(1001, 'U1004', 2),
(1002, 'U1003', 5);

insert into PostOggettoCompraloSubito(postoggetto, prezzo)
values 
(1005, 10),
(1002, 2499.99),
(1001, 174.00);


insert into PostOggettoAsta(postoggetto, prezzo_base, prezzo_bid, scadenza)
values 
(1003, 5.00, 1.00, current_timestamp + interval '7 day'),
(1004, 1.00, 0.5, current_timestamp + interval '4 day'),
(1006, 10.00, 2.00, current_timestamp + interval '3 day');


commit;

begin transaction
    set constraints all deferred;

insert into Utente(username, registrazione)
values 
('U1005', current_timestamp);
 
insert into Privato(utente)
values
('U1005')

commit; 


insert into Bid(codice, istante, asta, privato)
values
(99001, current_timestamp, 1003, 'U1001');

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

