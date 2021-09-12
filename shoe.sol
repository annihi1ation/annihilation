pragma solidity >=0.5.0 <0.7.0;
pragma experimental ABIEncoderV2;
contract Shoe{
    
    struct Attributes{
        string qr_1;
        string qr_2;
        string qr_3;
        
        string shoe_name;
    }
    Attributes attrs;
    
    function set_attrs(string memory _qr_1, string memory _qr_2, string memory _qr_3, string memory _shoe_name) public{
        attrs = Attributes(_qr_1, _qr_2, _qr_3, _shoe_name);
    }
    
    constructor() public{
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
        emit owner_transfer(address(0), owner);
    }
    
    function get_attrs() public view returns (string[] memory){
        string[] memory foo = new string[](4);
        foo[0] = attrs.qr_1;
        foo[1] = attrs.qr_2;
        foo[2] = attrs.qr_3;
        foo[3] = attrs.shoe_name;
        
        return foo;
    }
    function string_compare(string memory a, string memory b) public view returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }
    
    
    function check_attrs(string memory _qr_1, string memory _qr_2, string memory _qr_3) public view returns(bool){
        return (string_compare(attrs.qr_1, _qr_1) && string_compare(attrs.qr_2, _qr_2) && string_compare(attrs.qr_3, _qr_3));
    }
    
    address owner;
    
    event owner_transfer(address old_one, address new_one);
    
    modifier is_owner(){
        require(msg.sender == owner, "owner invalid");
        _;
    }
    
    function change_owner(address new_one) public is_owner{
        emit owner_transfer(owner, new_one);
        owner = new_one;
    }
    
    function get_owner() external view returns(address){
        return owner;
    }
}
