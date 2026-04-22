<script lang="ts">
export const description = 'Fotecky'
</script>

<script setup lang="ts">
import { onBeforeUnmount, onMounted, ref } from 'vue'

const baseUrl = import.meta.env.BASE_URL

const photos: { src: string, alt: string }[] = [
    { src: `${baseUrl}p1.jpg`, alt: 'Group photo one' },
    { src: `${baseUrl}p2.jpg`, alt: 'Group photo two' },
    { src: `${baseUrl}p3.jpg`, alt: 'Group photo three' },
    { src: `${baseUrl}p4.jpg`, alt: 'Group photo four' },
    { src: `${baseUrl}p5.jpg`, alt: 'Group photo five' },
    { src: `${baseUrl}p6.jpg`, alt: 'Group photo six' },
    { src: `${baseUrl}p7.jpg`, alt: 'Group photo seven' },
    { src: `${baseUrl}p8.jpg`, alt: 'Group photo eight' },
]

const galleryGrid = ref<HTMLElement | null>(null)

let activeCard: HTMLElement | null = null

function clamp(value: number, min: number, max: number) {
    return Math.min(Math.max(value, min), max)
}

function resetCard(card: HTMLElement) {
    card.style.setProperty('--photo-card-rotate-x', '0deg')
    card.style.setProperty('--photo-card-rotate-y', '0deg')
    delete card.dataset.interacting
}

function handleGalleryPointerMove(event: PointerEvent) {
    if (event.pointerType === 'touch') {
        return
    }

    const eventTarget = event.target

    if (!(eventTarget instanceof HTMLElement)) {
        return
    }

    const hoveredCard = eventTarget.closest('.gallery-card')

    if (!(hoveredCard instanceof HTMLElement)) {
        if (activeCard) {
            resetCard(activeCard)
            activeCard = null
        }

        return
    }

    if (hoveredCard !== activeCard) {
        if (activeCard) {
            resetCard(activeCard)
        }

        activeCard = hoveredCard
        activeCard.dataset.interacting = 'true'
    }

    const rect = hoveredCard.getBoundingClientRect()
    const localX = event.clientX - rect.left
    const localY = event.clientY - rect.top
    const normalizedX = (localX / rect.width) - 0.5
    const normalizedY = (localY / rect.height) - 0.5
    const rotateX = clamp(-normalizedY * 7, -4, 4)
    const rotateY = clamp(normalizedX * 9, -5, 5)

    hoveredCard.style.setProperty('--photo-card-rotate-x', `${rotateX.toFixed(2)}deg`)
    hoveredCard.style.setProperty('--photo-card-rotate-y', `${rotateY.toFixed(2)}deg`)
}

function handleGalleryPointerLeave() {
    if (!activeCard) {
        return
    }

    resetCard(activeCard)
    activeCard = null
}

onMounted(() => {
    const grid = galleryGrid.value

    if (!grid) {
        return
    }

    grid.addEventListener('pointermove', handleGalleryPointerMove, { passive: true })
    grid.addEventListener('pointerleave', handleGalleryPointerLeave)
})

onBeforeUnmount(() => {
    const grid = galleryGrid.value

    if (!grid) {
        return
    }

    grid.removeEventListener('pointermove', handleGalleryPointerMove)
    grid.removeEventListener('pointerleave', handleGalleryPointerLeave)
})
</script>

<template>
    <section class="gallery-page">
        <header class="gallery-header">
            <h1>Vychutnajte si náš fotografický talent...</h1>
        </header>

        <div ref="galleryGrid" class="gallery-grid">
            <figure v-for="photo in photos" :key="photo.src" class="gallery-card">
                <img :src="photo.src" :alt="photo.alt" loading="lazy" />
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
    --photo-card-rotate-x: 0deg;
    --photo-card-rotate-y: 0deg;
    position: relative;
    margin: 0;
    border: 1px solid var(--border);
    background: color-mix(in oklab, var(--card) 88%, black);
    overflow: hidden;
    transform:
        perspective(1100px)
        rotateX(var(--photo-card-rotate-x))
        rotateY(var(--photo-card-rotate-y))
        translateY(0);
    transform-style: preserve-3d;
    transition:
        transform 160ms ease,
        box-shadow 160ms ease;
    will-change: transform;
}

.gallery-card[data-interacting='true'] {
    box-shadow: 0 18px 32px oklch(0 0 0 / 0.18);
    transform:
        perspective(1100px)
        rotateX(var(--photo-card-rotate-x))
        rotateY(var(--photo-card-rotate-y))
        translateY(-4px);
}

.gallery-card img {
    display: block;
    width: 100%;
    aspect-ratio: 4 / 3;
    object-fit: cover;
    transform: translateZ(18px);
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
