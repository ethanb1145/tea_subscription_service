# Tea Subscription Service

## Overview

This is a Rails API for a Tea Subscription Service that allows customers to subscribe to tea subscriptions, cancel subscriptions, and view their subscription details.

### Endpoints

1. **Subscribe a Customer to a Tea Subscription**
   - Endpoint: `POST /api/v1/customers/:customer_id/subscriptions`
   - Allows a customer to subscribe to a tea subscription.
   - POST Request Body:
     ```json
     {
       "title": "Monthly Herbal Tea",
       "price": 16.99,
       "frequency": "monthly",
       "tea_id": 3
     }
     ```
   - 201 Response: Returns subscription details if successful.
     ```json
     {
      "data": {
          "id": "2",
          "type": "subscription",
          "attributes": {
              "title": "Monthly Herbal Tea",
              "price": "16.99",
              "status": "subscribed",
              "frequency": "monthly"
         }
       }
     }
     ```

2. **Cancel a Customer's Tea Subscription**
   - Endpoint: `PATCH /api/v1/customers/:customer_id/subscriptions/:subscription_id`
   - Allows a customer to cancel their tea subscription.
   - PUT Request Body:
     ```json
     {
       "status": "cancelled"
     }
     ```
   - 200 Response: Returns updated subscription details if successful.
     ```json
     {
      "data": {
          "id": "2",
          "type": "subscription",
          "attributes": {
              "title": "Monthly Herbal Tea",
              "price": "16.99",
              "status": "cancelled",
              "frequency": "monthly"
         }
       }
     }
    ```

3. **See all of a Customer's Subscriptions (Active and Cancelled)**
   - Endpoint: `GET /api/v1/customers/:customer_id/subscriptions`
   - Allows a customer to view all their active and cancelled subscriptions.
   - GET Response: Returns a list of subscriptions with details.
     ```json
       {
      "data": [
          {
              "id": "1",
              "type": "subscription",
              "attributes": {
                  "title": "Monthly Green Tea",
                  "price": "15.99",
                  "status": "subscribed",
                  "frequency": "monthly"
              }
          },
          {
              "id": "2",
              "type": "subscription",
              "attributes": {
                  "title": "Monthly Herbal Tea",
                  "price": "16.99",
                  "status": "cancelled",
                  "frequency": "monthly"
           }
         }
       ]
     }
     ```
     

## Project Structure

### Models

1. **Tea**
   - Attributes: Title, Description, Temperature, Brew Time
   - Relationships: Has many subscriptions

2. **Customer**
   - Attributes: First Name, Last Name, Email, Address
   - Relationships: Has many subscriptions

3. **Subscription**
   - Attributes: Title, Price, Status, Frequency
   - Relationships: Belongs to a customer and a tea
