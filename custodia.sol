//SPDX-License-Identifier: CC-BY-4.0


//contrato sepolia: 0x8F6d00211115C05E7A99048Acd3bFaBf70eB8CF9

pragma solidity 0.8.19;

import "contracts/exercicio/bradesco_token_aberto.sol" ;

contract CustodiaToken {

string public  nomeCliente;
uint256 public agenciaCliente;
uint256 public contaCliente;
uint256 private saldoEther;

ExercicioToken exercicioToken;


constructor (string memory _nomeCliente, uint256 _agenciaCliente, uint256  _contaCliente){
    
   
    nomeCliente = _nomeCliente;
    agenciaCliente = _agenciaCliente;
    contaCliente = _contaCliente;
    exercicioToken = ExercicioToken(0x89A2E711b2246B586E51f579676BE2381441A0d0);
    
}
    event Depositar(address from, uint amount);
    
 
    function meuSaldo() public view returns (uint256){
    return exercicioToken.balanceOf(address(this));

    }

    function gerarTokenParaEuCliente (uint256 quantidade) public {
    exercicioToken.mint(address(this), quantidade);

    }

 
   function transfereToken(uint256 quantidade, address destino) public payable  
   
    {
      
       require(exercicioToken.balanceOf(address(this)) >= quantidade, "Saldo insuficiente para a transacao");
       exercicioToken.transfer(destino, quantidade);
       
    } 

    function depositarEther() public payable {
        emit Depositar(msg.sender, msg.value);
    }
    
    function retornaSaldoEther() public view returns (uint256){
        
       return address(this).balance;
    }
   
    function transfereEther(address enderecoDestino, uint256 valorEther) public  {
        require(address(this).balance >= valorEther, "Saldo insuficiente para a transacao");
        payable(enderecoDestino).transfer(valorEther);
        
    }
}



