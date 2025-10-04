// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract CharacterSheet {
    // State variables
    string name;
    uint8 age8;
    string gender;
    string class;
    uint8 level = 1;
    uint32 public xp;

    // Structs
    struct Weapons {
        string weapon;   
    }
    
    struct StatusBase {
        uint8 hp8;
        uint8 stamine8;
        uint8 mana8;
        uint8 forca8;
        uint8 inteligencia8;
        uint8 defesa8;
        uint8 agilidade8;
    }

    // Arrays and mappings
    Weapons[] public Inventory;
    mapping (string => bool) public CheckInventory;

    // Initial values
    StatusBase public beginner = StatusBase(20, 10, 5, 5, 5, 5, 5);

    // Constructor
    constructor (string memory _name, uint8 _age8, string memory _gender, string memory _class) {
        name = _name;
        age8 = _age8;
        gender = _gender;
        class = _class;
    }

    // Functions
    function getInfo() public view returns (string memory, uint8, string memory, string memory, uint8) {
        return (name, age8, gender, class, level);
    }

    function addWeapon(string memory _weapon) public {
        Inventory.push(Weapons(_weapon));
        CheckInventory[_weapon] = true;
    }

    function training() public {
        xp += 10;
    }
}
