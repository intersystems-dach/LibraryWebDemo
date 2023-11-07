Class Library.LibraryUtils Extends (%Persistent, %RegisteredObject)
{

/// Adding books
ClassMethod AddBook(pTitle As %String, pAuthor As %String, pGenre As %Integer) As %Status
{

    If pTitle = "x"{
        Return 0
    }
    Set BookEntry = ##Class(Library.Book).%New()
    // do something
   
    Set BookEntry.Title = pTitle

   

    Set sqlLookup = "SELECT * FROM Library.Person WHERE Name LIKE "_"'"_pAuthor_"'"

    Write sqlLookup

    Set statement = ##class(%SQL.Statement).%New()

    Set status = statement.%Prepare(sqlLookup)

    If $$$ISOK(status){
        Write !,"Prepared successfully"
		Set RS = statement.%Execute()
        Write !,RS, !
        Write RS.%SQLCode
		If RS.%SQLCode >= 0{
            
			If (RS.%Next() = 1) {
                Write !,"Atleast one entry found with the same Author Name"
				Write RS.%Get("Name")_"-"_RS.%Get("ID")
				///write ! 
                Set extractedId = RS.%Get("ID")
                Set existingperson=##class(Library.Person).%OpenId(extractedId)
                Write !, "existing person", !, existingperson,!
                Set BookEntry.Author = existingperson
                Write !,"bookentry existing author",!, BookEntry.Author.Name, !
			}ElseIf (RS.%Next() = 0) {
                Write !,"No entry found",!,"Creating New Person entry"
                Set newperson = ##class(Library.Person).%New()
                Set newperson.Name = pAuthor
                Set sc = newperson.%Save()
                If ($$$ISOK(sc)){
                    Write !, "new person saved in Database"
                }Else{
                    Return 0
                }
                Set BookEntry.Author = newperson
                Write !,"bookentry new Author",!, BookEntry.Author.Name, !
            }
            
                
            If (pGenre = 1){
                Set BookEntry.Genre = "Comedy"
               
                Write !,"Comedy Genre added successfully"
            }ElseIf (pGenre = 2) {
                Set BookEntry.Genre = "Tragedy"
                Write !,"Tragedy Genre added successfully"
            }Else {
                Write !,"please provide a valid choice between 1 or 2"
            }
        

            Set sc = BookEntry.%Save()
            If ($$$ISOK(sc)){
                Write !, "Saved Book entry to database"
            }Else{
                Return 0
            }
            Return $$$OK
            
            ///write "County value"_county
        } Else{
            Write RS.%SQLCode
            Return 0
        }
    } Else {
        	Do $SYSTEM.OBJ.DisplayError(status)
            Return 0
    	}
}

/// remove a book from the list
ClassMethod RemoveBook(bookid) As %Status
{
    Set s = ##class(Library.Book).%DeleteId(bookid)
    Return s
}

ClassMethod Removeperson(personid, ByRef msg As %String) As %Status
{
   
    
    Set hasBorrowed = ##class(Library.LibraryUtils).hasborrowed(personid)
    If hasBorrowed = 0 {
    Set msg = "Friend deleted!"
    Set s = ##class(Library.Person).%DeleteId(personid)
    If $$$ISERR(s){
        Set msg = "Could not delete friend!"
    }
    Return s
    }
    Set msg = "Friend loaned a book!"
    Return 0
}

ClassMethod hasborrowed(personid) As %Stream.Object
{
    #dim tSql as %String = "select id from Library.Book"
    #dim tRS as %SQL.StatementResult  
    
    Set tRS = ##class(%SQL.Statement).%ExecDirect(,tSql)
    While tRS.%Next() {
       // $$$ThrowOnError(##class(Library.Book).%OpenId(tRS.ID).%JSONExportToString(.strJSON))
       Set bookdetail = ##class(Library.Book).%OpenId(tRS.ID)
       If bookdetail = ""{
        Continue
       }
       If bookdetail.Friend = ""{
        Continue
       }
       Set i = bookdetail.Friend.%Id()
       If bookdetail.Friend.%Id() = personid {
        Return 1
       }


    }
    Return 0
}

ClassMethod AddFriend(pNewfriend As %String, pFriendNumber As %Integer = 0) As %Status
{
    Set friend = ##class(Library.Person).%New()
    Set friend.Name = pNewfriend
    Set friend.PhoneNumber = pFriendNumber
    Set sc = friend.%Save()
    Return sc
}

/// will print info about one of the books in the library
ClassMethod PrintOne(id As %String, ByRef pBook As Library.Book) As %Status
{

    Set bookInstance = ##class(Library.Book).%OpenId(id)
    If bookInstance = ""{
        Return 0
    }
    Set pBook = bookInstance
    Return 1
}

ClassMethod PrintOnePerson(id As %String, ByRef pPerson As Library.Person) As %Status
{

    Set personInstance = ##class(Library.Person).%OpenId(id)
    If personInstance = ""{
        Return 0
    }
    Set pPerson = personInstance
    Return 1
}

// This method prints all items from teh database

ClassMethod PrintAll(ByRef allBook As %DynamicArray) As %Status
{
	&sql(select count(*) INTO :count from library.book)
	// Iterate through all books
	Set id = 1
    
	While (id <= count) {
		// This write will create a separator and give the user a correlation between book and ID
		
		Do ##class(Library.LibraryUtils).PrintOne(id, .eachBook )
        //Write !, eachBook.Title
        
        Set allBook(id) = eachBook
        //Write !, allBook(id)
		Set id = id + 1
	}
    //Write allBook
	Return $$$OK
}

ClassMethod PrintAllBooks() As %Stream.Object
{
    Set obj = {}
    #dim tSql as %String = "SELECT  JSON_ARRAYAGG(JSON_OBJECT('id':ID,'Author':Author,'Friend':Friend,'Genre':Genre,'Title':Title )) FROM Library.Book"
    Set reply = ##class(%DynamicObject).%New()
    Set tRS = ##class(%SQL.Statement).%ExecDirect(,tSql)
    Write tRS
    If tRS.%Next() {
        Set obj = ##class(%DynamicObject).%FromJSON(tRS.%GetData(1))
    }
    
    

    Write !, obj.%ToJSON()
    Quit obj
}

ClassMethod PrintAllPerson() As %Stream.Object
{
    Set obj = {}
    #dim tSql as %String = "SELECT  JSON_ARRAYAGG(JSON_OBJECT('id':ID,'Person': Name,'Phone': PhoneNumber)) FROM Library.Person"
    Set reply = ##class(%DynamicObject).%New()
    Set tRS = ##class(%SQL.Statement).%ExecDirect(,tSql)
    Write tRS
    If tRS.%Next() {
        Set obj = ##class(%DynamicObject).%FromJSON(tRS.%GetData(1))
    }
    
    

    Write !, obj.%ToJSON()
    Quit obj
}

ClassMethod PrintAllBooks2() As %Stream.Object
{
    #dim tSql as %String = "select id from Library.Book"
    #dim tRS as %SQL.StatementResult  
    Set tRet = []
    Set tRS = ##class(%SQL.Statement).%ExecDirect(,tSql)
    While tRS.%Next() {
        Set i = tRS.ID
        $$$ThrowOnError(##class(Library.Book).%OpenId(tRS.ID).%JSONExportToString(.strJSON))
        Do tRet.%Push(##class(%DynamicObject).%FromJSON(strJSON))

}
    Write !, tRet
    Quit tRet
}

/// Set sc = eachBook.%JSONExportToString(.s)
ClassMethod LoanBook(Bookid As %String, FriendsName As %String, ByRef msg As %String = "") As %Status
{
    Set isFound = ##class(Library.LibraryUtils).PrintOne(Bookid, .bookObject)
    If 'isFound{
        Set msg = "Book was not found"
        Return 0
    }
  
    If bookObject.Friend '= "" {
       Set msg = "Book is already loaned" 
       Return 0
    }
    Write !, "The book is available to loan"
    Write !, "checking your name in the DB..."
    Set existsFriend = ##class(Library.Person).NameIndexOpen(FriendsName)
    //Set openedBookInstance = ##class(Library.Book).%OpenId(Bookid)
    If (existsFriend = ""){
        Write !, "Name not found in the DB and it will be created first and then added to the book instance"
        Do ##class(Library.LibraryUtils).AddFriend(FriendsName)
        Set existsFriend = ##class(Library.Person).NameIndexOpen(FriendsName)
       
        
        Write !, "created and added successfully"
    }

    Set bookObject.Friend = existsFriend
    Set status = bookObject.%Save()
    Set msg = "Book is loaned to your new friend"
    
    Return status
}

/// Returning the product
ClassMethod ReturnBook(Bookid As %String, ByRef msg As %String = "") As %Status
{
    Set isFound = ##class(Library.LibraryUtils).PrintOne(Bookid, .bookObject)
    If 'isFound{
        Set msg = "Book not found"
        Return 0
    }
    If bookObject.Friend = "" {
        Set msg = "Book not loaned"
        Return 0
        
    }
    Write !,"Yes the book was loaned, we will return it and make it available in the library again"
    //Set openedBookInstance = ##class(Library.Book).%OpenId(Bookid)
    Set bookObject.Friend = ""
    Do bookObject.%Save()
    Set msg = "Book returned successfully"
    Return 1
}

/// Get the list of all the loaned books
ClassMethod GetLoanedBooks() As %Status
{
    &sql(select count(*) INTO :count from library.book where Friend IS NOT NULL )
    Write !,"Total number of loaned books are : ", count
}

/// Get the list of all the available books on the shelf
ClassMethod GetShelfBooks() As %Status
{
   &sql(Select count(*) INTO :count from Library.Book Where Friend IS NULL)
   Write !, "Total number of available books on the shelf is :", count
}

/// Number of books a friend has currently borrowed
ClassMethod FriendOwe(name As %String) As %Status
{
   &sql(Select count(*) into :count from Library.Book,Library.Person Where Book.Friend = Person.ID AND Person.Name = name)
   Write count
   Write !,"This friend has currently ", count, " borrowed books"
}

/// Which friend has this perticular book Id
ClassMethod GetFriend(BookId As %Integer) As %Status
{
  Set res = ##class(Library.Book).%OpenId(BookId)
  Set name = res.Friend.Name
  Write !, name
}

Storage Default
{
<Data name="LibraryUtilsDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
</Data>
<DataLocation>^Library.LibraryUtilsD</DataLocation>
<DefaultData>LibraryUtilsDefaultData</DefaultData>
<IdLocation>^Library.LibraryUtilsD</IdLocation>
<IndexLocation>^Library.LibraryUtilsI</IndexLocation>
<StreamLocation>^Library.LibraryUtilsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
