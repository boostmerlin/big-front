# BLAZOR LOTTERY

未完成  

### 优点
* 框架优秀，c#优秀，支持server端渲染和WASM
* blazor.server官方说性能不错（应该比rails好）

### 缺点

* 资料少，全靠官方文档
* 兼容性不好，ToC的不太适合，ToB应该没有什么问题
* 生态少，库少
* hotreload不好用，很多改变要重启才生效
* blazor.wasm 目前加载慢
  
## ENV

on mac:  
`brew install dotnet`

`ln  common/css/* blazor_lottery/wwwroot/css/lottery/`

on win:  
install your self

.NET SDK:
 Version:   6.0.109

this app is create with:
`dotnet new blazorserver -o blazor_lottery --no-https -f net6.0`

## Run

`dotnet watch`

automatic open browser for you

## Mod

use <https://ant-design-blazor.gitee.io/>

1. add new razor component  

dotnet new razorcomponent -n RAZOR_COM_NAME -o DIR_NAME
