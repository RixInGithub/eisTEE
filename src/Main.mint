routes {
	/ {
		Pages.setPage("main")
	}
}

store Store {
	state page = ""
	
	fun setPage (_page : String) {
		next { page = _page }
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
		<Nav/>
	}
}

component Main {
	connect Store exposing {page}
	get content {
		case (page) {
			"main" => 
		}
	}
}