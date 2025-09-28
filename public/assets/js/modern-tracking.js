// Modern JavaScript for Sample Tracking
// Replaces jQuery dependency with vanilla JavaScript

class ContactForm {
  constructor() {
    this.form = document.querySelector('form');
    this.contactApiUrl = this.getApiUrl('CONTACT_API_URL', 'http://localhost:3000/contacts');
    this.trackingApiUrl = this.getApiUrl('TRACKING_API_URL', 'http://localhost:3000/tracks');
    this.init();
  }

  init() {
    if (this.form) {
      this.form.addEventListener('submit', (event) => this.handleSubmit(event));
    }
    this.setupTracking();
  }

  getApiUrl(envVar, defaultValue) {
    // In a real app, this would read from environment variables
    // For now, we'll use the default values
    return defaultValue;
  }

  handleSubmit(event) {
    event.preventDefault();
    this.sendContact();
  }

  async sendContact() {
    try {
      const formData = new FormData(this.form);
      const guid = this.getOrCreateGuid();
      formData.append('guid', guid);

      const response = await fetch(this.contactApiUrl, {
        method: 'POST',
        body: formData
      });

      if (response.ok) {
        this.showMessage(`Success: ${response.status} - ${response.statusText}`, 'success');
      } else {
        this.showMessage(`Error: ${response.status} - ${response.statusText}`, 'error');
      }
    } catch (error) {
      this.showMessage('Oops! Something went wrong.', 'error');
      console.error('Contact submission error:', error);
    }
  }

  showMessage(message, type) {
    // Create a simple notification system
    const notification = document.createElement('div');
    notification.className = `notification ${type}`;
    notification.textContent = message;
    notification.style.cssText = `
      position: fixed;
      top: 20px;
      right: 20px;
      padding: 15px 20px;
      border-radius: 5px;
      color: white;
      font-weight: bold;
      z-index: 1000;
      ${type === 'success' ? 'background-color: #4CAF50;' : 'background-color: #f44336;'}
    `;

    document.body.appendChild(notification);

    // Auto-remove after 3 seconds
    setTimeout(() => {
      if (notification.parentNode) {
        notification.parentNode.removeChild(notification);
      }
    }, 3000);
  }

  // GUID generation and management
  s4() {
    const rand = (1 + Math.random()) * 0x10000;
    return (rand | 0).toString(16).substring(1);
  }

  createGuid() {
    return `${this.s4()}${this.s4()}-${this.s4()}-${this.s4()}-${this.s4()}-${this.s4()}${this.s4()}${this.s4()}`;
  }

  getOrCreateGuid() {
    if (localStorage.guid) {
      return localStorage.guid;
    } else {
      const guid = this.createGuid();
      localStorage.setItem('guid', guid);
      return guid;
    }
  }

  // Tracking functionality
  setupTracking() {
    const handler = () => this.sendTracking();
    window.addEventListener('hashchange', handler);
    window.addEventListener('load', handler);
  }

  getDateTime() {
    const today = new Date();
    const date = today.getFullYear() + '-' +
                 String(today.getMonth() + 1).padStart(2, '0') + '-' +
                 String(today.getDate()).padStart(2, '0');
    const time = String(today.getHours()).padStart(2, '0') + ":" +
                 String(today.getMinutes()).padStart(2, '0') + ":" +
                 String(today.getSeconds()).padStart(2, '0');
    return date + ' ' + time;
  }

  async sendTracking() {
    try {
      const guid = this.getOrCreateGuid();
      const visitedPage = window.location.href;
      const visitedDateTime = this.getDateTime();

      await fetch(this.trackingApiUrl, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          guid: guid,
          visited_page: visitedPage,
          visited_datetime: visitedDateTime
        })
      });
    } catch (error) {
      console.error('Tracking error:', error);
    }
  }
}

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
  new ContactForm();
});
