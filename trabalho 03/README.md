# Dispositivo de alarme com geolocalização
**Dupla**: Leonardo Lages e Thiago Lages

Exemplo do NodeMCU rodando o cliente e LOVE2D rodando o servidor: https://www.youtube.com/watch?v=4HGvy76VeIs

---

# Instruções para rodar o cliente

  * Os arquivos .lua devem ser rodados em ordem para inicializar o sistema

  * Primeiro arquivo: "connectwifi" - faz a conexão com o wifi (configurar nome e senha no arquivo).

  * Segundo arquivo: "mqtt" - cria o cliente e trata da inscrição e publicações a serem feitas. O "id" do cliente deve ser declarado de 0 a 9.

  * Terceiro arquivo: "sendcoordinates" - declara as funções que tratam de formatar os dados do wifi e enviar o pedido para o Geolocation API.

  * Quarto arquivo: "buttonpressed" - inicializa o tratamento do único botão utilizado.

---

# Instruções para rodar o servidor

  * Basta colocar todos os arquivos na mesma pasta e rodar em LOVE2D.

  * Para fazer a requisição a algum cliente, digite o número dele (0 a 9).

  * O módulo "json" foi retirado do link abaixo e foi utilizado para converter um json string (resposta da Geolocation API) para uma tabela em lua.

  * https://gist.github.com/tylerneylon/59f4bcf316be525b30ab