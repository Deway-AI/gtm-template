___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "displayName": "Deway SDK",
  "description": "Integrate the Deway Web SDK to track and identify users via the Data Layer.",
  "categories": ["ANALYTICS", "PERSONALIZATION"],
  "securityGroups": [],
  "id": "cvt_deway_sdk",
  "type": "TAG",
  "version": 1,
  "brand": {
    "thumbnail": "",
    "displayName": "Deway",
    "id": "brand_deway"
  },
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "help": "Your Deway application key",
    "displayName": "Deway App Key",
    "name": "appKey",
    "type": "TEXT",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "help": "e.g., user_id or visitorId",
    "displayName": "Data Layer Key for User ID",
    "name": "userIdKey",
    "type": "TEXT",
    "simpleValueType": true
  }
]


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  { "type": 1, "string": "key" },
                  { "type": 1, "string": "read" },
                  { "type": 1, "string": "write" },
                  { "type": 1, "string": "execute" }
                ],
                "mapValue": [
                  { "type": 1, "string": "Deway" },
                  { "type": 8, "boolean": true },
                  { "type": 8, "boolean": true },
                  { "type": 8, "boolean": true }
                ]
              }
            ]
          }
        }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://unpkg.com/@deway-ai/web-sdk/dist/loader.umd.js"
              }
            ]
          }
        }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "isRequired": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const injectScript = require('injectScript');
const callInWindow = require('callInWindow');
const copyFromDataLayer = require('copyFromDataLayer');

const scriptUrl = 'https://unpkg.com/@deway-ai/web-sdk/dist/loader.umd.js';

// Get the value from the Data Layer
let userId = copyFromDataLayer(data.userIdKey);

// Set a fallback if the value is null or undefined
if (!userId) {
  userId = 'guest_user';
}

// Inject the external SDK
injectScript(scriptUrl, function() {
  // Initialize the SDK
  callInWindow('Deway.init', {
    appKey: data.appKey
  });

  // Identify the user
  callInWindow('Deway.identify', userId);

  data.gtmOnSuccess();
}, data.gtmOnFailure);


___NOTES___

Created on 12/30/2025
