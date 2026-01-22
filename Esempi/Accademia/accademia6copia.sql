-- 1. Quanti sono gli strutturati di ogni fascia?
select posizione, count(*) as numero 
from persona 
group by posizione 


-- 2. Quanti sono gli strutturati con stipendio ≥ 40000?
select count(*) 
from persona 
where stipendio >= 40000


-- 3. Quanti sono i progetti già finiti che superano il budget di 50000?
select count(*)
from progetto 
where fine < current_date 
    and budget > 50000


-- 4. Qual è la media, il massimo e il minimo delle ore delle attività relative al progetto ‘Pegasus’ ?
select avg(ap.oreDurata) as media, max(ap.oreDurata) as massimo, min(ap.oreDurata) as minimo 
from attivitaprogetto ap 
join progetto pr on pr.id = ap.progetto 
where pr.nome = 'Pegasus'


-- 5. Quali sono le medie, i massimi e i minimi delle ore giornaliere dedicate al progetto
-- ‘Pegasus’ da ogni singolo docente?
select p.id, p.nome, p.cognome, avg(ap.oreDurata) as media, max(ap.oreDurata) as massimo, min(ap.oreDurata) as minimo
from persona p 
join attivitaprogetto ap on ap.persona = p.id 
join progetto pr on pr.id = ap.progetto 
where pr.nome = 'Pegasus'
group by p.id


-- 6. Qual è il numero totale di ore dedicate alla didattica da ogni docente?
select p.id, p.nome, p.cognome, sum(anp.oreDurata) as ore_didattica 
from persona p 
join attivitanonprogettuale anp on anp.persona = p.id 
where anp.tipo = 'Didattica'
group by p.id, p.nome, p.cognome 


-- 7. Qual è la media, il massimo e il minimo degli stipendi dei ricercatori?
select avg(stipendio) as media, max(stipendio) as massimo_stipendio, min(stipendio) as minimo_stipendio 
from persona  
where posizione = 'Ricercatore'


-- 8. Quali sono le medie, i massimi e i minimi degli stipendi dei ricercatori, dei professori associati e dei professori ordinari?
select posizione, avg(stipendio) as media_stipendio, max(stipendio) as massimo_stipendio, min(stipendio) as minimo_stipendio 
from persona  
group by posizione 


-- 9. Quante ore ‘Ginevra Riva’ ha dedicato ad ogni progetto nel quale ha lavorato?
select ap.progetto as id_progetto, pr.nome as nome_progetto, sum(ap.oreDurata) as ore_per_progetto
from persona p 
join attivitaprogetto ap on ap.persona = p.id 
join progetto pr on ap.progetto = pr.id 
where p.nome = 'Ginevra'
    and p.cognome = 'Riva'
group by ap.progetto, pr.nome


-- 10. Qual è il nome dei progetti su cui lavorano più di due strutturati?
select distinct pr.nome 
from progetto pr 
join attivitaprogetto ap1 on ap1.progetto = pr.id
join attivitaprogetto ap2 on ap2.progetto = pr.id 
where ap1.persona <> ap2.persona

select pr.id, pr.nome 
from attivitaprogetto ap 
join progetto pr on ap.progetto = pr.id 
group by pr.id, pr.nome 
having count (distinct ap.persona) > 2


-- 11. Quali sono i professori associati che hanno lavorato su più di un progetto?
select p.id as id_progetto, p.nome, p.cognome 
from persona p 
join attivitaprogetto ap on ap.persona = p.id 
where p.posizione = 'Professore Associato' 
group by p.id, p.nome, p.cognome  
having count(distinct(ap.progetto) > 1)



-- Seconda versione 

-- 1. Quanti sono gli strutturati di ogni fascia?
select posizione, count(*) as numero 
from persona 
group by (posizione)


-- 2. Quanti sono gli strutturati con stipendio ≥ 40000?
select count(*) as n_strutturati
from persona 
where stipendio >= 40000


-- 3. Quanti sono i progetti già finiti che superano il budget di 50000?
select count(*) as n_progetti
from progetto 
where fine < current_date 
    and budget > 50000


-- 4. Qual è la media, il massimo e il minimo delle ore delle attività relative al progetto ‘Pegasus’ ?
select avg(pr.oreDurata) as media, max(pr.oreDurata) as massimo, min(pr.oreDurata) as minimo 
from attivitaprogetto ap 
join progetto pr on pr.id = ap.progetto 
where pr.nome = 'Pegasus' 


-- 5. Quali sono le medie, i massimi e i minimi delle ore giornaliere dedicate al progetto ‘Pegasus’ da ogni singolo docente?
select ap.persona, avg(pr.oreDurata) as media, max(pr.oreDurata) as massimo, min(pr.oreDurata) as minimo
from attivitaprogetto ap 
join progetto pr on pr.id = ap.progetto 
where pr.nome = 'Pegasus'
group by ap.persona


-- 6. Qual è il numero totale di ore dedicate alla didattica da ogni docente?
select persona, sum(oreDurata) as numero_totale_ore 
from attivitanonprogettuale  
where tipo = 'Didattica'
group by persona


-- 7. Qual è la media, il massimo e il minimo degli stipendi dei ricercatori?
select avg(stipendio) as media, max(stipendio) as massimo, min(stipendio) as minimo 
from persona 
where posizione = 'Ricercatore'


-- 8. Quali sono le medie, i massimi e i minimi degli stipendi dei ricercatori, dei professori associati e dei professori ordinari?
select posizione, avg(stipendio) as media, max(stipendio) as massimo, min(stipendio) as minimo 
from persona 
group by posizione


-- 9. Quante ore ‘Ginevra Riva’ ha dedicato ad ogni progetto nel quale ha lavorato?
select ap.progetto, sum(ap.oreDurata) as ore_progetto
from persona p
join attivitaprogetto ap on p.id = ap.persona  
where p.nome = 'Ginevra'
    and p.cognome = 'Riva'
group by ap.progetto


-- 10. Qual è il nome dei progetti su cui lavorano più di due strutturati?
select pr.nome
from attivitaprogetto ap 
join progetto pr on pr.id = ap.progetto
group by pr.nome 
having count(distinct(ap.persona) > 2)


-- 11. Quali sono i professori associati che hanno lavorato su più di un progetto?
select p.id, p.nome, p.cognome 
from attivitaprogetto ap
join persona p on ap.persona = p.id
where p.posizione = 'Professore Associato'
group by p.id 
having count (distinct ap.progetto) > 1 