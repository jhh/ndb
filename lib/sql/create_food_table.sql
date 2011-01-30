drop table if exists FOOD;

create virtual table FOOD using fts4(
    tokenize=porter
    , ndb_number            varchar(5) not null
    , description         text
    , calories            integer
    , protein             float
    , fat                 float
    , saturated_fat       float
    , polyunsaturated_fat float
    , monounsaturated_fat float
    , trans_fat           float
    , cholesterol         float
    , sodium              float
    , potassium           float
    , carbohydrate        float
    , fiber               float
    , sugars              float
    , vitamin_a           integer
    , vitamin_c           float
    , calcium             integer
    , iron                float
    , vitamin_e           float
    , vitamin_k           float
    , thiamin             float
    , riboflavin          float
    , niacin              float
    , vitamin_b6          float
    , folic_acid          integer
    , vitamin_b12         float
    , pantothenic_acid    float
    , phosphorus          integer
    , magnesium           float
    , zinc                float
    , selenium            float
    , copper              float
    , manganese           float
);

insert into FOOD (
    ndb_number
    , description
    , calories
    , protein
    , fat
    , saturated_fat
    , polyunsaturated_fat
    , monounsaturated_fat
    , trans_fat
    , cholesterol
    , sodium
    , potassium
    , carbohydrate
    , fiber
    , sugars
    , vitamin_a
    , vitamin_c
    , calcium
    , iron
    , vitamin_e
    , vitamin_k
    , thiamin
    , riboflavin
    , niacin
    , vitamin_b6
    , folic_acid
    , vitamin_b12
    , pantothenic_acid
    , phosphorus
    , magnesium
    , zinc
    , selenium
    , copper
    , manganese
) select
    f.ndb_no
    , f.long_desc
    , sum(case when n.tagname = 'ENERC_KCAL' then nd.nutr_val end)
    , sum(case when n.tagname = 'PROCNT'     then nd.nutr_val end)
    , sum(case when n.tagname = 'FAT'        then nd.nutr_val end)
    , sum(case when n.tagname = 'FASAT'      then nd.nutr_val end)
    , sum(case when n.tagname = 'FAPU'       then nd.nutr_val end)
    , sum(case when n.tagname = 'FAMS'       then nd.nutr_val end)
    , sum(case when n.tagname = 'FATRN'      then nd.nutr_val end)
    , sum(case when n.tagname = 'CHOLE'      then nd.nutr_val end)
    , sum(case when n.tagname = 'NA'         then nd.nutr_val end)
    , sum(case when n.tagname = 'K'          then nd.nutr_val end)
    , sum(case when n.tagname = 'CHOCDF'     then nd.nutr_val end)
    , sum(case when n.tagname = 'FIBTG'      then nd.nutr_val end)
    , sum(case when n.tagname = 'SUGAR'      then nd.nutr_val end)
    , sum(case when n.tagname = 'VITA_IU'    then nd.nutr_val end)
    , sum(case when n.tagname = 'VITC'       then nd.nutr_val end)
    , sum(case when n.tagname = 'CA'         then nd.nutr_val end)
    , sum(case when n.tagname = 'FE'         then nd.nutr_val end)
    , sum(case when n.tagname = 'TOCPHA'     then nd.nutr_val end)
    , sum(case when n.tagname = 'VITK1'      then nd.nutr_val end)
    , sum(case when n.tagname = 'THIA'       then nd.nutr_val end)
    , sum(case when n.tagname = 'RIBF'       then nd.nutr_val end)
    , sum(case when n.tagname = 'NIA'        then nd.nutr_val end)
    , sum(case when n.tagname = 'VITB6A'     then nd.nutr_val end)
    , sum(case when n.tagname = 'FOLAC'      then nd.nutr_val end)
    , sum(case when n.tagname = 'VITB12'     then nd.nutr_val end)
    , sum(case when n.tagname = 'PANTAC'     then nd.nutr_val end)
    , sum(case when n.tagname = 'P'          then nd.nutr_val end)
    , sum(case when n.tagname = 'MG'         then nd.nutr_val end)
    , sum(case when n.tagname = 'ZN'         then nd.nutr_val end)
    , sum(case when n.tagname = 'SE'         then nd.nutr_val end)
    , sum(case when n.tagname = 'CU'         then nd.nutr_val end)
    , sum(case when n.tagname = 'MN'         then nd.nutr_val end)
from FOOD_DES f join NUT_DATA nd on f.ndb_no = nd.ndb_no
    join NUTR_DEF n on nd.nutr_no = n.nutr_no
group by f.ndb_no, f.long_desc;

insert into FOOD(FOOD) values('optimize');