import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Char "mo:base/Char";
import Text "mo:base/Text";
import Debug "mo:base/Debug";

actor {
    /*********************************************************************
    **
    ** Motoko Day 2 Challenge
    ** all work here is the respective work of James Nine
    ** jncrypto8@gmail.com
    **
    *********************************************************************/
    


    /*********************************************************************
    **
    ** Challenge 1
    **
    *********************************************************************/
    public func nat_to_nat8(n : Nat) : async Nat8 {
        return (Nat8.fromNat(n));
    };

    /*********************************************************************
    **
    ** Challenge 2
    **
    *********************************************************************/
    public func max_number_with_n_bits(n : Nat) : async Nat {
        let n8 : Nat = (2 ** 8);
        let n16 : Nat = (2 ** 16);
        let n32 : Nat = (2 ** 32);
        let n64 : Nat = (2 ** 64);
        
        if(n < n8) {
            return n8;
        } else if(n < n16) {
            return n16;
        } else if(n < n32) {
            return n32;
        } else {
            return n64;
        }
    };


    /*********************************************************************
    **
    ** Challenge 3
    **
    *********************************************************************/
    public func decimal_to_bits(n : Nat) : async Text {
        // array to store binary number
        var binary : Text = "";
        var binary_all : Text = "";
        var dec : Nat = n;

        // counter for binary array
        while (dec > 0) {
            // storing remainder in binary array
            binary := Nat.toText(dec % 2);
            dec := dec / 2;
            binary_all := binary # binary_all;
        };

        return binary_all;
    };

    /*********************************************************************
    **
    ** Challenge 4
    **
    *********************************************************************/
    let c : Char = 'c';
    public func capitalize_character() : async Text {
    	let num : Nat32 = Char.toNat32(c);
        // ensure to only get lowercase ASCII characters; everything else
        // is ignored
        if(num >= 97) {
            if(num <= 122) {
                let uppercase : Char = Char.fromNat32(num - 32);
    	        return(Char.toText(uppercase));
            };
        };

        return "not lowercase or invalid character";
    };

    /*********************************************************************
    **
    ** Challenge 5
    **
    *********************************************************************/
    public func capitalize_text(t : Text) : async Text {
        var newText : Text = "";

        for(char in t.chars()) {
            let num : Nat32 = Char.toNat32(char);
            // ensure to only get lowercase ASCII characters; everything else
            // is ignored
            if(num >= 97) {
                if(num <= 122) {
                    let uppercase : Char = Char.fromNat32(num - 32);
                    newText := newText # Char.toText(uppercase);
                } else {
                    newText := newText # Char.toText(char);
                };
            } else {
                newText := newText # Char.toText(char);
            };  
        };

    	return(newText);
    };

    /*********************************************************************
    **
    ** Challenge 6
    **
    *********************************************************************/
    let t6 : Text = "Hello";
    let c6 : Char = 'e';

    public func is_inside() : async Bool {
        label f for(char in t6.chars()) {
            if(char == c6) {
                return true;
            };
        };

        return false;
    };

    let t62 : Text = "Hello";
    let c62 : Char = 'a';

    public func is_inside2() : async Bool {
        label f for(char in t62.chars()) {
            if(char == c62) {
                return true;
            };
        };

        return false;
    };

    /*********************************************************************
    **
    ** Challenge 7
    **
    *********************************************************************/
    public func trim_whitespace(t : Text) : async Text {
        var cleanLeft : Text = "";
        var doneTrim = false;

        // trim all left whitespaces
        for(char in t.chars()) {
            let num : Nat32 = Char.toNat32(char);
            
            if(num != 32) {
                doneTrim := true;
            };
            
            if(doneTrim) {
                cleanLeft := cleanLeft # Char.toText(char);
            };
        };

        var cleanRight : Text = "";

        // reverse order
        for(char in cleanLeft.chars()) {
            cleanRight := Char.toText(char) # cleanRight;
        };

        var newText : Text = "";
        doneTrim := false;

        // trim all right rightspace (but in reverse)
        for(char in cleanRight.chars()) {
            let num : Nat32 = Char.toNat32(char);
            
            if(num != 32) {
                doneTrim := true;
            };
            
            if(doneTrim) {
                newText := newText # Char.toText(char);
            };
        };

        var fixedText : Text = "";

        // reverse order again
        for(char in newText.chars()) {
            fixedText := Char.toText(char) # fixedText;
        };

    	return(fixedText);
    };
    
    /*********************************************************************
    **
    ** Challenge 8
    **
    *********************************************************************/
    public func duplicated_character(t : Text) : async Text {
        var bucket : Nat32 = 0;

        // trim all left whitespaces
        for(char in t.chars()) {
            let num : Nat32 = Char.toNat32(char);

            if(bucket != num) {
                bucket := num;
            } else {
                return Char.toText(char);
            };
        };

        return t;
    };

    /*********************************************************************
    **
    ** Challenge 9
    **
    *********************************************************************/
    public func size_in_bytes(t : Text) : async Nat {
        var totalBytes : Nat = 0;

        // convert each character to binary
        for(char in t.chars()) {
            // first convert to ascii
            let num : Nat32 = Char.toNat32(char);
            
            // convert to binary
            var binary : Text = "";
            var binary_all : Text = "";
            var dec : Nat = Nat32.toNat(num);

            // counter for binary array
            while (dec > 0) {
                // storing remainder in binary array
                binary := Nat.toText(dec % 2);
                dec := dec / 2;
                binary_all := binary # binary_all;
            };

            // check to see how many 1's in front of number
            var hasOne : Nat = 0;
            var byteType : Nat = 1;
            label f for(char in t.chars()) {
                if(hasOne == 4) {
                    if(char == '1') {
                        hasOne += 1;
                    }
                } else if(hasOne == 3) {
                    if(char == '1') {
                        hasOne += 1;
                    }
                } else if(hasOne == 2) {
                    if(char == '1') {
                        hasOne += 1;
                    }
                } else if(hasOne == 1) {
                    if(char == '1') {
                        hasOne += 1;
                    }
                } else if(char == '1') {
                    hasOne += 1;
                } else {
                    break f;
                };
            };

            // assign byte number to bucket
            if(hasOne == 0) {
                // do nothing
            } else {
                byteType := hasOne;
            };

            // tally up total bytes
            totalBytes += byteType;
        };

        return totalBytes;
    };

    /*********************************************************************
    **
    ** Challenge 10
    **
    *********************************************************************/
    // not fully working yet
    let array_sort : [var Nat] = [var 2,5,3,8,4,1,9];

    public func bubble_sort() : async [Nat] {
        var i : Nat = 0;
        var j : Nat = 0;
        var size : Nat = array_sort.size();

        label outside while(i < size) {
            label inside while(j < (size - 1)) {
                if(j+1 < array_sort.size()) {
                    if(array_sort[j] > array_sort[j+1]) {
                        let bucket : Nat = array_sort[j];
                        array_sort[j] := array_sort[j+1];
                        array_sort[j+1] := bucket;
                        break inside;
                    };
                    j += 1;
                };
            };
            i += 1;
        };

        return Array.freeze(array_sort);
    };
};
