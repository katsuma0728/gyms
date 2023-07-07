if (document.URL.match(/sign_up/) || document.URL.match(/edit/)) {
  document.addEventListener('DOMContentLoaded', () => {
    const createImageHTML = (blob) => {
      const imageElement = document.getElementById('new-user-image');
      const blobImage = document.createElement('img');
      blobImage.setAttribute('class', 'new-user-img')
      blobImage.setAttribute('src', blob);

      imageElement.appendChild(blobImage);
    };
    document.getElementById('user_profile_image').addEventListener('change', (e) =>{
      const imageContent = document.querySelector('img');
      if (imageContent){
        if (document.URL.match(/edit/)) {
          // 画面上のimgを配列でもってきて先頭を削除
          document.getElementsByTagName('img')[1].remove()
        }else{
          imageContent.remove();
        }
      }

      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      createImageHTML(blob);
    });
  });
}