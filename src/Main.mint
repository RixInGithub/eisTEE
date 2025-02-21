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