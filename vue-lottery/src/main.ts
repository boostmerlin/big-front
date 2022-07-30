import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";

const app = createApp(App);
//put any use before mount
app.use(router);

app.mount("#app");
