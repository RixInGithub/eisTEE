#i_dare_you_to_find_any_SPACES
r=[]
with(open("./src/Main.mint","r"))as(codeIO):
	for(l)in(codeIO.read().split("\n")):
		while(l).startswith("\x20")or(l).startswith("\t"):l=l[1:]
		if(l).endswith("ENDROUTES"):break
		if(not(l).endswith("PARSEROUTE")):continue
		l=l[1:]
		wtsp=min([(a)for(a)in[l.find("\x20"),l.find("\t")]if-1!=a]or-1)
		if-1!=wtsp:l=l[:wtsp]+".html"
		r+=[l]
for(l)in(r):[__import__("os").makedirs(f"./dist/{"/".join(l.split("/")[:-1])}",exist_ok=True),__import__("shutil").copy2("./dist/index.html","./dist/"+l)]