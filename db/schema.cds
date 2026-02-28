namespace ao.cds.test;


// Example 1
entity OrgBooks {
    key ID          : UUID;
        description : localized String(1000);
}


// Example 2 --- how I would like to combine a text and a non-text entity into one entity with a localized field
entity S4Books {
    MANDT  : String(3);
    BUCHID : String(10);
    ISBN   : String(20);
}

entity S4Books_T {
    MANDT  : String(3);
    SPRAS  : String(1);
    BUCHID : String(10);
    BUCHTX : String(1000);
}

entity Books as
    select from S4Books as B
    mixin {
        localized : Association to many S4Books_T
                        on  localized.BUCHID = BUCHID
                        and localized.MANDT  = MANDT
    }
    into {
        key (
                B.MANDT || '|' || B.BUCHID
            )                as ID          : UUID,
            BUCHID,
            localized.BUCHTX as description : localized String(1000),
            ISBN
    }


//entity localized.Currencies as select from Currencies AS c {* /*...*/};
//entity localized.Books as select from Books AS p mixin {
  // association is redirected to localized.Currencies
//  country : Association to localized.Currencies on country = p.country;
//} into {* /*...*/};