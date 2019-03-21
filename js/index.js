import Elm from '../src/Main.elm'
import slides from '../slides/slide.*.jpg'

export function main() {
    console.log("slides", slides);
    return Elm.Elm.Main.init({
        node: document.getElementById('elm'),
        flags: Object.keys(slides).map(function (key) { return [key, slides[key]]; })
    });
}

main();
