<template>
  <div>
    <v-card>
      <v-card-title>Library Catalog</v-card-title>
      <v-layout justify-end>
        <v-btn
          small
          class="ma-2 primary justify-end"
          elevation="21"
          @click="createBookDialog = true"
        >
          <v-icon light>mdi-plus</v-icon>New Entry</v-btn
        >
      </v-layout>
      <v-layout justify-center>
        <v-text-field
          v-model="search"
          class="ma-2"
          append-icon="mdi-magnify"
          label="Search"
          single-line
          outlined
          dense
          hide-details
        ></v-text-field>
      </v-layout>
      <v-data-table
        :headers="headers"
        :items="items"
        :search="search"
        hide-default-footer
      >
        <template v-slot:item.id="{ item }">
          <div class="font-weight-bold"># <copy-label :text="item.id" /></div>
        </template>

        <template v-slot:item.Title="{ item }">
          <div class="font-weight-bold">
            <copy-label :text="item.Title" />
          </div>
        </template>

        <template v-slot:item.Author="{ item }">
          <div class="font-weight-bold">
            <copy-label :text="item.Author.Name" />
          </div>
        </template>

        <template v-slot:item.Friend="{ item }">
          <v-chip
            label
            small
            class="font-weight-bold error justify-center"
            style="width: 100%"
            v-if="item.Friend.ID"
            >Borrowed: {{ item.Friend.Name }}</v-chip
          >
          <v-chip
            label
            small
            class="font-weight-bold success justify-center"
            style="width: 100%"
            v-else
            >Available</v-chip
          >
        </template>

        <template v-slot:item.action="{ item }">
          <div class="actions">
            <v-btn
              class="primary"
              block
              small
              v-if="item.Friend.ID"
              elevation="21"
              @click="
                selectedBookId = item.id;
                returnBookDialog = true;
              "
            >
              Return Book
            </v-btn>
            <v-btn
              class="primary"
              block
              small
              v-else
              elevation="21"
              @click="
                configureLoanBook(item);
                loanBookDialog = true;
              "
            >
              Loan Book
            </v-btn>
          </div>
        </template>
      </v-data-table>
    </v-card>
    <!--Dialog to enter a new book-->
    <v-dialog v-model="createBookDialog" max-width="500px">
      <v-card dense>
        <div class="primary white--text">
          <v-card-title>
            <span class="text-h6">New Book Entry</span>
          </v-card-title>
          <v-card-subtitle>
            A form to add a new book into the catalog
          </v-card-subtitle>
        </div>
        <v-card-text>
          <v-form
            ref="createBookForm"
            v-model="validCreateBookForm"
            lazy-validation
          >
            <v-container>
              <v-row>
                <v-col cols="12" sm="12" class="pa-2">
                  <v-text-field
                    v-model="bookTitle"
                    label="Book Title"
                    outlined
                    dense
                    :rules="[(v) => !!v || 'Book title is required']"
                    required
                  ></v-text-field>
                </v-col>
                <v-col cols="12" sm="12" class="pa-2">
                  <v-text-field
                    v-model="authorName"
                    label="Author"
                    outlined
                    dense
                    :rules="[(v) => !!v || 'Author is required']"
                    required
                  ></v-text-field>
                </v-col>
                <v-col cols="12" sm="12" class="pa-2">
                  <v-text-field
                    v-model="genre"
                    label="Genre*"
                    outlined
                    dense
                    :rules="[(v) => !!v || 'Genre is required']"
                    required
                  ></v-text-field>
                </v-col>
              </v-row>
            </v-container>
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="blue darken-1"
            text
            @click="
              createBookDialog = false;
              resetCreateNewBookForm();
            "
          >
            Close
          </v-btn>
          <v-btn color="blue darken-1" text @click="createNewBook()">
            Save
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <!--Dialog to return book-->
    <v-dialog v-model="returnBookDialog" max-width="500px">
      <v-card>
        <v-card-title class="text-h5 primary white--text">
          Confirmation
        </v-card-title>
        <v-card-text class="pa-2">
          Are you sure book with Id <b>{{ selectedBookId }}</b> was returned?
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="error darken-1" text @click="returnBookDialog = false">
            No
          </v-btn>
          <v-btn color="blue darken-1" text @click="returnBook()"> Yes </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <!--Dialog to loan book -->
    <v-dialog v-model="loanBookDialog" max-width="500px">
      <v-card dense>
        <div class="primary white--text">
          <v-card-title>
            <span class="text-h6">Loan book form</span>
          </v-card-title>
          <v-card-subtitle>
            A form to loan book into the catalog
          </v-card-subtitle>
        </div>
        <v-card-text>
          <v-form
            ref="loanBookForm"
            v-model="validLoanBookForm"
            lazy-validation
          >
            <v-container>
              <v-row>
                <v-col cols="12" sm="12" class="pa-2">
                  Loaning book with id <b> {{ selectedloanBookId }} </b>
                </v-col>
                <v-col cols="12" sm="12" class="pa-2">
                  <v-select
                    v-model="loanBookFriend"
                    label="Select a person"
                    outlined
                    dense
                    :items="people"
                    item-text="Person"
                    :rules="[(v) => !!v || 'Please select a person from list']"
                    required
                  ></v-select>
                </v-col>
              </v-row>
            </v-container>
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="blue darken-1"
            text
            @click="
              loanBookDialog = false;
              resetLoanBook();
            "
          >
            Close
          </v-btn>
          <v-btn color="blue darken-1" text @click="loanBook()"> Save </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import axios from "axios";
import CopyLabel from "../common/CopyLabel";

/*
|---------------------------------------------------------------------
| DEMO Dashboard Card Component
|---------------------------------------------------------------------
|
| Demo card component to be used to gather some ideas on how to build
| your own dashboard component
|
*/
export default {
  components: {
    CopyLabel,
  },
  data() {
    return {
      search: "",
      // Create Book Dialog and form variables
      /* {
            "value": 1,
            "text": "Bach,Greta L.",

        },
        {
            "value": 3,
            "text": "Quixote,Jules G.",

        }, */
      createBookDialog: false,
      validCreateBookForm: "",
      bookTitle: "",
      authorName: "",
      genre: "",
      // Return book dialog
      returnBookDialog: false,
      selectedBookId: 0,
      // Loan Book form
      loanBookDialog: false,
      validLoanBookForm: "",
      selectedloanBookId: "",
      loanBookFriend: "",
      headers: [
        { text: "Book Id", align: "start", value: "id" },
        { text: "Book Title", value: "Title" },
        { text: "Author", value: "Author" },
        { text: "Genre", value: "Genre" },
        { text: "Status", value: "Friend" },

        { text: "", sortable: false, align: "right", value: "action" },
      ],
      items: [],
      people: [],
    };
  },
  mounted() {
    this.retrieveAllBooks();
  },
  methods: {
    async retrieveAllBooks() {
      //axios call to retrieve all books
      await axios
        .get(process.env.VUE_APP_IRIS_API_URL + "/LibraryApi/getallbook")
        .then((resp) => {
          this.items = resp.data.status;
          console.log(this.items);
        });
    },
    async retrieveAllPeople() {
      //axios call to retrieve all books
      await axios
        .get(process.env.VUE_APP_IRIS_API_URL + "/LibraryApi/getallperson")
        .then((resp) => {
          this.people = resp.data.status;
          console.log(this.people);
        });
    },
    async createNewBook() {
      if (this.$refs.createBookForm.validate()) {
        const newbook_URL = `${process.env.VUE_APP_IRIS_API_URL}/LibraryApi/addbook?title=${this.bookTitle}3&author=${this.authorName}&genre=${this.genre}`;
        await axios.post(newbook_URL).then((resp) => {
          console.log(resp);
        });

        this.$refs.createBookForm.reset();
        this.retrieveAllBooks();
        this.createBookDialog = false;
      }
    },
    resetCreateNewBookForm() {
      this.$refs.createBookForm.reset();
    },
    async returnBook() {
      //Axios call with this.selectedBookId
      const returnbook_url = `${process.env.VUE_APP_IRIS_API_URL}/LibraryApi/returnbook/${this.selectedBookId}`;
      await axios.post(returnbook_url).then((resp) => {
        /* this.people = resp.data.status */
        console.log(resp);
      });

      this.retrieveAllBooks();
      this.returnBookDialog = false;
    },
    async loanBook() {
      if (this.$refs.loanBookForm.validate()) {
        //Write axios to loan book
        console.log("Friend name to loan is", this.loanBookFriend);
        const loan_url = `${process.env.VUE_APP_IRIS_API_URL}/LibraryApi/loanbook?Bookid=${this.selectedloanBookId}&FriendsName=${this.loanBookFriend}`;
        await axios.post(loan_url).then((resp) => {
          /* this.people = resp.data.status */
          console.log(resp);
        });

        this.$refs.loanBookForm.reset();
        this.retrieveAllBooks();
        this.loanBookDialog = false;
      }
    },
    resetLoanBook() {
      this.$refs.loanBookForm.reset();
    },
    configureLoanBook(item) {
      this.selectedloanBookId = item.id;
      this.retrieveAllPeople();
      //axios call to retrieve all people and create people variable in data() example shown
    },
  },
};
</script>
