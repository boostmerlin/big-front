<script lang="ts">
import "common/css/Row.css";
// component is just a object, with some lifecycle methods and options

// Component provided template option but runtime compilation is not supported in this build of Vue.
// Configure your bundler to alias "vue" to "vue/dist/vue.esm-bundler.js"
//动态编译需要在vite.config.js添加vue alias
export default {
  template: `
        <div class="Row">
            <slot></slot>
        </div>
    `,
};
</script>
