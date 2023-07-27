let hooks = {}

hooks.key = {
  mounted() {
    let input = document.getElementById('message-input')
    input.addEventListener('keypress', e => {
      if (e.code == 'Enter') {
        if (e.ctrlKey) {
          this.pushEvent('send_message', {message: {message: e.target.value}})
          e.target.value = ''
        } else {
          e.preventDefault()
          return false;
        }
      }
    }, false)
  }
}

hooks.scroll = {
  mounted() {
    var scrollBox = document.getElementById('scroll-box')
    scrollBox.scrollTop = scrollBox.scrollHeight
    // let target = document.getElementById('scroll-box').lastElementChild
    // target.scrollIntoView(false)
  },
  updated() {
    var scrollBox = document.getElementById('scroll-box')
    scrollBox.scrollTop = scrollBox.scrollHeight
    // let target = document.getElementById('scroll-box').lastElementChild
    // target.scrollIntoView(false)
  }
}

export default hooks
