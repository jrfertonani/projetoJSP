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
        <title>JSP Page</title>
    </head>
    <body>
        <%              
            //receber os dados no formulario cadpro.html
            
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
            
            try{
            //Fazer conexão com o DB
            Connection conecta;
            PreparedStatement st;
            Class.forName("com.mysql.jdbc.Driver");
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/testejsp", "root", "");
            //Inserir dados na tabela produtos no DB
            st = conecta.prepareStatement("INSERT INTO produto(descricao, dataDeValidade, dataDeCadastro, preco, ativo) VALUES (?, ?, ?, ?, ?)");
            st.setString(1, descricao);
            st.setDate(2, new java.sql.Date(dataDeValidade.getTime()));
            st.setDate(3, new java.sql.Date(dataDeCadastro.getTime()));
            st.setDouble(4, preco);
            st.setBoolean(5, ativo);
            st.execute(); // Executa o comando INSERT
            st.close();
            conecta.close();
            out.print("Product created!!!!");
            
            }catch(Exception x){
            out.print("Erro: " + x.getMessage());            
            }
            

            %>
    </body>
</html>
