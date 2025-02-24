
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
        <title>Editar</title>
    </head>
    <body>
        <%
            //Recebe o codigo 
            Int id;
            id = Integer.parseInt(request.getParameter("id"));
            //Fazer conexão com o DB
            Connection conecta;
            PreparedStatement st;
            Class.forName("com.mysql.jdbc.Driver");
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/testejsp", "root", "");
         
            //Buscar o produto pelo id
            st = conecta.preparedStatement("SELECT * FROM produto WHER id = ?");
            st = getInt(1, id);
            ResultSet resultado = st.executeQuery(); // Execulta o id.
            //verifica se o codigo foi encontrado
            if(!resultado.next()){
                out.print("Este produto não encontrado!");
            } else { // se encontrou
            
        %>
        
          <form method="post" action="alterar_produtos.jsp">
              
              <p>
                <label>Id</label>
                <input type="number" name="id" id="id" value="<%= resultado.getString("id") %>">
            </p>
            
            <p>
                <label>Descricaoo</label>
                <input type="text" name="descricao" id="descricao" size="50" maxlength="50" value="<%=resultado.getString("descricao") %>">
            </p>
            
            <p>
                <label>Data de validade</label>
                <input type="date" name="dataDeValidade" id="dataDeValidade" value="<%= resultado.getString("dataDeValidade") %>">
            </p>
            
             <p>
                <label>Data de cadastro</label>
                <input type="date" name="dataDoCadastro" id="dataDoCadastro" value="<%= resultado.getString("dataDoCadastro") %>">
            </p>
            
             <p>
                <label>Preco</label>
                <input type="number" name="preco" id="preco" placeholder="R$ 0,00" value="<%= resultado.getString("preco") %>">

            </p>
            
             <p>
                <label>Ativo</label>
                <input type="checkbox" name="ativo" id="ativo" value="<%= resultado.getString("ativo") %>">
            </p>
            
           
            <p>
                <input type="submit" value="Salvar Alteracoes">
            </p>
        </form>        
        
        <%
           
            }
                       
        %>    
      
    </body>
</html>
