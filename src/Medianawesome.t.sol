pragma solidity ^0.4.18;

import "ds-test/test.sol";

import "./Medianawesome.sol";

contract MedianawesomeTest is DSTest {
    Medianawesome medianawesome;

    function setUp() public {
        medianawesome = new Medianawesome();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
