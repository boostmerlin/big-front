import { Component, PropsWithChildren } from 'react'
import './app.css'

import 'common/js/Sound'

class App extends Component<PropsWithChildren> {

  componentDidMount () {}

  componentDidShow () {
    console.log('app did show')
    window.playBg()
  }

  componentDidHide () {}

  render () {
    // this.props.children 是将要会渲染的页面
    return this.props.children
  }
}

export default App

