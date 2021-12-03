const {assert} = require('chai');

const CryptoWhale = artifacts.require('./CryptoWhale')

// check for chai
require('chai')
.use(require('chai-as-promised'))
.should()


contract('CryptoWhale', (accounts)=> {
    // Bringing our contract to test it
    let contract

    // testing container - describe
    describe('deployment', async() =>{
        // test samples with writing it
        it('deploys successfully!', async()=>{
            contract = await CryptoWhale.deployed()
            const address = contract.address;
            assert.notEqual(address, '')
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
            assert.notEqual(address, 0x0)
        })

        it('has a name', async()=> {
            const name = await contract.name()
            assert.equal(name, 'CryptoWhale')
        })

        it('has a symbol', async()=> {
            const name = await contract.symbol()
            assert.equal(name, 'CWHALE')
        })

    })
})