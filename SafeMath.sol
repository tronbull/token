pragma solidity >=0.4.22 <0.6.0; //solidity version

/**
 * @title SafeMath
 * @dev Math operations with safety checks that revert on error
 */
library SafeMath {
   
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;

        return c;
    }


    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);

        return c;
    }
    
    
    function mul(uint256 a, uint256 b) public pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }
    
    function div(uint256 a, uint256 b) public pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
    
   function getTronBase(uint256 numerator, uint256 denominator) public pure returns(uint256){
         uint256 _numerator  = mul(numerator,10 ** uint256(6));
         uint256 _quotient = div(_numerator,denominator);
         return _quotient;
    }
    
    
    function tronProcess(uint256 _value) public pure  returns(uint256){
      uint256 divider = 1*10**uint256(18);
      return getTronBase(_value,divider);
    }

   
}