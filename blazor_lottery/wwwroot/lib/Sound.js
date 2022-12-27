window.playError = function() {
    new Howl({
        src: ['sound/error.mp3']
    }).play()
}

window.playHooray = function() {
    setTimeout(()=>{
        new Howl({
            src: ['sound/hooray.mp3']
        }).play()
    }, 620)
}

window.playAppear = function() {
    new Howl({
        src: ['sound/appear.mp3']
    }).play()
}

window.playSound = function(name) {
    new Howl({
        src: [`sound/${name}.mp3`]
    }).play()
}