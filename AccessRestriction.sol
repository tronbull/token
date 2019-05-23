pragma solidity >=0.4.22 <0.6.0;

contract AccessRestriction {

    address internal super_admin;
    
    mapping(address => mapping(string => bool)) internal roles;
    
    constructor() public{
       super_admin = msg.sender;
    }
    
    modifier onlySuperAdmin(){
        require(super_admin == msg.sender);
        _;
    }

    function assignRole (address entity, string role) public onlySuperAdmin {
        require(entity != address(0));
        require(!has(entity, role));
      roles[entity][role] = true;
    }
  
    function unassignRole (address entity, string role) public onlySuperAdmin {
        require(entity != address(0));
        require(has(entity, role));
        roles[entity][role] = false;
    }
    
    function has(address entity,string role) public view returns(bool){
        require(entity != address(0));
        return roles[entity][role];
    }
  
    modifier hasRole (string role) {
     require(roles[msg.sender][role] == true);
        _;
  }
}