// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ProductDetails {

    // state variables

    uint256 private nextProductId = 1;

    mapping(uint256 => Product) private products;


    
    // Contract states - enum
    enum ProductState {
        PRODUCT_REGISTERED,
        QUALITY_ASSURANCE,
        PRODUCT_TRANSIT,
        PRODUCT_IN_INVENTORY,
        PRODUCT_SOLD,
        PRODUCT_RECALLED,
        CONSUMPTION,
        PENDING,
        VALIDATING,
        PUBLISHING
    }

    enum ContractCondition {
        OPEN,
        LOCKED,
        PENDING
    }



    struct Product {
        uint256 id;
        string name;
        string description;
        uint256 manufactureDate;
        string batchNumber;

        ProductState state;
        ContractCondition condition;

        // other properties
    }



    // handle errors
    error Unauthorized(address user);
    error InvalidProductId();
    error ProductIdNotFound();
    error CallerNotOwner();
    error InsufficientPrevileges(string action);
    error InvalidStateTransition();



   

    // handle product events
    event ProductAdded(uint256 indexed productId);
    event ProductAccepted();
    event ProductRejected();
    event ProductAlreadyExists();
    event ProductSuspicious();
    event ProductDetailsRetrieved();
    event ProductPotentiallyCounterFeit();

  // Regarding supply chain
  event ProductRegistered(uint256 indexed productId);
  event QualityCheckUpdated();
  event ShipmentStarted();
  event ShipmentReceived();
  event InventoryUpdated();
  event ProductSold(uint256 indexed productId);
  event ProductConsumed(uint256 indexed productId);

  event ProductRecall(uint256 indexed productId);


    // more events
    

    // add a product
    function addProduct(string memory name, string memory description, uint256 manufacturedDate, string memory batchNumber) public {
        uint256 productId = nextProductId++;
        products[productId] = Product(productId, name, description, manufacturedDate, batchNumber);
        
        emit ProductAdded(productId);
    }

    // retrieve  product details
    function getProductDetails(uint256 productId) public view returns(Product memory) {
        require(products[productId].id != 0, "Product not found");

        return products[productId];
    }

    // Handle product state
    function updateProductState(uint256 productId, ProductState currentState) public view {
        Product storage product = products[productId];

         // check for valid state transitions
         if (product.state == ProductState.PRODUCT_REGISTERED && currentState != ProductState.PRODUCT_TRANSIT) {
            revert InvalidStateTransition();

         }
    }
}