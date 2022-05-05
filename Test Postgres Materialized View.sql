EXPLAIN ANALYZE
select *
from public.materializedview

EXPLAIN
ANALYZE
SELECT sp.stateprovinceid,
    sp.stateprovincecode,
    sp.isonlystateprovinceflag,
    sp.name AS stateprovincename,
    sp.territoryid,
    cr.countryregioncode,
    cr.name AS countryregionname
FROM person.stateprovince sp
    JOIN person.countryregion cr ON sp.countryregioncode::text = cr.countryregioncode::text;

REFRESH MATERIALIZED VIEW materializedview;
