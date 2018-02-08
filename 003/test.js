function xslFunc(xslSource, xmlSource, params, elem) {

	try{
		var dom = new DOMDocument();
		var xslDoc = dom.load(xslSource, true );
		var xmlDoc = dom.load(xmlSource, false);

		var xslProc = new XSLTProcessor();
		xslProc.importStylesheet(xslDoc);
		for (var key in params) {
			xslProc.setParameter(null, key, params[key]);
		}

		var node = xslProc.transformToFragment(xmlDoc, document);
		elem.innerHTML = "";
		elem.appendChild(node);
	} catch(e) {
		elem.innerHTML = e.description;
	}
}

function DOMDocument() {

	var isIE = !window.XSLTProcessor;
	if(!isIE) {
		this.load = load;
	} else {
		this.load = loadIE;
		window.XSLTProcessor = XSLTProcessorIE;
	}

	function load(url, isXsl) {
		var request = new XMLHttpRequest();
		request.open("GET", url, false);
		request.send(null);
		return request.responseXML;
	}

	function loadIE(url, isXsl) {
		var objType = isXsl ? "Msxml2.FreeThreadedDOMDocument" : "Msxml2.DOMDocument";
		var doc = new ActiveXObject(objType);
		doc.async = false;
		doc.load(url);
		var docErr = doc.parseError;
		if (docErr.errorCode != 0) {
			var msg = "ActiveXObject error !"
			+ "<br>errorCode: " + docErr.errorCode
			+ "<br>reason: " + docErr.reason
			+ "<br>url: " + url
			+ "<br>objType: " + objType
			;
			throw new Error(msg);
		}
		return doc;
	}
}

function XSLTProcessorIE() {

	this.xslt = new ActiveXObject("Msxml2.XSLTemplate");

	this.importStylesheet = function(styleSheet) {
		this.xslt.stylesheet = styleSheet;
		this.xslProc = this.xslt.createProcessor();
	}

	this.setParameter = function(namespaceURI, localName, value) {
		this.xslProc.addParameter(localName, value);
	}

	this.transformToFragment = function(source, owner) {
		this.xslProc.input = source;
		this.xslProc.transform();
		var elem = owner.createElement(null);
		elem.innerHTML = this.xslProc.output;
		return elem;
	}
}
