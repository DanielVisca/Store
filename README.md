# Store
This is in response to a coding challenge for Shopify's 2019 Summer Internship

Hello :) My name is Daniel, thanks for checking out my store. It is definitely in its rough stages but it was fun to make so it wont be that way for long!

<h2>Features:</h2> 
<p>
-GraphQL API <br>
-carts with total dollar amounts and purchase option <br>
-carts are destroyed after being purchased <br>
-front-end <br>
... To be added to <br>
Unit tests.

Current and Potential Issues. <br>
-When no carts currently exist in the database and an item is added to a cart <br>
-Empty carts can be abandoned and left in the database <br>
-Some queries are not set up and will result in an error.
</p>

<Strong>Example Queries </Strong> 
<p>
{ 
  allProducts(inStock: true) {
    title
    id
  }
  cart(id: 47) {
    cart_items {
      id
    }
    product(id: 25) {
      id
    }
  }
  product(id: 20) {
    title
  }
}
  </p>
  <p>
  {
  allProducts(inStock: true) {
    title
    description
    price
    inventory_count
  }
  product(id: 20) {
    title
    description
    price
    inventory_count
  }
  cart(id: 47) {
    cart_items {
      id
    }
    product(id: 25) {
      id
    }
  }
 
}
 </p>
<strong> Example Mutations </strong>
<p>
  mutation {
  purchaseProduct(id: 25 ) {
    id
    inventory_count
  }
}
  </p>

<p>
  mutation{
  purchaseCart(id: 48){
    id
  }
}
</p>
