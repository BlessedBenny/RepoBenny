#!/bin/bash
echo 'March15 5AM' >> Dealers_working_during_losses
awk '{print $1, $2, $5, $6}' 0315_Dealer_schedule | grep "05:00:00 AM" >> Dealers_working_during_losses

