unq_loan_accts <- unique(loan_input_lla_out_flat$AccountNumber)
unq_co_rcv_accts <- unique(lla_co_rcv_input_flat$AccountNumber)
all <- length(unq_loan_accts)
lla <- length(unq_co_rcv_accts)
tr <-length(which(unq_co_rcv_accts %in% unq_loan_accts)) #counts TRUEs, in %in% containment
(lla - tr)/lla
lla/all

# find $ amount in charge-off and recovery separately, which appear in LLA (loss&recov input, with loan numbers) 
# but not in the LLA-generated input/output
co_tot <- sum(lla_co_rcv_input_flat$ChargeoffAmount, na.rm = TRUE)
co_not_in_loan_accts <- sum(lla_co_rcv_input_flat$ChargeoffAmount[which(!(unq_co_rcv_accts %in% unq_loan_accts))], na.rm = TRUE)
