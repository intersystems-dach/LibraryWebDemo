<template>
  <div v-if="showChart">
    <apexchart type="bar" height="430" :options="chartOptions" :series="series"></apexchart>
  </div>
</template>

<script>
export default {
  data() {
    return {
      showChart: false,
      series: [{
        data: [44, 55, 41, 64]
      } /* ,{
        data: [53, 32, 33, 52, 13, 44, 32]
      } */],
      chartOptions: {
        chart: {
          type: 'bar',
          height: 430
        },
        plotOptions: {
          bar: {
            horizontal: true,
            dataLabels: {
              position: 'top'
            }
          }
        },
        dataLabels: {
          enabled: true,
          offsetX: -6,
          style: {
            fontSize: '12px',
            colors: ['#fff']
          }
        },
        stroke: {
          show: true,
          width: 1,
          colors: ['#fff']
        },
        xaxis: {
          categories: ['Mystery', 'Science Fiction', 'Romance', 'Crime', ]
        }
      }
    }
  },
  mounted() {
    this.showChart = true
  }
}
</script>
