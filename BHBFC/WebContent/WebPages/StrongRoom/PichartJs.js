var options = {
  container: document.getElementById('myChart'),
  data: [
    { label: 'Jatrabari', value: 10 },
    { label: 'Khilgaon', value: 20 },
    { label: 'Pallabi', value: 7 },
    { label: 'Mirpur', value:12},
    { label: 'Uttara', value: 8 },
    { label: 'Dhanmondi', value: 6 },
  ],
  series: [
    {
      type: 'pie',
      angleKey: 'value',
      labelKey: 'label',
    },
  ],
};

agCharts.AgChart.create(options);

var revenueData = [
	  {
	    quarter: "Jatrabari",
	    pending: 10
	  },
	  {
	    quarter: "Khilgaon",
	    pending: 20
	  },
	  {
	    quarter: "Pallabi",
	    pending: 7
	  },
	  {
	    quarter: "Mirpur",
	    pending: 12
	  },
	  {
	    quarter: "Uttara",
	    pending: 8,	    
	  },
	  {
	    quarter: "Dhanmondi",
	    pending: 6
	  }	  
	];


var options1 = {
		  container: document.getElementById('myChart1'),
		  title: {
		    text: "Pending Loan Case",
		  },
		  subtitle: {
		    text: 'in loan count',
		  },
		  data: revenueData,
		  series: [
		    {
		      type: 'column',
		      xKey: 'quarter',
		      yKeys: ['pending'],
		    },
		  ],
		};

		agCharts.AgChart.create(options1);
