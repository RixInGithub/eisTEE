routes {
	/ { // we dont need PARSEROUTE on this since index.html is preincluded
		Store.setPage("main")
	}
	/not_found { // PARSEROUTE
		Store.setPage("guh?")
	}
} // ENDROUTES

store Store {
	state page = "guh?"
	fun setPage (nPage : String) {
		`
window.api=function($a){return[eval("var\x20$b,$e,$f,$g,$h,$k"),$a=Object.entries($a).map(function(_){return""+_.map(encodeURIComponent).join("=")}).join("&"),$b=Reflect.construct(Image,[]),$b.crossOrigin="anonymous",$b.src="https://eistee.x10.bz/index.php?"+$a,Reflect.construct(Promise,[function($c,$d){[$b.addEventListener("load",function(){[$e=document.createElement("canvas"),$e.width=$b.width,$e.height=$b.height,$e=$e.getContext("2d"),$e.drawImage($b,0,0),$b.remove(),$f=$e.getImageData(0,0,$b.width,$b.height).data,$g=Reflect.construct(DataView,[$f.buffer.slice(0,4)]),$g.setUint8(3,0),$g=$g.getUint32(0,1),$f=$f.slice(4,(($g+3-($g%3))*4)/3+5),$h=Array(($f.length/4)*3),"console.log(\"sacred\x20variable\x20$h:\",$h)",Array($f.length/4).fill(0).map(function(_,$ind){return[$ind*4,$ind*3]}).forEach(function([$ind,$j]){$k=0;while($k<3){($h[$j+$k]=$f[$ind+$k]);$k+=1}}),$c(JSON.parse(Reflect.construct(TextDecoder,[]).decode(Reflect.construct(Uint8Array,[$h]).buffer).slice(0,$g)))]}),$b.addEventListener("error",function(...$e){$b.remove()&&$d(...$e)}),document.head.appendChild($b)]}])][4]}
		`
		// window.api()
		next { page: nPage }
	}
}

component Nav {
	fun render {
		<nav>
			<img src="https://eistee.x10.bz/index.php" referrerpolicy="origin"/>
			"testing"
		</nav>
	}
}

component PageMain {
	fun render {
		<>
			<Nav/>
		</>
	}
}

component PageGuhhhh {
	fun render {
		<>
			<Nav/>
			"404"
		</>
	}
}

component Main {
	connect Store exposing {page}
	fun render {
		case (page) {
			"main" => <PageMain/>
			=> <PageGuhhhh/>
		}
	}
}