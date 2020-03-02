# simple_bank
Implement a simple bank in rails [Study Project]
Routes:

user POST /user(.:format)             user#create
params:
  name
  email
  cpf

user_view POST /user/view(.:format)        user#view
Params:
  user_id

user_update POST /user/update(.:format)      user#update
params:
  name
  email

user_destroy POST /user/destroy(.:format)     user#destroy
  Params:
  user_id

account POST /account(.:format)          account#create
  Params:
  user_id
  number

account_view POST /account/view(.:format)     account#view
Params:
  number
  account_destroy POST /account/destroy(.:format)  account#destroy
     
account_withdraw POST /account/withdraw(.:format) account#withdraw
Params:
  number
  amount

account_deposit POST /account/deposit(.:format)  account#deposit
Params:
  number
  amount
 
account_transfer POST /account/transfer(.:format) account#transfer
Params:
  receiver_id
  sender_id
  transfer amount to transfer


