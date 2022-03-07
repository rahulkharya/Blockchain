const assert = require('assert');
const web3 = require('web3');

const RWD = artifacts.require('RWD');
const Tether = artifacts.require('Tether');
const DecentralBank = artifacts.require('DecentralBank');

require('chai')
.use(require('chai-as-promised'))
.should()

contract('DecentralBank', ([owner, investor]) => {

    let tether, rwd

    function tokens(number) {
        return web3.utils.toWei(number, 'ether')
    }

    beforeEach(async () => {

        tether = await Tether.new()
        rwd = await RWD.new()
        decentralBank = await DecentralBank.new(tether.address, rwd.address)

        // transferring 1 milion tokens to decentral bank
        await rwd.transfer(decentralBank.address, tokens('1000000'))

        // transferring 100 tokens to investor
        await tether.transfer(
            investor, 
            tokens('100'),
            { from: owner }
            )

    })

    describe('Mock Tether Deployment', async() => {

        it('matches name successfully', async () => {

            const name = await tether.name()
            assert.equal(name, 'Mock Tether Token')

        })

        it('matches symbol successfully', async () => {

            const symbol = await tether.symbol()
            assert.equal(symbol, 'USDT')

        })
})


    describe('Mock RWD Deployment', async() => {

        it('matches name successfully', async () => {

            const name = await rwd.name()
            assert.equal(name, 'Reward Token')

        })

        it('matches symbol successfully', async () => {

            const symbol = await rwd.symbol()
            assert.equal(symbol, 'RWD')

        })

    })


    describe('Decentral Bank Deployment', async () => {

        it('matches name successfully', async() => {

            const name = await decentralBank.name()
            assert.equal(name, 'Decentral Bank')

        })

        it('contract has tokens', async () => {

            let balance = await rwd.balanceOf(decentralBank.address)
            assert.equal(balance, tokens('1000000'))

        })

    })


    describe('Yield Farming', async () => {

        it('rewards tokens for staking', async () => {

            let result

            // check investor balance
            result = await tether.balanceOf(investor)
            assert.equal(result.toString(), tokens('100'), 'investor mock wallet balance before staking')

            // check staking for investor of 100 tokens
            await tether.approve(decentralBank.address, tokens('100'), {from: investor})
            await decentralBank.depositTokens(tokens('100'), {from: investor})

            // check updated balance of investor
            result = await tether.balanceOf(investor)
            assert.equal(result.toString(), tokens('0'), 'investor mock wallet balance after staking')

            // check updated balance of decentral bank
            result = await tether.balanceOf(decentralBank.address)
            assert.equal(result.toString(), tokens('100'), 'decentral bank mock wallet balance after staking')
            
            // is staking balance
            result = await decentralBank.isStaking(investor)
            assert.equal(result.toString(), 'true', 'investor is staking status after staking')

            // issue tokens
            await decentralBank.issueTokens({from: owner})

            // ensuring that only the owner can issue tokens
            await decentralBank.issueTokens({from: investor}).should.be.rejected

            // ustaking tokens
            await decentralBank.unstakeTokens({from: investor})

            // investor's mock balance after unstaking from bank
            result = await tether.balanceOf(investor)
            assert.equal(result.toString(), tokens('100'), 'investor mock tether balance after unstaking from bank')

            // decentral bank balance after investor's unstaking
            result = await tether.balanceOf(decentralBank.address)
            assert.equal(result.toString(), tokens('0'), 'decentral mock balance should be zero after unstaking of investor')

            // investor staking balance in decentral bank after successful unstaking
            result = await decentralBank.stakingBalance(investor)
            assert.equal(result.toString(), tokens('0'), 'investor staking balance in decentral bank after unstaking should be zero')

            // investor staking status after successful unstaking
            result = await decentralBank.isStaking(investor)
            assert.equal(result.toString(), 'false', 'investor staking status after unstaking should be false')

        })

    })

})