import { createSSRApp } from "vue";
import App from "./App.vue";
// import routes from "./router";

export function createApp() {
  const app = createSSRApp(App);
  // app.use(routes);
  return {
    app,
  };
}
