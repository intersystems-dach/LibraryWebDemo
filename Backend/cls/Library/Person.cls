Class Library.Person Extends (%Persistent, %Populate, %XML.Adaptor, %ZEN.DataModel.Adaptor, %JSON.Adaptor)
{

Property Name As %String [ Required ];

Index NameIndex On Name [ Unique ];

Property PhoneNumber As %String;

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>PhoneNumber</Value>
</Value>
</Data>
<DataLocation>^Library.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<ExtentSize>100</ExtentSize>
<IdLocation>^Library.PersonD</IdLocation>
<IndexLocation>^Library.PersonI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,16,$lb("-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000"),$lb(21,21,21,21,21,21,21,21,21,21,21,21,21,21,21),$lb(758198320,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,758198320))</Histogram>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(1,7,14,21,28,35,42,49,56,63,70,76,82,88,94,100),$lb(0,0,0,1,0,0,1,0,0,0,1,0,1,0,0),$lb(822083584,822083584,922746880,922746880,825491456,825491456,842072064,822083584,939524096,842530816,859111424,859111424,875692032,838860800,956301312,876150784,892731392,892731392,909312000,909312000,925892608,805306368,905969664,926285824,942800896,838860800,939524096,943194112,959709184,959709184,825241600,825241600))</Histogram>
<Selectivity>1</Selectivity>
</Property>
<Property name="Name">
<AverageFieldSize>18.12</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="PhoneNumber">
<AverageFieldSize>6.9</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" A7801"," C3768"," F1870"," G7579"," I148"," J3120"," L8095"," N8496"," P6530"," Q8749"," S6759"," T5034"," U7840"," V6882"," X3636"," Z5831"),$lb(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),$lb(541144888,1094137904,1127429942,1127429942,1177630775,1177630775,1194800439,1194800439,1227961400,1227961400,1244868914,1244868914,1278750777,1278750777,1312306233,1312306233,1345729843,1345729843,1362638644,1362638644,1396062005,1396062005,1412771891,1412771891,1429682228,1429682228,1446393912,1446393912,1479751219,1479751219,1513437235,542782776))</Histogram>
<Selectivity>1.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="NameIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^Library.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
