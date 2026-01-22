'''1. Elencare tutti i progetti la cui fine è successiva al
2023-12-31''' 
SELECT id, nome
FROM progetto
WHERE fine > '2023-12-31'; 


'''2. Contare il numero totale di persone per ciascuna posizione
(Ricercatore, Professore Associato, Professore Ordinario).'''
SELECT posizione, count(*)
FROM persona 
GROUP BY posizione; 


'''3. Restituire gli id e i nomi delle persone che hanno almeno
un giorno di assenza per "Malattia".'''
SELECT p.id, p.nome 
FROM persona p, assenza a 
WHERE p.id = a.persona and a.tipo = 'Malattia'
GROUP BY p.id, p.nome;

-- oppure 
SELECT distinct p.id, p.nome, p.cognome
FROM persona p, assenza a 
WHERE p.id = a.persona and a.tipo = 'Malattia'


'''4. Per ogni tipo di assenza, restituire il numero complessivo
di occorrenze'''
SELECT tipo, COUNT(*)
FROM assenza
GROUP BY tipo;


'''5. Calcolare lo stipendio massimo tra tutti i "Professori
Ordinari"'''
SELECT max(stipendio)
FROM persona 
WHERE posizione = 'Professore Ordinario';

-- oppure 

-- SELECT stipendio
-- FROM persona
-- WHERE posizione = 'Professore Ordinario'
-- ORDER BY stipendio DESC 
-- LIMIT 1;


'''6. Quali sono le attività e le ore spese dalla persona con id 1
nelle attività del progetto con id 4, ordinate in ordine
decrescente. Per ogni attività, restituire l’id, il tipo e il
numero di ore.'''
SELECT id, tipo, oredurata
FROM attivitaprogetto
WHERE persona = 1 and progetto = 4 
ORDER BY ore_durata desc;


'''7. Quanti sono i giorni di assenza per tipo e per persona. Per
ogni persona e tipo di assenza, restituire nome, cognome,
tipo assenza e giorni totali.'''
SELECT p.nome, p.cognome, a.tipo, count(a.giorno) as giorni_totali
FROM persona p, assenza a
WHERE a.persona = p.id 
GROUP BY p.nome, p.cognome, a.tipo;


'''8. Restituire tutti i “Professori Ordinari” che hanno lo
stipendio massimo. Per ognuno, restituire id, nome e
cognome'''

-- Opzione Subquery
SELECT id, nome, cognome
FROM persona
WHERE posizione = 'Professore Ordinario'
and stipendio = (
    SELECT max(stipendio)
    FROM persona 
    WHERE posizione = 'Professore Ordinario'
);

-- Opzione WITH
WITH mspo as (
    SELECT max(stipendio) as max_stipendio_PO
    FROM persona 
    WHERE posizione == 'Professore Ordinario')

SELECT id as persona_id, nome, cognome 
FROM persona, mspo 
WHERE posizione = 'Professore Ordinario' 
AND stipendio = mspo.max_stipendio_PO; 

-- Opzione 2
max_stipendio = float('-inf')
persone_max = [] 
for p in persona: 
    if p.stipendio > max_stipendio:
        max_stipendio = p.stipendio
        persone_max = [p] 
    elif p.stipendio = max_stipendio:
        persona.max.append(p)

-- Opzione 3 GROUP BY + HAVING (costa più della Subquery)
SELECT id as persona_id, nome, cognome 
FROM persona 
WHERE posizione = 'Professore Ordinario'
GROUP BY id, nome, cognome,
HAVING stipendio = (
    SELECT (max_stipendio)
    FROM persona 
    WHERE posizione = 'Professore Ordinario'
);

-- Opzione 4 >= ALL 
SELECT id as persona_id, nome, cognome 
FROM persona 
WHERE posizione = 'Professore Ordinario'
    AND stipendio >= ALL (
        SELECT stipendio
        FROM persona 
        WHERE posizione = 'Professore Ordinario'
    );


-- Opzione 5 NOT EXISTS 
SELECT p.id as persona_id, p.nome, p.cognome 
FROM persona p
WHERE posizione = 'Professore Ordinario'
    AND NOT EXISTS (
        SELECT *
        FROM persona p1 
        WHERE p1.posizione = 'Professore Ordinario'
            AND p1.stipendio > p.stipendio
    );


-- Opzione 6
SELECT *
FROM persona p
LEFT OUTER JOIN persona p1 
    on p.id <> p1.id AND p.posizione = 'Professore Ordinario' and p1.posizione = p.posizione
    AND p.stipendio < p1.stipendio 
    AND p1.id is null;



'''9. Restituire la somma totale delle ore relative alle attività
progettuali svolte dalla persona con id = 3 e con durata
minore o uguale a 3 ore'''
SELECT persona, sum(oredurata) as totale_ore 
FROM attivitaprogetto 
WHERE persona = 3 and oredurata <= 3 
GROUP BY persona;


'''10.Restituire gli id e i nomi delle persone che non hanno
mai avuto assenze di tipo "Chiusura Universitaria"'''
SELECT DISTINCT p.id, p.nome, p.cognome 
FROM persona p
WHERE p.id NOT IN (
    SELECT a.persona
    FROM assenza a 
    WHERE a.tipo = 'Chiusura Universitaria'
);


--capire perché questa query è sbagliata:
SELECT id as persona_id, nome, cognome
FROM persona 
WHERE posizione = 'Professore Ordinario'
GROUP BY id, nome, cognome, posizione
HAVING stipendio = max(stipendio)
AND posizione = 'Professore Ordinario';


