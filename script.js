document.addEventListener('DOMContentLoaded', () => {
    // Terminal animation sequence
    const delays = [800, 1500, 2200, 3000];
    const elements = [
        document.querySelector('.fade-in-1'),
        document.querySelector('.fade-in-2'),
        document.querySelector('.fade-in-3'),
        document.querySelectorAll('.fade-in-4')
    ];

    setTimeout(() => {
        if(elements[0]) elements[0].style.transition = 'opacity 0.3s';
        if(elements[0]) elements[0].style.opacity = '1';
    }, delays[0]);

    setTimeout(() => {
        if(elements[1]) elements[1].style.transition = 'opacity 0.3s';
        if(elements[1]) elements[1].style.opacity = '1';
    }, delays[1]);

    setTimeout(() => {
        if(elements[2]) elements[2].style.transition = 'opacity 0.3s';
        if(elements[2]) elements[2].style.opacity = '1';
    }, delays[2]);

    setTimeout(() => {
        if(elements[3]) {
            elements[3].forEach(el => {
                el.style.transition = 'opacity 0.5s';
                el.style.opacity = '1';
            });
        }
    }, delays[3]);

    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });
});
