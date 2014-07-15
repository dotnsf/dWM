<%@ page language="java" contentType="text/html; charset=windows-31j"
    pageEncoding="UTF-8"%>

<%@ page import="org.w3c.dom.*" %>
<%@ page import="org.xml.sax.*" %>
<%@ page import="javax.xml.parsers.*" %>
<%@ page import="java.security.Security" %>
<%@ page import="javax.net.ssl.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="me.juge.dwm.*" %>
<%@ page import="javax.xml.parsers.*" %>
<%@ page import="org.apache.commons.httpclient.*" %>
<%@ page import="org.apache.commons.httpclient.methods.*" %>

<html>
<head>

<link rel="shortcut icon" href="favicon.ico" />
<meta http-equiv="Content-Type" content="text/html; charset=Windows-31J">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/> 
<meta name="apple-mobile-web-app-capable" content="yes" /> 
<script type="text/javascript">
<!--
  window.onload = function(){
  // for hide URL bar
  setTimeout( scrollTo, 100, 0, 1 );
}
// -->
</script>

<%
String al = "ja", title_name = "dW Mobile", pcurl = "http://www.ibm.com/developerworks/", newrssurl = "http://www.ibm.com/developerworks/format/gadgets?xs=dHyEdG9qUkBgL%2FegKSl7kj8DWTWM9QTd&xm=BK4wv0sFDEyNYApya0oYSHCaW6tHf7AaaMIQNiWBO%2FM%3D";
Enumeration enumeration = request.getHeaders( "ACCEPT-LANGUAGE" );
if( enumeration.hasMoreElements() ){
	al = ( ( String )enumeration.nextElement() ).toLowerCase();
}

if( al.startsWith( "ja" ) ){
	title_name = "dW モバイル";
	pcurl += "jp/";
	newrssurl = "http://www.ibm.com/developerworks/jp/rss/dw_dwjp.xml";
}

String ua = request.getHeader( "USER-AGENT" );
if( ua.indexOf( "Android" ) >= 0 ){
%>
<link href="//ajax.googleapis.com/ajax/libs/dojo/1.9.3/dojox/mobile/themes/android/android.css" rel="stylesheet"></link>
<%
}else{
%>
<link href="//ajax.googleapis.com/ajax/libs/dojo/1.9.3/dojox/mobile/themes/iphone/iphone.css" rel="stylesheet"></link>
<%
}
%>

<title><%= title_name %></title>
<link href="//ajax.googleapis.com/ajax/libs/dojo/1.9.3/dojox/mobile/themes/Buttons.css" rel="stylesheet"></link>

<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/dojo/1.9.3/dojo/dojo.js" djConfig="parseOnLoad: true"></script>

<script language="JavaScript" type="text/javascript">
<!--
dojo.require( "dojox.mobile.parser" );
dojo.require( "dojox.mobile" );
dojo.requireIf( !dojo.isWebKit, "dojox.mobile.compat" );
// -->
</script>

<style>
.box {
  border: 1px solid #A7C0E0;
  width: 300px;
  height: 250px;
  background-image: url( images/widget-bg.png );
  background-repeat: no-repeat;
  background-color: white;
}
</style>
</head>

<body>

<div id="settings" dojoType="dojox.mobile.View" selected="true">

<h1 align="middle" dojoType="dojox.mobile.Heading"><%= title_name %>
<div dojoType="dojox.mobile.ToolBarButton" style="float:right;" onClick="location.href='<%= pcurl %>'">PC</div>
</h1>

<ul dojoType="dojox.mobile.RoundRectList">
<!-- 
<li dojoType="dojox.mobile.ListItem" icon="images/new.png" href="./catlist.jsp?cat=new" transition="slide">New</li>
 -->
<%
try{
//	HostConfiguration hf = new HostConfiguration();
//	hf.setHost( host, port );
	
	GetMethod method = new GetMethod( newrssurl );
//	method.setHostConfiguration( hf );
	HttpClient client = new HttpClient();
//	client.getParams().setParameter( HttpMethodParams.USER_AGENT, USER_AGENT );
	
	int sc = client.executeMethod( method );
	//String xml = method.getResponseBodyAsString(); //. New で文字化け
	String xml = "";
	BufferedReader br = new BufferedReader( new InputStreamReader( method.getResponseBodyAsStream(), "UTF-8" ) );
	String s = br.readLine();
	while( s != null ){
		xml += ( s + "\n" );
		s = br.readLine();
	}
	br.close();
	
	DocumentBuilderFactory dbfactory = DocumentBuilderFactory.newInstance();
	DocumentBuilder builder = dbfactory.newDocumentBuilder();
	Document xdoc = builder.parse( new InputSource( new StringReader( xml ) ) );
	Element root = xdoc.getDocumentElement();
	NodeList list = root.getElementsByTagName( "channel" );
	Element element = ( Element )list.item( 0 );
	list = element.getElementsByTagName( "item" );
	int size = list.getLength();
	for( int i = 0; i < size; i ++ ){
		Element element0 = ( Element )list.item( i );
		
		NodeList list0 = element0.getElementsByTagName( "title" );
		Element element1 = ( Element )list0.item( 0 );
		String ititle = element1.getFirstChild().getNodeValue();

		list0 = element0.getElementsByTagName( "description" );
		element1 = ( Element )list0.item( 0 );
		String idescription = element1.getFirstChild().getNodeValue();

		list0 = element0.getElementsByTagName( "link" );
		element1 = ( Element )list0.item( 0 );
		String ilink = element1.getFirstChild().getNodeValue();
		if( ilink.indexOf( "?" ) > -1 ){
			int n = ilink.indexOf( "?" );
			ilink = ilink.substring( 0, n );
		}
		
	    String li = "<li dojoType=\"dojox.mobile.ListItem\" class=\"mblVariableHeight\" style=\"font-size:10px\"><a href=\"./article.jsp?url=" + ilink + "\" class=\"lnk\">" + ititle + "</a><br/>" + idescription + "</li>\n";
%>
<%= li %>
<%
	}
}catch( Exception e ){
//	e.printStackTrace();
}

%>
</ul>

<ul dojoType="dojox.mobile.RoundRectList">
<li dojoType="dojox.mobile.ListItem" icon="images/dw.png" href="./catlist.jsp?cat=java" transition="slide">Java</li>
<li dojoType="dojox.mobile.ListItem" icon="images/dw.png" href="./catlist.jsp?cat=linux" transition="slide">Linux</li>
<li dojoType="dojox.mobile.ListItem" icon="images/dw.png" href="./catlist.jsp?cat=oss" transition="slide">Open Source</li>
<li dojoType="dojox.mobile.ListItem" icon="images/dw.png" href="./catlist.jsp?cat=web" transition="slide">Web Development</li>
<li dojoType="dojox.mobile.ListItem" icon="images/dw.png" href="./catlist.jsp?cat=xml" transition="slide">XML</li>
<li dojoType="dojox.mobile.ListItem" icon="images/dw.png" href="./catlist.jsp?cat=agile" transition="slide">Agile</li>
<li dojoType="dojox.mobile.ListItem" icon="images/dw.png" href="./catlist.jsp?cat=mobile" transition="slide">Mobile</li>
<li dojoType="dojox.mobile.ListItem" icon="images/dw.png" href="./catlist.jsp?cat=cloud" transition="slide">Cloud</li>
</ul>

<ul dojoType="dojox.mobile.RoundRectList">
<li dojoType="dojox.mobile.ListItem" icon="images/was.png" href="./catlist.jsp?cat=websphere" transition="slide">WebSphere</li>
<li dojoType="dojox.mobile.ListItem" icon="images/im.png" href="./catlist.jsp?cat=im" transition="slide">Information Management</li>
<li dojoType="dojox.mobile.ListItem" icon="images/lotus.png" href="./catlist.jsp?cat=lotus" transition="slide">Lotus</li>
<li dojoType="dojox.mobile.ListItem" icon="images/rational.png" href="./catlist.jsp?cat=rational" transition="slide">Rational</li>
<li dojoType="dojox.mobile.ListItem" icon="images/tivoli.png" href="./catlist.jsp?cat=tivoli" transition="slide">Tivoli</li>
</ul>

</div>

</body>
</html>
