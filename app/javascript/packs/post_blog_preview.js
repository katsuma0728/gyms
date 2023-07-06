if (document.URL.match(/new/) || document.URL.match(/edit/)) {
  
  document.addEventListener('DOMContentLoaded', () => {
    const createImageHTML = (blob) => {
      const imageElement = document.getElementById('new-image');
      const blobImage = document.createElement('img');
      blobImage.setAttribute('class', 'new-img')
      blobImage.setAttribute('src', blob);

      imageElement.appendChild(blobImage);
    };
    document.getElementById('post_blog_image').addEventListener('change', (e) =>{
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
