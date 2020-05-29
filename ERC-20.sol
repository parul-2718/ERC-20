pragma solidity ^0.4.21;


contract EIP20Interface {
    mapping(address => uint256) balances;
mapping(address => mapping (address => uint256)) allowed;
    uint256 public totalSupply;
    constructor(uint256 total) public {
   totalSupply = total;
   balances[msg.sender] = totalSupply;
}
    
    function balanceOf(address _owner) public view returns (uint256 balance){
        return balances[_owner];
    }

    
    function transfer(address _to, uint256 _value) public returns (bool ){
        require(_value<=balances[msg.sender]);
        balances[msg.sender]=balances[msg.sender] - _value;
        balances[_to] = balances[_to] + _value;
        emit Transfer(msg.sender,_to, _value);
        return true;
    }

    
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool ){
        require(_value<=balances[_from]);
        require(_value<=allowed[_from][msg.sender]);
        balances[_from]= balances[_from] - _value;
        allowed[_from][msg.sender]=allowed[_from][msg.sender] - _value;
        balances[_to] = balances[_to]+ _value;
        Transfer(_from, _to, _value);
        return true;
    }

   
    function approve(address _spender, uint256 _value) public returns (bool){
        allowed[msg.sender][_spender]=_value;
        emit Approval(msg.sender,_spender,_value);
        return true;
    }

    
    function allowance(address _owner, address _spender) public view returns (uint ){
        return allowed[_owner][_spender];
    }

    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}