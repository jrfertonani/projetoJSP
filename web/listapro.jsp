
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listagem de preodutos</title>
        
    </head>
    <body>
        <% 
        
         try{
            //Fazer conexão com o DB
            Connection conecta;
            PreparedStatement st;
            Class.forName("com.mysql.jdbc.Driver");
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/testejsp", "root", "");
            
            //Listar dados na tabela produtos no DB
            st = conecta.prepareStatement("SELECT * FROM produto ORDER By descricao");
            ResultSet rs = st.executeQuery();            
        %>
            
        <table border="1">
            <tr>
                <th>Id</th>
                <th>Descricao</th>
                <th>Data de validade</th>
                <th>Data de cadastro</th>
                <th>Preço</th>
                <th>Ativo</th>
            </tr>
        
        <%
            while(rs.next()){
        %>
            
            <tr>
                <td><%= rs.getString("id") %></td>
                <td><%= rs.getString("descricao") %></td>
                <td><%= rs.getString("dataDeValidade") %></td>
                <td><%= rs.getString("dataDeCadastro") %></td>
                <td><%= rs.getString("preco") %></td>
                <td><%= rs.getString("ativo") %></td>
                <td><a href="excpro.jsp?codigo=<%=rs.getString("id")%>">Excluir</td>
                <td><a href="editarpro.jsp?codigo=<%=rs.getString("id")%>">Excluir</td>
            </tr>                
                
        <%
            }
        %>
        
        </table>
        
        <%
            }catch(Exception x){
            out.print("Erro: " + x.getMessage());            
            }
        
        %>
    </body>
</html>
