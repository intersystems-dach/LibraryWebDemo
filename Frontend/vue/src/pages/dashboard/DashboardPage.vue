<template>
  <div class="d-flex flex-grow-1 flex-column">
    <v-row class="flex-grow-0" dense>
      <v-col cols="12" xl="12">
        <v-card
          class="h-full"
          style="min-height: 380px"
          img="https://t4.ftcdn.net/jpg/03/32/82/91/360_F_332829173_V4kiRCM2s24t1h5xs2mamqchsQmFLedg.jpg"
        >
        </v-card>
      </v-col>

      <!--  <v-col cols="12" md="6" xl="4">
        <bar></bar>
      </v-col>

      <v-col cols="12" md="6" xl="4">
        <radial></radial>
      </v-col> -->
    </v-row>

    <v-row class="flex-grow-0" dense>
      <v-col cols="12" xl="12">
        <books-card class="h-full" color="#8c9eff"></books-card>
      </v-col>
    </v-row>

    <v-row class="flex-grow-0" dense>
      <v-col cols="12" xl="12">
        <people-card class="h-full" color="#8c9eff"></people-card>
      </v-col>
    </v-row>
    <v-row class="flex-grow-0 justify-center" dense>
      <p></p>
      <v-btn class="ma-2 primary" elevation="21" @click="loadDemoBooks()">
        Add Demo Books
      </v-btn>
      <v-btn class="ma-2 primary" elevation="21" @click="loadDemoPeople()">
        Add Demo Persons
      </v-btn>
    </v-row>
  </div>
</template>

<script>
// DEMO Cards for dashboard
import ActivityCard from "../../components/dashboard/ActivityCard";
import SalesCard from "../../components/dashboard/SalesCard";
import TrackCard from "../../components/dashboard/TrackCard";
import TableCard from "../../components/dashboard/TableCard";
import SourcesCard from "../../components/dashboard/SourcesCard";
import TicketsCard from "../../components/dashboard/TicketsCard";
import TodoCard from "../../components/dashboard/TodoCard";
import BooksCard from "../../components/dashboard/BooksCard.vue";
import PeopleCard from "../../components/dashboard/PeopleCard.vue";
import bar from "../ui/charts/_examples/apex-charts/simple/bar.vue";
import radial from "../ui/charts/_examples/apex-charts/simple/radial.vue";
import {
  loadExampleBooks,
  loadExamplePersons,
} from "../../example/loadExampleData";
export default {
  components: {
    SalesCard,
    ActivityCard,
    TrackCard,
    TableCard,
    SourcesCard,
    TicketsCard,
    TodoCard,
    BooksCard,
    PeopleCard,
    bar,
    radial,
  },
  data() {
    return {
      loadingInterval: null,

      isLoading1: true,
      isLoading2: true,
      isLoading3: true,
      isLoading4: true,

      ordersSeries: [
        {
          name: "Orders",
          data: [
            ["2020-02-02", 34],
            ["2020-02-03", 43],
            ["2020-02-04", 40],
            ["2020-02-05", 43],
          ],
        },
      ],

      customersSeries: [
        {
          name: "Customers",
          data: [
            ["2020-02-02", 13],
            ["2020-02-03", 11],
            ["2020-02-04", 13],
            ["2020-02-05", 12],
          ],
        },
      ],
    };
  },
  computed: {
    theme() {
      return this.$vuetify.theme.isDark
        ? this.$vuetify.theme.defaults.dark
        : this.$vuetify.theme.defaults.light;
    },
  },
  mounted() {
    let count = 0;

    // DEMO delay for loading graphics
    this.loadingInterval = setInterval(() => {
      this[`isLoading${count++}`] = false;
      if (count === 4) this.clear();
    }, 400);
  },
  beforeDestroy() {
    this.clear();
  },
  methods: {
    clear() {
      clearInterval(this.loadingInterval);
    },
    loadDemoBooks() {
      loadExampleBooks();
      // reload the books
      window.location.reload();
    },

    loadDemoPeople() {
      loadExamplePersons();
      // reload the books
      window.location.reload();
    },
  },
};
</script>
