<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BestellPos einfügen</title>
</head>
<body>
   <form action="BP_TO_LI_insert.jsp" method="post">
     <table border="0">
       <tr>
        <td>Anzahl:</td>
        <td><input type="text" name="Anzahl_der_Lieferung" /></td>
       </tr>
       <tr>
        <td>TrackingID:</td>
        <td>
          <% 
       // get a connection from the DataSource       	
   		Context initContext = new InitialContext();	  
   		DataSource ds = (DataSource)initContext.lookup("java:/comp/env/jdbc/myoracle");
   		Connection con = ds.getConnection();
       
   		con.setAutoCommit(false);
   	
      
          
       PreparedStatement stmt = null;
       ResultSet rs = null;
       
       
       %>
        <%  
      String query2 = "SELECT TrackingID FROM BestellPos";
          
       stmt = con.prepareStatement(query2);
       rs = stmt.executeQuery(query2);
       %>
       <select name ="BestellPos" size="1">
       <%  while(rs.next()){ %>
           <option><%= rs.getInt(1)%></option>
       <% } %>
       </select>
        
        </td>
       </tr>
          <tr>
        <td>Lieferung:</td>
        <td>
          <% 
       // get a connection from the DataSource       	
   		Context initContext2 = new InitialContext();	  
   		DataSource ds2 = (DataSource)initContext2.lookup("java:/comp/env/jdbc/myoracle");
   		Connection con2 = ds2.getConnection();
       
   		con2.setAutoCommit(false);
   	
      
          
       PreparedStatement stmt2 = null;
       ResultSet rs2 = null;
       
       
       %>
        <%  
      String query22 = "SELECT Liefernummer FROM Lieferung";
          
       stmt2 = con2.prepareStatement(query22);
       rs2 = stmt2.executeQuery(query22);
       %>
       <select name ="Lieferung" size="1">
       <%  while(rs2.next()){ %>
           <option><%= rs2.getInt(1)%></option>
       <% } %>
       </select>
        
        </td>
       </tr>
     </table>
     
   
     
     <input type="submit" value="Insert"/>
   </form>
  <br />
  <a href="index.htm">Zur Startseite</a>
</body>
</html>