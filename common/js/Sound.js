import { Howl } from 'howler'

import bg from '../sound/bg.mp3'
import error from '../sound/error.mp3'
import hooray from '../sound/hooray.mp3'
import appear from '../sound/appear.mp3'

window.playError = function() {
    new Howl({
        src: [error]
    }).play()
}

window.playHooray = function() {
    setTimeout(()=>{
        new Howl({
            src: [hooray]
        }).play()
    }, 620)
}

window.playAppear = function() {
    new Howl({
        src: [appear]
    }).play()
}

window.playBg = function() {
    new Howl({
        loop: true,
        src: [bg],
    }).play()
}