Class LibraryApi.spec Extends %REST.Spec [ ProcedureBlock ]
{

XData OpenAPI [ MimeType = application/json ]
{
{
  "swagger":"2.0",
  "info":{
    "description":"An API for Library Management using InterSystems IRIS",
    "version":"1.0.0",
    "title":"Library Book",
    "license":{
      "name":"Apache 2.0",
      "url":"http://www.apache.org/licenses/LICENSE-2.0.html"
    }
  },
  "schemes":[
    "https"
  ],
  "paths":{
    "/addbook":{
      "post":{
        "description":"Add a new book",
        "operationId":"AddingBook",
        "x-ISC_CORS": true,
        "produces":[
          "application/json"
        ],
        "parameters":[
          {
            "name":"title",
            "in":"query",
            "type":"string"
          },
          {
            "name":"author",
            "in":"query",
            "type":"string"
          },
          {
            "name":"genre",
            "in":"query",
            "type":"integer"
          }
        ],
        "responses":{
          "200":{
            "description":"Success"
          },
          "500":{
            "description":"Server error"
          }
        }
      }
    },
    "/addfriend":{
      "post":{
        "description":"Add a new friend",
        "operationId":"AddingFriend",
        "x-ISC_CORS": true,
        "produces":[
          "application/json"
        ],
        "responses":{
          "200":{
            "description":"Success"
          },
          "500":{
            "description":"Server error"
          }
        }
      }
    },
    "/findabook/{bookid}":{
      "get":{
        "description":"Find a book",
        "operationId":"FindingBook",
        "produces":[
          "application/json"
        ],
        "parameters":[
          {
            "name":"bookid",
            "in":"path",
            "type":"string",
            "required":true
          }
        ],
        "responses":{
          "200":{
            "description":"Success"
          },
          "500":{
            "description":"Server error"
          }
        }
      }
    },
    "/findaperson/{personid}":{
      "get":{
        "description":"Find a person",
        "operationId":"Findingperson",
        "produces":[
          "application/json"
        ],
        "parameters":[
          {
            "name":"personid",
            "in":"path",
            "type":"string",
            "required":true
          }
        ],
        "responses":{
          "200":{
            "description":"Success"
          },
          "500":{
            "description":"Server error"
          }
        }
      }
    },
    "/getallbook":{
      "get":{
        "description":"list of all the books",
        "operationId":"GetAllBooks",
        "x-ISC_CORS": true,
        "produces":[
          "application/json"
        ],
        "responses":{
          "200":{
            "description":"Success"
          },
          "500":{
            "description":"Server error"
          }
        }
      }
    },
    "/getallperson":{
      "get":{
        "description":"list of all the people",
        "operationId":"GetAllPerson",
        "x-ISC_CORS": true,
        "produces":[
          "application/json"
        ],
        "responses":{
          "200":{
            "description":"Success"
          },
          "500":{
            "description":"Server error"
          }
        }
      }
    },
    "/loanbook":{
      "post":{
        "description":"loan a book to a friend",
        "operationId":"LoanBook",
        "x-ISC_CORS": true,
        "produces":[
          "application/json"
        ],
        "parameters":[
          {
            "name":"Bookid",
            "in":"query",
            "type":"string"
          },
          {
            "name":"FriendsName",
            "in":"query",
            "type":"string"
          }
        ],
        "responses":{
          "200":{
            "description":"Success"
          },
          "500":{
            "description":"Server error"
          }
        }
      }
    },
    "/returnbook/{bookid}":{
      "post":{
        "description":"return a book from a friend",
        "operationId":"ReturnBook",
        "x-ISC_CORS": true,
        "produces":[
          "application/json"
        ],
        "parameters":[
          {
            "name":"bookid",
            "in":"path",
            "type":"string",
            "required":true
          }
        ],
        "responses":{
          "200":{
            "description":"Success"
          },
          "500":{
            "description":"Server error"
          }
        }
      }
    },
    "/loanedbooks":{
      "get":{
        "description":"list of all the loaned books",
        "operationId":"loanedBooks",
        "produces":[
          "application/json"
        ],
        "responses":{
          "200":{
            "description":"Success"
          },
          "500":{
            "description":"Server error"
          }
        }
      }
    },
    "/removebook":{
      "post":{
        "description":"remove a book",
        "operationId":"RemoveBook",
        "produces":[
          "application/json"
        ],
        "parameters":[
          {
            "name":"Bookid",
            "in":"query",
            "type":"string"
          }
        ],
        "responses":{
          "200":{
            "description":"Success"
          },
          "500":{
            "description":"Server error"
          }
        }
      }
    },
    "/removeperson":{
      "post":{
        "description":"remove a person",
        "operationId":"RemovePerson",
        "produces":[
          "application/json"
        ],
        "parameters":[
          {
            "name":"Personid",
            "in":"query",
            "type":"string"
          }
        ],
        "responses":{
          "200":{
            "description":"Success"
          },
          "500":{
            "description":"Server error"
          }
        }
      }
    }
  }
}
}

}
