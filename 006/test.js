/**
 * Get the URL parameter value
 *
 * @param  search {string} パラメータのキー文字列
 * @return  json {json} 
 */
function getParams(search) {
	var json = {};
	search = decodeURIComponent(search);
	var a = search.split(/[?&]/);
	a.forEach(function(e,i){
		if(e.length<=0) {
			return;
		}
		var ka = e.split('=');
		var kb = ka[0].split('.');
		var kc = kb[0].split(/[\[\]]/);
		var x = {f:json, g:kc[0]};
		parseParam(x, kc[1], []);
		parseParam(x, kb[1], {});
		x.f[x.g] = ka[1];
	})
    return json;
}
function parseParam(x, p, n) {
	if (p !== void 0) {
		if(x.f[x.g] === void 0){
			x.f[x.g] = n;
		}
		x.f = x.f[x.g];
		x.g = p;
	}
}

function test(a, b) {
	var search = decodeURIComponent(location.search);
	a.value = search.replace(/&/g, "\n&");
	var json = getParams(location.search);
	b.value = JSON.stringify(json, null, '  ');
	{
		var j = {};
		j["club_name"] = "Foo+Bar";
		j["club"] = {};
		j["club"]["tel"] = "0120-345-678";
		j["club"]["post"] = "123-4567";
		j["m_id"] = [];
		j["m_id"][0] = "101";
		j["m_id"][1] = "102";
		j["m_id"][2] = "103";
		j["member"] = [];
		j["member"][0] = {};
		j["member"][0]["sex"] = "2";
		j["member"][0]["age"] = "30";
		j["member"][1] = {};
		j["member"][1]["sex"] = "1";
		j["member"][1]["age"] = "28";
		j["member"][2] = {};
		j["member"][2]["sex"] = "2";
		j["member"][2]["age"] = "26";
		console.log(j);
	}
	{
		var j = {
			"club_name": "Foo+Bar",
			"club": {  "tel": "0120-345-678",  "post": "123-4567"	},
			"m_id": [ "101", "102", "103"	],
			"member": [
			  {	"sex": "2",	"age": "30"	},
			  {	"sex": "1",	"age": "28" },
			  {	"sex": "2",	"age": "26" }
			]
		};
		console.log(j);
	}
}
