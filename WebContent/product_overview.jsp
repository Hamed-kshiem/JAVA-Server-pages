<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style>
#customers {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #0080B8;
  color: white;
}
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Produktübersicht</title>
</head>
<body>
   <table id="customers">
     <tr>
       <th>Produktnummer</th>
       <th>EAN-Nummer</th>
       <th>Bezeichnung</th>
       <th>Verkaufspreis</th>
       <th>Herstellkosten</th>
       <th>Erscheinungsjahr</th>
       <th>&nbsp;</th>
     </tr>
     <%
       // get a connection from the DataSource       	
	   Context initContext = new InitialContext();
	   Context envContext  = (Context)initContext.lookup("java:/comp/env");
	   
	   DataSource ds = (DataSource)envContext.lookup("jdbc/myoracle");
	   	   
	   Connection con = ds.getConnection();
	   
       // get all products
       String query = "SELECT produktNr, ean, bezeichnung, verkaufsPreis, herstellkosten, erscheinungsJahr FROM produkt ORDER BY produktNr";
       
       Statement stmt = null;
       ResultSet rs = null;
       
       try {
         stmt = con.createStatement();
         rs = stmt.executeQuery(query);
         
         while(rs.next()) { %>
           <tr>
             <td><%= rs.getInt(1) %></td>
             <td><%= rs.getInt(2) %></td>
             <td><%= rs.getString(3) %></td>
             <td><%= rs.getDouble(4) %></td>
             <td><%= rs.getDouble(5) %></td>
             <td><%= rs.getInt(6) %></td>
             <td><a href="product_delete.jsp?produktNr=<%= rs.getInt(1) %>">Delete</a></td>
           </tr>
         
         <%}
         
       } catch(SQLException e) {
         e.printStackTrace();
       } finally {    
    	   // Always make sure result sets and statements are closed,
    	   // and the connection is returned to the pool
    	   if (rs != null) {
    	      try { rs.close(); } catch (SQLException e) { ; }
    	      rs = null;
    	    }
    	    if (stmt != null) {
    	      try { stmt.close(); } catch (SQLException e) { ; }
    	      stmt = null;
    	    }
    	    if (con != null) {
    	      try { con.close(); } catch (SQLException e) { ; }
    	      con = null;
    	    }
       }
     %>
   </table>
  <br />
  <a href="index.htm">Zur Startseite</a>
</body>
</html>