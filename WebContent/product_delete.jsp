<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Produkt löschen </title>
</head>
<body>
  <%
    // get a connection from the DataSource       	
	Context initContext = new InitialContext();
	Context envContext  = (Context)initContext.lookup("java:/comp/env");
	  
	DataSource ds = (DataSource)envContext.lookup("jdbc/myoracle");
	Connection con = ds.getConnection();
	
	con.setAutoCommit(false);
       
    // delete the product with the specified serial number
    String query = "DELETE FROM produkt WHERE produktNr = ?";
       
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    int prodNr = Integer.parseInt(request.getParameter("produktNr"));
    
    try {
      stmt = con.prepareStatement(query);
      
      // bind variables
      stmt.setInt(1, prodNr);
      
      stmt.executeUpdate();
      
      // commit the changes
      con.commit();
      
      out.println("Das Produkt mit der Produktnummer " + prodNr + " wurde erfolgreich gelöscht!");
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