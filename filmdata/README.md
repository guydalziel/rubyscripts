# Overview #
Converts XML data from singular XML files located within subdirectories
into a CSV file.

# Directory Structure #
-------------
```
  ./ScriptTest/data7/subdir7/data-98765.xml
  ./ScriptTest/data1/subdir1/data-4352435.xml
  ./ScriptTest/data1/data2/subdir2/data-643478.xml
  ./ScriptTest/data1/data2/data3/subdir3/data-092309.xml
  ./ScriptTest/data10/subdir10/data-76532754.xml
  ./ScriptTest/data10/subdir10/subdir9/data-6327789928.xml
  ./ScriptTest/data5/subdir5/data-231324.xml
  ./ScriptTest/data5/data6/subdir6/data-467368.xml
```

# Sample XML Data #
-------------
```
  <?xml version="1.0" encoding="utf-8" ?>
  <product uid="0004">
        <title>The Lord of the Rings: The ellowship of the Ring</title>
        <actor>Não Precisa</actor>
        <director>Alex</director>
        <country>United Kingdom</country>
        <asset>
                <format>ANIMATION</format>
                <bitrate>6899.0 Kbps</bitrate>
                <fps>25</fps>
                <aspect>16:8</aspect>
                <width>1600</width>
        </asset>
  </product>
```

# Usage #
----------

The script is run from the root of the directory where the XML files are
located with no options. Conversion is automatic.

  bash-4.3$ ls
  ScriptTest  filmdata.rb
  bash-4.3$ ./filmdata.rb 
  bash-4.3$ ls
  ScriptTest  filmdata.csv  filmdata.rb

The XML data has been converted to a CSV file.

# CSV Output #
----------------
  UID,Title,Actor,Director,Country,File Path,Bit Rate,FPS,Aspect Ratio
  0006,"Skulle det dukke opp flere lik, så er det bare å inge",Aud Schønemann,Knut Bohwim,NORWAY,/home/guydalziel/src/repositories/github/rubyscripts/filmdata/ScriptTest/data7/subdir7/0006/PRORES,23495.9 Kbps,22.74,3:2
  00011661857421,The Wolverine,Hugh Jackman,James Mangold,US,/home/guydalziel/src/repositories/github/rubyscripts/filmdata/ScriptTest/data1/subdir1/00011661857421/MXF,9000.0 Kbps,25,16:9
  0010,The Twilight Saga: Breaking Dawn - Part 2,"Robert Pattinson , Kristen Stewart",Bill Condon,BRAZIL,/home/guydalziel/src/repositories/github/rubyscripts/filmdata/ScriptTest/data1/data2/subdir2/0010/IMX,23.5 Kbps,15.6,8:4
