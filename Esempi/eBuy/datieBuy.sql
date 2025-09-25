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
 
INSERT INTO PostOggettoUsato(postoggetto, condizione, anni_garanzia) VALUES
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