-- 1. Quanti sono gli strutturati di ogni fascia?
select posizione, count(*) as numero 
from persona 
group by posizione 

-- 2. Quanti sono gli strutturati con stipendio ≥ 40000?
select count(*) as numero_strutturati 
from persona 
where stipendio >= 40000

-- 3. Quanti sono i progetti già finiti che superano il budget di 50000?
select count(*) as progetti_finiti 
from progetto 
where fine <= current_date 
    and budget > 50000

-- 4. Qual è la media, il massimo e il minimo delle ore delle attività relative al progetto ‘Pegasus’ ?
select round(avg(ap.oreDurata):numeric, 2) as media, max(ap.oreDurata) as massimo, min(ap.oreDurata) as minimo 
from attivitaprogetto ap
join progetto pr on ap.progetto = pr.id 
where pr.nome = 'Pegasus'

-- 5. Quali sono le medie, i massimi e i minimi delle ore giornaliere dedicate al progetto ‘Pegasus’ da ogni singolo docente?
select ap.persona, round(avg(ap.oreDurata)::numeric, 2) as media, max(ap.oreDurata) as massimo, min(ap.oreDurata) as minimo 
from attivitaprogetto ap 
join progetto pr on ap.progetto = p.id 
where pr.nome = 'Pegasus'
group by ap.persona 

-- 6. Qual è il numero totale di ore dedicate alla didattica da ogni docente?
select persona, sum(oreDurata)  
from attivitanonprogettuale 
where tipo = 'Didattica'
group by persona  

-- 7. Qual è la media, il massimo e il minimo degli stipendi dei ricercatori?
select round(avg(stipendio):numeric, 2) as media, max(stipendio) as massimo, min(stipendio) as minimo 
from persona 
where posizione = 'Ricercatore'

-- 8. Quali sono le medie, i massimi e i minimi degli stipendi dei ricercatori, dei professori associati e dei professori ordinari?
select posizione, round(avg(stipendio):numeric, 2) as media, max(stipendio) as massimo, min(stipendio) as minimo 
from persona 
group by posizione

-- 9. Quante ore ‘Ginevra Riva’ ha dedicato ad ogni progetto nel quale ha lavorato?
select ap.progetto, sum(ap.oreDurata) as ore_lavorate
from attivitaprogetto ap 
join persona p on ap.persona = p.id
where p.nome = 'Ginevra'
    and p.cognome = 'Riva'
group by ap.progetto 

-- 10. Qual è il nome dei progetti su cui lavorano più di due strutturati?
select pr.nome 
from attivitaprogetto ap 
join progetto pr on ap.progetto = pr.id 
group by pr.nome
having count(distinct ap.persona) > 2

-- 11. Quali sono i professori associati che hanno lavorato su più di un progetto?
select p.id, p.nome, p.cognome 
from attivitaprogetto ap 
join persona p on ap.persona = p.id 
where p.posizione = 'Professore Associato'
group by p.id, p.nome, p.cognome 
having count(distinct ap.progetto) > 1 



-- 1. Quanti sono gli strutturati di ogni fascia?
select posizione, count(*) as numero 
from persona 
group by posizione 

-- 2. Quanti sono gli strutturati con stipendio ≥ 40000?
select count(*) as numero 
from persona 
where stipendio >= 40000

-- 3. Quanti sono i progetti già finiti che superano il budget di 50000?
select count(*) as progetti_finiti 
from progetto 
where fine <= current_date 
    and budget > 50000

-- 4. Qual è la media, il massimo e il minimo delle ore delle attività relative al progetto ‘Pegasus’ ?
select round(avg(ap.oreDurata)::numeric, 2) as media, max(ap.oreDurata) as massimo, min(ap.oreDurata) as minimo 
from attivitaprogetto ap 
join progetto pr on ap.progetto = pr.id 
where pr.nome = 'Pegasus'

-- 5. Quali sono le medie, i massimi e i minimi delle ore giornaliere dedicate al progetto ‘Pegasus’ da ogni singolo docente?
select ap.persona, round(avg(ap.oreDurata)::numeric, 2) as media, max(ap.oreDurata) as massimo, min(ap.oreDurata) as minimo 
from attivitaprogetto ap 
join progetto pr on ap.progetto = p.id 
where pr.nome = 'Pegasus'
group by ap.persona 

-- 6. Qual è il numero totale di ore dedicate alla didattica da ogni docente?
select persona, sum(oreDurata) as numero_ore_totali 
from attivitanonprogettuale
where tipo = 'Didattica'
group by persona 

-- 7. Qual è la media, il massimo e il minimo degli stipendi dei ricercatori?
select round(avg(stipendio)::numeric, 2) as media, max(stipendio) as massimo, min(stipendio) as minimo 
from persona 
where posizione = 'Ricercatore'

-- 8. Quali sono le medie, i massimi e i minimi degli stipendi dei ricercatori, dei professori associati e dei professori ordinari?
select round(avg(stipendio)::numeric, 2) as media, max(stipendio) as massimo, min(stipendio) as minimo 
from persona 
group by posizione 

-- 9. Quante ore ‘Ginevra Riva’ ha dedicato ad ogni progetto nel quale ha lavorato?
select ap.progetto, sum(ap.oreDurata)
from attivitaprogetto ap 
join persona p on ap.persona = p.id 
where p.nome = 'Ginevra'
    and p.cognome = 'Riva'
group by ap.progetto 

-- 10. Qual è il nome dei progetti su cui lavorano più di due strutturati?
select pr.nome
from attivitaprogetto ap 
join progetto pr on ap.progetto = pr.id 
group by pr.nome 
having count (distinct ap.persona) > 2

-- 11. Quali sono i professori associati che hanno lavorato su più di un progetto?
select p.id, p.nome, p.cognome
from attivitaprogetto ap 
join persona p on ap.persona = p.id 
where p.posizione = 'Professore Associato'
group by p.id, p.nome, p.cognome 
having count (distinct ap.progetto) > 1 