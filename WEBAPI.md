**Telephone Call**
----
  Creates telephone calls

* **URL**

  /api/v1/telephone-calls

* **Method:**

  `POST`

* **Success Response:**

  * **Code:** 201 Created <br />
    **Content:**
    ``` json
    {
      "id": "25",
      "type": "start",
      "timestamp": "2016-02-29T12:00:00Z",
      "call_id": "70",
      "source": "AAXXXXXXXXX",
      "destination": "AAXXXXXXXXX"
    }
    ```

* **Error Response:**

  * **Code:** 400/403 Bad Request <br />
    **Content:**
    ``` json
     {"errors":{"message":{"field":{"field":["message"]}}}}
    ```

* **Sample Call Start:**

  ``` json
  {
    "type": "start", // Required
    "timestamp": "2016-02-29T12:00:00Z", // Required
    "call_id": "70", // Required
    "source": "AAXXXXXXXXX", // Required
    "destination": "AAXXXXXXXXX" // Required
  }
  ```

* **Sample Call End:**

  ``` json
  {
    "type": "end", // Required
    "timestamp": "2016-02-29T12:00:00Z", // Required
    "call_id": "70" // Required
  }
  ```

  **Telephone Bill**
  ----
    Gets telephone bills

  * **URL**

    /api/v1/telephone-bills

  * **Method:**

    `GET`

  * **Success Response:**

    * **Code:** 200 Ok <br />
      **Content:**
      ``` json
      [{
        "destination": "AAXXXXXXXXX",
        "call_start_date": "29/01/2018",
        "call_start_time": "12:00:00",
        "call_duration": "0h35m42s",
        "call_price": "R$ 3,96"
      }]
      ```

  * **Error Response:**

    * **Code:** 400/403 Bad Request <br />
      **Content:**
      ``` json
       {"errors":{"message":{"field":{"field":["message"]}}}}
      ```

  * **Sample Report:**

    ``` json
    {
      "telephone_number": "AAXXXXXXXXX", // Required
      "period": "01/2018" // Optional
    }
    ```
