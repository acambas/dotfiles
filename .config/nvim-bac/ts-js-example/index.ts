console.info("Hello via Bun!");
if (1 <= 2) {
	console.log("1 <= 2");
}
for (const zxc of [1, 2, 3]) {
	console.log(zxc);
}
class Foo {
	sdf: string;
	bar: number = 0;
	conttructor() {
		this.sdf = "zxc";
	}
}
console.log("asd");
console.log("idemooo");
import qwe from "./qwe.ts";
console.info(qwe);
console.log("ideoooo");

const a = new Foo();

a.sdf = "qwe";
a.sdf = "zxc";
const b = new Foo();
b.bar = 123;
b.sdf = "sfdg";
b.bar = 123;

function sasa() {
	console.log(b);
	console.log("idemoosdfsdf");
}

sasa();
