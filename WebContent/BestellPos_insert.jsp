<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bestellung einfügen</title>
</head>
<body>
  <%
    // get a connection from the DataSource       	
	Context initContext = new InitialContext();	  
	DataSource ds = (DataSource)initContext.lookup("java:/comp/env/jdbc/myoracle");
	Connection con = ds.getConnection();
    
	con.setAutoCommit(false);
	
    // insert the product
    String query = "INSERT INTO BestellPos(TrackingID, PosNr,Menge,EinzelPreis,bestelleinheit,Bestellung,Produkt)" + 
        " VALUES(?,?,?,?,?,?,?)";
       
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    
    try {
      int TrackingID = Integer.parseInt(request.getParameter("TrackingID"));
      int PosNr =      Integer.parseInt(request.getParameter("PosNr"));
      int Menge =      Integer.parseInt(request.getParameter("Menge"));
      double EinzelPreis = Double.parseDouble(request.getParameter("EinzelPreis"));
      String bestelleinheit = request.getParameter("bestelleinheit");
      int Bestellung = Integer.parseInt(request.getParameter("Bestellung"));
      int Produkt =    Integer.parseInt(request.getParameter("Produkt"));
 
      System.out.println("1");
      stmt = con.prepareStatement(query);

      // bind variables
      stmt.setInt(1, TrackingID);
      stmt.setInt(2, PosNr);
      stmt.setInt(3, Menge);
      stmt.setDouble(4, EinzelPreis);
      stmt.setString(5, bestelleinheit);
      stmt.setInt(6, Bestellung);
      stmt.setInt(7, Produkt);
      System.out.println("2");

      stmt.executeUpdate();
      System.out.println("3");

      // commit the changes
      con.commit();
      
      out.println("Das BestellPos mit der TrackingID " + TrackingID + " wurde erfolgreich eingefügt!");
    } catch(SQLException e) {
      out.println("Error: " + e.getMessage());
      con.rollback();
      e.printStackTrace();
    } catch(Exception e) {
      out.println("Error: " + e.getMessage());
      con.rollback();
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
  <br />
  <a href="product_overview.jsp">Zur Produktübersicht</a>

</body>
</html>