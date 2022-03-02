variable "labels" {
  type = map(string)
  default = {
    "" : "invalid empty key",
    ".test" : "dot not allowed"
    "Wöä" : "only lower characters allowed"
    "öäüàéì" : "key_with_internaltional_characters"
    "!test" : "exclamation not allowed"
    "allow-empty-value" : ""
    "key_with_underscore" : "allowed"
    "space not allowed" : ""
    "123" : "key need to start with lowercase character"
    "key_123-" : "value_123-"
  }
  description = "Additional labels (e.g. `map('BusinessUnit','XYZ')`"

  // https://cloud.google.com/compute/docs/labeling-resources#requirements
  // https://www.terraform.io/language/values/variables#custom-validation-rules
  // https://github.com/hashicorp/terraform/issues/26205#issuecomment-692935473
  // https://www.regular-expressions.info/unicode.html
  // https://stackoverflow.com/a/3010005
  //
  // https://www.terraform.io/language/functions/contains
  // https://www.terraform.io/language/functions/can
  // https://www.terraform.io/language/functions/regex
  // https://www.terraform.io/language/expressions/conditionals
  #  validation {
  #    condition     = !contains([for k, v in var.labels : can(regex("[a-zA-Z][a-zA-Z0-9_-]{0,62}", k)) ? regex("[a-zA-Z][a-zA-Z0-9_-]{0,62}", k) == k : false && can(regex("[a-zA-Z0-9_-]{0,63}", v)) ? regex("[a-zA-Z0-9_-]{0,63}", v) == v : false], false)
  #    error_message = "Labels must meet the following constraints: Keys must start with a lowercase character. Only hyphens (-), underscores (_), lowercase characters, and numbers are allowed. International characters are allowed."
  #  }
}

output "labels" {
  value = [for k, v in var.labels : tomap({
    condition-key   = can(regex("[\\p{Ll}][\\p{Ll}0-9_-]{0,62}", k)) ? regex("[\\p{Ll}][\\p{Ll}0-9_-]{0,62}", k) == k : false,
    condition-value = can(regex("[\\p{Ll}0-9_-]{0,63}", v)) ? regex("[\\p{Ll}0-9_-]{0,63}", v) == v : false,
    key-regex       = can(regex("[\\p{Ll}][\\p{Ll}0-9_-]{0,62}", k)) ? regex("[\\p{Ll}][\\p{Ll}0-9_-]{0,62}", k) : "EXCEPTION",
    value-regex     = can(regex("[\\p{Ll}0-9_-]{0,63}", v)) ? regex("[\\p{Ll}0-9_-]{0,63}", v) : "EXCEPTION",
    key             = k,
    value           = v
  })]
}

output "valid" {
  value = !contains([for k, v in var.labels : can(regex("[a-zA-Z][a-zA-Z0-9_-]{0,62}", k)) ? regex("[a-zA-Z][a-zA-Z0-9_-]{0,62}", k) == k : false && can(regex("[a-zA-Z0-9_-]{0,63}", v)) ? regex("[a-zA-Z0-9_-]{0,63}", v) == v : false], false)
}