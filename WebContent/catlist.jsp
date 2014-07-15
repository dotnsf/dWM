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
String al = "ja", title_name = "IBM developerWorks";
Enumeration enumeration = request.getHeaders( "ACCEPT-LANGUAGE" );
if( enumeration.hasMoreElements() ){
	al = ( ( String )enumeration.nextElement() ).toLowerCase();
}

String title = null, rssurl = null;
String cat = request.getParameter( "cat" );
if( cat == null ) cat = "new";
if( cat.equals( "new" ) ){
  title = "New";
  rssurl = ( al.startsWith( "ja" ) ? "http://www.ibm.com/developerworks/jp/rss/dw_dwjp.xml" : "http://www.ibm.com/developerworks/format/gadgets?xs=dHyEdG9qUkBgL%2FegKSl7kj8DWTWM9QTd&xm=BK4wv0sFDEyNYApya0oYSHCaW6tHf7AaaMIQNiWBO%2FM%3D" );
}else if( cat.equals( "java" ) ){
  title = "Java";
  rssurl = ( al.startsWith( "ja" ) ? "http://www.ibm.com/developerworks/jp/views/java/rss/libraryview.jsp" : "http://www.ibm.com/developerworks/views/java/rss/libraryview.jsp" );
}else if( cat.equals( "linux" ) ){
  title = "Linux";
  rssurl = ( al.startsWith( "ja" ) ? "http://www.ibm.com/developerworks/jp/views/linux/rss/libraryview.jsp" : "http://www.ibm.com/developerworks/views/linux/rss/libraryview.jsp" );
}else if( cat.equals( "oss" ) ){
  title = "OpenSource";
  rssurl = ( al.startsWith( "ja" ) ? "http://www.ibm.com/developerworks/jp/views/opensource/rss/libraryview.jsp" : "http://www.ibm.com/developerworks/views/opensource/rss/libraryview.jsp" );
}else if( cat.equals( "web" ) ){
  title = "Web Development";
  rssurl = ( al.startsWith( "ja" ) ? "http://www.ibm.com/developerworks/jp/views/web/rss/libraryview.jsp" : "http://www.ibm.com/developerworks/views/web/rss/libraryview.jsp" );
}else if( cat.equals( "xml" ) ){
  title = "XML";
  rssurl = ( al.startsWith( "ja" ) ? "http://www.ibm.com/developerworks/jp/views/xml/rss/libraryview.jsp" : "http://www.ibm.com/developerworks/views/xml/rss/libraryview.jsp" );
}else if( cat.equals( "agile" ) ){
  title = "Agile transformation";
  rssurl = ( al.startsWith( "ja" ) ? "http://www.ibm.com/developerworks/jp/views/agile/rss/libraryview.jsp" : "http://www.ibm.com/developerworks/views/agile/rss/libraryview.jsp" );
}else if( cat.equals( "mobile" ) ){
  title = "Mobile development";
  rssurl = ( al.startsWith( "ja" ) ? "http://www.ibm.com/developerworks/jp/views/mobile/rss/libraryview.jsp" : "http://www.ibm.com/developerworks/views/mobile/rss/libraryview.jsp" );
}else if( cat.equals( "cloud" ) ){
  title = "Cloud computing";
  rssurl = ( al.startsWith( "ja" ) ? "http://www.ibm.com/developerworks/jp/views/cloud/rss/libraryview.jsp" : "http://www.ibm.com/developerworks/views/cloud/rss/libraryview.jsp" );
}else if( cat.equals( "websphere" ) ){
  title = "WebSphere";
  rssurl = ( al.startsWith( "ja" ) ? "http://www.ibm.com/developerworks/jp/views/websphere/rss/libraryview.jsp" : "http://www.ibm.com/developerworks/views/websphere/rss/libraryview.jsp" );
}else if( cat.equals( "lotus" ) ){
  title = "Lotus";
  rssurl = ( al.startsWith( "ja" ) ? "http://www.ibm.com/developerworks/jp/views/lotus/rss/libraryview.jsp" : "http://www.ibm.com/developerworks/views/lotus/rss/libraryview.jsp" );
}else if( cat.equals( "im" ) ){
  title = "Information Management";
  rssurl = ( al.startsWith( "ja" ) ? "http://www.ibm.com/developerworks/jp/views/data/rss/libraryview.jsp" : "http://www.ibm.com/developerworks/views/data/rss/libraryview.jsp" );
}else if( cat.equals( "rational" ) ){
  title = "Rational";
  rssurl = ( al.startsWith( "ja" ) ? "http://www.ibm.com/developerworks/jp/views/rational/rss/libraryview.jsp" : "http://www.ibm.com/developerworks/views/rational/rss/libraryview.jsp" );
}else if( cat.equals( "tivoli" ) ){
  title = "Tivoli";
  rssurl = ( al.startsWith( "ja" ) ? "http://www.ibm.com/developerworks/jp/views/tivoli/rss/libraryview.jsp" : "http://www.ibm.com/developerworks/views/tivoli/rss/libraryview.jsp" );
}else{
%>

<%
}
%>

<title><%= title %></title>

<%
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

<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/dojo/1.9.3/dojo/dojo.js" djConfig="parseOnLoad: true"></script>

<script language="JavaScript" type="text/javascript">
<!--
dojo.require( "dojox.mobile.parser" );
dojo.require( "dojox.mobile" );
dojo.requireIf( !dojo.isWebKit, "dojox.mobile.compat" );
// -->
</script>

<style>
.lnk {
  font-size: 14px;
  color: #0B5199;
  text-decoration: none;
}
</style>
</head>

<body>

<div id="settings" dojoType="dojox.mobile.View" selected="true">

<h1 align="middle" dojoType="dojox.mobile.Heading" back="Top" href="./"><%= title %></h1>

<%
//String ul = DojoList.GetList( rssurl );

String ul = "<ul dojoType=\"dojox.mobile.RoundRectList\">\n";
try{
//	HostConfiguration hf = new HostConfiguration();
//	hf.setHost( host, port );
	
	GetMethod method = new GetMethod( rssurl );
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
	    ul += li;
	}
}catch( Exception e ){
//	e.printStackTrace();
}
ul += "</ul>\n";
%>
<%= ul %>

</div>

</body>
</html>
