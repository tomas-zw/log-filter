<script setup>
const props = defineProps({
  items: Array,
});
</script>

<template>
    <div class="item" v-for="item in items">
        <p>{{ item.ip }}</p>
        <p>{{ item.url }}</p>
        <p>{{ item.month }} - {{ item.day }} - {{ item.time }}</p>
    </div>
</template>

<style scoped>
.item {
    border: 1px solid green;
    padding: 5px;
    min-width: 300px;
}
</style>
