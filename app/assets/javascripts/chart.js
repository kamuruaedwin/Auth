      document.addEventListener("DOMContentLoaded", () => {
      const canvas = document.getElementById('chart-container');
      const context = canvas.getContext('2d');
      const animationDuration = 280000; // Animation duration in milliseconds
      let animationStartTime;
      let burst_value;
      const container = document.getElementById('container');
      const betid = container.getAttribute('data-betid');

      let animationIsRunning = true; // Initially, the animation is running
      let randomStopTime = Math.random() * 280000; // Random stopping point (approximately 30 seconds);
      let clearAnimationTimeout;
      
      const maxLastValues = 8; // Maximum number of last values to display
      const lastYValues = [];
      const hashvalueToValueMap = {};
      
      const chart = new Chart(context, {
        type: 'line',
        data: {
          labels: [],
          datasets: [{
            label: 'Animation Progress',
            data: [],
            borderColor: 'orange',
            borderWidth: 2,
            legend: {
              display: false,
            }
          }],
        },
        options: {
          scales: {
            x: {
              type: 'linear',
              position: 'bottom',
              title: {
                display: false,
                text: 'Time',
              },
            },
            y: {
              type: 'linear',
              position: 'left',
              title: {
                display: false,
                text: 'Value',
              },
              beginAtZero: false, // Do not start y-axis from zero
            },
          },
        },
      });

      const valueDisplay = document.getElementById('value-display');
      const timerDisplay = document.getElementById('timer-display');
      const buttonContainer = document.getElementById('button-container');
      const tableBody = document.getElementById('table-body'); // Table body element

      function generateHashvalue() {
        const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        let hashvalue = '';
        const hashvalueLength = 32; // 128 bits / 4 bits per character = 32 characters
        for (let i = 0; i < hashvalueLength; i++) {
          hashvalue += characters.charAt(Math.floor(Math.random() * characters.length));
        }
        return hashvalue;
      }

      function drawGraph() {
        const currentTime = Date.now();
        if (!animationStartTime) {
          animationStartTime = currentTime;
        }
        const elapsedTime = currentTime - animationStartTime;

        const progress = Math.min(1, elapsedTime / animationDuration);
        const value = 1 + progress * (elapsedTime / 1000);

        chart.data.labels.push((elapsedTime / 1000).toFixed(2));
        chart.data.datasets[0].data.push(value);
        chart.update();

        valueDisplay.textContent = `Stake* ${value.toFixed(2)}`;

        if (elapsedTime >= randomStopTime || (progress >= 1 && animationIsRunning)) {
          stopAnimation(value);
        } else if (animationIsRunning) {
          requestAnimationFrame(drawGraph);
        }
      }

      function stopAnimation(value) {
        animationIsRunning = false;
        burst_value = value;
        hashvalue = generateHashvalue();
        // Update the burst_value in the DOM
             lastYValues.push({ hashvalue, value });
        if (lastYValues.length > maxLastValues) {
          const removedValue = lastYValues.shift();
          delete hashvalueToValueMap[removedValue.hashvalue];
        }
        valueDisplay.textContent = `BURST! ${value.toFixed(2)}`;

        hashvalueToValueMap[hashvalue] = value;
        displayLastValues();
        updateTable();
         // Disable the "Place Bet" button
        const placeBetButton = document.getElementById('placeBetButton');
        if (placeBetButton) {
          placeBetButton.disabled = false;
        }
        let countdown = 5;
        timerDisplay.textContent = countdown;
        const countdownInterval = setInterval(() => {
          countdown--;
          timerDisplay.textContent = countdown;
          if (countdown === 0) {
            clearInterval(countdownInterval);
            randomStopTime = Math.random() * 280000;
            startAnimation();
            timerDisplay.textContent = '';
          }
        }, 1000);

        clearAnimationTimeout = setTimeout(() => {
          clearAnimation();
        }, 3000);
        
         
       $.ajax({
                type: 'POST',
                url: 'http://localhost:3000/bets/save_burst_data', // Update the URL as needed durin
                data: {
                    'burst_data[burst_value]': burst_value,
                    'burst_data[hashvalue]': hashvalue,
                    
                    
                },
                beforeSend: function(xhr) {
                    xhr.setRequestHeader('X-CSRF-Token', $('meta[name=csrf-token]').attr('content'));
                },
                success: function(response) {
                    // Handle the success response from the server, if needed
                },
                error: function(error){
                  //managing error
                }
            });

        
      }


      function clearAnimation() {
        context.clearRect(0, 0, canvas.width, canvas.height);
        chart.data.labels = [];
        chart.data.datasets[0].data = [];
        chart.update();
      }

      function displayLastValues() {
        buttonContainer.innerHTML = '';
        for (const [hashvalue, value] of Object.entries(hashvalueToValueMap)) {
          const button = document.createElement('button');
          button.className = 'last-value-button';
          button.textContent = `${value.toFixed(2)}`;
          button.addEventListener('click', () => {
            hashvalueValueDisplay.textContent = hashvalue;
            hashvalueDisplay.style.display = 'block';
          });
          buttonContainer.appendChild(button);
        }
      }

      function updateTable() {
        tableBody.innerHTML = '';
        for (const [hashvalue, value] of Object.entries(hashvalueToValueMap)) {
          const row = document.createElement('tr');
          const yValueCell = document.createElement('td');
          yValueCell.textContent = value.toFixed(2);
          const hashvalueCell = document.createElement('td');
          hashvalueCell.textContent = hashvalue;
          row.appendChild(yValueCell);
          row.appendChild(hashvalueCell);
          tableBody.appendChild(row);
        }
      }



      function startAnimation() {
        animationStartTime = null;
        animationIsRunning = true;
         // Enable the "Place Bet" button
      const placeBetButton = document.getElementById('placeBetButton');
      if (placeBetButton) {
        placeBetButton.disabled = true;
      }
        drawGraph();
        
      }
      startAnimation();
     
    });

        