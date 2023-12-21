<template>
  <div>
    <v-card>
      <v-card-title>Personnel Directory</v-card-title>
      <v-layout justify-end>
        <v-btn
          small
          class="ma-2 primary justify-end"
          elevation="21"
          @click="createPersonDialog = true"
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

        <template v-slot:item.Person="{ item }">
          <div class="font-weight-bold">
            <copy-label :text="item.Person" />
          </div>
        </template>

        <template v-slot:item.action="{ item }">
          <div class="actions">
            <v-btn
              class="error"
              block
              small
              elevation="21"
              @click="deletePerson(item)"
            >
              Delete person
            </v-btn>
          </div>
        </template>
      </v-data-table>
    </v-card>
    <!--Dialog to enter a people-->
    <v-dialog v-model="createPersonDialog" max-width="500px">
      <v-card dense>
        <div class="primary white--text">
          <v-card-title>
            <span class="text-h6">New Personnel Entry</span>
          </v-card-title>
          <v-card-subtitle>
            A form to add a new person into the directory
          </v-card-subtitle>
        </div>
        <v-card-text>
          <v-form
            ref="createPersonForm"
            v-model="validPersonForm"
            lazy-validation
          >
            <v-container>
              <v-row>
                <v-col cols="12" sm="12" class="pa-2">
                  <v-text-field
                    v-model="name"
                    label="Name"
                    outlined
                    dense
                    :rules="[(v) => !!v || 'Book title is required']"
                    required
                  ></v-text-field>
                </v-col>
                <v-col cols="12" sm="12" class="pa-2">
                  <v-text-field
                    v-model="phoneNumber"
                    label="Phone number"
                    outlined
                    dense
                    :rules="[(v) => !!v || 'Author is required']"
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
              createPersonDialog = false;
              resetCreateNewPersonForm();
            "
          >
            Close
          </v-btn>
          <v-btn color="blue darken-1" text @click="createNewPerson()">
            Save
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import CopyLabel from "../common/CopyLabel";
import axios from "axios";
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
      createPersonDialog: false,
      validPersonForm: "",
      name: "",
      phoneNumber: "",

      headers: [
        { text: "Person Id", align: "start", value: "id" },
        {
          text: "Name",
          value: "Person",
        },
        { text: "Phone number", value: "Phone" },

        { text: "", sortable: false, align: "right", value: "action" },
      ],
      items: [],
    };
  },
  mounted() {
    this.retrieveAllPeople();
  },
  methods: {
    async retrieveAllPeople() {
      //axios call to retrieve all books
      await axios
        .get(process.env.VUE_APP_IRIS_API_URL + "/LibraryApi/getallperson")
        .then((resp) => {
          this.items = resp.data.status;
          console.log(this.items);
        });
    },
    async createNewPerson() {
      if (this.$refs.createPersonForm.validate()) {
        //Write axios to create the person check the data() variables
        const requestBody = {
          friendName: this.name,
          friendNumber: this.phoneNumber,
          // Add more data as needed
        };
        const url_add_person = `${process.env.VUE_APP_IRIS_API_URL}/LibraryApi/addfriend`;
        await axios.post(url_add_person, requestBody).then((resp) => {
          //this.items = resp.data.status
          console.log(resp);
        });

        this.$refs.createPersonForm.reset();
        this.retrieveAllPeople();
        this.createPersonDialog = false;
      }
    },
    resetCreateNewPersonForm() {
      this.$refs.createPersonForm.reset();
    },
    async deletePerson(item) {
      console.log("Delete person called");
      const person_id = item.id;
      const url_del_person = `${process.env.VUE_APP_IRIS_API_URL}/LibraryApi/removeperson?Personid=${person_id}`;
      console.log(url_del_person);

      await axios.post(url_del_person).then((resp) => {
        //this.items = resp.data.status
        console.log(resp);
      });

      this.retrieveAllPeople();
    },
  },
};
</script>
