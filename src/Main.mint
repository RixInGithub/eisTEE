routes {
	/ {
		Pages.setPage("main")
	}
}

store Store {
	state page = ""
	
	fun setPage (nPage : String) {
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
		<Nav/>
	}
}

component Main {
	connect Store exposing {page}
	fun render {
		case (page) {
			"main" => <PageMain/>
		}
	}
}