const swiper = new Swiper('.swiper', {
    loop: false,
    spaceBetween: 20,

    slidesPerView: 1, 
    breakpoints: {
        // Quando a tela for >= 768px
        768: { slidesPerView: 2 },
        // Quando a tela for >= 1024px
        1024: { slidesPerView: 3 }
    },
    
    // If we need pagination
    pagination: {
        el: '.swiper-pagination',
        clickable: true,
        dynamicBullets: true
    },

    // Navigation arrows
    navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
    },
});