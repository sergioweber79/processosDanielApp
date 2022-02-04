<!-- Sergio Weber -->
<html>
<head>
<title>Processos Daniel APP (Candidato: Sergio Weber)</title>
<meta charset="utf-8"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<META HTTP-EQUIV="EXPIRES" CONTENT="Mon, 22 Jul 2002 11:12:01 GMT">


<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>



</head>
<body>
<h2>Processos Daniel APP (Candidato: Sergio Weber)</h2>
<br/>
<form id="frmmenu"></form>
	<input type="button" id="btnWIPO" value="Processos WIPO" title="Consultar/Cadastrar Processos site WIPO"/>
	<input type="button" id="btnDaniel" value="Consultar Processos" title="Consultar Processos Cadastrados "/>
</form>
<br/>
<br/>
<div id="processosWipo">
	<h4>Processos WIPO</h4><br/>
	<input type="text" placeholder="Processo WIPO" id="txtConsWIPO"/>
	<input type="button" id="btnConsWIPO" value="Consultar" title="Consultar Processos site WIPO"/>
</div>

<div id="processosDaniel">
	<h4>Processos</h4>
	<input type="text" placeholder="Processo Cadastrado" id="txtProcessoConsDaniel"/><br/><br/>
	<input type="text" placeholder="Requerente" id="txtRequerenteConsDaniel"/><br/><br/>
	<input type="button" id="btnConsDaniel" value="Consultar" title="Consultar Processos"/>
	
</div>

<div id="processosWipoDetail">
	<h4>Processos WIPO Detalhes</h4><br/>
	<label for="numeroPublicacao">numeroPublicacao</label> <input type="text" id="numeroPublicacao"/><br/><br/>
	<label for="numneroPedidoInternacional">numneroPedidoInternacional</label> <input type="text" id="numeroPedidoInternacional"/><br/><br/>
	<label for="numneroPedidoInternacional">dtPublicacao</label> <input type="text" id="dtPublicacao"/><br/><br/>
	<label for="numneroPedidoInternacional">requerentes</label> <input type="text" id="requerentes" size="200"/><br/><br/>
	<label for="numneroPedidoInternacional">titulo</label> <input type="text" id="titulo" size="200"/><br/><br/>
	<input type="button" id="btnSalvarWIPO" value="Salvar" title="Salvar Processos site WIPO"/>
	
</div>

<div id="processosDanielDetail">
	<h4>Processos detalhes</h4><br/><br/>
	<div id="tbProcesos">
	</div>
</div>


</body>
<script type="text/javascript">

function escondeTodasDivs(){
	

	$("#processosWipo").hide();
	$("#processosDaniel").hide();
	
	$("#processosWipoDetail").hide();
	$("#processosDanielDetail").hide();
}

$(document).ready(function(){
	
	escondeTodasDivs();
	
	
	$("#btnWIPO").on('click', function(){
		
		$("#processosWipo").show();
		$("#processosDaniel").hide();
		$("#processosDanielDetail").hide();
	});
	
	$("#btnDaniel").on('click', function(){
		$("#processosWipo").hide();
		$("#processosWipoDetail").hide();
		$("#processosDaniel").show();
		
		
	});
	
	$("#btnConsWIPO").on('click', function(){
		
		

		if ($('#txtConsWIPO').val()){
			var retorno=null;
			
			 $.ajax({
		         url:  'http://localhost:8080/processosDanielApi/processowipo/wipo/'+$('#txtConsWIPO').val(),
		         method: "GET",
		         success:    function(data) {
		        	 			retorno= data;
		                         },
		         async:      false,
		         error: function(data) {
		        	 	retorno=data;
		                 },
		         dataType:   "json"	                 
		     });
	
	
			 if (retorno.numeroPublicacao){
				 $('#numeroPublicacao').val(retorno.numeroPublicacao);
				 $('#numeroPedidoInternacional').val(retorno.numeroPedidoInternacional);
				 $('#dtPublicacao').val(retorno.dtPublicacao);
				 $('#requerentes').val(retorno.requerentes);
				 $('#titulo').val(retorno.titulo);
				 $("#processosWipoDetail").show();			 
			 }else{
				 alert("Não foi possivel consultar o processo!");
			 }
	
		}else{
			alert('Informe o processo para consultar!');
		}
		
		
		
		
	});
	
	$("#btnConsDaniel").on('click', function(){
		
		
		var url=null;
		if ($('#txtProcessoConsDaniel').val() && $('#txtRequerenteConsDaniel').val()){
			url='http://localhost:8080/processosDanielApi/processodaniel/numeropublicacao/'+$('#txtProcessoConsDaniel').val()+'/requerentes/'+$('#txtRequerenteConsDaniel').val();
		}else if ($('#txtProcessoConsDaniel').val()){
			url='http://localhost:8080/processosDanielApi/processodaniel/numeropublicacao/'+$('#txtProcessoConsDaniel').val()
		}else if ($('#txtRequerenteConsDaniel').val()){
			url='http://localhost:8080/processosDanielApi/processodaniel/requerentes/'+$('#txtRequerenteConsDaniel').val()
		}
		if (url){
			var retorno=null;
			
			 $.ajax({
		         url:  url,
		         method: "GET",
		         success:    function(data) {
		        	 			retorno= data;
		                         },
		         async:      false,
		         error: function(data) {
		        	 	retorno=data;
		                 },
		         dataType:   "json"	                 
		     });
	
	
			 if (retorno){
				 
				 var arrayJson = eval(retorno);
				 var tabela = criarTabelaProcessos(arrayJson);
				 document.getElementById("tbProcesos").innerHTML = tabela;
				 $("#processosDanielDetail").show();
			 }else{
				 alert("Não foi possivel consultar o processo!");
			 }
	
		}else{
			alert('Informe o numero ou requernte para consultar!');
		}
		
		
		
		
	});
	
	
	
	
	
	$("#btnSalvarWIPO").on('click', function(){
		
			
		
		    if ($('#numeroPublicacao').val() && 
		    		$('#numeroPedidoInternacional').val() && 
		    		$('#dtPublicacao').val() && 
		    		$('#requerentes').val() && 
		    		$('#titulo').val() ){
		    	
		    
		    	
		    	var dtPub = $('#dtPublicacao').val();
		    	
		    	dtPub = dtPub.substring(6, 10)+'-'+dtPub.substring(3, 5)+'-'+dtPub.substring(0, 2);
			
				var djson='{';
				
				djson=djson+'"numeroPublicacao":'+'"'+$('#numeroPublicacao').val()+'"'+',';
				djson=djson+'"numeroPedidoInternacional":'+'"'+$('#numeroPedidoInternacional').val()+'"'+',';
				
				djson=djson+'"dtPublicacao":'+'"'+dtPub+'"'+',';
				djson=djson+'"requerentes":'+'"'+$('#requerentes').val()+'"'+',';
				djson=djson+'"titulo":'+'"'+$('#titulo').val()+'"'+',';
				
				djson=djson.substring(0, djson.length-1); 
				
				djson=djson+'}';
				
				var retorno=null;
				
				 $.ajax({
			         url:  'http://localhost:8080/processosDanielApi/processodaniel/add',
			         data: djson,
			         method: "POST",
			         success:    function(data) {
			        	 			retorno=data;
			                         },
			         async:      false,
			         error: function(data) {
			        	 	retorno=data;
			                 },
			         contentType: "application/json;charset=utf-8",			                 
			         dataType:   "json"
			     });
		
		
				 if (retorno.numeroPublicacao){
					 escondeTodasDivs();
					 alert("Processo Salvo com Sucesso!");
					 
				 }else{
					 alert("Não foi possivel salvar o processo!");
				 }
		
		    }else{
		    	alert('Informe os campos do processo para salvar!');
		    }
		
		
		
	});
	

});

function criarTabelaProcessos(arrayJson){
	 var tabela="<table border='1'>";
	 tabela+= '<thead>';
		
	 tabela+='<tr>';
	 tabela+='<th>Num. Publicacao</th>';
	 tabela+='<th>Num. Pedido Internacioanal</th>';
	 tabela+='<th>DtPublicaco</th>';
	 tabela+='<th>Requerentes</th>';
	 tabela+='<th>Titulo</th>';
	 tabela+='</tr>';
	 tabela+='</thead>';
	 for (var j = 0; j < arrayJson.length; j++) {
		 
		 tabela+=' <tr>  ';
		 tabela+=' <td>'+arrayJson[j].numeroPublicacao+'</td> ';
		 tabela+=' <td>'+arrayJson[j].numeroPedidoInternacional+'</td> ';
		 tabela+=' <td>'+arrayJson[j].dtPublicacao+'</td> ';
		 tabela+=' <td>'+arrayJson[j].requerentes+'</td> ';
		 tabela+=' <td>'+arrayJson[j].titulo+'</td> ';
		 tabela+=' </tr> ';
		 
	 }
	 tabela+='</tbody>';
	
	 return tabela;	
}

</script>
</html>
