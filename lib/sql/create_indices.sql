drop index if exists food_des_idx;
create unique index food_des_idx on FOOD_DES (NDB_No);
drop index if exists nut_data_idx;
create unique index nut_data_idx on NUT_DATA (NDB_No, Nutr_No);
drop index if exists nutr_def_idx;
create unique index nutr_def_idx on NUTR_DEF (Nutr_No, Tagname);
