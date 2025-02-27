routes {
	/* routeparsing doesnt cover most holes
		/src/index // PARSEROUTEHTML
		/login/index // PARSEROUTEHTML
	*/
	/ { // we dont need PARSEROUTE on this since index.html is preincluded
		Store.setPage("main")
	}
	/not_found { // PARSEROUTEHTML
		Store.setPage("guh?")
	}
	/src/ {
		Store.setSrc(SearchParams.fromString(Window.url().search) |> SearchParams.get("q")) // this returns a `Maybe(String)` which is ideal!
	}
	/login/ {
		Store.setPage("login")
	}
} // ENDROUTES

module API {
	fun call (query : Object) { // i wonder if this succeeds (hell yeah it did)
		`(function($a){return(function($b,$e,$f,$g,$h,$k){return[$a=Object.entries($a).map(function(_){return""+_.map(encodeURIComponent).join("=")}).join("&"),$b=Reflect.construct(Image,[]),$b.crossOrigin="anonymous",$b.src="#{Store.endpnt}?"+$a,Reflect.construct(Promise,[function($c,$d){[$b.addEventListener("load",function(){[$e=document.createElement("canvas"),$e.width=$b.width,$e.height=$b.height,$e=$e.getContext("2d"),$e.drawImage($b,0,0),$b.remove(),$f=$e.getImageData(0,0,$b.width,$b.height).data,$g=Reflect.construct(DataView,[$f.buffer.slice(0,4)]),$g.setUint8(3,0),$g=$g.getUint32(0,1),$f=$f.slice(4,(($g+3-($g%3))*4)/3+5),$h=Array(($f.length/4)*3),"console.log(\"sacred\x20variable\x20$h:\",$h)",Array($f.length/4).fill(0).map(function(_,$ind){return[$ind*4,$ind*3]}).forEach(function([$ind,$j]){$k=0;while($k<3){($h[$j+$k]=$f[$ind+$k]);$k+=1}}),$c(JSON.parse(Reflect.construct(TextDecoder,[]).decode(Reflect.construct(Uint8Array,[$h]).buffer).slice(0,$g)))]}),$b.addEventListener("error",function(...$e){$b.remove()&&$d(...$e)}),document.head.appendChild($b)]}])][4]})()})(#{query})`
	}
}

module Utils {
	fun jsonToMap (json : String) {
		decode Json.parse(json) as Map
	}

	fun mapToJSON (map : Map) {
		Json.stringify(encode map)
	}
}

store Store {
	state page = "guh?"
	state endpnt = "https://eistee.x10.bz/index.php"
	state src = ""

	fun setPage (nPage : String) {
		next { page: nPage }
	}

	fun setSrc (maybe : Maybe(String)) {
		case maybe {
			Maybe.Just(nSrc) => {
				Store.setPage("sResults")
				next { src: nSrc }
			}
			=> Window.jump("/")
		}
	}
}

component Nav {
	style bar {
		display: flex;
		flex-direction: row;
		row-gap: 4px;
		padding: 2px 4px;
		background-color: #061f60;
		color: White;
		justify-content: space-between;
		align-items: center;
	}

	style menu {
		display: flex;
		flex-direction: row;
		gap: 4px;
		align-items: center;
		
		& * {text-decoration: none;color: inherit;}
	}
	
	style i {
		font: inherit;
		font-size: 80%;
		border: 1px solid CurrentColor;
		border-right: 0;
		padding: 1px;
		outline: 0;
		background-color: Transparent;
		width: 145px;
		
		&::placeholder, &::-webkit-placeholder {
			font-style: italic;
			text-align: center;
			color: inherit;
			opacity: 0.8;
		}
	}

	style b {
		border: 1px solid CurrentColor;
		background-color: Transparent;
		padding: 0;
		width: 21px;
		cursor: pointer;
		font-size: 0.8em;
	}

	style inpCont {gap: 0;align-items: stretch;}

	fun render {
		<nav::bar> // get it? navbar?
			<form::menu action="/src/">
				<strong><a href="/">"eisTEE"</a></strong>
				<div::menu::inpCont>
					<input::i name="q" placeholder="wie man eistee macht..."/>
					<button::b class="fa fa-search"/>
				</div>
			</form>
			<div::menu>
				<a href="/login/" class="fa fa-sign-in"/>
			</div>
		</nav>
	}
}

component PageMain {
	style f {
		margin-top: 5% !important;
		display: flex;
		flex-direction: column;
		align-self: center;
		width: 50%;
	}

	style i {
		color: inherit;
		border: 2px solid CurrentColor;
		border-right: 0;
		font: inherit;
		font-size: 90%;
		padding: 2px;
		width: 100%;
		outline: 0;
		text-align: left;
		background-color: Black;

		&::placeholder, &::-webkit-placeholder {
			font-style: italic;
			text-align: center;
			color: inherit;
			opacity: 0.8;
		}
	}

	style tC {
		text-align: center;
		margin-top: 0;
	}

	style btn {
		flex-shrink: 0;
		width: 28px;
		text-align: center;
		border: 0;
		padding: 0;
		background-color: White;
		color: Black;
		cursor: pointer;
	}

	style inpCnt {
		display: flex;
		flex-direction: row;
	}

	fun render {
		<form::f::tC action="/src/">
			<h1::tC style="margin-bottom:2.5%">"eisTEE"</h1>
			<div::inpCnt>
				<input::i name="q" placeholder="wie man eistee macht..."/>
				<button::btn class="fa fa-search"/>
			</div>
		</form>
	}
}

async component PageSrc {
	// bump

	fun render {
		Json.stringify(API.call(encode {"action": "src", "q": "#{(`encodeURIComponent(#{Store.src})`)}"}))
	}
}

component PageLogin {
	fun render {
		"wip"
	}
}

component PageGuhhhh {
	style c {
		align-self: center;
	}

	fun render {
		<>
			<style>"body>div>div>nav+div{justify-content:center}"</style>
			<div::c>
				<h1>404</h1>
				<p>"Page not found, try again later or check the spelling of the URL."</p>
				<p>"This may also happen because of a broken link from an older website."</p>
			</div>
		</>
	}
}

component DecisivePage {
	connect Store exposing {page}
	fun render {
		case (page) {
			"main" => <PageMain/>
			"sResults" => <PageSrc/>
			"login" => <PageLogin/>
			=> <PageGuhhhh/>
		}
	}
}

component Main {
	style a {
		height: 100%;
		display: flex;
		flex-direction: column;
	}

	style uppermost {
		--font: "Lucida Sans", "Lucida Sans Unicode", "Lucida Grande", Tahoma, sans-serif;
		--fSiz: 10.5pt;
		font: var(--fSiz) var(--font);
	}

	style page {
		background-color: #606da0;
		color: White;
	}

	fun render {
		<div::a::uppermost>
			<Nav/>
			<div::a::page><DecisivePage/></div>
		</div>
	}
}
