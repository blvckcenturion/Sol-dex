// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Define a contract named DevToken as per the ERC20 token standards
contract TestToken {
    string public name = "Test Token";
    string public symbol = "TEST";
    uint256 public totalSupply = 1000000000000000000000000; // 1 million tokens
    uint8 public decimals = 18;

    // Create an event which will be emitted when a token is tranferred 
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    // Create an event which will be emitted when a token is approved 
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    // Create a contructor and set `balance = totalSuppy` i.e. 1 million tokens
    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    // Create a transfer function as per the ERC20 token standards
    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    
    // Create an approve function as per the ERC20 token standards
    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // Create a transferFrom function as per the ERC20 token standards
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(_value <= balanceOf[_from], "Insufficient balance");
        require(_value <= allowance[_from][msg.sender], "Insufficient allowance");
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}