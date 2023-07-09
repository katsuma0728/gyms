// if (document.URL.match(/sign_up/) || document.URL.match(/edit/)) {
  document.addEventListener('DOMContentLoaded', () => {
    const createImageHTML = (blob) => {
      const imageElement = document.getElementById('new-user-image');
      const blobImage = document.createElement('img');
      blobImage.setAttribute('class', 'new-user-img')
      blobImage.setAttribute('src', blob);

      imageElement.appendChild(blobImage);
    };
    const target = document.getElementById('user_profile_image');
    if (target){
    target.addEventListener('change', (e) =>{
      const imageContent = document.getElementsByClassName('new-user-img')[0];
      console.log('change!')
      if (imageContent){
        const target = document.getElementById('registraion_page');
        if (target) {
          // 画面上のimgを配列でもってきて先頭を削除
          imageContent.remove();
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
// };