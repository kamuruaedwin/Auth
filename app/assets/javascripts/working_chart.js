
document.addEventListener("DOMContentLoaded", () => {
  const canvas = document.getElementById('chart-container');
  const context = canvas.getContext('2d');
  const animationDurations = [2800, 107000, 800, 12005, 3000, 6666, 2800, 80000,107,62,80,53, 2006, 3005, 4004, 701, 620, 611, 503, 170, 530, 710, 602, 7100, 6200,17, 80, 62, 53,44, 5300, 40400,17000, 242, 530,701, 620, 260, 503,440]; // List of possible animation durations
  let animationDuration = animationDurations[Math.floor(Math.random() )];
  console.log(animationDuration)
  let animationStartTime;
  let burst_value;
  let animationIsRunning = true;
  let randomStopTime = Math.random() * animationDuration;
  let clearAnimationTimeout;
  let betid = getDynamicBetId(); // Set the betid dynamically

  const maxLastValues = 8;
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
          beginAtZero: false,
        },
      },
    },
  });

  const valueDisplay = document.getElementById('value-display');
  const timerDisplay = document.getElementById('timer-display');
  const buttonContainer = document.getElementById('button-container');
  const tableBody = document.getElementById('table-body');

  function getRandomDuration(durations) {
    return durations[Math.floor(Math.random() * animationDurations.length)];
  }

  function generateHashvalue() {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let hashvalue = '';
    const hashvalueLength = 32;
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
      stopAnimation(value, betid);
    } else if (animationIsRunning) {
      requestAnimationFrame(() => drawGraph());
    }
  }

  function stopAnimation(value, betid) {
    animationIsRunning = false;
    burst_value = value;
    hashvalue = generateHashvalue();
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
        animationDuration = getRandomDuration(animationDurations); // Set a new random duration
        console.log(animationDuration)
        console.log(burst_value)


        startAnimation(betid); // Call startAnimation with betid after countdown
        timerDisplay.textContent = '';
      }
    }, 1000);

    clearAnimationTimeout = setTimeout(() => {
      clearAnimation();
    }, 3000);
 
    $.ajax({
      type: 'POST',
      url: 'http://localhost:3000/bets/save_burst_data',
      data: {
        'burst_data[burst_value]': burst_value,
        'burst_data[hashvalue]': hashvalue,
        'burst_data[betid]': betid
        
      },
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name=csrf-token]').attr('content'));
      },
      success: function(response) {
        // Handle the success response from the server, if needed
      },
      error: function(error) {
        // Handle any errors, if needed
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
    

  function startAnimation(betid) {
    animationStartTime = null;
    animationIsRunning = true;
    // Disable the "Place Bet" button
    const placeBetButton = document.getElementById('placeBetButton');
    if (placeBetButton) {
      placeBetButton.disabled = true;
    }
    drawGraph(betid);
  }

  function getDynamicBetId() {
    // Example: Retrieve the betid from an HTML element with ID 'betid'
    const betidElement = document.getElementById('betid');
    if (betidElement) {
      return betidElement.textContent;
    } else {
      // If betid is not available, you can handle this case accordingly
      return null;
    }
  }

  // Start the animation
  startAnimation(betid);
  console.log(animationDuration)

});
