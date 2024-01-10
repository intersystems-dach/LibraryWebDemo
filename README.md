![Banner](./Frontend/vue/public/libcartoon.jpg)

# LibraryWebDemo

A demo library management webapplication. Build with Vue.js and InterSystems IRIS.

---

## Prerequisites

-   [Node.js](https://nodejs.org/en/download/) (version 12 or higher)
-   [npm](https://www.npmjs.com/get-npm) (version 6 or higher)

---

## Usage

1. Clone this repo
2. Follow the instruction to install the Library API [here](./Backend/README.md)
3. Run the following command in the root folder to intsall and run the frontend
    ```bash
    cd Frontend/vue && npm run start
    ```

---

## Authentication

For demonstration purposes you can use the following credentials to login:

| Username | Password |
| -------- | -------- |
| demo     | demo     |

---

## Azure Active Directory

If you want to use Azure Active Directory for authentication, you can follow the instructions [here](https://devblogs.microsoft.com/azure-sdk/vue-js-user-authentication/) to configure it.

> _Note_: You have to add your Azure Active Directory credentials to the [authConfig.js](./Frontend/vue/src/pages/auth/authConfig.js.template) file (_rename the file from `authConfig.js.template` to `authConfig.js` afterwards_).

---

## Connect to your own IRIS instance

By default the frontend connects to the IRIS instance running on your local machine. If you want to connect to a different instance, you can change the connection enviroment in the [.env](./Frontend/vue/.env) file.

_**Restart the development server after configuration changes!**_

---

By [Shubham S.](https://github.com/sumalyareact) & [Philipp B.](https://github.com/cophilot)
