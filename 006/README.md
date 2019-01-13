## 検証環境

- ブラウザ
	- Internet Explorer 11.195.17763.0
	- Edge 44.17763.1.0
	- FireFox 64.0
- ソース
	- [ソースはこちら](https://github.com/sugao516/hello-world/tree/master/006 "")

## JSON オブジェクトを文字列に変換

javascript で JSON オブジェクトは以下のように記述される。

``` test.js
var json = {
	/* 1. "名前"に"値"を定義 */
	"club_name": "Foo+Bar",
	/* 2. "名前"に{オブジェクト}を定義 */
	"club": {
		"tel": "0120-345-678",
		"post": "123-4567"
	},
	/* 3. "名前"に["値"の配列]を定義 */
	"m_id": ["101", "102", "103"],
	/* 4. "名前"に[{オブジェクト}の配列]を定義 */
	"member": [
		{ "sex": "f", "age": "30" },
		{ "sex": "m", "age": "28" }
	]
};
```

それぞれの"値"には、以下のようにアクセスできる。

``` test.js
/* 1. "名前": "値" */
json.club_name = "Foo+Bar";
/* 2. "名前": {オブジェクト} */
json.club.tel = "0120-345-678";
json.club.post = "123-4567";
/* 3. "名前": ["値"の配列] */
json.m_id[0] = "101";
json.m_id[1] = "102";
json.m_id[2] = "103";
/* 4. "名前": [{オブジェクト}の配列] */
json.member[0].sex = "f";
json.member[0].age = "30";
json.member[1].sex = "m";
json.member[1].age = "28";
```

ここで、以下のような(A)JSONオブジェクトと(B)文字列の変換を考える。  
1."名前": "値"

``` test.js
"club_name": "Foo+Bar"		⇔	"club_name=Foo+Bar"
```

2."名前": {オブジェクト}

``` test.js
"club": {
	"tel": "0120-345-678",	⇔	"club.tel=0120-345-678"
	"post": "123-4567"		⇔	"club.post=123-4567"
}
```

3."名前": ["値"の配列]

``` test.js
"m_id": [
	"101",					⇔	"m_id[0]=101"
	"102",					⇔	"m_id[1]=102"
	"103"					⇔	"m_id[2]=103"
]
```

4."名前": [{オブジェクト}の配列]

``` test.js
"member": [
	{ "sex": "f",			⇔	"member[0].sex=f"
	  "age": "30" },		⇔	"member[0].age=30"
	{ "sex": "m",			⇔	"member[1].sex=m"
	  "age": "28" }			⇔	"member[1].age=28"
]
```

表にまとめると、こんな感じ。

| # | array | object | (A) JSONオブジェクト | (B) 文字列 |
|--:|:-:|:-:|:--|:--|
| 1 |  |  | "club_name": "Foo+Bar" |club_name=Foo+Bar|
| 2 |  |〇| "club": { <br>&emsp;"tel": "0120-345-678", <br>&emsp;"post": "123-4567" <br> } |club.tel=0120-345-678<br>club.post=123-4567|
| 3 |〇|  | "m_id": [<br>&emsp; "101",<br>&emsp; "102",<br>&emsp; "103"<br>] |m_id[0]=101 <br> m_id[1]=102 <br> m_id[2]=103 |
| 4 |〇|〇| "member": [<br>&emsp;{ "sex": "f", <br>&emsp;"age": "30" }, <br>&emsp;{ "sex": "m", <br>&emsp;"age": "28" } <br>] |member[0].sex=f <br> member[0].age=30 <br> member[1].sex=m <br> member[1].age=28|

### 実装

#### (A) JSON オブジェクト ⇒ (B) 文字列

``` test.js
function traverseJSON(json, keys, callback) {
	if (typeof json !== "object") {
		callback(keys, json);
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
traverseJSON(json, [], function (keys, value) {
	var name = keys.join('.');
	console.log(name + "=" + value);
});
```
#### 応用：JSON オブジェクトで form 初期化

``` test.html
<!-- ラジオボタン -->
<input type="radio" id="member1.sex.m" name="member[1].sex" value="m">男
<input type="radio" id="member1.sex.f" name="member[1].sex" value="f">女
```
``` test.js
/* 個別に設定（jquery使用）*/
$("[name='member[1].sex']").val(['m']);

/* JSONオブジェクトで設定（jquery使用）*/
var json = { "member": [{ "sex": "f", "age": "30" },{ "sex": "m", "age": "28" }]};
traverseJSON(json, [], function (keys, value) {
	var name = keys.join('.');
	$("[name='" + name + "']").val([value]);
});
```

#### (B) 文字列 ⇒ (A) JSON オブジェクト

``` test.js
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
{
	var json = { build: buildJSON };
	json.build("club_name=Foo+Bar");
	json.build("club.tel=0120-345-678");
	json.build("club.post=123-4567");
	json.build("m_id[0]=101");
	json.build("m_id[1]=102");
	json.build("m_id[2]=103");
	json.build("member[0].sex=f");
	json.build("member[0].age=30");
	json.build("member[1].sex=m");
	json.build("member[1].age=28");
	console.log(json);
}
```

#### 応用：URL パラメータを JSON オブジェクトに変換

``` test.js
function paramsToJSON(search) {
	var json = {};
	decodeURIComponent(search)
		.split(/[?&]/)
		.slice(1)
		.forEach(buildJSON, json)
	return json;
}
var json = paramsToJSON(location.search);
```

URL パラメータ（'&'毎に改行している）

```
?club_name=Foo+Bar
&club.sports=2
&club.area-2=on
&club.area-4=on
&club.tel=0120-345-678
&club.post=123-4567
&m_id[0]=101
&member[0].sex=f
&member[0].age=30
&m_id[1]=102
&member[1].sex=m
&member[1].age=28
&m_id[2]=103
&member[2].sex=f
&member[2].age=26
```

## ajax で、ローカルの JSON ファイルを読み込む

``` test.js
var response = $.ajax({ url: 'test.json', dataType: 'json', async: false });
var json = JSON.parse(response.responseText);
```

IE11 では、jquery-1.10.x までは、以下の記述が無いと、`$.ajax` がエラー（アクセスが拒否されました。）となる。
jquery-1.11.0 以降では不要。

``` test.html
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10">
```
