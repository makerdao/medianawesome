pragma solidity ^0.4.18;

import "ds-thing/thing.sol";

contract Medianawesome is DSThing {
    struct Feed {
        uint128 val;
        uint32 zzz;
    }
    mapping (address => Feed) public feeds;
    mapping (uint8 => address) public owners;
    uint128 val;
    bool    has;
    uint8 public next = 1;
    uint8 public min = 1;

    function prod(uint128 val_, uint32 zzz_) public {
        feeds[msg.sender] = Feed(val_, zzz_);
        (val, has) = compute();
        // LogValues
    }
    function void() public {
        feeds[msg.sender].zzz = 0;
    }
    function read() public view returns (bytes32) {
        assert(has);
        return bytes32(val);
    }
    function peek() public view returns (bytes32,bool) {
        return (bytes32(val), has);
    }
    function set(address owner) public auth {
        owners[next] = owner;
        next = next + 1;
    }
    function compute() internal view returns (uint128, bool) {
        uint128[] memory wuts = new uint128[](next - 1);
        uint8 ctr = 0;
        for (uint8 i = 1; i < next; i++) {
            Feed memory feed = feeds[owners[i]];
            if (feed.zzz > now) {
                if (ctr == 0 || feed.val >= wuts[ctr - 1]) {
                    wuts[ctr] = feed.val;
                } else {
                    uint8 j = 0;
                    while (feed.val >= wuts[j]) {
                        j++;
                    }
                    for (uint8 k = ctr; k > j; k--) {
                        wuts[k] = wuts[k - 1];
                    }
                    wuts[j] = feed.val;
                }
                ctr++;
            }
        }

        if (ctr < min) {
            return (val, false);
        }

        uint128 value;
        if (ctr % 2 == 0) {
            uint128 val1 = wuts[(ctr / 2) - 1];
            uint128 val2 = wuts[ctr / 2];
            value = uint128(wdiv(add(val1, val2), 2 ether));
        } else {
            value = wuts[(ctr - 1) / 2];
        }

        return (value, true);
    }
}
