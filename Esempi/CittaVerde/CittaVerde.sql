-- 1. Gli operatori devono poter calcolare l’insieme delle aree verdi fruibili che hanno almeno un soggetto verde della specie 'Pinus pinea' e piantata almeno 5 anni fa.

select count(distinct a.id)
from areaverde a, soggettoverde sv, specie s  
where s.n_scientifico = 'Pinus pinea', sv.date <= current_date - interval '5 years', a.is_fruibile = true


-- 2. Il management deve poter calcolare, l’insieme delle aree verdi sensibili che non sono state 
-- oggetto di alcun intervento
-- nel periodo '2023-10-9' - '2023-10-13'

select count(a.id)
from areaverde a, intervento i 
where a.is_sensibile = true
and a.id not in (
    select i.area  
    from intervento i
    where i.inizio between date '2023-10-9' and date '2023-10-13'
);

-- 3. I dipendenti comunali devono poter ottenere dal sistema gli operatori ai quali è stato assegnato il minor numero di interventi con priorità maggiore o uguale a 5 nell'anno 2023.

-- Soluzione query 3

WITH
n_int_per_oper AS (
    select o.cf, o.nome, o.cognome, count(*) num_interv
    from operatore o, intervento i, assegna a
    where
        a.operatore = o.cf
        and a.interventoassegnato = i.id
        and i.priorita >= 5
        and extract(year from a.istante) = 2023
    group by o.cf),
n_min_interv as (
    select min(num_interv) as n_min
    from n_int_per_oper
)
select *
from n_int_per_oper t1, n_min_interv t2
where t1.num_interv = t2.n_min;


-- 4. restituire tutte le aree verdi con almeno 10 soggetti verdi

select a.id
from areaverde a, soggettoverde s 
where s.area = a.id 
group by a.id 
having count(s.id) >= 10


-- 5. il numero di operatori che sono stati assegnati almeno una volta ad interventi con priorità < 4

select count(distinct o.cf) as num_operatori
from operatore o, assegna a, intervento i, interventoassegnato ia
where a.operatore = o.cf and a.interventoassegnato = ia.id_intervento and i.id = ia.id_intervento and i.priorita < 4


-- 6. la durata prevista media e la durata effettiva media degli interventi completati.

select avg(i.durata) as durata_prevista_media, avg(ia.fine - i.inizio) as durata_effettiva_media  
from intervento i 
join interventoassegnato ia on i.id = ia.id_intervento 
where ia.fine is not null


-- 7. gli operatori assegnati all'intervento più lungo

select o.cf, o.nome, o.cognome 
from operatore o
join assegna a on a.operatore = o.cf 
join interventoassegnato ia on ia.id_intervento = a.interventoassegnato
join intervento i on i.id = ia.id_intervento
where i.durata = (
    select max(durata)
    from intervento
    )


-- 8. il numero degli interventi non terminati assegnati ad aree verdi non sensibili

select count(i.id)
from intervento i 
join areaverde av on i.area = av.id
join interventoassegnato ia on i.id = ia.id_intervento
where ia.fine is null and av.is_sensibile = false 


-- 9. le aree verdi senza nessun soggetto verde.

select *
from areaverde a
where not exists (
    select 1 
    from soggettoverde s 
    where s.area = a.id 
);
