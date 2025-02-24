<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Excluir</title>
    </head>
    <body>
        <%
            //Recebendo o id do formulario
            int id;
            id = Integer.parseInt(request.getParameter("id"));
        try{  
            //Conecta no bd
             Class.forName("com.mysql.jdbc.Driver");
             Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/testejsp", "root", "");
             //Exclui o produto celecionado
             PreparedStatement st = conecta.preparedStatement("DELETE FROM produtos WHERE id=:? ");
             st.setInt(1, id); // Executa o manando DELETE
             
             int resultado = st.executeUpdate();
             //verifica se o id foi encontrado ou não
             if(resultado == 0){
             out.print("Codigo não encontrado!");
            }else{
            out.print("O produto de codigo " + id + "foi excluido com sucesso!");
            }
           }catch (Exception erro){
                String mensagemErro = erro.getMessage();
                out.print("Entre em contato com o suporte " + mensagemErro);
            }
        %>
    </body>
</html>
