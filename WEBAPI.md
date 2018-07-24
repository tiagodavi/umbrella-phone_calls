**Telephone Call**
----
  Create telephone call (start|end)

  You have to send two requests in any order to build a record pair.

* **URL**

  /api/v1/telephone-calls

* **Method:**

  `POST`

* **Success Response:**

  * **Code:** 200 OK <br />
    **Content:**
    ```
    {
      "id": 25,
      "type": "start",
      "timestamp": "2016-02-29T12:00:00",
      "call_id": 70,
      "source": "AAXXXXXXXXX",
      "destination": "AAXXXXXXXXX"
    }
    ```

* **Error Response:**

  * **Code:** 403 Bad Request <br />
    **Content:**
    ```
     {"errors":{"message":{"field":["message"]}}}
    ```

* **Json body to create a call start:**

  ```
  {
    "type": "start", // Required
    "timestamp": "2016-02-29T12:00:00Z", // Required
    "call_id": "70", // Required
    "source": "AAXXXXXXXXX", // Required
    "destination": "AAXXXXXXXXX" // Required
  }
  ```

* **Json body to create a call end:**

  ```
  {
    "type": "end", // Required
    "timestamp": "2016-02-29T12:10:00Z", // Required
    "call_id": "70" // Required
  }
  ```

  **Telephone Bill**
  ----
    Get telephone bill

  * **URL**

    /api/v1/telephone-bills/:phone_number?period=month/year

  * **Method:**

    `GET`

  * **Success Response:**

    * **Code:** 200 Ok <br />
      **Content:**
      ```
      [{
        "destination": "AAXXXXXXXXX",
        "call_start_date": "2016-02-29",
        "call_start_time": "12:00:00",
        "call_duration": "0h35m42s",
        "call_price": "R$ 3,96"
      }]
      ```

  * **Error Response:**

    * **Code:** 403 Bad Request <br />
      **Content:**
      ```
       {"errors":{"message":{"field":["message"]}}}
      ```
