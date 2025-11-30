'''1. Elencare tutti i progetti la cui fine è successiva al
2023-12-31''' 
SELECT id, nome
FROM progetto
where fine > '2023-12-31' 


'''2. Contare il numero totale di persone per ciascuna posizione
(Ricercatore, Professore Associato, Professore Ordinario).'''
SELECT posizione, count(posizione)
FROM persona 
GROUP BY posizione 


'''Restituire gli id e i nomi delle persone che hanno almeno
un giorno di assenza per "Malattia".'''
SELECT p.id, p.nome 
FROM persona p, assenza a 
WHERE p.id = a.persona and a.tipo == 'Malattia'
GROUP BY p.id, p.nome
HAVING COUNT(a.tipo) >= 1


'''Per ogni tipo di assenza, restituire il numero complessivo
di occorrenze'''
SELECT tipo, COUNT(tipo)
FROM assenza
GROUP BY tipo


'''Calcolare lo stipendio massimo tra tutti i "Professori
Ordinari"'''
SELECT max(stipendio)
FROM persona 
WHERE posizione = 'Professore Ordinario'

-- oppure 

SELECT nome, cognome, stipendio
FROM persona
WHERE posizione = 'Professore Ordinario'
ORDER BY stipendio DESC 
LIMIT 1


'''Quali sono le attività e le ore spese dalla persona con id 1
nelle attività del progetto con id 4, ordinate in ordine
decrescente. Per ogni attività, restituire l’id, il tipo e il
numero di ore.'''
SELECT id, tipo, sum(oredurata) as totale_ore
FROM attivitaprogetto
WHERE persona = 1 and progetto = 4 
GROUP BY id, tipo
ORDER BY totale_ore desc


'''Quanti sono i giorni di assenza per tipo e per persona. Per
ogni persona e tipo di assenza, restituire nome, cognome,
tipo assenza e giorni totali.'''
SELECT p.nome. p.cognome, count(a.tipo), count(a.giorno)
FROM assenza a, persona p 
WHERE a.persona = p.id 
GROUP BY a.tipo, p.nome


'''Restituire tutti i “Professori Ordinari” che hanno lo
stipendio massimo. Per ognuno, restituire id, nome e
cognome'''
SELECT id, nome, cognome, max(stipendio)
FROM persona
WHERE posizione = 'Professore Ordinario'
GROUP BY id, nome, cognome


'''Restituire la somma totale delle ore relative alle attività
progettuali svolte dalla persona con id = 3 e con durata
minore o uguale a 3 ore'''
SELECT persona, sum(oredurata) as totale_ore 
FROM attivitaprogetto 
WHERE persona = 3 and oredurata <= 3 


'''Restituire gli id e i nomi delle persone che non hanno
mai avuto assenze di tipo "Chiusura Universitaria"'''
SELECT DISTINCT p.id, p.nome, p.cognome 
FROM assenza a, persona p
WHERE a.persona = p.id and a.tipo != 'Chiusura Universitaria'
GROUP BY p.id, p.nome, p.cognome 

