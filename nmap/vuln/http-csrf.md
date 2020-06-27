# http-csrf

## Desc.
Detects cross Site Request Forgeries (CSRF) 
* It'll try to detect them by checking each form if it contains an unpredictable toker for each user
  Without one an attacker may forge malicious requests
* To recongnize a toke in a form, the script will iterate through the form's
  attributres & will search for common patterns in their name. If that fails,
  it will also calculate the entropy of each attribute's value. A big
  entropy means a possible token
* This script comes along with a cooke that gives access in pages that
  require authentication, because tht's where the privileged exist.
  See the http library's documentation to set your own cookie
