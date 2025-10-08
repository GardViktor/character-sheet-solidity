// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract CharacterSheet {
    // State variables
    string name;
    uint8 age8;
    string gender;
    string class;
    uint8 public level = 1;
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

    uint32[] private xpArray = [
        0,       // nível 1
        300,     // nível 2
        900,     // nível 3
        2700,    // nível 4
        6500,    // nível 5
        14000,   // nível 6
        23000,   // nível 7
        34000,   // nível 8
        48000,   // nível 9
        64000,   // nível 10
        85000,   // nível 11
        100000,  // nível 12
        120000,  // nível 13
        140000,  // nível 14
        165000,  // nível 15
        195000,  // nível 16
        225000,  // nível 17
        265000,  // nível 18
        305000,  // nível 19
        355000   // nível 20
    ];

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

    function gainXp(uint32 amount) public {
        xp += amount;

        // trava o XP máximo
        if (xp > 355000) {
            xp = 355000;
        }

        levelUp();
    }

    function levelUp() private {
        uint8 newLevel = 1;

        for (uint8 i = uint8(xpArray.length); i > 0; i--) {
            if (xp >= xpArray[i - 1]) {
                newLevel = i;
                break; // encontrou o nível, sai do loop
            }
        }

        // atualiza somente se o nível subiu
        if (newLevel > level) {
            level = newLevel;
        }
    }
}
