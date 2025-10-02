'''Restituire nome e reddito dei padri di persone con reddito > 20'''
-- ANY

select distinct p.nome, p.reddito
from Persona p, Parternita pat, Persona f
where p.nome = pat.padre and f.nome = pat.figlio 
    and f.reddito > 20


select distinct p.nome, p.reddito 
from Persona p 
where p.nome = any(select pat.padre
                    from Paternita pat, Persona f 
                    where f.nome = pat.figlio 
                    and f.reddito > 20)

'''Restituire i dati delle persone con reddito maggiore del reddito di tutte le
persone di età < 30'''
-- ALL
select nome 
from Persona p
where p.reddito > all(select reddito
                        from Persona p 
                        where p.eta < 30)

select nome 
from Persona p 
where p.reddito > 
        (select max(reddito) from Persona where eta < 30)


'''Restituire i dati delle persone con almeno un figlio'''
select *
from Persona p 
where exists (select *
                from Paternita
                where padre = p.nome)
            
    or exists (select *
                from Maternita
                where madre = p.nome)



'''Restituire nome ed età delle madri che hanno almeno un figlio la cui età
differisce meno di 20 anni dalla loro.'''

select nome, eta 
from Persona p, Maternita mat
where p.nome = mat.madre 
and mat.figlio in (select q.nome 
                    from Persona q
                    where p.eta - q.eta < 20)



select nome, eta 
from Persona p, Paternita pat 
where p.nome = pat.padre 
and pat.figlio in (select q.nome
                    from Persona q
                    where p.eta - q.eta < 20)



'''Restituire i dati delle persone con il reddito più alto.'''
-- 
select *
from Persona 
where reddito = (select max(reddito) 
                from Persona)

select *
from Persona 
where reddito >= all(select reddito from Persona)


'''Restituire i dati delle persone che hanno la coppia (età, reddito) diversa
da tutte le altre'''
--  NOT IN 
select *
from Persona p 
where (eta, reddito)
    not in (select eta, reddito
            from Persona 
            where nome <> p.nome)
