<script setup lang="ts">
import { reactive } from 'vue';

let contactMail = reactive({ email: "[obfuscated]" });

setTimeout(() => {
    const meow = [
        "org",
        "road2fei",
        "uwunix",
        ".",
        "@"
    ];
    contactMail.email = meow[1] + meow[4] + meow[2] + meow[3] + meow[0];
}, 500);
</script>
<template>
  <h1>Vitajte na stránke tímu NNCYB</h1>
  <h2>Tu je niečo málo o nás:</h2>
  <ul class="list-disc pl-6">
    <li>
      Pochádzame zo Strednej Priemyselnej školy Jozefa Murgaša v Banskej
      Bystrici
    </li>
    <li>Meno NNCYB znamená Not Neccessarily CYB</li>
    <li>Nevieme o sebe napísať viac ako 3 súvislé vety</li>
    <br />
    <li>
      Kontaktný email: <a class="contactMail" :href="'mailto:' + contactMail.email" target="_blank">{{ contactMail.email }}</a>
    </li>
  </ul>
</template>

<style>
.contactMail {
    color:lightblue;
}
.contactMail:hover {
    text-decoration:underline;
}
</style>
