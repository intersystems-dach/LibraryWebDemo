/// Book class to define the book details
Class Library.Book Extends (%Persistent, %Populate, %XML.Adaptor, %ZEN.DataModel.Adaptor, %JSON.Adaptor)
{

/// Book title
Property Title As %String [ Required ];

/// Description
Property BookNumber As %Integer;

Index BookNumberIndex On BookNumber [ Unique ];

/// Genre of the book
Property Genre As %String [ Required ];

/// Book Author
Property Author As Library.Person [ Required ];

/// Friend associated with the book loan.
Property Friend As Library.Person;

Storage Default
{
<Data name="BookDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Title</Value>
</Value>
<Value name="3">
<Value>Genre</Value>
</Value>
<Value name="4">
<Value>Author</Value>
</Value>
<Value name="5">
<Value>Friend</Value>
</Value>
<Value name="6">
<Value>bookNumber</Value>
</Value>
<Value name="7">
<Value>BookNumber</Value>
</Value>
</Data>
<DataLocation>^Library.BookD</DataLocation>
<DefaultData>BookDefaultData</DefaultData>
<ExtentSize>1</ExtentSize>
<IdLocation>^Library.BookD</IdLocation>
<IndexLocation>^Library.BookI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Author">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="Friend">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="Genre">
<AverageFieldSize>9</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="Title">
<AverageFieldSize>8</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^Library.BookS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
