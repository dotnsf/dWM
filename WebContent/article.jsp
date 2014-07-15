<%@ page language="java" contentType="text/html; charset=windows-31j"
    pageEncoding="UTF-8"%>

<%@ page import="org.w3c.dom.*" %>
<%@ page import="javax.xml.parsers.*" %>
<%@ page import="java.security.Security" %>
<%@ page import="javax.net.ssl.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="me.juge.dwm.*" %>
<%@ page import="javax.xml.parsers.*" %>
<%@ page import="org.apache.commons.httpclient.*" %>
<%@ page import="org.apache.commons.httpclient.methods.*" %>



<html>
<head>

<%
String title = "", body = "", url_ = request.getParameter( "url" );
if( url_ == null ) url_ = "";

String url = request.getParameter( "url" );
if( url == null ) url = "";
if( url.length() > 0 ){
	try{
		GetMethod method = new GetMethod( url );
		HttpClient client = new HttpClient();
		
		int sc = client.executeMethod( method );
//		String text = method.getResponseBodyAsString();
		String text = "";
		BufferedReader br = new BufferedReader( new InputStreamReader( method.getResponseBodyAsStream(), "UTF-8" ) );
		String s = br.readLine();
		while( s != null ){
			text += ( s + "\n" );
			s = br.readLine();
		}
		br.close();

		//. <title>
		int n1 = text.toLowerCase().indexOf( "<title" );
		int n2 = text.toLowerCase().indexOf( ">", n1 + 1 );
		int n3 = text.toLowerCase().indexOf( "</title", n2 + 1 );
		if( n1 > -1 && n2 > n1 && n3 > n2 ){
			title = text.substring( n2 + 1, n3 );
		}
		
		//. <body>
		n1 = text.toLowerCase().indexOf( "<body" );
		n2 = text.toLowerCase().indexOf( "</body", n1 + 1 );
		if( n1 > -1 && n2 > n1 ){
			body = text.substring( n1, n2 );
			
			//. <!-- CONTENT_BODY -->
			n1 = body.indexOf( "<!-- CONTENT_BODY" );
			n2 = body.indexOf( ">", n1 + 1 );
			if( n1 > -1 && n2 > n1 ){
				body = body.substring( n2 + 1 );
			}
			
			//. <!-- MAIN_COLUMN_CONTENT_END -->
			n1 = body.indexOf( "<!-- MAIN_COLUMN_CONTENT_END" );
			if( n1 > -1 ){
				body = body.substring( 0, n1 );
			}
			
			//. <a href="#...
			while( ( n1 = body.toLowerCase().indexOf( "<a href=\"#" ) ) > -1 ){
				n2 = body.toLowerCase().indexOf( "</a>", n1 + 1 );
				if( n1 > -1 && n2 > n1 ){
					body = body.substring( 0, n1 ) + body.substring( n2 + 4 );
				}
			}
			
			//. <img
			while( ( n1 = body.toLowerCase().indexOf( "<img" ) ) > -1 ){
				n2 = body.toLowerCase().indexOf( ">", n1 + 1 );
				if( n1 > -1 && n2 > n1 ){
					String alt = "", img = body.substring( n1, n2 );
					n3 = img.toLowerCase().indexOf( "alt=\"" );
					int n4 = img.toLowerCase().indexOf( "\"", n3 + 5 );
					if( n3 > -1 && n4 > n3 + 4 ){
						alt = img.substring( n3 + 5, n4 );
					}
					body = body.substring( 0, n1 ) + alt + body.substring( n2 + 1 );
				}
			}

			//. 不要な部分を取り除きつつ、
			//. プログラムコード内の改行は残す、などの配慮が必要。
			
			//. 全てのタグを取り除く
			n2 = 0;
			while( ( n1 = body.indexOf( "<", n2 ) ) > -1 ){
				n2 = body.indexOf( ">", n1 + 1 );
				String tag = body.substring( n1 + 1, n2 ).toLowerCase();
//				if( tag.startsWith( "pre" ) || ( !tag.startsWith( "p" ) && !tag.startsWith( "br" ) ) ){
				if( !tag.startsWith( "p" ) && !tag.startsWith( "br" ) && !tag.startsWith( "/pre" ) ){
					body = body.substring( 0, n1 ) + body.substring( n2 + 1 );
					n2 = n1;
				}
			}
		}
	}catch( Exception e ){
		e.printStackTrace();
	}
}
%>

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


String server = request.getRequestURL().toString();
int n1 = server.indexOf( "//" );
int n2 = server.indexOf( "/", n1 + 2 );
if( n1 > -1 && n2 > n1 ){
  server = server.substring( 0, n2 );
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
dojo.require( "dojox.mobile.parser" );
dojo.require( "dojox.mobile" );
dojo.requireIf( !dojo.isWebKit, "dojox.mobile.compat" );
</script>

</head>

<body>

<div id="settings" dojoType="dojox.mobile.View" selected="true">

<h1 align="middle" dojoType="dojox.mobile.Heading" back="Back" href="javascript:history.back();"><%= title %>
<div dojoType="dojox.mobile.ToolBarButton" style="float:right;" onClick="location.href='<%= url_ %>'">PC</div>
</h1>

<ul dojoType="dojox.mobile.RoundRectList">
<li dojoType="dojox.mobile.ListItem" class="mblVariableHeight" style="font-size:10px">
<%= body %>
</li>
</ul>

</div>
</body>
</html>
