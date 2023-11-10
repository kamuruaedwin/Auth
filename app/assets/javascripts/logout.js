<div class="container">
  <div class="card">
    <div class="card-header">
      <ul class="nav nav-tabs card-header-tabs">
        <li class="nav-item">
          <%= link_to 'Live Bets', 'javascript:void(0);', id: 'live-bets-link' %>
        </li>
        <li class="nav-item">
          <a class="nav-link" id="Live Bets" href="#">Live Bets</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" id="History" href="#">History</a>
        </li>
      </ul>
    </div>
    <div class="card-body" id="content">
      <div id="content1" style="display: block;">
        <h5 class="card-title">Chats</h5>
        <p class="card-text">Messages</p>
      </div>
      <div id="content2" style="display: none;">
        <h5 class="card-title">Live Bets</h5>
        <p class="card-text">Active Bets</p>
      </div>
      <div id="content3" style="display: none;">
        <h5 class="card-title">History</h5>
        <p class="card-text">Past Animations</p>
      </div>
    </div>
  </div>
</div>

<script>
  // Add click event listeners to the buttons
  document.getElementById('Chats').addEventListener('click', () => {
    showContent('content1');
  });

  document.getElementById('Live Bets').addEventListener('click', () => {
    showContent('content2');
  });

  document.getElementById('History').addEventListener('click', () => {
    showContent('content3');
  });

  function showContent(contentId) {
    // Hide all content divs
    document.getElementById('content1').style.display = 'none';
    document.getElementById('content2').style.display = 'none';
    document.getElementById('content3').style.display = 'none';

    // Show the selected content div
    document.getElementById(contentId).style.display = 'block';
  }

  // Initially, show the content of the active button (Button 1)
  showContent('content1');
</script>








