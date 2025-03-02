// JavaScript para accordion
document.querySelectorAll('.accordion-header').forEach(button => {
    button.addEventListener('click', () => {
        const content = button.nextElementSibling;
        
        if (content.style.display === 'block') {
            content.style.display = 'none';
            button.querySelector('i').classList.replace('fa-chevron-up', 'fa-chevron-down');
        } else {
            content.style.display = 'block';
            button.querySelector('i').classList.replace('fa-chevron-down', 'fa-chevron-up');
        }
    });
});

// Inicialmente ocultar todos os conteúdos do accordion
document.querySelectorAll('.accordion-content').forEach(content => {
    content.style.display = 'none';
});

// Smooth scrolling para links âncora
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        
        document.querySelector(this.getAttribute('href')).scrollIntoView({
            behavior: 'smooth'
        });
    });
});