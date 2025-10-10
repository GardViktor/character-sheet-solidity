// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract CharacterSheet {
    // State variables
    string private nameChar;
    string private class;
    // Background
    uint8 public level = 1;
    string private race;
    // Alignment
    string private gender;
    uint8 private age8;
    string private namePlayer;
    uint32 public xp32;
    
    struct Weapons {
        string weapon;   
    }
    
    struct StatusBase {
        uint8 hp8;
        uint8 stamina8;
        uint8 mana8;
        uint8 str8;
        uint8 intel8;
        uint8 def8;
        uint8 agi8;
    }

    Weapons[] public Inventory;
    mapping(string => bool) public CheckInventory;
    mapping(string => StatusBase) public classes;

    uint32[] private xpArray = [
        0, 300, 900, 2700, 6500, 14000, 23000, 34000, 48000, 64000,
        85000, 100000, 120000, 140000, 165000, 195000, 225000, 265000, 305000, 355000
    ];

    constructor(string memory _nameChar, string memory _class, string memory _race, string memory _gender, uint8 _age8, string memory _namePlayer) {
        nameChar = _nameChar;
        class = _class;
        race = _race;
        gender = _gender;
        age8 = _age8;
        namePlayer = _namePlayer;
        
        // Define os status base de cada classe
        classes["Artificer"] = StatusBase(13,12,14,10,16,12,10);
        classes["Barbarian"] = StatusBase(18,16,4,18,6,16,8);
        classes["Bard"] = StatusBase(12,10,14,8,12,10,14);
        classes["Cleric"] = StatusBase(14,12,14,10,12,14,10);
        classes["Druid"] = StatusBase(13,10,15,8,14,12,10);
        classes["Fighter"] = StatusBase(16,14,6,16,8,14,10);
        classes["Monk"] = StatusBase(13,16,6,12,10,10,18);
        classes["Paladin"] = StatusBase(16,12,10,16,10,16,8);
        classes["Ranger"] = StatusBase(14,14,8,12,10,12,16);
        classes["Rogue"] = StatusBase(12,14,6,10,10,10,18);
        classes["Sorcerer"] = StatusBase(10,8,18,6,18,8,10);
        classes["Warlock"] = StatusBase(11,10,17,8,17,9,11);
        classes["Wizard"] = StatusBase(10,8,18,6,20,8,10);
    }

    function getInfo() public view returns (string memory, string memory, uint8, string memory, string memory, uint8, string memory, uint32) {
        return (nameChar, class, level, race, gender, age8, namePlayer, xp32);
    }

    function addWeapon(string memory _weapon) public {
        Inventory.push(Weapons(_weapon));
        CheckInventory[_weapon] = true;
    }

    function getStatus() public view returns (StatusBase memory) {
        return classes[class];
    }

    function gainXp(uint32 amount) public {
        xp32 += amount;
        if (xp32 > 355000) xp32 = 355000;
        levelUp();
    }

    function levelUp() private {
        uint8 newLevel = 1;
        for (uint8 i = uint8(xpArray.length); i > 0; i--) {
            if (xp32 >= xpArray[i - 1]) {
                newLevel = i;
                break;
            }
        }
        if (newLevel > level) level = newLevel;
    }
}

