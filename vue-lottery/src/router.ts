import { createRouter, createWebHistory, RouteRecordRaw } from "vue-router";
import PrizeTake from "./views/PrizeTake.vue";
import PrizeConfig from "./views/PrizeConfig.vue";

const routes: RouteRecordRaw[] = [
  {
    path: "/configure",
    component: PrizeConfig,
  },
  {
    path: "/take",
    component: PrizeTake,
  },
  {
    path: "/:pathMatch(.*)",
    redirect: "/configure",
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
