// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VehicleMarketplace {
    // Struct to represent a vehicle
    struct Vehicle {
        uint256 id;
        address owner;
        string make;
        string model;
        uint256 year;
        uint256 price;
        bool isSecondHand;
        string imageUrl;
        bool isListed;
        uint256 highestBid;
        address highestBidder;
        mapping(address => uint256) bids;
    }

    // Events
    event VehicleAdded(
        uint256 id,
        address indexed owner,
        string make,
        string model,
        uint256 year,
        uint256 price,
        bool isSecondHand,
        string imageUrl
    );
    event VehicleListed(
        uint256 id,
        address indexed owner,
        uint256 price,
        string imageUrl
    );
    event VehicleSold(
        uint256 id,
        address indexed buyer,
        address indexed seller,
        uint256 price
    );
    event VehicleBidPlaced(uint256 id, address indexed bidder, uint256 amount);
    event VehicleBidWithdrawn(
        uint256 id,
        address indexed bidder,
        uint256 amount
    );
    event VehicleHighestBidIncreased(
        uint256 id,
        address indexed bidder,
        uint256 amount
    );
    event VehicleBidAccepted(
        uint256 id,
        address indexed buyer,
        address indexed seller,
        uint256 price
    );

    // State variables
    uint256 public nextVehicleId;
    mapping(uint256 => Vehicle) public vehicles;

    // Function to add a vehicle to the marketplace
    // Function to add a vehicle to the marketplace
    function addVehicle(
        string memory _make,
        string memory _model,
        uint256 _year,
        uint256 _price,
        bool _isSecondHand,
        string memory _imageUrl
    ) external {
        vehicles[nextVehicleId].id = nextVehicleId;
        vehicles[nextVehicleId].owner = msg.sender;
        vehicles[nextVehicleId].make = _make;
        vehicles[nextVehicleId].model = _model;
        vehicles[nextVehicleId].year = _year;
        vehicles[nextVehicleId].price = _price;
        vehicles[nextVehicleId].isSecondHand = _isSecondHand;
        vehicles[nextVehicleId].imageUrl = _imageUrl;
        emit VehicleAdded(
            nextVehicleId,
            msg.sender,
            _make,
            _model,
            _year,
            _price,
            _isSecondHand,
            _imageUrl
        );
        nextVehicleId++;
    }

    // Function to list a vehicle for sale
    function listVehicle(uint256 _id) external {
        Vehicle storage vehicle = vehicles[_id];
        require(vehicle.owner == msg.sender, "You don't own this vehicle");
        require(!vehicle.isListed, "Vehicle already listed");
        vehicle.isListed = true;
        emit VehicleListed(_id, msg.sender, vehicle.price, vehicle.imageUrl);
    }

    // Function to remove a vehicle from sale
    function unlistVehicle(uint256 _id) external {
        Vehicle storage vehicle = vehicles[_id];
        require(vehicle.owner == msg.sender, "You don't own this vehicle");
        require(vehicle.isListed, "Vehicle not listed");
        vehicle.isListed = false;
    }

    // Function to purchase a vehicle
    function purchaseVehicle(uint256 _id) external payable {
        Vehicle storage vehicle = vehicles[_id];
        require(vehicle.isListed, "Vehicle not listed for sale");
        require(msg.value >= vehicle.price, "Insufficient funds sent");

        // Transfer funds to the seller
        payable(vehicle.owner).transfer(msg.value);

        // Transfer ownership of the vehicle
        vehicle.owner = msg.sender;
        vehicle.isListed = false;

        emit VehicleSold(_id, msg.sender, vehicle.owner, vehicle.price);
    }

    // Function to place a bid on a vehicle
    function placeBid(uint256 _id) external payable {
        Vehicle storage vehicle = vehicles[_id];
        require(vehicle.isListed, "Vehicle not listed for sale");
        require(
            msg.value > vehicle.highestBid,
            "Bid not higher than current highest bid"
        );

        if (vehicle.highestBidder != address(0)) {
            // Refund the previous highest bidder
            payable(vehicle.highestBidder).transfer(vehicle.highestBid);
        }

        vehicle.highestBid = msg.value;
        vehicle.highestBidder = msg.sender;
        vehicle.bids[msg.sender] = msg.value;

        emit VehicleBidPlaced(_id, msg.sender, msg.value);
        emit VehicleHighestBidIncreased(_id, msg.sender, msg.value);
    }

    // Function to withdraw a bid
    function withdrawBid(uint256 _id) external {
        Vehicle storage vehicle = vehicles[_id];
        require(vehicle.isListed, "Vehicle not listed for sale");
        require(vehicle.bids[msg.sender] > 0, "No bid to withdraw");

        uint256 amount = vehicle.bids[msg.sender];
        vehicle.bids[msg.sender] = 0;
        payable(msg.sender).transfer(amount);

        emit VehicleBidWithdrawn(_id, msg.sender, amount);
    }

    // Function to accept a bid and sell the vehicle
    function acceptBid(uint256 _id) external {
        Vehicle storage vehicle = vehicles[_id];
        require(vehicle.owner == msg.sender, "You don't own this vehicle");
        require(vehicle.isListed, "Vehicle not listed for sale");
        require(
            vehicle.highestBidder != address(0),
            "No bids placed on this vehicle"
        );

        // Transfer funds to the seller
        payable(msg.sender).transfer(vehicle.highestBid);

        // Transfer ownership of the vehicle
        vehicle.owner = vehicle.highestBidder;
        vehicle.isListed = false;
        uint256 price = vehicle.highestBid;

        emit VehicleBidAccepted(_id, vehicle.owner, msg.sender, price);
        emit VehicleSold(_id, vehicle.owner, msg.sender, price);
    }

    // Function to get all vehicles owned by a particular address
    function getOwnerVehicles(
        address _owner
    ) external view returns (uint256[] memory) {
        uint256[] memory result = new uint256[](nextVehicleId);
        uint256 counter = 0;
        for (uint256 i = 0; i < nextVehicleId; i++) {
            if (vehicles[i].owner == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }
}
