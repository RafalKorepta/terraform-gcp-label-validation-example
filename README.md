# Terraform validation test

Validation can be view after running the following command:

```bash
terraform plan
```

The output should look as follows:

```
Changes to Outputs:
  + labels = [
      + {
          + "condition-key"   = "false"
          + "condition-value" = "false"
          + "key"             = ""
          + "key-regex"       = "EXCEPTION"
          + "value"           = "invalid empty key"
          + "value-regex"     = "invalid"
        },
      + {
          + "condition-key"   = "false"
          + "condition-value" = "false"
          + "key"             = "!test"
          + "key-regex"       = "test"
          + "value"           = "exclamation not allowed"
          + "value-regex"     = "exclamation"
        },
      + {
          + "condition-key"   = "false"
          + "condition-value" = "false"
          + "key"             = ".test"
          + "key-regex"       = "test"
          + "value"           = "dot not allowed"
          + "value-regex"     = "dot"
        },
      + {
          + "condition-key"   = "false"
          + "condition-value" = "false"
          + "key"             = "123"
          + "key-regex"       = "EXCEPTION"
          + "value"           = "key need to start with lowercase character"
          + "value-regex"     = "key"
        },
      + {
          + "condition-key"   = "false"
          + "condition-value" = "false"
          + "key"             = "Wöä"
          + "key-regex"       = "öä"
          + "value"           = "only lower characters allowed"
          + "value-regex"     = "only"
        },
      + {
          + "condition-key"   = "true"
          + "condition-value" = "true"
          + "key"             = "allow-empty-value"
          + "key-regex"       = "allow-empty-value"
          + "value"           = ""
          + "value-regex"     = ""
        },
      + {
          + "condition-key"   = "true"
          + "condition-value" = "true"
          + "key"             = "key_123-"
          + "key-regex"       = "key_123-"
          + "value"           = "value_123-"
          + "value-regex"     = "value_123-"
        },
      + {
          + "condition-key"   = "true"
          + "condition-value" = "true"
          + "key"             = "key_with_underscore"
          + "key-regex"       = "key_with_underscore"
          + "value"           = "allowed"
          + "value-regex"     = "allowed"
        },
      + {
          + "condition-key"   = "false"
          + "condition-value" = "true"
          + "key"             = "space not allowed"
          + "key-regex"       = "space"
          + "value"           = ""
          + "value-regex"     = ""
        },
      + {
          + "condition-key"   = "true"
          + "condition-value" = "true"
          + "key"             = "öäüàéì"
          + "key-regex"       = "öäüàéì"
          + "value"           = "key_with_internaltional_characters"
          + "value-regex"     = "key_with_internaltional_characters"
        },
    ]
  + valid  = false

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.
```