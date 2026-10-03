document.addEventListener('DOMContentLoaded', function() {
    const createTrackerButton = document.getElementById('createTracker');
    const joinTrackerButton = document.getElementById('joinTracker');
    const pingTrackerButton = document.getElementById('pingTracker');
    const trackerNameInput = document.getElementById('trackerName');
    const frequencyInput = document.getElementById('frequency');
    const trackersDiv = document.getElementById('trackers');
    
    createTrackerButton.addEventListener('click', function() {
        const trackerName = trackerNameInput.value;
        const frequency = frequencyInput.value;
        
        if (trackerName && frequency) {
            fetch('https://gps_tracker/createTracker', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                    trackerName: trackerName,
                    frequency: frequency
                })
            }).then(resp => resp.json()).then(resp => console.log(resp));
        }
    });
    
    joinTrackerButton.addEventListener('click', function() {
        const frequency = frequencyInput.value;
        
        if (frequency) {
            fetch('https://gps_tracker/joinTracker', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                    frequency: frequency
                })
            }).then(resp => resp.json()).then(resp => console.log(resp));
        }
    });
    
    pingTrackerButton.addEventListener('click', function() {
        const frequency = frequencyInput.value;
        
        if (frequency) {
            fetch('https://gps_tracker/pingTracker', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                    frequency: frequency
                })
            }).then(resp => resp.json()).then(resp => console.log(resp));
        }
    });
    
    window.addEventListener('message', function(event) {
        const data = event.data;
        
        if (data.action === 'load' || data.action === 'update') {
            trackersDiv.innerHTML = '';
            
            for (const frequency in data.trackers) {
                const tracker = data.trackers[frequency];
                const trackerDiv = document.createElement('div');
                trackerDiv.className = 'tracker';
                trackerDiv.innerHTML = `<h2>${tracker.trackerName}</h2><p>Frequency: ${tracker.frequency}</p><p>Members: ${Object.keys(tracker.members).length}</p>`;
                
                if (tracker.position) {
                    trackerDiv.innerHTML += `<p>Position: ${tracker.position.x}, ${tracker.position.y}, ${tracker.position.z}</p>`;
                }
                
                trackersDiv.appendChild(trackerDiv);
            }
        }
    });
});