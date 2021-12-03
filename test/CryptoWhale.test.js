const {assert} = require('chai');

const CryptoWhale = artifacts.require('./CryptoWhale')

// check for chai
require('chai')
.use(require('chai-as-promised'))
.should()


contract('CryptoWhale', (accounts)=> {
    let contract

    before( async () => {
        // Bringing our contract to test it
        contract = await CryptoWhale.deployed()
    })

    // testing container - describe
    describe('deployment', async() => {
        // test samples with writing it
        it('deploys successfully!', async()=>{
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

    describe('minting', async() =>{
        it('creates a new token', async()=>{
            const result = await contract.mint('https...1')
            const totalSupply = await contract.totalSupply()

            //success
            assert.equal(totalSupply, 1)

            const event  = result.logs[0].args
            assert.equal(event._from, '0x0000000000000000000000000000000000000000', 'from is the contract')
            assert.equal(event._to, accounts[0], 'to is msg.sender')

            //Failure
            await contract.mint('https...1').should.be.rejected

        })
    })

    describe('indexing', async () => {
        it('lists CryptoWhales', async () => {
            // mint the new three tokens 
            await contract.mint('https...2')
            await contract.mint('https...3')
            await contract.mint('https...4')
            const totalSupply = await contract.totalSupply()

            // Loop tghrough list and grab CWhale from list
            let result = []
            let CryptoWhale
            for(i=1; i <= totalSupply; i++){
                CryptoWhale = await contract.cryptoWhales(i-1)
                result.push(CryptoWhale) 
            }

            // assert that our new array result will equal our expected result
            // How many tokens should we have minted?
            let expected = ['https...1','https...2','https...3','https...4']
            assert.equal(result.join(','), expected.join(','))
        })
    })
    
})