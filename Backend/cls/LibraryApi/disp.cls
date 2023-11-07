/// An API for Library Management using InterSystems IRIS
/// Dispatch class defined by RESTSpec in LibraryApi.spec
Class LibraryApi.disp Extends %CSP.REST [ GeneratedBy = LibraryApi.spec.cls, ProcedureBlock ]
{

/// The class containing the RESTSpec which generated this class
Parameter SpecificationClass = "LibraryApi.spec";

/// Ignore any writes done directly by the REST method.
Parameter IgnoreWrites = 1;

/// By default convert the input stream to Unicode
Parameter CONVERTINPUTSTREAM = 1;

/// The default response charset is utf-8
Parameter CHARSET = "utf-8";

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/addbook" Method="post" Call="AddingBook" />
  <Route Url="/addfriend" Method="post" Call="AddingFriend" />
  <Route Url="/findabook/:bookid" Method="get" Call="FindingBook" />
  <Route Url="/findaperson/:personid" Method="get" Call="Findingperson" />
  <Route Url="/getallbook" Method="get" Call="GetAllBooks" />
  <Route Url="/getallperson" Method="get" Call="GetAllPerson" />
  <Route Url="/loanbook" Method="post" Call="LoanBook" />
  <Route Url="/returnbook/:bookid" Method="post" Call="ReturnBook" />
  <Route Url="/loanedbooks" Method="get" Call="loanedBooks" />
  <Route Url="/removebook" Method="post" Call="RemoveBook" />
  <Route Url="/removeperson" Method="post" Call="RemovePerson" />
</Routes>
}

ClassMethod AddingBook() As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        If $DATA(%request.Data("title",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"title")) Quit
        }
        If $DATA(%request.Data("title",1)) {
            Set ptitle=%request.Data("title",1)
        }
        If $DATA(%request.Data("author",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"author")) Quit
        }
        If $DATA(%request.Data("author",1)) {
            Set pauthor=%request.Data("author",1)
        }
        If $DATA(%request.Data("genre",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"genre")) Quit
        }
        If $DATA(%request.Data("genre",1)) {
            Set pgenre=%request.Data("genre",1)
            If ($NUMBER(pgenre,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"genre",pgenre)) Quit
        }
        Set response=##class(LibraryApi.impl).AddingBook(.ptitle,.pauthor,.pgenre)
        Do ##class(LibraryApi.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$PARAMETER("LibraryApi.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

ClassMethod AddingFriend() As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set response=##class(LibraryApi.impl).AddingFriend()
        Do ##class(LibraryApi.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$PARAMETER("LibraryApi.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

ClassMethod FindingBook(pbookid As %String) As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set response=##class(LibraryApi.impl).FindingBook(pbookid)
        Do ##class(LibraryApi.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$PARAMETER("LibraryApi.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

ClassMethod Findingperson(ppersonid As %String) As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set response=##class(LibraryApi.impl).Findingperson(ppersonid)
        Do ##class(LibraryApi.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$PARAMETER("LibraryApi.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

ClassMethod GetAllBooks() As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set response=##class(LibraryApi.impl).GetAllBooks()
        Do ##class(LibraryApi.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$PARAMETER("LibraryApi.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

ClassMethod GetAllPerson() As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set response=##class(LibraryApi.impl).GetAllPerson()
        Do ##class(LibraryApi.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$PARAMETER("LibraryApi.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

ClassMethod LoanBook() As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        If $DATA(%request.Data("Bookid",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"Bookid")) Quit
        }
        If $DATA(%request.Data("Bookid",1)) {
            Set pBookid=%request.Data("Bookid",1)
        }
        If $DATA(%request.Data("FriendsName",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"FriendsName")) Quit
        }
        If $DATA(%request.Data("FriendsName",1)) {
            Set pFriendsName=%request.Data("FriendsName",1)
        }
        Set response=##class(LibraryApi.impl).LoanBook(.pBookid,.pFriendsName)
        Do ##class(LibraryApi.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$PARAMETER("LibraryApi.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

ClassMethod ReturnBook(pbookid As %String) As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set response=##class(LibraryApi.impl).ReturnBook(pbookid)
        Do ##class(LibraryApi.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$PARAMETER("LibraryApi.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

ClassMethod loanedBooks() As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set response=##class(LibraryApi.impl).loanedBooks()
        Do ##class(LibraryApi.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$PARAMETER("LibraryApi.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

ClassMethod RemoveBook() As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        If $DATA(%request.Data("Bookid",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"Bookid")) Quit
        }
        If $DATA(%request.Data("Bookid",1)) {
            Set pBookid=%request.Data("Bookid",1)
        }
        Set response=##class(LibraryApi.impl).RemoveBook(.pBookid)
        Do ##class(LibraryApi.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$PARAMETER("LibraryApi.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

ClassMethod RemovePerson() As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        If $DATA(%request.Data("Personid",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"Personid")) Quit
        }
        If $DATA(%request.Data("Personid",1)) {
            Set pPersonid=%request.Data("Personid",1)
        }
        Set response=##class(LibraryApi.impl).RemovePerson(.pPersonid)
        Do ##class(LibraryApi.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$PARAMETER("LibraryApi.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

}
