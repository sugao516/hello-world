/**
 * build JSON object
 *
 * @param  s {string} "key=value"
 * @param  this {json} JSON object
 */
function buildJSON(s) {
	var ka = s.split('=');
	var kb = ka[0].split('.');
	var kc = kb[0].split(/[\[\]]/);
	var x = { f: this, g: kc[0] };
	parseParam(x, kc[1], []);
	parseParam(x, kb[1], {});
	x.f[x.g] = ka[1];
}
function parseParam(x, p, n) {
	if (p !== void 0) {
		if (x.f[x.g] === void 0) {
			x.f[x.g] = n;
		}
		x.f = x.f[x.g];
		x.g = p;
	}
}

/**
 * traverse JSON object
 *
 * @param  json {json} JSON object
 * @param  keys {array} key array
 * @param  callback {function}
 */
function traverseJSON(json, keys, callback) {
	if (typeof json !== "object") {
		if (typeof json !== "function") {
			callback(keys, json);
		}
		return;
	}
	var b = Array.isArray(json);
	for (var k in json) {
		var x = keys.concat();
		if (b) {
			x[x.length - 1] += '[' + k + ']';
		} else {
			x.push(k);
		}
		traverseJSON(json[k], x, callback);
	}
}

/**
 * URL parameters to JSON object
 *
 * @param  search {string} URLパラメータ
 * @return json {json}
 */
function paramsToJSON(search) {
	var json = {};
	decodeURIComponent(search)
		.split(/[?&]/)
		.slice(1)
		.forEach(buildJSON, json)
	return json;
}

$(document).ready(function () {
	document.title = "test: " + $.fn.jquery;
	var json;
	if (location.search.length > 0) {
		var search = decodeURIComponent(location.search);
		tarea_a.value = search.replace(/&/g, "\n&");
		json = paramsToJSON(location.search);
	} else {
		var response = $.ajax({ url: 'test.json', dataType: 'json', async: false });
		json = JSON.parse(response.responseText);
	}
	traverseJSON(json, [], function (keys, value) {
		var name = keys.join('.');
		$("[name='" + name + "']").val([value]);
	});
	tarea_b.value = JSON.stringify(json, null, '  ');
	test();
});

function test() {
	{
		var j = {};
		j["club_name"] = "Foo+Bar";
		j["club"] = {};
		j["club"]["sports"] = "2";
		j["club"]["area-2"] = "on";
		j["club"]["area-4"] = "on";
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
			/* 1. "名前"に"値"を定義 */
			"club_name": "Foo+Bar",
			/* 2. "名前"に{オブジェクト}を定義 */
			"club": {
				"sports": "2",
				"area-2": "on",
				"area-4": "on",
				"tel": "0120-345-678",
				"post": "123-4567"
			},
			/* 3. "名前"に["値"の配列]を定義 */
			"m_id": ["101", "102", "103"],
			/* 4. "名前"に[{オブジェクト}の配列]を定義 */
			"member": [
				{ "sex": "2", "age": "30" },
				{ "sex": "1", "age": "28" },
				{ "sex": "2", "age": "26" }
			]
		};
		console.log(j);
	}
	{
		var j = { buildJSON: buildJSON };
		j.buildJSON("club_name=Foo+Bar");
		j.buildJSON("club.sports=2");
		j.buildJSON("club.area-2=on");
		j.buildJSON("club.area-4=on");
		j.buildJSON("club.tel=0120-345-678");
		j.buildJSON("club.post=123-4567");
		j.buildJSON("m_id[0]=101");
		j.buildJSON("m_id[1]=102");
		j.buildJSON("m_id[2]=103");
		j.buildJSON("member[0].sex=f");
		j.buildJSON("member[0].age=30");
		j.buildJSON("member[1].sex=m");
		j.buildJSON("member[1].age=28");
		j.buildJSON("member[2].sex=f");
		j.buildJSON("member[2].age=26");
		console.log(j);
		traverseJSON(j, [], function (keys, value) {
			var name = keys.join('.');
			console.log(name + "=" + value);
		});
	}
}
