# uni-app

[通过命令创建](https://uniapp.dcloud.net.cn/quickstart-cli.html)
`npx degit dcloudio/uni-preset-vue#vite-ts uniapp-lottery`
一个vite + ts + vue3的工程，即node模式
然后将vue-lottery移植过来

这种方式的编译器是在工程目录内

## get started

`npm i &&　npm run dev:h5`

## 迁移修改

* 组件替换为uni-app的基础组件(H5下不替换也可，但是要编译到不同平台的话需要)
* icon 使用uni-ui里的
* 不支持运行时编译，如Row.vue组件, 需要修改为SFC
* h函数似乎渲染不了uni-icons
* 修改ReadPacket.css中的var(--ani-time) 为常量

## 坑

* @dcloudio/vite-plugin-uni 内置了vite依赖，和package.json指定的vite版本会造成冲突, npm i 报错

* `npx @dcloudio/uvm alpha` 执行升级会报错 2023年2月18日20:25:52

* 执行 `npx @dcloudio/uvm` 后在hbuildx 支行会报错 Cannot start service: Host version "0.16.17" does not match binary version "0.15.18"，点击运行会使用hbuilx本身的插件编译，和文档说明不符

* 红包自定的css动画没有生效(css 变量不起作用),修改为直接写死

## Know issues

* 仅在h5上测试

## TODO

* 适配到其它平台
