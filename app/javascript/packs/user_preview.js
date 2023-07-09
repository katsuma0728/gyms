document.addEventListener('DOMContentLoaded', () => {
  const createImageHTML = (blob) => {
    const imageElement = document.getElementById('new-user-image');
    const blobImage = document.createElement('img');
    blobImage.setAttribute('class', 'new-user-img')
    blobImage.setAttribute('src', blob);
    imageElement.appendChild(blobImage);
  };

  const target = document.getElementById('user_profile_image');
  if (target) {
    target.addEventListener('change', (e) => {
    const imageContent = document.querySelector('.new-user-img');
    if (imageContent){
      const tareget = document.getElementById('registraion_page');
      
      if (target) {
        imageContent.remove();
      } else {
        document.getElementsByTagName('img')[1].remove()
      }
    }

    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
    createImageHTML(blob);
    });
  };
});