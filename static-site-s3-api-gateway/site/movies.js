import { apiUrl } from './config.js';

document.getElementById('fetchMovies').addEventListener('click', () => {
  const moviesDiv = document.getElementById('movies');
  moviesDiv.innerHTML = 'Loading...';

  fetch(apiUrl + '/movies')
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok: ' + response.statusText);
      }
      return response.json();
    })
    .then(data => {
      moviesDiv.innerHTML = '<h2>Movie Titles:</h2>';
      const ul = document.createElement('ul');
      data.forEach(movie => {
        const li = document.createElement('li');
        li.textContent = movie.title;
        ul.appendChild(li);
      });
      moviesDiv.appendChild(ul);
    })
    .catch(error => {
      moviesDiv.innerHTML = `<p style="color: red;">Error fetching movies: ${error.message}</p>`;
      console.error('There was a problem with the fetch operation:', error);
    });
});
