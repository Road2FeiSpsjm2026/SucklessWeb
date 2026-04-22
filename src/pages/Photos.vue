<script lang="ts">
export const description = 'Fotecky'
</script>

<script setup lang="ts">
const baseUrl = import.meta.env.BASE_URL

const photos: { src: string, alt: string, title: string }[] = [
    { src: `${baseUrl}p1.jpg`, alt: 'Group photo one', title: 'Fotecka 1' },
    { src: `${baseUrl}p2.jpg`, alt: 'Group photo two', title: 'Fotecka 2' },
    { src: `${baseUrl}p3.jpg`, alt: 'Group photo three', title: 'Fotecka 3 [Tu sme sa už poniektorí veľmi nudili]' },
    { src: `${baseUrl}p4.jpg`, alt: 'Group photo four', title: 'Fotecka 4' },
    { src: `${baseUrl}p5.jpg`, alt: 'Group photo five', title: 'Fotecka 5' },
    { src: `${baseUrl}p6.jpg`, alt: 'Group photo six', title: 'Fotecka 6' },
    { src: `${baseUrl}p7.jpg`, alt: 'Group photo seven', title: 'Fotecka 7' },
    { src: `${baseUrl}p8.jpg`, alt: 'Group photo eight', title: 'Fotecka 8' },
]
</script>

<template>
    <section class="gallery-page">
        <header class="gallery-header">
            <h1>Vychutnajte si náš fotografický talent...</h1>
        </header>

        <div class="gallery-grid">
            <figure v-for="photo in photos" :key="photo.src" class="gallery-card">
                <img :src="photo.src" :alt="photo.alt" loading="lazy" />
                <figcaption>{{ photo.title }}</figcaption>
            </figure>
        </div>
    </section>
</template>

<style scoped>
.gallery-page {
    display: grid;
    gap: 1rem;
}

.gallery-header {
    display: grid;
    gap: 0.35rem;
}

.gallery-header p {
    color: var(--muted-foreground);
}

.gallery-grid {
    display: grid;
    gap: 0.85rem;
    grid-template-columns: repeat(4, minmax(0, 1fr));
}

.gallery-card {
    margin: 0;
    border: 1px solid var(--border);
    background: color-mix(in oklab, var(--card) 88%, black);
    overflow: hidden;
}

.gallery-card img {
    display: block;
    width: 100%;
    aspect-ratio: 4 / 3;
    object-fit: cover;
    border-bottom: 1px solid var(--border);
}

.gallery-card figcaption {
    padding: 0.55rem 0.65rem;
    font-size: 0.85rem;
    color: var(--muted-foreground);
}

@media (max-width: 700px) {
    .gallery-grid {
        grid-template-columns: repeat(2, minmax(0, 1fr));
    }
}

@media (max-width: 480px) {
    .gallery-grid {
        grid-template-columns: 1fr;
    }
}
</style>