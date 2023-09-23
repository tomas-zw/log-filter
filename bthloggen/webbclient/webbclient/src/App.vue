<script setup>
import Items from "./components/item.vue";
import Search from "./components/search.vue";
import { ref } from "vue";
const items = ref([]);

async function getData(search) {
    const response = await fetch(`http://localhost:1337/data${search}`);
    const data = await response.json();

    items.value = data;
}
</script>

<template>
  <header>
    <!-- <img alt="Vue logo" class="logo" src="./assets/logo.svg" width="125" height="125" /> -->
        <Search :search="getData" />
  </header>

  <main>
        <p></p>
        <div class="item-wrapper">
            <Items :items="items" />
        </div>
  </main>
</template>

<style scoped>
header {
  line-height: 1.5;
}

.logo {
  display: block;
  margin: 0 auto 2rem;
}

.item-wrapper {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-top: 20px;
}
</style>
