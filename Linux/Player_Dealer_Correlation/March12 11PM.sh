#!/bin/bash
echo 'March12 11PM' >> Dealers_working_during_losses
awk '{print $1, $2, $5, $6}' 0312_Dealer_schedule | grep "11:00:00 PM" >> Dealers_working_during_losses

