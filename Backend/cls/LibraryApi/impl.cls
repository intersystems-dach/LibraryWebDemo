/// An API for Library Management using InterSystems IRIS<br/>
/// Business logic class defined by OpenAPI in LibraryApi.spec<br/>
/// Updated Nov 2, 2023 17:48:26
Class LibraryApi.impl Extends %REST.Impl [ ProcedureBlock ]
{

/// If ExposeServerExceptions is true, then details of internal errors will be exposed.
Parameter ExposeServerExceptions = 1;

/// Add a new book<br/>
/// The method arguments hold values for:<br/>
///     title<br/>
///     author<br/>
///     genre<br/>
ClassMethod AddingBook(title As %String, author As %String, genre As %Integer) As %DynamicObject
{
    //(Place business logic here)
    Set response = ##class(Library.LibraryUtils).AddBook(title,author,genre)
    //Do ..%SetHeader(<name>,<value>)
    //Quit (Place response here) ; response may be a string, stream or dynamic object
    Set jsonresponse = ##class(%DynamicObject).%New()
    Do jsonresponse.%Set("status",response )
    /*set arr = ##class(%DynamicArray).%New()
    do arr.%Push(1)
    do arr.%Push(2)
    do arr.%Push(3)
    do jsonresponse.%Set("arr",arr) */
    //Set body = ##class(%DynamicObject).%FromJSON(%request.Content)
    Do ..%SetStatusCode(200)
    If response = 0{

        Do ..%SetStatusCode(500)

    }
    Return jsonresponse
}

/// Add a new friend
ClassMethod AddingFriend() As %DynamicObject
{
    Set body = ##class(%DynamicObject).%FromJSON(%request.Content)
    Set name = body.%Get("friendName")
    Set number = body.%Get("friendNumber")
    Set status =##class(Library.LibraryUtils).AddFriend(name,number)
    Set jsonresponse = ##class(%DynamicObject).%New()
    Do ..%SetStatusCode(200)
    If status = 0{
        Do ..%SetStatusCode(500)
        Set status = 0
    }
    Do jsonresponse.%Set("status",status)
    Return jsonresponse

    //(Place business logic here)
    //Do ..%SetStatusCode(<HTTP_status_code>)
    //Do ..%SetHeader(<name>,<value>)
    //Quit (Place response here) ; response may be a string, stream or dynamic object
}

/// Find a book<br/>
/// The method arguments hold values for:<br/>
///     bookid<br/>
ClassMethod FindingBook(bookid As %String) As %DynamicObject
{

    Set result = ##class(Library.LibraryUtils).PrintOne(bookid, .foundBook)
    If result = 0{
         Do ..%SetStatusCode(500)
         Return "something is wrong"
    }
    Do ..%SetStatusCode(200)
    
    Set sc = foundBook.%JSONExportToString(.s)
    Return s
}

/// list of all the books
ClassMethod GetAllBooks() As %DynamicObject
{
   
    Set res = ##class(Library.LibraryUtils).PrintAllBooks()
    Write res
    Set reply = ##class(%DynamicObject).%New()
    Do reply.%Set("status",res)


    Return reply
}

/// loan a book to a friend<br/>
/// The method arguments hold values for:<br/>
///     Bookid<br/>
///     FriendsName<br/>
ClassMethod LoanBook(Bookid As %String, FriendsName As %String) As %DynamicObject
{

    Set result = ##class(Library.LibraryUtils).LoanBook(Bookid,FriendsName, .msg)
    Set reply = ##class(%DynamicObject).%New()
    Do reply.%Set("status",result)
    Do reply.%Set("message",msg)
    
    Return reply
}

/// return a book from a friend<br/>
/// The method arguments hold values for:<br/>
///     bookid<br/>
ClassMethod ReturnBook(bookid As %String) As %DynamicObject
{
   
    Set status = ##class(Library.LibraryUtils).ReturnBook(bookid,.msg)
    Set jsonresp = ##class(%DynamicObject).%New()
    Do jsonresp.%Set("status", status)
    Do jsonresp.%Set("message", msg)
    Return jsonresp
}

/// list of all the loaned books
ClassMethod loanedBooks() As %DynamicObject
{
}

/// remove a book<br/>
/// The method arguments hold values for:<br/>
///     Bookid<br/>
ClassMethod RemoveBook(Bookid As %String) As %DynamicObject
{
  Set status = ##class(Library.LibraryUtils).RemoveBook(Bookid)
  Set jsonresp = ##class(%DynamicObject).%New()
  If $$$ISERR(status){
    Set status = 0
  }
  Do jsonresp.%Set("status", status)
  Return jsonresp
}

/// remove a person<br/>
/// The method arguments hold values for:<br/>
///     Personid<br/>
ClassMethod RemovePerson(Personid As %String) As %DynamicObject
{
    //(Place business logic here)
    //Do ..%SetStatusCode(<HTTP_status_code>)
    //Do ..%SetHeader(<name>,<value>)
    //Quit (Place response here) ; response may be a string, stream or dynamic object
    Set status = ##class(Library.LibraryUtils).Removeperson(Personid, .msg)
    Set jsonresp = ##class(%DynamicObject).%New()
    If $$$ISERR(status){
        Set status = 0
    }
    Do jsonresp.%Set("status", status)
    Do jsonresp.%Set("msg", msg)
    Return jsonresp
}

/// Find a person<br/>
/// The method arguments hold values for:<br/>
///     personid<br/>
ClassMethod Findingperson(personid As %String) As %DynamicObject
{
    Set result = ##class(Library.LibraryUtils).PrintOnePerson(personid, .foundPerson)
    If result = 0{
         Do ..%SetStatusCode(500)
         Return "something is wrong"
    }
    Do ..%SetStatusCode(200)
    
    Set sc = foundPerson.%JSONExportToString(.s)
    Return s
}

/// list of all the people
ClassMethod GetAllPerson() As %DynamicObject
{
    Set res = ##class(Library.LibraryUtils).PrintAllPerson()
    Write res
    Set reply = ##class(%DynamicObject).%New()
    Do reply.%Set("status",res)


    Return reply
}

}
