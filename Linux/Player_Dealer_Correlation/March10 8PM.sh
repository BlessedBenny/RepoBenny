#!/bin/bash
echo 'March10 8PM' >> Dealers_working_during_losses
awk '{print $1, $2, $5, $6}' 0310_Dealer_schedule | grep "08:00:00 PM" >> Dealers_working_during_losses
