<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Alterar produto</title>
    </head>
    <body>
        <%
            //receber os dados ALTERADOS no formulario editarpro.jsp
            String descricao;
            Date dataDeValidade;
            Date dataDeCadastro;
            Double preco;
            Boolean ativo;
            
            descricao = request.getParameter("descricao");
            
            String dataValidadeStr = request.getParameter("dataDeValidade");
            String dataCadastroStr = request.getParameter("dataDeCadastro");
            // Converter para Date (usar diretamente no banco)
            SimpleDateFormat formatoEntrada = new SimpleDateFormat("yyyy-MM-dd");
            dataDeValidade = formatoEntrada.parse(dataValidadeStr);
            dataDeCadastro = formatoEntrada.parse(dataCadastroStr);
            // formato brasileiro
            SimpleDateFormat formatoSaida = new SimpleDateFormat("dd/MM/yyyy");
            String dataValidadeFormatada = formatoSaida.format(dataDeValidade);
            String dataCadastroFormatada = formatoSaida.format(dataDeCadastro);
                           
            String precoStr = request.getParameter("preco").replace(",", ".");
            preco = Double.parseDouble(precoStr);
            
            String ativoStr = request.getParameter("ativo");
            ativo = (ativoStr != null && ativoStr.equals("on")); 
             //Fazer conexão com o DB
            Connection conecta;
            PreparedStatement st;
            Class.forName("com.mysql.jdbc.Driver");
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/testejsp", "root", "");
            //Alterar produtos
            st = conecta.preparedStatement("UPDATE produto SET descricao = ?, dataDeValidade = ?, dataDeCadastro = ?, preco = ?, ativo = ?, WHERE id = ? ");
            st.setString(1, descricao);
            st.setDate(2, new java.sql.Date(dataDeValidade.getTime()));
            st.setDate(3, new java.sql.Date(dataDeCadastro.getTime()));
            st.setDouble(4, preco);
            st.setBoolean(5, ativo);
            st.execute(); // Executa o comando UPDATE
            st.close();
            conecta.close();
            out.print("Product atualizado "+ descricao + "!!!!");
            
            
            
        %>
        
        
    </body>
</html>
