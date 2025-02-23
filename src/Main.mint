routes {
	/ { // we dont need PARSEROUTE on this since index.html is preincluded
		Store.setPage("main")
	}
	/not_found { // PARSEROUTEHTML
		Store.setPage("guh?")
	}
	/*
		/src/index // PARSEROUTEHTML
	*/
	/src/ {
		Store.setPage("sResults")
	}
} // ENDROUTES

store Store {
	state page = "guh?"
	state endpnt = "https://eistee.x10.bz/index.php"
	fun setPage (nPage : String) {
		`
window.api=function($a){return(function($b,$e,$f,$g,$h,$k){return[$a=Object.entries($a).map(function(_){return""+_.map(encodeURIComponent).join("=")}).join("&"),$b=Reflect.construct(Image,[]),$b.crossOrigin="anonymous",$b.src="#{endpnt}?"+$a,Reflect.construct(Promise,[function($c,$d){[$b.addEventListener("load",function(){[$e=document.createElement("canvas"),$e.width=$b.width,$e.height=$b.height,$e=$e.getContext("2d"),$e.drawImage($b,0,0),$b.remove(),$f=$e.getImageData(0,0,$b.width,$b.height).data,$g=Reflect.construct(DataView,[$f.buffer.slice(0,4)]),$g.setUint8(3,0),$g=$g.getUint32(0,1),$f=$f.slice(4,(($g+3-($g%3))*4)/3+5),$h=Array(($f.length/4)*3),"console.log(\"sacred\x20variable\x20$h:\",$h)",Array($f.length/4).fill(0).map(function(_,$ind){return[$ind*4,$ind*3]}).forEach(function([$ind,$j]){$k=0;while($k<3){($h[$j+$k]=$f[$ind+$k]);$k+=1}}),$c(JSON.parse(Reflect.construct(TextDecoder,[]).decode(Reflect.construct(Uint8Array,[$h]).buffer).slice(0,$g)))]}),$b.addEventListener("error",function(...$e){$b.remove()&&$d(...$e)}),document.head.appendChild($b)]}])][4]})()}
		`
		/* window.api(params)
			Execute an API request to var endpnt (defined in line 12) and manuever with the response so much, an image turns into fucking JSON idek how
		*/
		next { page: nPage }
	}
}

component Nav {
	style bar {
		display: flex;
		flex-direction: column;
		gap: 8px;
		padding: 16px;
		background-color: #061f60;
		color: White;
		margin: auto;
		border-bottom-left-radius: 16px;
		border-bottom-right-radius: 16px;
	}

	style c {
		align-self: center;
	}

	style menu {
		display: flex;
		flex-direction: row;
		gap: inherit;
	}

	style icn {
		text-decoration: none;
		color: inherit;
	}

	fun render {
		<nav::bar> // get it? navbar?
			<form::c::menu action="/src/">
				<strong>"eisTEE"</strong>
				<input name="q" placeholder="wie man eistee macht..."/>
			</form>
			<div::menu>
				<div::menu></div>
				<div::menu></div>
				<div::menu>
					<a::icn href="/login/" class="fa fa-sign-in"/>
				</div>
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
		border: 2px solid CurrentColor;
		border-right: 0;
		font: inherit;
		font-size: 90%;
		padding: 2px;
		width: 100%;
		outline: 0;
		text-align: left;

		&::placeholder, &::-webkit-placeholder {
			font-style: italic;
			text-align: center;
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
		background-color: Black;
		color: White;
		cursor: pointer;
	}

	style inpCnt {
		display: flex;
		flex-direction: row;
	}

	fun render {
		<>
			<style>"body>div>div{display: flex;flex-direction: column;}"</style>
			<form::f::tC action="/src/">
				<h1::tC>"eisTEE"</h1>
				<div::inpCnt>
					<input::i name="q" placeholder="wie man eistee macht..."/>
					<button::btn class="fa fa-search"/>
				</div>
			</form>
		</>
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

component PageSrc {
	fun render {
		"wip"
	}
}

component DecisivePage {
	connect Store exposing {page}
	fun render {
		case (page) {
			"main" => <PageMain/>
			"sResults" => <PageSrc/>
			=> <PageGuhhhh/>
		}
	}
}

component Main {
	style page {
		height: 100%;
		display: flex;
		flex-direction: column;
	}

	style uppermost {
		--font: "Lucida Sans", "Lucida Sans Unicode", "Lucida Grande", Tahoma, sans-serif;
		--fSiz: 10.5pt;
		font: var(--fSiz) var(--font);
		height: 100%;
	}

	fun render {
		<div::uppermost>
			<Nav/>
			<div::page><DecisivePage/></div>
		</div>
	}
}
