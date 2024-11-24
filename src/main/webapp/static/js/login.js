const choose=document.querySelector('#choose');
const tabs=document.querySelectorAll('.tab');
choose.addEventListener('click',function (e){
    if(e.target.tagName==='A'){
        choose.querySelector('.active').classList.remove('active');
        e.target.classList.add('active');
        for(let i=0;i<tabs.length;i++){
            tabs[i].style.display='none';
        }
        tabs[e.target.dataset.id].style.display='block';
    }
});