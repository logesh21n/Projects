<h1 align = "center">Vehicle Marketplace Smart Contract</h1>

**Introduction:**

This project implements a decentralized vehicle marketplace smart contract using Solidity. The contract allows users to buy, sell, and bid on vehicles securely and transparently on the Ethereum blockchain. It includes advanced features such as an escrow system, listing with images, bidding functionality, and integration with decentralized identity systems.

**Features:**

1. **Vehicle Struct:**
   - The contract defines a `Vehicle` struct to represent each vehicle.
   - It includes fields such as `make`, `model`, `year`, `price`, `isSecondHand`, `imageUrl`, `isListed`, `highestBid`, and `highestBidder`.

2. **Adding Vehicles:**
   - Users can add vehicles to the marketplace using the `addVehicle` function, providing details like make, model, year, price, and image URL.
   - Upon addition, the contract emits an `VehicleAdded` event with relevant details.

3. **Listing Vehicles:**
   - Owners can list their vehicles for sale using the `listVehicle` function.
   - The `VehicleListed` event is emitted upon successful listing.

4. **Unlisting Vehicles:**
   - Owners can remove their vehicles from sale using the `unlistVehicle` function.

5. **Purchasing Vehicles:**
   - Buyers can purchase listed vehicles by sending the required amount of ether to the seller.
   - The contract facilitates the transfer of ownership and funds securely.
   - An `VehicleSold` event is emitted upon successful purchase.

6. **Bidding on Vehicles:**
   - Users can place bids on listed vehicles using the `placeBid` function.
   - The contract handles bid transactions securely, ensuring only the highest bid is considered.
   - Events such as `VehicleBidPlaced`, `VehicleBidWithdrawn`, and `VehicleHighestBidIncreased` are emitted during bidding.

7. **Accepting Bids:**
   - Sellers can accept bids placed on their vehicles using the `acceptBid` function.
   - Upon acceptance, the highest bidder becomes the new owner, and funds are transferred securely.
   - Events like `VehicleBidAccepted` and `VehicleSold` are emitted upon successful bid acceptance.

8. **Withdrawal of Bids:**
   - Users can withdraw their bids using the `withdrawBid` function if they choose to retract their offer.
   - The contract ensures the safe return of bid amounts to the respective bidders.

9. **Owner Verification:**
   - The contract can be integrated with decentralized identity systems to verify the ownership of vehicles securely.

**Usage:**

1. **Adding a Vehicle:**
   - Use the `addVehicle` function to add a new vehicle to the marketplace.
   - Provide details such as make, model, year, price, and image URL.

2. **Listing a Vehicle:**
   - After adding a vehicle, list it for sale using the `listVehicle` function.

3. **Purchasing a Vehicle:**
   - Buyers can purchase listed vehicles by sending the required amount of ether to the seller.

4. **Bidding on a Vehicle:**
   - To bid on a listed vehicle, use the `placeBid` function and specify the amount.

5. **Accepting a Bid:**
   - Sellers can accept bids using the `acceptBid` function, transferring ownership to the highest bidder.

6. **Withdrawing a Bid:**
   - Bidders can withdraw their bids if needed using the `withdrawBid` function.

**Conclusion:**

The Vehicle Marketplace Smart Contract provides a robust and secure platform for buying, selling, and bidding on vehicles on the Ethereum blockchain. With features such as an escrow system, listing with images, and bidding functionality, it offers a decentralized solution for vehicle transactions. Users can interact with the contract to add vehicles, list them for sale, purchase vehicles, place bids, and accept bids securely and transparently. The contract can be further enhanced and integrated with decentralized identity systems for owner verification, making it a comprehensive solution for the vehicle marketplace on the blockchain.