// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.4.22 <0.7.0;

import './AttendenceRegister.sol';

contract AttendenceRegisterTest {

    // initiating an instance of AttendenceRegister
    AttendenceRegister ar;

    // beforeAll runs before all other tests
    function beforeAll() public {
    
        // creating an instance of a contract to be tested
        ar = new AttendenceRegister();
    
    }

    // testing add() using try-catch
    function testAddSuccessUsingTryCatch() public {

        try ar.add(1, "naruto", 5) returns (uint256 r) {

            Assert.equal(r, 101, "wrong roll number");

        }

        catch Error(string memory /* reason */ ) {

            // this is executed in case revert was called inside getData
            // and a reason string was provided
            Assert.ok(false, "failed with reason");

        }

        catch (bytes memory) /* low level data */ {
        
            // this is executed in case revert was used
            // or failing assertion, division by zero
            // etc inside getData
            Assert.ok(false, 'failed unexpected');

        }

    }

    // test failure case of add() using try-catch
    function testAddFailureUsingTryCatch1() public {
    
        // this will revert on require for invalid class
        try ar.add(1, 'naruto', 13) returns (uint256 r) {
        
            Assert.ok(false, 'method execution should fail');
        
        } catch Error(string memory reason) {
        
            Assert.equal(reason, 'invalid class', 'failed with unexpected reason');
        
        } catch (bytes memory) {

            Assert.ok(false, 'failed unexpected');

        }
    
    }

    // test another failure case of add using try-catch
    function testAddFailureUsingTryCatch2() public {

        // this will revert on require for wrong roll number
        try ar.add(1, 'naruto', 11) public returns(uint r) {

            Assert.ok(false, 'method execution should fail');

        } catch Error (string memory reason) {

            Assert.equal(reason, "roll number not available", "failed with unexpected reason");

        } catch (bytes memory) {

            Assert.ok(false, "failed unexpected");

        }

    }

}
