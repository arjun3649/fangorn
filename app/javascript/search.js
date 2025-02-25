// app/javascript/search.js
document.addEventListener('turbo:load', function() {
  const searchInput = document.querySelector('[data-search]');
  const searchResults = document.getElementById('search-results');

  if (searchInput) {
    // Get product ID from the form (we'll add this data attribute in the next step)
    const productId = searchInput.dataset.productId;
    
    let currentRequest = null;

    searchInput.addEventListener('input', function (e) {
      
      const query = e.target.value.trim();
      
      // Cancel previous pending request
      if (currentRequest) {
        currentRequest.abort();
      }

      if (query.length < 2) {
        searchResults.classList.add('hidden');
        return;
      }

      // Show loading state
      searchResults.innerHTML = '<div class="p-2 text-gray-500">Searching...</div>';
      searchResults.classList.remove('hidden');

      // Create new AbortController for the current request
      const controller = new AbortController();
      currentRequest = controller;

      fetch(`/products/${productId}/properties/search?query=${encodeURIComponent(query)}`, {
        signal: controller.signal
      })
      .then(response => {
        if (!response.ok) throw new Error('Network response was not ok');
        return response.json();
      })
        .then(data => {
         console.log('Raw response:', data);
        if (data.length === 0) {
          searchResults.innerHTML = '<div class="p-2 text-gray-500">No results found</div>';
          return;
        }

        searchResults.innerHTML = `
  <div class="border rounded-md bg-white">
    ${data.map(property => `
      <div class="p-3 hover:bg-gray-50 cursor-pointer border-b" 
           data-property='${JSON.stringify(property).replace(/</g, '\\u003c')}'>
        <p class="font-medium">${property.name.replace(/</g, '&lt;')}</p>
        ${property.description ? `<p class="text-sm text-gray-600">${property.description.replace(/</g, '&lt;')}</p>` : ''}
        ${property.unit ? `<p class="text-sm text-gray-500">Unit: ${property.unit.replace(/</g, '&lt;')}</p>` : ''}
      </div>
    `).join('')}
  </div>
`;
        // Add click handlers to all results
        searchResults.querySelectorAll('[data-property]').forEach(result => {
          result.addEventListener('click', () => {
            const property = JSON.parse(result.dataset.property);
            fillForm(property);
          });
        });
      })
      .catch(error => {
        if (error.name !== 'AbortError') {
          console.error('Fetch error:', error);
          searchResults.innerHTML = '<div class="p-2 text-red-500">Error loading results</div>';
        }
      });
    });

    // Hide results when clicking outside
    document.addEventListener('click', (e) => {
      if (!searchResults.contains(e.target) && !searchInput.contains(e.target)) {
        searchResults.classList.add('hidden');
      }
    });
  }
});

function fillForm(property) {
  document.querySelector('[data-search]').value = property.name;
  document.getElementById('property_description').value = property.description || '';
  document.getElementById('property_unit').value = property.unit || '';
  document.getElementById('search-results').classList.add('hidden');
}