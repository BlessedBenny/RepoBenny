#!/bin/bash
echo 'March15 8AM' >> Dealers_working_during_losses
awk '{print $1, $2, $5, $6}' 0315_Dealer_schedule | grep "08:00:00 AM" >> Dealers_working_during_losses

