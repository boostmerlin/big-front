# taro.js

[通过命令创建](https://uniapp.dcloud.net.cn/quickstart-cli.html)
`npx @tarojs/cli init taro-lottery`

## get started

`npm i &&　npm run dev:h5`

## 迁移修改

* 组件替换为taro的基础组件(H5下不替换也可，但是要编译到不同平台的话需要)
* app.ts -> index.ts, index.tsx -> app.tsx
* config页没有样式, 子元素选择器不生效, 修改为类选择器

## 坑

* .LotteryView input 子元素选择器不生效

## Know issues

* 仅在h5上测试
* 背景声音不能播放 即使交互后也不能播放，发现和文件有关，其它文件可以播放，可能太大？(The AudioContext was not allowed to start. It must be resumed (or created) after a user gesture on the page.)
* 打包时候为什么会把common package中的bg.mp3, hooray.mp3拷贝到taro-lottery目录下？

## TODO

* 适配到其它平台
