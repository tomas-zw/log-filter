<script setup>
import { ref } from "vue";

const props = defineProps({
  search: Function,
});
const ip = ref("");
const url = ref("");
const month = ref("");
const day = ref("");
const time = ref("");

</script>

<template>
    <div class="search-wrapper">

        <div>
            <label>ip:</label>
            <input class="input-field" type="text" v-model="ip" />
            <button class="red" @click.stop="search(`?ip=${ip}`)">Search</button>
            <label>url:</label>
            <input class="input-field" type="text" v-model="url" />
            <button class="red" @click.stop="search(`?url=${url}`)">Search</button>
            <label>All items: </label>
            <button class="red" @click.stop="search(``)">Search</button>
        </div>
        <div>
            <label>month:</label>
            <input class="input-field" type="text" v-model="month" />
            <button @click.stop="search(`?month=${month}`)">Search</button>
            <label>day:</label>
            <input class="input-field" type="text" v-model="day" />
            <button @click.stop="search(`?day=${day}`)">Search</button>
            <label>time:</label>
            <input class="input-field" type="text" v-model="time" />
            <button @click.stop="search(`?time=${time}`)">Search</button>
        </div>
        <div class="pad">
            <label>month/day/time</label>
            <button @click.stop="search(`?month=${month}&day=${day}&time=${time}`)">Search</button>
            <label>day/time</label>
            <button @click.stop="search(`?day=${day}&time=${time}`)">Search</button>
        </div>

    </div>
</template>

<style scoped>
.item {
    border: 1px solid green;
    padding: 5px;
}

.input-field {
    margin-right: 5px;
}

.pad {
    margin-left: 20px;
}

label {
    display: block;
}

.search-wrapper {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
}
</style>
