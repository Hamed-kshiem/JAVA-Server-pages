<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Produkt einfügen</title>
</head>
<body> 
   <form action="product_insert.jsp" method="post">
     <table border="0">
       <tr>
        <td>Produktnummer:</td>
        <td><input type="text" name="produktNr" /></td>
       </tr>
       <tr>
        <td>EAN-Nummer:</td>
        <td><input type="text" name="ean" /></td>
       </tr>
       <tr>
        <td>Bezeichnung:</td>
        <td><input type="text" name="bezeichnung" /></td>
       </tr>
       <tr>
        <td>Verkaufspreis:</td>
        <td><input type="text" name="verkaufsPreis" /></td>
       </tr>
       <tr>
        <td>Herstellkosten:</td>
        <td><input type="text" name="herstellKosten" /></td>
       </tr>
       <tr>
        <td>Erscheinungsjahr:</td>
        <td><input type="text" name="erscheinungsJahr" /></td>
       </tr>
     </table>
     
     <input type="submit" value="Insert"/>
   </form>
  <br />
  <a href="index.htm">Zur Startseite</a>
</body>
</html>