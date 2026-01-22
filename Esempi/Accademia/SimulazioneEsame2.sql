/*1. Quali sono le persone con stipendio di al massimo 40000 euro?*/
SELECT nome, cognome
FROM persona
WHERE stipendio <= 40000;


/*2. Quali sono i ricercatori che lavorano ad almeno un progetto e hanno uno stipendio 
di al massimo 40000?*/
SELECT p.id, p.nome, p.cognome 
FROM persona p
JOIN attivitaprogetto ap ON ap.persona = p.id
WHERE p.stipendio <= 40000 and p.posizione = 'Ricercatore'
GROUP BY p.id, p.nome, p.cognome 
HAVING COUNT(ap.progetto) >= 1;

SELECT DISTINCT p.id, p.nome, p.cognome 
FROM persona p, attivitaprogetto a 
WHERE p.id = ap.persona AND p.posizione = 'Ricercatore' AND p.stipendio <= 40000


/*3. Qual è il budget totale dei progetti nel db?*/
SELECT sum(budget) as budget_totale
FROM progetto;


/*4. Qual è il budget totale dei progetti a cui lavora ogni persona? 
Per ogni persona restituire nome, cognome e budget totale dei progetti nei quali è coinvolto.*/
SELECT p.nome, p.cognome, sum(distinct(pr.budget)) as budget_totale
FROM persona p 
JOIN attivitaprogetto ap ON ap.persona = p.id 
JOIN progetto pr ON pr.id = ap.progetto
GROUP BY p.nome, p.cognome   
ORDER BY p.nome DESC;


/*5. Qual è il numero di progetti a cui partecipa ogni professore ordinario. Per ogni professore 
ordinario, restituire nome, cognome, numero di progetti nei quali è coinvolto*/ 
SELECT p.id, p.nome, p.cognome, count(distinct(ap.progetto)) as numero_progetti
FROM persona p, attivitaprogetto ap
WHERE p.posizione = 'Professore Ordinario' and p.id = ap.persona
GROUP BY p.id, p.nome, p.cognome


/*6. Qual è il numero di assenze per malattia di ogni professore associato. Per 
ogni professore associato, restituire nome, cognome e numero di assenze per
malattia*/
SELECT p.id, p.nome, p.cognome, count(a.tipo) as numero_assenze_malattia
FROM persona p, assenza a
WHERE p.posizione = 'Professore Associato' and p.id = a.persona and a.tipo = 'Malattia'
GROUP BY p.id, p.nome, p.cognome;


/*7. Qual è il numero totale di ore, per ogni persona, dedicate al progetto con id 
‘5’. Per ogni persona che lavora al progetto, restituire nome, cognome e numero di ore totali
dedicate ad attività progettuali relative al progetto*/
SELECT p.id, p.nome, p.cognome, sum(ap.oredurata) as ore_totali
FROM persona p
JOIN attivitaprogetto ap ON ap.persona = p.id
WHERE ap.progetto = 5
GROUP BY p.id, p.nome, p.cognome


/*8. Qual è il numero medio di ore delle attività progettuali svolte da ogni 
persona. Per ogni persona, restituire nome, cognome e numero medio di ore delle 
sue attività progettuali (in qualsivoglia progetto)*/
SELECT p.id, p.nome, p.cognome, round(avg(ap.oredurata), 2) as numero_medio_ore
FROM persona p
JOIN attivitaprogetto ap ON ap.persona = p.id
GROUP BY p.id, p.nome, p.cognome


/*9. Qual è il numero totale di ore, per ogni persona, dedicate alla didattica. 
Per ogni persona che ha svolto attività didattica, restituire nome, cognome e 
numero di ore totali dedicate alla didattica*/
SELECT p.id, p.nome, p.cognome, sum(anp.oredurata) as ore_totali_didattica
FROM persona p, attivitanonprogettuale anp 
WHERE p.id = anp.persona and anp.tipo = 'Didattica' 
GROUP BY p.id, p.nome, p.cognome


/*10. Quali sono le persone che hanno svolto attività nel WP di id ‘5’ del progetto 
con id ‘3’. Per ogni persona, restituire il numero totale di ore svolte in 
attività progettuali per il WP in questione*/ 
SELECT p.id, p.nome, p.cognome, sum(ap.oredurata) as numero_totale 
FROM attivitaprogetto ap
JOIN persona p ON p.id = ap.persona
WHERE ap.wp = 5 and ap.progetto = 3 
GROUP BY p.id, p.nome, p.cognome