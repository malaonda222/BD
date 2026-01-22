-- 1. Gli operatori devono poter calcolare l’insieme delle aree verdi fruibili che hanno almeno un soggetto verde della specie 'Pinus pinea' e piantata almeno 5 anni fa.

select distinct 
from areaverde a 
join soggettoverde s on s.area = a.id 
where s.specie = 'Pinus pinea'
    and a.is_fruibile = true 
    and s.data <= current_date - interval '5 years'



select distinct a.id 
from areaverde a
join soggettoverde s on s.area = a.id
where s.specie = 'Pinus pinea' 
    and a.is_fruibile = true 
    and s.data <= current_date - interval '5 years'


--2. Il management deve poter calcolare, l’insieme delle aree verdi sensibili che non sono state oggetto di alcun intervento nel periodo '2023-10-9' - '2023-10-13'
select *
from areaverde a
where a.is_sensibile = true 
    and a.id NOT IN (
        select i.area
        from intervento i, interventoassegnato ia
        where i.id = ia.id_intervento 
            and (i.inizio, ia.fine) OVERLAPS ('2023-10-9', '2023-10-13')
    )

    -- oppure 
    and NOT EXISTS (
        select *
        from intervento i, interventoassegnato ia
        where i.id = ia.id_intervento 
            and (i.inizio, ia.fine) OVERLAPS ('2023-10-9', '2023-10-13')
            and i.area = a.id 
    )

    -- oppure 
    select * 
    from areaverde a,
    left outer join intervento i on a.id = i.area 
    left outer join interventoassegnato ia on ia.id_intervento = i.id 
        and (i.inizio ia.fine) OVERLAPS ('2023-10-9', '2023-10-13')
    where i.id is null;


-- 3. 
-- tutti gli operatori ai quali sono stati assegnati al massimo due interventi con priorità maggiore o uguale a 5 nell'anno 2023 

select o.cf, o.nome, o.cognome
from operatore o, assegna a, intervento i 
where 
    a.operatore = o.cf
    and a.interventoassegnato = i.id 
    and i.priorita >= 5
    and extract(year from a.istante) = 2023 
group by o.cf 
having count(*) <= 2 


-- 4. 
select 
    avg(make_interval(mins => durata)) as interval_durata_prevista,
    avg(extract(epoch from fine - inizio) / 60) as durata_effettiva_minuti
from intervento i, interventoassegnato ia 
where i.id = ia.id_intervento and ia.fine is not null
