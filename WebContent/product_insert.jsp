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
<title>Produkt einfügen</title>
</head>
<body>
  <%
    // get a connection from the DataSource       	
	Context initContext = new InitialContext();	  
	DataSource ds = (DataSource)initContext.lookup("java:/comp/env/jdbc/myoracle");
	Connection con = ds.getConnection();
    
	con.setAutoCommit(false);
	
    // insert the product
    String query = "INSERT INTO produkt(produktNr, ean, bezeichnung, verkaufsPreis, herstellKosten, erscheinungsJahr)" + 
        " VALUES(?,?,?,?,?,?)";
       
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    try {
      int produktNr = Integer.parseInt(request.getParameter("produktNr"));
      int ean = Integer.parseInt(request.getParameter("ean"));
      String bezeichnung = request.getParameter("bezeichnung");
      double verkaufsPreis = Double.parseDouble(request.getParameter("verkaufsPreis"));
      double herstellKosten = Double.parseDouble(request.getParameter("herstellKosten"));
      int erscheinungsJahr = Integer.parseInt(request.getParameter("erscheinungsJahr"));
      
      stmt = con.prepareStatement(query);
      
      // bind variables
      stmt.setInt(1, produktNr);
      stmt.setInt(2, ean);
      stmt.setString(3, bezeichnung);
      stmt.setDouble(4, verkaufsPreis);
      stmt.setDouble(5, herstellKosten);
      stmt.setInt(6, erscheinungsJahr);
       
      stmt.executeUpdate();

      // commit the changes
      con.commit();
      
      out.println("Das Produkt mit der Produktnummer " + produktNr + " wurde erfolgreich eingefügt!");
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