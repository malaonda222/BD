/*1. Quanti sono gli strutturati di ogni fascia?*/
select posizione, count(*) as numero
from persona
group by posizione

/*2. Quanti sono gli strutturati con stipendio ≥ 40000?*/
select count(*) 
from persona
where stipendio >= 40000

/*3. Quanti sono i progetti già finiti che superano il budget di 50000?*/
select count(*)
from progetto
where budget > 50000 and fine < current_date

/*4. Qual è la media, il massimo e il minimo delle ore delle attività relative al progetto ‘Pegasus’ ?*/
select max(ap.oredurata), min(ap.oredurata), avg(ap.oredurata)
from attivitaprogetto ap, progetto pr
where ap.progetto = pr.id and pr.nome = 'Pegasus'

/*5. Quali sono le medie, i massimi e i minimi delle ore giornaliere dedicate al progetto ‘Pegasus’ da ogni singolo docente?*/
select p.id, p.nome, p.cognome, avg(ap.oredurata) as media, min(ap.oredurata) as minimo, max(ap.oredurata) as massimo
from attivitaprogetto ap, progetto pr, persona p
where ap.progetto = pr.id and pr.nome = 'Pegasus' and ap.persona = p.id
group by p.id
order by media desc

/*6. Qual è il numero totale di ore dedicate alla didattica da ogni docente?*/
select p.id, p.nome, p.cognome, sum(anp.oredurata) as ore_didattica
from attivitanonprogettuale anp, persona p
where anp.tipo = 'Didattica' and anp.persona = p.id
group by p.id

/*7. Qual è la media, il massimo e il minimo degli stipendi dei ricercatori?*/
select avg(p.stipendio) as media, min(p.stipendio) as minimo, max(p.stipendio) as massimo
from persona p
where p.posizione = 'Ricercatore'

/*8. Quali sono le medie, i massimi e i minimi degli stipendi dei ricercatori, dei professori associati e dei professori ordinari?*/
select p.posizione, avg(p.stipendio) as media, min(p.stipendio) as minimo, max(p.stipendio) as massimo
from persona p
group by p.posizione

/*9. Quante ore ‘Ginevra Riva’ ha dedicato ad ogni progetto nel quale ha lavorato?*/
select ap.progetto as id_progetto, pr.nome as progetto, sum(ap.oredurata) as totale_ore
from persona p, attivitaprogetto ap, progetto pr
where ap.persona = p.id and p.nome = 'Ginevra' and p.cognome = 'Riva' and ap.progetto = pr.id
group by ap.progetto, pr.nome, ap.oredurata

/*10. Qual è il nome dei progetti su cui lavorano più di due strutturati?*/
select pr.id as progetto_id, pr.nome as progetto
from attivitaprogetto ap, progetto pr
where ap.progetto = pr.id
group by pr.id
having count(distinct(ap.persona) > 2)

/*11. Quali sono i professori associati che hanno lavorato su più di un progetto?*/
select p.id as id_persona, p.nome, p.cognome 
from persona p, attivitaprogetto ap
where ap.persona = p.id and p.posizione = 'Professore Associato'
group by p.id
having count(distinct(ap.progetto) >= 2);