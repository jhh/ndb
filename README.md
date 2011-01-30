README
======

Import the USDA National Nutrient Database for Standard Reference into a
Sqlite3 database.

Instructions
------------

1. Download and the ASCII version of the SR23 database from the [Nutrient Data
Laboratory Home Page][ndl]. There is a 7.6 Mb ZIP file containing the entire
database.

2. Extract the database into this project's top-level directory. It will
create a subdirectory called 'sr23' and should look like:

        sr23/Data_src.pdf
        sr23/DATA_SRC.txt
        sr23/DATSRCLN.txt
        sr23/DERIV_CD.txt
        sr23/FD_GROUP.txt
        sr23/FOOD_DES.txt
        sr23/FOOTNOTE.txt
        sr23/LANGDESC.txt
        sr23/LANGUAL.txt
        sr23/NUT_DATA.txt
        sr23/NUTR_DEF.txt
        sr23/sr23_doc.pdf
        sr23/SRC_CD.txt
        sr23/WEIGHT.txt

3. Requires [bundler][bundler]. Run `bundle install` to install required gems
if needed.

4. Run `rake load` to create database and, optionally, `rake pivot` to create
a flattened table with nutrient values (requires [fts4][fts] extensions to
Sqlite).

[ndl]: http://www.ars.usda.gov/nutrientdata
[bundler]: http://gembundler.com/
[fts]: http://www.sqlite.org/fts3.html
