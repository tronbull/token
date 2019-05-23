pragma solidity >=0.4.22 <0.6.0; 

import "./AccessRestriction.sol";
import "./SafeMath.sol";
import "./TRC20.sol";
import "./Pausable.sol";

contract BullToken is TRC20,AccessRestriction,Pausable {
    
    using SafeMath for uint256; 
    
    address owner_address;
    mapping(address => uint256) unclaimed;
    mapping(address => uint256) balances;
 
 
    string public constant symbol = "Bull";
    string public constant name = "TRONBULL";
    uint256 public constant decimals = 6;
    uint256 private  _totalSupply =  100000000000000  ;// 10 crore * 1000000
    uint256 private  _miningSupply = 60000000000000; // 6 crore * 1000000
    
    mapping (address => mapping (address => uint256)) private _allowed;
    
    
    constructor() public {
      owner_address = msg.sender;   
      balances[owner_address] = _totalSupply; 
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }
    
    function unclaimedBalanceOf(address _address) public view returns(uint256){
        return unclaimed[_address];
    }

    function balanceOf(address _address) public view returns (uint256) {
        return balances[_address];
    }
    
    function getMiningSupply() public view returns(uint256){
        return _miningSupply;
    }
    
    
     /*Get Address Balance*/
    function getAddressBalance(address _address) public view returns (uint256) {
       return _address.balance;
    }
    
    function getOwner() public view returns(address){
        return owner_address;
    }
    
    
    
    function getTotalBalance(address _address) public view returns (uint256){
        return unclaimedBalanceOf(_address).add(balanceOf(_address));
    }


    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowed[owner][spender];
    }

    
    function transfer(address to, uint256 value) public whenNotPaused returns (bool) {
        require(to != address(0));
        balances[msg.sender] = balances[msg.sender].sub(value);
        balances[to] = balances[to].add(value);
        emit Transfer(msg.sender, to, value);
        return true;
    }
    
    function approve(address spender, uint256 value) public whenNotPaused returns (bool) {
        require(spender != address(0));
        _allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 tokens) public whenNotPaused returns (bool) {
        balances[from] = balances[from].sub(tokens);
        _allowed[from][msg.sender] = _allowed[from][msg.sender].sub(tokens);
        balances[to] = balances[to].add(tokens);
        emit Transfer(from, to, tokens);
        return true;
    }


    function increaseAllowance(address spender, uint256 addedValue) public whenNotPaused returns (bool) {
        require(spender != address(0));
        _allowed[msg.sender][spender] = _allowed[msg.sender][spender].add(addedValue);
        return true;
    }

    
    function decreaseAllowance(address spender, uint256 subtractedValue) public whenNotPaused returns (bool) {
        require(spender != address(0));
        _allowed[msg.sender][spender] = _allowed[msg.sender][spender].sub(subtractedValue);
        return true;
    }
    
    
    /*Setters*/
    
    function setBalance(address _address, uint256 _value) public whenNotPaused hasRole('token') {
        balances[_address] = _value;
    }
    
    function setTotalSupply(uint256 _value) public whenNotPaused hasRole('token') {
        _totalSupply = _value;
    }
    
    function setUnclaimedBalance(address _address,uint256 _value) public whenNotPaused hasRole('token') {
        unclaimed[_address] = _value;
    }
    
    function setMiningSupply(uint256 _value) public whenNotPaused hasRole('token') {
        _miningSupply = _value;
    }
    
    
}