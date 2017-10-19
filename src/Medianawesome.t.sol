pragma solidity ^0.4.18;

import "ds-test/test.sol";

import "./Medianawesome.sol";

contract User {
    Medianawesome med;
    function User(Medianawesome med_) public {
        med = med_;
    }
    function doProd(uint128 val, uint32 zzz) public {
        med.prod(val,zzz);
    }
}

contract MedianawesomeTest is DSTest {
    Medianawesome med;

    function setUp() public {
        med = new Medianawesome();
    }

    function testSet() public {
        assertEq(med.owners(1), 0x0);
        assertEq(uint(med.next()), 1);
        med.set(this);
        assertEq(med.owners(1), this);
        assertEq(uint(med.next()), 2);
    }

    function testOne() public {
        User u = new User(med);
        med.set(this);
        med.set(u);
        med.prod(1 ether, uint32(now + 1 days));
        u.doProd(2 ether, uint32(now + 1 days));
        var (val,has) = med.peek();
        log_named_decimal_uint('value', uint(val), 18);
        assertTrue(has);
        assertTrue(false);
    }
}
