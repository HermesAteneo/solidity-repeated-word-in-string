 pragma solidity ^0.8.0;

// SPDX-License-Identifier: Free
// https://github.com/HermesAteneo/

contract RepeatedWords {
 
    function HowManyRepeated(string memory what, string memory where) public pure returns(uint){
        uint times = 0;
        if( ContainWord( what, where ) ){
            uint whatLen = CountUTF8String(what);
            uint whereLen = CountUTF8String(where);
            
            for (uint i = 0; i < whereLen - whatLen + 1 ; i++) {
                if( ContainWord( what, Substring( where, i , i + whatLen) ) ){
                    times++;
                }
            }
        }
        return times;
    }

    function HowManyRepeatedBytes(string memory what, string memory where) public pure returns(uint){
        uint times = 0;
        if( ContainWord( what, where ) ){
            uint whatLen = BasicCount(what);
            uint whereLen = BasicCount(where);
            
            for (uint i = 0; i < whereLen - whatLen + 1 ; i++) {
                if( ContainWord( what, Substring( where, i , i + whatLen) ) ){
                    times++;
                }
            }
        }
        return times;
    }




    function BasicCount(string memory text) public pure returns (uint256) {
        return bytes(text).length;
        // 1️⃣ outputs 7  //º outputs 2  //👩‍❤️‍💋‍👩👏1️⃣❤️❤ ¨
    }


    function CountUTF8String(string memory str) public pure returns (uint256 length){
        uint i=0;
        bytes memory string_rep = bytes(str);

        while (i<string_rep.length){
            if (string_rep[i]>>7==0)
                i+=1;
            else if (string_rep[i]>>5==bytes1(uint8(0x6)))
                i+=2;
            else if (string_rep[i]>>4==bytes1(uint8(0xE)))
                i+=3;
            else if (string_rep[i]>>3==bytes1(uint8(0x1E)))
                i+=4;
            else
                //For safety
                i+=1;

            length++;
        }
    }


    function ContainWord (string memory what, string memory where) public pure returns (bool found){
        bytes memory whatBytes = bytes (what);
        bytes memory whereBytes = bytes (where);

        //require(whereBytes.length >= whatBytes.length);
        if(whereBytes.length < whatBytes.length){ return false; }

        found = false;
        for (uint i = 0; i <= whereBytes.length - whatBytes.length; i++) {
            bool flag = true;
            for (uint j = 0; j < whatBytes.length; j++)
                if (whereBytes [i + j] != whatBytes [j]) {
                    flag = false;
                    break;
                }
            if (flag) {
                found = true;
                break;
            }
        }
        return found;

    }


    function Substring(string memory str, uint startIndex, uint endIndex) public pure returns (string memory ) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(endIndex-startIndex);
        for(uint i = startIndex; i < endIndex; i++) {
            result[i-startIndex] = strBytes[i];
        }
        return string(abi.encodePacked (result) );
    }


}
