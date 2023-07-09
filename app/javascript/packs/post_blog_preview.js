//if (document.URL.match(/new/) || document.URL.match(/edit/)) {

  document.addEventListener('DOMContentLoaded', () => {
    const createImageHTML = (blob) => {
      const imageElement = document.getElementById('new-image');
      const blobImage = document.createElement('img');
      blobImage.setAttribute('class', 'new-img')
      blobImage.setAttribute('src', blob);

      imageElement.appendChild(blobImage);
    };
    const result = document.getElementById('post_blog_image')
    if(result) {
    result.addEventListener('change', (e) =>{
      const imageContent = document.querySelector('img');
      if (imageContent){
        const target = document.getElementById("new_post_blogs_page")

        if (target) {
          imageContent.remove();
          // 画面上のimgを配列でもってきて先頭を削除
        }else{

           document.getElementsByTagName('img')[1].remove()
        }
      }

      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      createImageHTML(blob);
    });
    };
  });
//}
