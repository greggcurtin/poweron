[  <TITLE>
|  ONLINE.SETTLEMENT
|
|  <PURPOSE>
|  Used for balancing an Online Card interface.
| 
|  Output includes
|   * Summary Report   Includes totals for each report as well as balancing section that
|                      checks to be sure the reports balance to themselves.
|   * Settlement, System, Difference 1, Difference 2 reports (optional)
|                      These are the standard settlement reports but formatted in a standard
|                      manner for all interfaces. A report is only generated if there are
|                      transactions that are selected for the report.
|                      The Diff 1 for yesterday and the Diff 2 for tomorrow are also generated.
|                      If international fees are assessed, a separate report is generated for each
|                      report type.
|   * Exceptions       A detail report of all transactions that were approved to the network
|                      but could not be posted. This is a consolidated list of transactions
|                      for the given system date.   
|
|
|  <ANY SPECIAL INFORMATION/NOTES REQUIRED TO RUN?>
|
|  To run a report based on the Unix date/time instead of settlement date, enter a cutoff
|  time in the field SETTLEMENTTIME in the SETUP division. Be sure to save the file to a new
|  PowerOn name.
|
|  Prompts:
|
|    Network/Message Format  Choose from one of the listed network interfaces
|    Select Date             Enter the settlement date
|    Print Detail Reports    Enter N to just produce a Summary & Exception reports.
|                            Enter Y to produce detail transaction reports in addition
|                            to the Summary & Exception reports.
|
|  <Stack comments in reverse chronological order.>
|  PROGRAMMER:  Sharon Rigg, Symitar
|  DATE:        2021-JUN-08
|  RELEASE:     2021.00
|  CASE/DEFECT: #######/######
|  DETAILS:     Changed quote to apostrophe. Fixed Summary Totals.
|
|  PROGRAMMER:  Sharon Rigg, Symitar
|  DATE:        2021-JUN-04
|  RELEASE:     2021.00
|  CASE/DEFECT: #######/######
|  DETAILS:     Fixed date for yesterday's Diff 1 report.
|
|  PROGRAMMER:  Sharon Rigg, Symitar
|  DATE:        2021-MAY-31
|  RELEASE:     2021.00
|  CASE/DEFECT: #######/######
|  DETAILS:     Added Diff 2 for tomorrow and Diff 1 for yesterday. Added International Fee reports.
|               Included balancing page.
|
|  PROGRAMMER:  Sharon Rigg, Symitar
|  DATE:        2021-MAY-24
|  RELEASE:     2021.00
|  CASE/DEFECT: #######/######
|  DETAILS:     Added support for Online Exceptions report.
|
|  PROGRAMMER:  Sharon Rigg, Symitar
|  DATE:        2021-MAY-21
|  RELEASE:     2021.00
|  CASE/DEFECT: #######/######
|  DETAILS:     Modified summary page to be cleaner. Fixed Acq Totals (Db vs Cr)
|
|  PROGRAMMER:  Sharon Rigg, Symitar
|  DATE:        2021-APR-30
|  RELEASE:     2021.00
|  CASE/DEFECT: #######/######
|  DETAILS:     Fixed code to pick up SERVICESBA. Added check for ORCC for Leslie (temp). Fixed change made on 4/27 for Response Code 000.
|               (Don't take value of RespCodeOut as it could be alpha).
|
|  PROGRAMMER:  Sharon Rigg, Symitar
|  DATE:        2021-APR-28
|  RELEASE:     2021.00
|  CASE/DEFECT: #######/######
|  DETAILS:     Print all supported services in one report (SERVICEISS, SERVICEACQ, SERVICESBI, SERVICESBA)
|
|  PROGRAMMER:  Sharon Rigg, Symitar
|  DATE:        2021-APR-27
|  RELEASE:     2021.00
|  CASE/DEFECT: #######/######
|  DETAILS:     Support Response Code Out of 000 for EPOC
|
|  PROGRAMMER:  Sharon Rigg, Symitar
|  DATE:        2021-APR-05
|  RELEASE:     2021.00
|  CASE/DEFECT: #######/######
|  DETAILS:     Created
|
|  Summary Output Example:
|  ====================================================================================================================================
|  FDR/NYCE - Settle 05/31
|                                                                     DEBIT           CREDIT        TRANSFERS               TOTAL
|                                                          ---------------- ---------------- ----------------    ----------------
|  SUBTOTAL      FDR/NYCE - Settle 05/31 - Issuer              3,762,912.22       358,763.35         5,439.00     3,404,148.87  DB
|                                                          ---------------- ---------------- ----------------    ----------------
|  
|                                                                                                                ----------------
|  TOTALS        FDR/NYCE - Settle 05/31                                                                          3,404,148.87  DB
|                                                                                                                ----------------
|                                                             SINGLE CURRENCY   MULTI-CURRENCY                                        
|                                                          ---------------- ----------------                     ----------------
|  VISA FEES     FDR/NYCE - Settle 05/17 - Issuer                     12.68             1.80                                14.48  DB
|                                                          ---------------- ----------------                     ----------------
|                                                             CURRENCY CONV     CROSS BORDER                                 
|                                                          ---------------- ----------------                     ----------------
|  MC FEES       FDR/NYCE - Settle 05/17 - Issuer                     12.68             1.80                                14.48  DB
|                                                          ---------------- ----------------                     ----------------
|
|  INTL FEES     FDR/NYCE - Settle 05/17 - Issuer                                                                           28.96  DB
|                                                                                                                ----------------
|  ====================================================================================================================================
|  .... same total info printed for the following reports if transactions exist:
|  FDR/NYCE - System 05/31
|  FDR/NYCE - Diff 1 05/31
|  FDR/NYCE - Diff 2 05/31
|  FDR/NYCE - Diff 1 05/30 (Diff 1 for Yesterday)
|  FDR/NYCE - Diff 2 06/01 (Diff 2 for Tomorrow)
|  FDR/NYCE - Except 05/31
|  ====================================================================================================================================
|  Yesterday"s Difference Report                                                                                    310,447.85 
|    (+) Today"s System Report                                                                                    9,326,134.51 
|    (-) Today"s Settle Report                                                                                    3,404,148.87 
|    (-) Today"s Diff2 Report                                                                                     5,962,306.84 
|    (+) Tomorrow"s Diff 2 Report                                                                                         0.00 
|                                                                                                                ----------------
|  (=) Today"s Difference/GL Balance:                                                                               270,126.65 
|    (-) Today"s Difference Report:                                                                                 270,126.65 
|                                                                                                                ================
|  (=) Amount reports are Out of Balance:                                                                                 0.00 
|  
|  ====================================================================================================================================
]

ATMDIALOG
TARGET=ATMDIALOG

DEFINE
[Customizable variables]
 SETTLETIME=""        [HHMMSS.  Set this field to pull trans by Transmission time and rename PowerOn.]

 #INCLUDE "RB.PARAMONLINE.DEF"
 #INCLUDE "RD.OUTPUT.DEF"

[Temporary Variable]
 ORCCCOUNT=NUMBER
[Prompt variables]
 NETWORKMSGFORMAT=NUMBER
 SELECTDATE=DATE
 PRINTREPORT=NUMBER ARRAY(7)          [RPTMAX]
[Accumulate/Print Variables]
 TOTALINDEX=0
 TOTALAMOUNTS=MONEY ARRAY(7,4,1,4)    [RPTMAX, SERVICEMAX, AUTHFLAG, TRANCODEMAX]
 TOTALCOUNTS=NUMBER ARRAY(7,4,1,4)    [RPTMAX, SERVICEMAX, AUTHFLAG, TRANCODEMAX]
 TOTALFEEAMOUNTS=MONEY ARRAY(7,4,1,4) [RPTMAX, SERVICEMAX, AUTHFLAG, FEETYPEMAX]
 FEEAMOUNT=MONEY ARRAY(4)             [FEETYPEMAX]
 RECORDSELECTED=NUMBER ARRAY(7)       [RPTMAX]
 LINECOUNT=NUMBER ARRAY(7,1)          [RPTMAX,RPTNUMINDEX]
 AUTHFLAG=NUMBER
 REJECT=NUMBER
 AMTTEXT=CHARACTER(17)
 AMTCOL=NUMBER
 AMTLEN=NUMBER
 AMOUNT=MONEY
[Misc Variables]
 TRUE=1
 FALSE=0
 I=NUMBER
 ERRORTEXT=CHARACTER
 TMPRPTNUM=NUMBER
 TMPCHR=CHARACTER
 SELECTDATECHR=CHARACTER
 APOSTROPHE=CHARACTER(1)
 RPTOPENED=NUMBER
[Report Variables: Summary, Settle, System, Diff1, Diff2, Exc, Diff1 Yesterday, Diff2 Tomorrow]
 RPTSUMMARY=0
 RPTSETTLE=1
 RPTSYSTEM=2
 RPTDIFF1=3
 RPTDIFF2=4
 RPTDIFF1YESTERDAY=5
 RPTDIFF2TOMORROW=6
 RPTEXCEPTIONS=7
 RPTMAX=7
 RPTNAME=CHARACTER ARRAY(7)        [RPTMAX]
 RPTDESC=CHARACTER ARRAY(7)        [RPTMAX]
 RPTNUM=NUMBER ARRAY(7,1)          [RPTMAX,RPTNUMINDEX]
 RPTNUMINDEX=NUMBER                [0=Transactions, 1=International Fees]
 RPTINDEX=NUMBER
[Service Variables: Issuer, Acq, SBI, SBA]
 SERVICEISS=1
 SERVICEACQ=2
 SERVICESBI=3
 SERVICESBA=4
 SERVICEMAX=4
 SERVICETYPE=NUMBER                
 SERVICETYPESAVE=NUMBER           
[Tran Type Variables]
 TRANCODEINVALID=0
 TRANCODEINQ=1
 TRANCODEWD=2
 TRANCODEDEP=3
 TRANCODEXFER=4
 TRANCODEMAX=4
 FEETYPEVISASC=1 [Visa Intl Single-currency]
 FEETYPEVISAMC=2 [Visa Intl Multi-currency]
 FEETYPEMCCCA=3  [MC Intl Currency Conversion Assessment]
 FEETYPEMCICA=4  [MC Intl Cross Border]
 FEETYPEMAX=4
[Constant Arrays]
 PROCESSORNAME=CHARACTER ARRAY(99)
 ROUTINGCODE=NUMBER ARRAY(4)       [SERVICEMAX]
 SERVICENAME=CHARACTER ARRAY(4)    [SERVICEMAX]
 TRANTYPEMAX=16
 TRANTYPE=NUMBER ARRAY(16)         [TRANTYPEMAX:ATMDIALOG:OURTRANCODE]
END

SETUP
[
|  Prompt for:
|   Network/Message Format
|   Select Date - Used for all reports
|   Print Detail Reports?
]
 APOSTROPHE=CTRLCHR(39)
 CALL GETNETWORKBYALPHA [Prompt for Network/Message Format]

 SELECTDATE=DATEREAD("Select Date")
 IF SELECTDATE='--/--/--' THEN
  DO
   PRINT "Select Date cannot be blank."
   NEWLINE
   TERMINATE
  END
 ELSE
  DO
   @ATMDIALOGFROMDATE=SELECTDATE-5
   @ATMDIALOGTODATE=SELECTDATE+5
  END

[ IF YESNOREAD("","Print Detail Reports") THEN
  DO
   FOR RPTINDEX=RPTSETTLE TO RPTMAX
    DO
     PRINTREPORT(RPTINDEX)=TRUE
    END
  END 
 PRINTREPORT(RPTEXCEPTIONS)=TRUE
]
 CALL SETARRAYCONSTANTS
 SERVICETYPESAVE=-1
END

SELECT
[
| Keep Selection Criteria simple so PowerOn runs faster
]
 ATMDIALOG:RECORDTYPE=1 AND
 ATMDIALOG:NETWORKMESSAGEFORMAT=NETWORKMSGFORMAT
END

SORT
 ATMDIALOG:OURTRANSMISSIONDATE
 ATMDIALOG:OURTRANSMISSIONTIME
 ATMDIALOG:TRACENUMBER
END

PRINT TITLE=PROCESSORNAME(NETWORKMSGFORMAT)+" - Summary "+FORMAT("99/99",SELECTDATE)
[
| Set reject/auth flag
| Determine which reports the message should be reported for 
| Evaluate message for errors
| Accumulate total for tran type per report/service
|  and optionally print message to detail reports 
]
 HEADER=""

 CALL GETTRANINFO
 CALL SELECTRECORD
 CALL ERRORCHECKING
 FOR RPTINDEX=RPTSETTLE TO RPTMAX
  DO
   IF RECORDSELECTED(RPTINDEX)=TRUE THEN
     CALL PRINTDETAILTOREPORT
  END
 SERVICETYPESAVE=SERVICETYPE
END

TOTAL
[
|  Accumulate totals for service and report.
|  Print totals per report type both in Summary report 
|   and Detail Report
|  Print balancing information
]
 OUTPUTSWITCH(OUTPUTCHANNELDEFAULT,ERRORTEXT)
 IF ERRORTEXT<>"" THEN
  CALL FILEERRORHANDLER
 HEADER=""
[Temporary code just to see if anyone supports ORCC]
 IF ORCCCOUNT>0 THEN
  DO
   PRINT "**********WARNING***************"
   NEWLINE
   PRINT "CU SUPPORTS ORCC TRANSACTIONS. CONTACT SYMITAR CARD SUPPORT IMMEDIATELY."
   NEWLINE
  END
[End of Temporary Code]
 PRINT REPEATCHR("=",132)
 NEWLINE
 FOR RPTINDEX=RPTSETTLE TO RPTMAX
  DO
   IF TOTALCOUNTS(RPTINDEX,TOTALINDEX,FALSE,TOTALINDEX)>0 OR
      TOTALCOUNTS(RPTINDEX,TOTALINDEX,TRUE,TOTALINDEX)>0 THEN
    DO
     [Print totals in Summary Report]
     OUTPUTSWITCH(OUTPUTCHANNELDEFAULT,ERRORTEXT)
     IF ERRORTEXT<>"" THEN
      CALL FILEERRORHANDLER
     HEADER=""
     FOR SERVICETYPE=SERVICEISS TO SERVICEMAX
      DO
       CALL CALCSUBTOTALS
      END
     [Force a new page after Invalid Transaction exceptions]
     IF LINECOUNT(RPTSUMMARY,0)>0 THEN
      NEWPAGE
     PRINT RPTNAME(RPTINDEX)
     NEWLINE
     RPTOPENED=OUTPUTCHANNELDEFAULT
     CALL PRINTREPORTTOTALS
     PRINT REPEATCHR("=",132)
     NEWLINE
    END
   [Print totals in Detail Report (both regular and Intl Fee Rpt]
   FOR RPTNUMINDEX=0 TO 1
    DO
     IF PRINTREPORT(RPTINDEX)=TRUE AND RPTNUM(RPTINDEX,RPTNUMINDEX)<>0 THEN
      DO
       OUTPUTSWITCH(RPTNUM(RPTINDEX,RPTNUMINDEX),ERRORTEXT)
       IF ERRORTEXT<>"" THEN
        CALL FILEERRORHANDLER
       HEADER=""
       NEWPAGE
       RPTOPENED=RPTNUM(RPTINDEX,RPTNUMINDEX)
       CALL PRINTREPORTTOTALS
      END
    END
  END
 OUTPUTSWITCH(OUTPUTCHANNELDEFAULT,ERRORTEXT)
 IF ERRORTEXT<>"" THEN
  CALL FILEERRORHANDLER
 NEWPAGE
 CALL PRINTBALANCINGTOTALS
 PRINT REPEATCHR("=",132)
 NEWLINE
END

PROCEDURE GETTRANINFO
[
| Get information from ATM Dialog record that will be 
| used for all reports.
|
| Return: REJECT
|         AUTHFLAG
|         SERVICETYPE
]
 REJECT=FALSE
 IF ATMDIALOG:ROUTINGCODE=1 THEN
  DO
   IF ATMDIALOG:OURRESPONSECODE<>0 AND
      ATMDIALOG:OURRESPONSECODE<>2013 AND
      ATMDIALOG:OURRESPONSECODE<>2032 THEN
    REJECT=TRUE
  END
 ELSE
  DO
   IF ATMDIALOG:NETWORKMESSAGEFORMAT=PARAMNETMSGANSIEDS THEN
    DO
     IF ATMDIALOG:RESPONSECODEOUT<>"00" AND
        ATMDIALOG:RESPONSECODEOUT<>"01" AND
        ATMDIALOG:RESPONSECODEOUT<>"02" AND
        ATMDIALOG:RESPONSECODEOUT<>"03" THEN
      REJECT=TRUE
    END
   ELSE IF ATMDIALOG:NETWORKMESSAGEFORMAT=PARAMNETMSGISO93EPOC THEN
    DO                               
     IF VALUE(ATMDIALOG:RESPONSECODEOUT)<>2 AND                                                         
        VALUE(ATMDIALOG:RESPONSECODEOUT)>=100 AND                                                       
        VALUE(ATMDIALOG:RESPONSECODEOUT)<>400 AND                                                       
        VALUE(ATMDIALOG:RESPONSECODEOUT)<>900 THEN  
      REJECT=TRUE
    END  
   ELSE IF ATMDIALOG:NETWORKMESSAGEFORMAT=PARAMNETMSGISO93SHAZAM THEN
    DO
     REJECT=TRUE
     IF (SEGMENT(ATMDIALOG:MESSAGETYPEIN,1,2)="11" AND                              
         SEGMENT(ATMDIALOG:MISCDATA2,58,58)="0") OR                                 
        (SEGMENT(ATMDIALOG:MESSAGETYPEIN,1,2)="12" AND                              
         SEGMENT(ATMDIALOG:MISCDATA2,58,58)="0") OR                                 
        (SEGMENT(ATMDIALOG:MESSAGETYPEIN,1,2)="13" AND                              
         SEGMENT(ATMDIALOG:MISCDATA2,58,60)="300") OR                               
        (SEGMENT(ATMDIALOG:MESSAGETYPEIN,1,2)="14" AND                              
         SEGMENT(ATMDIALOG:MISCDATA2,58,60)="400") OR                               
        (SEGMENT(ATMDIALOG:MESSAGETYPEIN,1,2)="16" AND                              
         SEGMENT(ATMDIALOG:MISCDATA2,58,60)="600") OR                               
        (SEGMENT(ATMDIALOG:MESSAGETYPEIN,1,2)="18" AND                              
         SEGMENT(ATMDIALOG:MISCDATA2,58,60)="800") THEN                             
      REJECT=FALSE
    END                                                                                             
   ELSE IF ATMDIALOG:RESPONSECODEOUT<>"00" AND
           ATMDIALOG:RESPONSECODEOUT<>"000" AND
           ATMDIALOG:RESPONSECODEOUT<>"10" AND
           ATMDIALOG:RESPONSECODEOUT<>"T7" THEN  [** NEED TO ADD OTHER POSSIBLE PARTIAL APPROVAL VALUES]
    REJECT=TRUE
  END

 IF ATMDIALOG:OURPREAUTHCODE=1 OR
    ATMDIALOG:OURPREAUTHCODE=2 THEN
  AUTHFLAG=TRUE
 ELSE
  AUTHFLAG=FALSE

 IF ATMDIALOG:TRANSUBTYPE=3 AND                [ SERVICESBA ]
    ATMDIALOG:ROUTINGCODE=1 THEN
  SERVICETYPE=SERVICESBA
 ELSE IF ATMDIALOG:TRANSUBTYPE=3 OR            [ SERVICESBI ]
         ATMDIALOG:TRANSUBTYPE=25 OR
         ATMDIALOG:TRANSUBTYPE>=31 THEN
  SERVICETYPE=SERVICESBI
 ELSE IF ATMDIALOG:ROUTINGCODE=1 THEN          [ ACQ ]
  SERVICETYPE=SERVICEACQ
 ELSE                                          [ ISS ]
  SERVICETYPE=SERVICEISS
END

PROCEDURE SELECTRECORD
[
|  Determine in which reports the transaction should be reported.
|
|  Pass  : REJECT
|          AUTHFLAG
|
|  Return: RECORDSELECTED(X)
]
 FOR I=0 TO RPTMAX
  DO
   RECORDSELECTED(I)=FALSE
  END

 IF (SETTLETIME="" AND 
     ATMDIALOG:NETWORKSETTLEDATE=SELECTDATE) OR
    (SETTLETIME<>"" AND
     ((ATMDIALOG:TRANSMISSIONDATE=SELECTDATE AND
       ATMDIALOG:TRANSMISSIONTIME<=SETTLETIME) OR
     (ATMDIALOG:TRANSMISSIONDATE=SELECTDATE-1 AND
      ATMDIALOG:TRANSMISSIONTIME>SETTLETIME))) THEN
  RECORDSELECTED(RPTSETTLE)=TRUE
 
 IF ATMDIALOG:OURSYSTEMDATE=SELECTDATE THEN
  RECORDSELECTED(RPTSYSTEM)=TRUE

 IF (SETTLETIME="" AND
     ATMDIALOG:OURSYSTEMDATE=SELECTDATE AND
     ATMDIALOG:NETWORKSETTLEDATE>SELECTDATE) OR
     (SETTLETIME<>"" AND
      ATMDIALOG:OURSYSTEMDATE=SELECTDATE AND
      ATMDIALOG:TRANSMISSIONDATE=SELECTDATE AND
      ATMDIALOG:TRANSMISSIONTIME>SETTLETIME) THEN
  RECORDSELECTED(RPTDIFF1)=TRUE

 IF (SETTLETIME="" AND
     ATMDIALOG:OURSYSTEMDATE=SELECTDATE AND
     ATMDIALOG:NETWORKSETTLEDATE<SELECTDATE) OR
     (SETTLETIME<>"" AND
      ATMDIALOG:OURSYSTEMDATE=SELECTDATE AND
      ATMDIALOG:TRANSMISSIONDATE=SELECTDATE AND
      ATMDIALOG:TRANSMISSIONTIME<SETTLETIME) THEN
  RECORDSELECTED(RPTDIFF2)=TRUE

 IF (SETTLETIME="" AND
     ATMDIALOG:OURSYSTEMDATE=SELECTDATE-1 AND
     ATMDIALOG:NETWORKSETTLEDATE>SELECTDATE-1) OR
     (SETTLETIME<>"" AND
      ATMDIALOG:OURSYSTEMDATE=SELECTDATE-1 AND
      ATMDIALOG:TRANSMISSIONDATE=SELECTDATE-1 AND
      ATMDIALOG:TRANSMISSIONTIME>SETTLETIME) THEN
  RECORDSELECTED(RPTDIFF1YESTERDAY)=TRUE

 IF (SETTLETIME="" AND
     ATMDIALOG:OURSYSTEMDATE=SELECTDATE+1 AND
     ATMDIALOG:NETWORKSETTLEDATE<SELECTDATE+1) OR
     (SETTLETIME<>"" AND
      ATMDIALOG:OURSYSTEMDATE=SELECTDATE+1 AND
      ATMDIALOG:TRANSMISSIONDATE=SELECTDATE+1 AND
      ATMDIALOG:TRANSMISSIONTIME<SETTLETIME) THEN
  RECORDSELECTED(RPTDIFF2TOMORROW)=TRUE

 IF ATMDIALOG:OURSYSTEMDATE=SELECTDATE AND 
    REJECT=FALSE AND AUTHFLAG=FALSE AND
    ATMDIALOG:POSTSUCCESS=FALSE AND
    ATMDIALOG:DUPLICATEFLAG=FALSE AND
    ATMDIALOG:POSTAMOUNT<>$0.00 THEN
  RECORDSELECTED(RPTEXCEPTIONS)=TRUE

 FOR I=1 TO RPTMAX
  DO
   IF RECORDSELECTED(I)=TRUE THEN
    RECORDSELECTED(0)=TRUE
  END

[Temporary code]
 IF ATMDIALOG:ACQUIRERNETWORKID="ORC" OR 
    ATMDIALOG:NETWORKID="546000" THEN
  ORCCCOUNT=ORCCCOUNT+1
END

PROCEDURE ERRORCHECKING
[
|  Perform any prechecking that requires exception messages
|  to be printed to the Summary Report.
|  Errors causing the program to terminate begin with ***
|
|  Pass:   LINECOUNT(X,X)
|
|  Return: LINECOUNT(X,X)
]
 OUTPUTSWITCH(OUTPUTCHANNELDEFAULT,ERRORTEXT)
 IF ERRORTEXT<>"" THEN
  CALL FILEERRORHANDLER

 ERRORTEXT=""
 IF ATMDIALOG:OURTRANCODE>TRANTYPEMAX THEN
  ERRORTEXT="*** Undefined Tran Code :"+FORMAT("99",ATMDIALOG:OURTRANCODE)+" Please contact Symitar."
 ELSE IF TRANTYPE(ATMDIALOG:OURTRANCODE)=TRANCODEINVALID THEN
   ERRORTEXT="!!! Unrecognized Tran Code :"+FORMAT("99",ATMDIALOG:OURTRANCODE) 
 ELSE IF RECORDSELECTED(RPTSYSTEM)=TRUE AND
         REJECT=FALSE AND AUTHFLAG=FALSE AND
         ATMDIALOG:DUPLICATEFLAG=FALSE AND
         (ATMDIALOG:NETWORKSETTLEDATE>SELECTDATE+1 OR 
          ATMDIALOG:NETWORKSETTLEDATE<SELECTDATE-1) THEN
  ERRORTEXT="!!! Settle Date out of range: System Date "+FORMAT("99/99",SELECTDATE)+
             " Settle Date "+FORMAT("99/99",ATMDIALOG:NETWORKSETTLEDATE) 

 IF ERRORTEXT<>"" THEN
  DO
   COL=001 ATMDIALOG:PROCESSORACCOUNT
   COL=032 ATMDIALOG:POSTAMOUNT
   COL=034 ATMDIALOG:OURTRANSMISSIONDATE
   COL=046 SEGMENT(ATMDIALOG:OURTRANSMISSIONTIME,1,2)+":"+
           SEGMENT(ATMDIALOG:OURTRANSMISSIONTIME,3,4)+":"+
           SEGMENT(ATMDIALOG:OURTRANSMISSIONTIME,5,6)
   COL=056 "ProcCode: "+ATMDIALOG:TRANSACTIONCODE
   IF LENGTH(ERRORTEXT)>57 THEN
    ERRORTEXT=SEGMENT(ERRORTEXT,1,57)
   COL=074 ERRORTEXT
   NEWLINE
   LINECOUNT(RPTSUMMARY,0)=LINECOUNT(RPTSUMMARY,0)+1
  END
 IF SEGMENT(ERRORTEXT,1,3)="***" THEN
  TERMINATE
 ERRORTEXT=""
END

PROCEDURE PRINTDETAILTOREPORT
[
|  Accumulate total for report and print detail line
|  for specified report if requested.
|
|  Pass:   RPTINDEX
|          SETTLETIME
|          PRINTREPORT(X)
|          REJECT
|          AUTHFLAG
|          LINECOUNT(X,X)
|
|  Return: LINECOUNT(X,X)
]

 CALL ACCUMTOTALS
 IF PRINTREPORT(RPTINDEX)=TRUE THEN
  DO
   RPTNUMINDEX=0 [Transactions]
   CALL HEADERCHECK
   CALL PRINTDETAILITEM
   IF FEEAMOUNT(TOTALINDEX)<>$0.00 THEN
    DO
     RPTNUMINDEX=1 [International Fees]
     CALL HEADERCHECK
     CALL PRINTINTLFEEITEM
    END
  END
END

PROCEDURE ACCUMTOTALS
[
|  Accumulate total count for report, service, and tran type (W/D/X)
|  Accumulate total amount for tran type (W/D/X) 
|  Accumulate total international fee amounts
|
|  Pass:   RPTINDEX
|          REJECT
|          AUTHFLAG
| 
|  Return: TOTALAMOUNTS(X,X,X,X)
|          TOTALFEEAMOUNTS(X,X,X,X)
|          FEEAMOUNT(X)
]

 AMOUNT=ATMDIALOG:POSTAMOUNT
 TOTALCOUNTS(RPTINDEX,SERVICETYPE,AUTHFLAG,TRANTYPE(ATMDIALOG:OURTRANCODE))=
  TOTALCOUNTS(RPTINDEX,SERVICETYPE,AUTHFLAG,TRANTYPE(ATMDIALOG:OURTRANCODE))+1
 TOTALCOUNTS(RPTINDEX,SERVICETYPE,AUTHFLAG,TOTALINDEX)=
  TOTALCOUNTS(RPTINDEX,SERVICETYPE,AUTHFLAG,TOTALINDEX)+1
 TOTALCOUNTS(RPTINDEX,TOTALINDEX,AUTHFLAG,TOTALINDEX)=
  TOTALCOUNTS(RPTINDEX,TOTALINDEX,AUTHFLAG,TOTALINDEX)+1
 IF ATMDIALOG:DUPLICATEFLAG=0 AND
    REJECT=FALSE AND 
    TRANTYPE(ATMDIALOG:OURTRANCODE)<>TRANCODEINVALID THEN
  DO
   TOTALAMOUNTS(RPTINDEX,SERVICETYPE,AUTHFLAG,TRANTYPE(ATMDIALOG:OURTRANCODE))=
    TOTALAMOUNTS(RPTINDEX,SERVICETYPE,AUTHFLAG,TRANTYPE(ATMDIALOG:OURTRANCODE))+AMOUNT
   CALL GETINTERNATIONALFEES
   FEEAMOUNT(TOTALINDEX)=$0.00
   FOR I=FEETYPEVISASC TO FEETYPEMAX
    DO
     TOTALFEEAMOUNTS(RPTINDEX,SERVICETYPE,AUTHFLAG,I)=
      TOTALFEEAMOUNTS(RPTINDEX,SERVICETYPE,AUTHFLAG,I)+FEEAMOUNT(I)  
     TOTALFEEAMOUNTS(RPTINDEX,SERVICETYPE,AUTHFLAG,TOTALINDEX)=
      TOTALFEEAMOUNTS(RPTINDEX,SERVICETYPE,AUTHFLAG,TOTALINDEX)+FEEAMOUNT(I)  
     FEEAMOUNT(TOTALINDEX)=FEEAMOUNT(TOTALINDEX)+FEEAMOUNT(I)
    END
  END
END

PROCEDURE GETINTERNATIONALFEES
[  
|  Find international fee amounts (Visa or MC)
|
|  RETURN: FEEAMOUNT(X)
]

[  VISA SINGLE/MULTI CURRENCY FEE]
 FOR I=0 TO FEETYPEMCICA
  DO
   FEEAMOUNT(I)=$0.00
  END
 IF ATMDIALOG:AMOUNT10OUT<>$0.00 THEN                                         
  DO                                                                       
   IF ATMDIALOG:SINGLECURRENCYFLAG=1 THEN              
    FEEAMOUNT(FEETYPEVISASC)=ATMDIALOG:AMOUNT10OUT  
   ELSE
    FEEAMOUNT(FEETYPEVISAMC)=ATMDIALOG:AMOUNT10OUT  
  END                                                
 ELSE IF ATMDIALOG:ISAFEEAMOUNT<>$0.00 THEN  
  DO                                                                       
   IF ATMDIALOG:SINGLECURRENCYFLAG=1 THEN              
    FEEAMOUNT(FEETYPEVISASC)=ATMDIALOG:ISAFEEAMOUNT
   ELSE
    FEEAMOUNT(FEETYPEVISAMC)=ATMDIALOG:ISAFEEAMOUNT
  END                                                
[  MASTERCARD CCA FEE                                                                      
]                                                                               
 IF ATMDIALOG:AMOUNT8OUT<>$0.00 THEN                                           
  FEEAMOUNT(FEETYPEMCCCA)=ATMDIALOG:AMOUNT8OUT          
 ELSE IF ATMDIALOG:CCAFEEAMOUNT<>$0.00 THEN                                   
  FEEAMOUNT(FEETYPEMCCCA)=ATMDIALOG:CCAFEEAMOUNT
                                                                                                                                                  
[  MASTERCARD ICA FEE                                                                      
]                                                                               
 IF ATMDIALOG:AMOUNT9OUT<>$0.00 THEN   
  FEEAMOUNT(FEETYPEMCICA)=ATMDIALOG:AMOUNT9OUT 
 ELSE IF ATMDIALOG:ICAFEEAMOUNT<>$0.00 THEN                                    
  FEEAMOUNT(FEETYPEMCICA)=ATMDIALOG:ICAFEEAMOUNT       
END

PROCEDURE HEADERCHECK
[
|  Set Header lines depending on report type.
|  Ensure there is room to print the full transaction
|  before a new page.
|
|  Pass:   RPTINDEX
|          RPTNUMINDEX
|          SETTLETIME
|          LINECOUNT(X,X)
|
|  Return: LINECOUNT(X,X)
]
 CALL REPORTSWITCH
 TMPCHR=RPTDESC(RPTINDEX)
 HEADERS
  PRINT TMPCHR
  IF SETTLETIME<>"" THEN
   PRINT " Settlement Time: "+SETTLETIME
  NEWLINE
  NEWLINE
  IF RPTNUMINDEX=0 THEN
   DO
    COL=001 "Card Number"
    COL=021 "Flags"
    COL=027 "Proc Code"
    COL=047 RIGHT "Debit"
    COL=064 RIGHT "Credit"
    COL=069 "SW Date Time"
    COL=084 "Acq Inst ID" 
    COL=100 "Trace Number"
    COL=117 "Resp Out/In"
    NEWLINE
    COL=005 "Account Number"
    COL=069 "CU Date Time"
    COL=084 "Set Inst"
    COL=100 "Terminal ID"
    COL=117 "Reference Number"
    NEWLINE
   END
  ELSE
   DO
    COL=001 "Card Number"
    COL=020 "Suffix"
    COL=039 RIGHT "Tran Amount"
    COL=062 RIGHT "Sgl Crrncy ISA Fee"
    COL=087 RIGHT "Multi-Crrncy ISA Fee"
    COL=108 RIGHT "CCA Fee"
    COL=129 RIGHT "ICA Fee"
    NEWLINE
   END
  PRINT REPEATCHR("-",132)
  NEWLINE
 END

 IF LINECOUNT(RPTINDEX,RPTNUMINDEX)>55 OR 
    LINECOUNT(RPTINDEX,RPTNUMINDEX)=0 OR
    SERVICETYPE<>SERVICETYPESAVE THEN
  DO
   IF LINECOUNT(RPTINDEX,RPTNUMINDEX)<>0 THEN
    NEWPAGE
   PRINT SERVICENAME(SERVICETYPE)+" Transactions"
   NEWLINE
   LINECOUNT(RPTINDEX,RPTNUMINDEX)=7
  END
END

PROCEDURE PRINTDETAILITEM
[
|  Print a single detail item 
|
|  Pass:   AUTHFLAG
|          REJECTFLAG
|          TRANTYPE(X)
|          LINECOUNT(X,X)
]
 PRINT ATMDIALOG:PROCESSORACCOUNT
 IF ATMDIALOG:CARDSEQUENCENUMBER<>"" THEN
  COL=020 "-"+SEGMENT(ATMDIALOG:CARDSEQUENCENUMBER,1,1)

 IF ATMDIALOG:FORCEPOST=TRUE THEN
  COL=023 "F"
 IF ATMDIALOG:REVERSALFLAG=TRUE THEN
  COL=024 "R"
 IF AUTHFLAG=TRUE THEN
  COL=025 "A"
 COL=027 ATMDIALOG:TRANSACTIONCODE
 IF TRANTYPE(ATMDIALOG:OURTRANCODE)=TRANCODEWD OR
    TRANTYPE(ATMDIALOG:OURTRANCODE)=TRANCODEXFER THEN
  DO
   AMTCOL=047
   CALL PRINTAMOUNT
  END
 IF TRANTYPE(ATMDIALOG:OURTRANCODE)=TRANCODEDEP OR
    TRANTYPE(ATMDIALOG:OURTRANCODE)=TRANCODEXFER THEN
  DO
   AMTCOL=064
   CALL PRINTAMOUNT
  END
 COL=069 FORMAT("99/",MONTH(ATMDIALOG:TRANSMISSIONDATE))
 PRINT FORMAT("99",DAY(ATMDIALOG:TRANSMISSIONDATE))
 COL=075 SEGMENT(ATMDIALOG:TRANSMISSIONTIME,1,2)
 PRINT ":"
 PRINT SEGMENT(ATMDIALOG:TRANSMISSIONTIME,3,4)
 PRINT ":"
 PRINT SEGMENT(ATMDIALOG:TRANSMISSIONTIME,5,6)
 COL=084 ATMDIALOG:ACQINSTIDCODE
 COL=100 LEFT ATMDIALOG:TRACENUMBER
 COL=124 RIGHT ATMDIALOG:RESPONSECODEOUT
 COL=125 "/"
 COL=126 ATMDIALOG:RESPONSECODEIN
 NEWLINE
 LINECOUNT(RPTINDEX,RPTNUMINDEX)=LINECOUNT(RPTINDEX,RPTNUMINDEX)+1

 IF ATMDIALOG:OURID1<>"" AND ATMDIALOG:OURACCOUNT<>"?" THEN
  DO
   COL=005 ATMDIALOG:OURACCOUNT
   IF ATMDIALOG:OURACCTCODE1<=2 THEN
    COL=016 "S"
   ELSE
    COL=016 "L"
   COL=017 "-"+ATMDIALOG:OURID1
  END
 COL=069 FORMAT("99/",MONTH(ATMDIALOG:OURTRANSMISSIONDATE))
 PRINT FORMAT("99",DAY(ATMDIALOG:OURTRANSMISSIONDATE))
 COL=075 SEGMENT(ATMDIALOG:OURTRANSMISSIONTIME,1,2)
 PRINT ":"
 PRINT SEGMENT(ATMDIALOG:OURTRANSMISSIONTIME,3,4)
 PRINT ":"
 PRINT SEGMENT(ATMDIALOG:LOCALTRANTIME,5,6)
 COL=084 ATMDIALOG:SETTLEMENTINSTID
 COL=100 ATMDIALOG:TERMINALID
 COL=117 ATMDIALOG:REFERENCENUMBER
 NEWLINE
 LINECOUNT(RPTINDEX,RPTNUMINDEX)=LINECOUNT(RPTINDEX,RPTNUMINDEX)+1

 IF ATMDIALOG:OURID2<>"" AND ATMDIALOG:OURACCOUNT2<>"?" THEN
  DO
   COL=05 ATMDIALOG:OURACCOUNT2
   IF ATMDIALOG:OURACCTCODE2<=2 THEN
    COL=16 "S"
   ELSE
    COL=16 "L"
   COL=17 "-"+ATMDIALOG:OURID2
  END
 COL=069 ATMDIALOG:CARDACCEPTORNAME
 IF ATMDIALOG:QUALIFIER1<>"" OR ATMDIALOG:QUALIFIER2<>"" THEN
  DO
   COL=096 "QUAL1: "
   COL=103 ATMDIALOG:QUALIFIER1
   COL=107 "QUAL2: "
   COL=114 ATMDIALOG:QUALIFIER2
  END
 NEWLINE
 LINECOUNT(RPTINDEX,RPTNUMINDEX)=LINECOUNT(RPTINDEX,RPTNUMINDEX)+1

 IF ATMDIALOG:DUPLICATEFLAG=1 THEN
  DO
   COL=10 "*** The above transaction was detected as a duplicate"
   PRINT " and not posted ***"
   NEWLINE
   LINECOUNT(RPTINDEX,RPTNUMINDEX)=LINECOUNT(RPTINDEX,RPTNUMINDEX)+1
  END
 ELSE
  DO
   IF REJECT=TRUE THEN
    DO
     COL=10 "*** The above transaction was Denied - "
     CALL PRINTDENIALREASON
     PRINT " ***"
     NEWLINE
     LINECOUNT(RPTINDEX,RPTNUMINDEX)=LINECOUNT(RPTINDEX,RPTNUMINDEX)+1
    END
   ELSE IF ATMDIALOG:OURRESPONSECODE<>0 THEN
    DO
     COL=10 "*** Our Response Code - "
     CALL PRINTDENIALREASON
     PRINT " ***"
     NEWLINE
     LINECOUNT(RPTINDEX,RPTNUMINDEX)=LINECOUNT(RPTINDEX,RPTNUMINDEX)+1
    END
  END
END

PROCEDURE PRINTAMOUNT
[
|  Print a Credit/Debit Amount
|
|  Pass:   AUTHFLAG
|          REJECTFLAG
|          TRANTYPE(X)
]

 AMTTEXT=FORMAT("##,###,##9.99+",AMOUNT)
 AMTLEN=0
 FOR I=1 TO LENGTH(AMTTEXT)
  DO
   IF SEGMENT(AMTTEXT,I,I)<>"" THEN
    AMTLEN=AMTLEN+1
  END
 IF AUTHFLAG=TRUE OR TRANTYPE(ATMDIALOG:OURTRANCODE)=TRANCODEXFER THEN
  COL=AMTCOL-AMTLEN "("
 COL=AMTCOL AMOUNT
 IF AUTHFLAG=TRUE OR TRANTYPE(ATMDIALOG:OURTRANCODE)=TRANCODEXFER THEN
  COL=AMTCOL+2 ")"
 IF REJECT=TRUE OR TRANTYPE(ATMDIALOG:OURTRANCODE)=TRANCODEINVALID OR
    ATMDIALOG:DUPLICATEFLAG=1 THEN
  COL=AMTCOL+3 "*"
END

PROCEDURE PRINTINTLFEEITEM
[
|  Print detail line for international fee
| 
|  PASS:   FEEAMOUNT(X)
]

 COL=001 ATMDIALOG:PROCESSORACCOUNT
 COL=020 ATMDIALOG:CARDSEQUENCENUMBER
 COL=039 RIGHT ATMDIALOG:POSTAMOUNT
 COL=062 RIGHT FEEAMOUNT(FEETYPEVISASC)
 COL=087 RIGHT FEEAMOUNT(FEETYPEVISAMC)
 COL=108 RIGHT FEEAMOUNT(FEETYPEMCCCA)
 COL=129 RIGHT FEEAMOUNT(FEETYPEMCICA)
 NEWLINE
END

PROCEDURE CALCSUBTOTALS
[
|  Calculate Totals for a specific Service.
|  If issuer, total is Withdrawal-Deposit
|  If acquirer, total is Deposit-Withdrawal
|  
|  Pass:  RPTINDEX
|         SERVICETYPE
|         TOTALAMOUNTS(X,X,X,X)
]
 IF ROUTINGCODE(SERVICETYPE)=1 THEN
  TOTALAMOUNTS(RPTINDEX,SERVICETYPE,FALSE,TOTALINDEX)=
   TOTALAMOUNTS(RPTINDEX,SERVICETYPE,FALSE,TRANCODEDEP)-
    TOTALAMOUNTS(RPTINDEX,SERVICETYPE,FALSE,TRANCODEWD)
 ELSE
  TOTALAMOUNTS(RPTINDEX,SERVICETYPE,FALSE,TOTALINDEX)=
   TOTALAMOUNTS(RPTINDEX,SERVICETYPE,FALSE,TRANCODEWD)-
    TOTALAMOUNTS(RPTINDEX,SERVICETYPE,FALSE,TRANCODEDEP)

 TOTALAMOUNTS(RPTINDEX,TOTALINDEX,FALSE,TOTALINDEX)=
  TOTALAMOUNTS(RPTINDEX,TOTALINDEX,FALSE,TOTALINDEX)+
   TOTALAMOUNTS(RPTINDEX,SERVICETYPE,FALSE,TOTALINDEX)
END

PROCEDURE PRINTREPORTTOTALS
[
|  Print totals per report type to Summary report 
|  or Detail Report
|
|  Pass:  RPTINDEX
|         SERVICETYPE
|         RPTNAME(X)
|         TOTALCOUNTS(X,X,X,X)
|         TOTALAMOUNTS(X,X,X,X)
]
 IF RPTOPENED=OUTPUTCHANNELDEFAULT OR RPTNUMINDEX=0 THEN
  DO
   FOR SERVICETYPE=SERVICEISS TO SERVICEMAX
    DO
     IF TOTALCOUNTS(RPTINDEX,SERVICETYPE,FALSE,TOTALINDEX)>0 OR
        TOTALCOUNTS(RPTINDEX,SERVICETYPE,TRUE,TOTALINDEX)>0 THEN
      CALL PRINTSUBTOTAL
    END
   COL=126 RIGHT REPEATCHR("-",16)
   NEWLINE
   PRINT "TOTALS "
   COL=015 RPTNAME(RPTINDEX)
   COL=123 ABS(TOTALAMOUNTS(RPTINDEX,TOTALINDEX,FALSE,TOTALINDEX))
   IF TOTALAMOUNTS(RPTINDEX,TOTALINDEX,FALSE,TOTALINDEX)>=$0.00 THEN
    COL=126 "DB"
   ELSE
    COL=126 "CR"
   NEWLINE
   COL=126 RIGHT REPEATCHR("-",16)
   NEWLINE
  END
 IF RPTOPENED=OUTPUTCHANNELDEFAULT OR RPTNUMINDEX=1 THEN
  DO
   FOR SERVICETYPE=SERVICEISS TO SERVICEMAX
    DO
     IF TOTALCOUNTS(RPTINDEX,SERVICETYPE,FALSE,TOTALINDEX)>0 OR
        TOTALCOUNTS(RPTINDEX,SERVICETYPE,TRUE,TOTALINDEX)>0 THEN
      CALL PRINTINTLTOTALS
    END
  END
END

PROCEDURE PRINTSUBTOTAL
[
|  Print totals for a specific report/service.
|  
|  Pass:  RPTINDEX
|         RPTNAME(X)
|         TOTALAMOUNTS(X,X,X)
]
 COL=072 RIGHT "DEBIT"
 COL=089 RIGHT "CREDIT"
 COL=106 RIGHT "TRANSFERS"
 COL=126 RIGHT "TOTAL"
 NEWLINE

 COL=072 RIGHT REPEATCHR("-",16)
 COL=089 RIGHT REPEATCHR("-",16)
 COL=106 RIGHT REPEATCHR("-",16)
 COL=126 RIGHT REPEATCHR("-",16)
 NEWLINE

 PRINT "SUBTOTAL "
 COL=015 RPTNAME(RPTINDEX)+" - "+SERVICENAME(SERVICETYPE)
 IF ROUTINGCODE(SERVICETYPE)=1 THEN
  DO
   COL=072 TOTALAMOUNTS(RPTINDEX,SERVICETYPE,FALSE,TRANCODEDEP)
   COL=089 TOTALAMOUNTS(RPTINDEX,SERVICETYPE,FALSE,TRANCODEWD)
  END
 ELSE
  DO
   COL=072 TOTALAMOUNTS(RPTINDEX,SERVICETYPE,FALSE,TRANCODEWD)
   COL=089 TOTALAMOUNTS(RPTINDEX,SERVICETYPE,FALSE,TRANCODEDEP)
  END
 COL=106 TOTALAMOUNTS(RPTINDEX,SERVICETYPE,FALSE,TRANCODEXFER)
 COL=123 ABS(TOTALAMOUNTS(RPTINDEX,SERVICETYPE,FALSE,TOTALINDEX))
 IF TOTALAMOUNTS(RPTINDEX,SERVICETYPE,FALSE,TOTALINDEX)>=$0.00 THEN
  COL=126 "DB"
 ELSE
  COL=126 "CR"
 NEWLINE

 COL=072 RIGHT REPEATCHR("-",16)
 COL=089 RIGHT REPEATCHR("-",16)
 COL=106 RIGHT REPEATCHR("-",16)
 COL=126 RIGHT REPEATCHR("-",16)
 NEWLINE
 NEWLINE
END

PROCEDURE PRINTINTLTOTALS
[
|  PRINT INTERNATIONAL FEE TOTALS
|
|  Pass:  RPTOPENED
|         TOTALFEEAMOUNTS(X,X,X,X)
]
 FEEAMOUNT(TOTALINDEX)=$0.00
 FOR I=FEETYPEVISASC TO FEETYPEMCICA
  DO
   FEEAMOUNT(I)=TOTALFEEAMOUNTS(RPTINDEX,SERVICETYPE,FALSE,I)
   FEEAMOUNT(TOTALINDEX)=FEEAMOUNT(TOTALINDEX)+FEEAMOUNT(I)
  END

 IF RPTOPENED<>OUTPUTCHANNELDEFAULT THEN
  DO
   PRINT REPEATCHR("-",132)
   NEWLINE
   COL=001 "TOTAL INTERNATIONAL FEES"
   COL=062 RIGHT FEEAMOUNT(FEETYPEVISASC)
   COL=087 RIGHT FEEAMOUNT(FEETYPEVISAMC)
   COL=108 RIGHT FEEAMOUNT(FEETYPEMCCCA)
   COL=129 RIGHT FEEAMOUNT(FEETYPEMCICA)
   NEWLINE
   NEWLINE
  END
 IF FEEAMOUNT(FEETYPEVISASC)+FEEAMOUNT(FEETYPEVISAMC)<>$0.00 THEN
  DO
   COL=072 RIGHT "SINGLE CURRENCY"
   COL=089 RIGHT "MULTI-CURRENCY"
   NEWLINE
   COL=072 RIGHT REPEATCHR("-",16)
   COL=089 RIGHT REPEATCHR("-",16)
   COL=126 RIGHT REPEATCHR("-",16)
   NEWLINE
   PRINT "VISA FEES"
   COL=015 RPTNAME(RPTINDEX)+" - "+SERVICENAME(SERVICETYPE)
   COL=072 FEEAMOUNT(FEETYPEVISASC)
   COL=089 FEEAMOUNT(FEETYPEVISAMC)
   COL=123 FEEAMOUNT(FEETYPEVISASC)+FEEAMOUNT(FEETYPEVISAMC)
   IF FEEAMOUNT(FEETYPEVISASC)+FEEAMOUNT(FEETYPEVISAMC)>=$0.00 THEN
    COL=126 "DB"
   ELSE
    COL=126 "CR"
   NEWLINE
  END
 IF FEEAMOUNT(FEETYPEMCCCA)+FEEAMOUNT(FEETYPEMCICA)<>$0.00 THEN
  DO
   COL=072 RIGHT "CURRENCY CONVERSION(CCA)"
   COL=089 RIGHT "CROSS BORDER(ICA)"
   NEWLINE
   COL=072 RIGHT REPEATCHR("-",16)
   COL=089 RIGHT REPEATCHR("-",16)
   COL=126 RIGHT REPEATCHR("-",16)
   NEWLINE
   PRINT "MC FEES"
   COL=015 RPTNAME(RPTINDEX)+" - "+SERVICENAME(SERVICETYPE)
   COL=072 FEEAMOUNT(FEETYPEMCCCA)
   COL=089 FEEAMOUNT(FEETYPEMCICA)
   COL=123 FEEAMOUNT(FEETYPEMCCCA)+FEEAMOUNT(FEETYPEMCICA)
   IF FEEAMOUNT(FEETYPEMCCCA)+FEEAMOUNT(FEETYPEMCICA)>=$0.00 THEN
    COL=126 "DB"
   ELSE
    COL=126 "CR"
   NEWLINE
  END
 IF FEEAMOUNT(FEETYPEVISASC)+FEEAMOUNT(FEETYPEVISAMC)<>$0.00 AND
    FEEAMOUNT(FEETYPEMCCCA)+FEEAMOUNT(FEETYPEMCICA)<>$0.00 THEN
  DO
   COL=126 RIGHT REPEATCHR("-",16)
   NEWLINE
   PRINT "TOTAL FEES"
   COL=015 RPTNAME(RPTINDEX)+" - "+SERVICENAME(SERVICETYPE)
   COL=123 FEEAMOUNT(TOTALINDEX)
   IF FEEAMOUNT(TOTALINDEX)>=$0.00 THEN
    COL=126 "DB"
   ELSE
    COL=126 "CR"
   NEWLINE
   COL=126 RIGHT REPEATCHR("-",16)
   NEWLINE
  END
END

PROCEDURE PRINTBALANCINGTOTALS
[
A debit balance would be entered as positive and a credit balance would be entered as a negative.

Yesterday’s Difference:
(+) Today’s System Report
(-) Today’s Settle Report
(-) Today's Diff2 Report
(+) Tomorrow's Diff 2 Report
(=) Today’s Difference:
]

 TOTALAMOUNTS(TOTALINDEX,TOTALINDEX,FALSE,TOTALINDEX)=
  TOTALAMOUNTS(RPTDIFF1YESTERDAY,TOTALINDEX,FALSE,TOTALINDEX)+
  TOTALAMOUNTS(RPTSYSTEM,TOTALINDEX,FALSE,TOTALINDEX)-
  TOTALAMOUNTS(RPTSETTLE,TOTALINDEX,FALSE,TOTALINDEX)-
  TOTALAMOUNTS(RPTDIFF2,TOTALINDEX,FALSE,TOTALINDEX)+
  TOTALAMOUNTS(RPTDIFF2TOMORROW,TOTALINDEX,FALSE,TOTALINDEX)

 COL=001 "Yesterday"+APOSTROPHE+"s Difference Report"
 COL=123 TOTALAMOUNTS(RPTDIFF1YESTERDAY,TOTALINDEX,FALSE,TOTALINDEX)
 NEWLINE
 COL=001 "  (+) Today"+APOSTROPHE+"s System Report"
 COL=123 TOTALAMOUNTS(RPTSYSTEM,TOTALINDEX,FALSE,TOTALINDEX)
 NEWLINE
 COL=001 "  (-) Today"+APOSTROPHE+"s Settle Report"
 COL=123 TOTALAMOUNTS(RPTSETTLE,TOTALINDEX,FALSE,TOTALINDEX)
 NEWLINE
 COL=001 "  (-) Today"+APOSTROPHE+"s Diff2 Report"
 COL=123 TOTALAMOUNTS(RPTDIFF2,TOTALINDEX,FALSE,TOTALINDEX)
 NEWLINE
 COL=001 "  (+) Tomorrow"+APOSTROPHE+"s Diff 2 Report"
 COL=123 TOTALAMOUNTS(RPTDIFF2TOMORROW,TOTALINDEX,FALSE,TOTALINDEX)
 NEWLINE
 COL=126 RIGHT REPEATCHR("-",16)
 NEWLINE
 COL=001 "(=) Today"+APOSTROPHE+"s Difference/GL Balance:"
 COL=123 TOTALAMOUNTS(TOTALINDEX,TOTALINDEX,FALSE,TOTALINDEX)
 NEWLINE
 COL=001 "  (-) Today"+APOSTROPHE+"s Difference Report:"
 COL=123 TOTALAMOUNTS(RPTDIFF1,TOTALINDEX,FALSE,TOTALINDEX)
 NEWLINE
 COL=126 RIGHT REPEATCHR("=",16)
 NEWLINE
 COL=001 "(=) Amount reports are Out of Balance:"
 COL=123 TOTALAMOUNTS(TOTALINDEX,TOTALINDEX,FALSE,TOTALINDEX)-
         TOTALAMOUNTS(RPTDIFF1,TOTALINDEX,FALSE,TOTALINDEX)
 NEWLINE
 NEWLINE
 IF TOTALAMOUNTS(TOTALINDEX,TOTALINDEX,FALSE,TOTALINDEX)-
     TOTALAMOUNTS(RPTDIFF1,TOTALINDEX,FALSE,TOTALINDEX)<>$0.00 THEN
  DO
   PRINT "WARNING: Reports should balance to themselves but they do not. Look for"
   PRINT " transactions listed at the beginning of this report"
   NEWLINE
   PRINT "that may have a blank settlement date."
   NEWLINE
  END
END

PROCEDURE REPORTSWITCH
[
|  Switch to a Detail Report. If first time, open report
| 
|  Pass:   RPTINDEX
|          RPTNUMINDEX
|
|  Return: RPTNUM(RPTINDEX,RPTNUMINDEX)
]
 IF RPTNUM(RPTINDEX,RPTNUMINDEX)=0 THEN
  DO
   IF RPTNUMINDEX=0 THEN
    OUTPUTOPEN(OUTPUTDEVREPORT,0,RPTNAME(RPTINDEX),"ATMREPORTS",TMPRPTNUM,ERRORTEXT)
   ELSE
    OUTPUTOPEN(OUTPUTDEVREPORT,0,RPTNAME(RPTINDEX)+" Intl Fees","ATMREPORTS",TMPRPTNUM,ERRORTEXT)
   RPTNUM(RPTINDEX,RPTNUMINDEX)=TMPRPTNUM
   IF ERRORTEXT<>"" THEN
    CALL FILEERRORHANDLER
   END
 OUTPUTSWITCH(RPTNUM(RPTINDEX,RPTNUMINDEX),ERRORTEXT)
 IF ERRORTEXT<>"" THEN
  CALL FILEERRORHANDLER
END

PROCEDURE FILEERRORHANDLER
[
|  Check File I/O Error and Terminate 
|
|  Pass:   FILEERROR
]
 IF ERRORTEXT<>"" AND ERRORTEXT<>"EOF" THEN
  DO
   PRINT "ERROR: "+ERRORTEXT+"!"
   NEWLINE
   TERMINATE
  END
END

PROCEDURE GETNETWORKBYALPHA
[
|  Prompt user for the Network Message Type
|  Network names in alpha order
|
|  Return: NETWORKMSGFORMAT
]
 NETWORKMSGFORMAT=32 
[NUMBERREAD("",
  "(26) ACI B24 ISO87",
  "(41) Alaric ISO87",
  "(02) Bevertec ISO87",
  "(36) Certegy B24 ISO93",
  "(33) Certegy VIP ISO87",
  "(09) CO-OP ISO87",
  "(10) CO-OP/SCC ISO87",
  "(13) CUSC-NGN ISO87",
  "(06) EDS ANSI",
  "(08) eFunds ISO87",
  "(28) elan B24 ISO87",
  "(39) EPOC ISO93",
  "(03) FIS ISOI ISO87",
  "(29) FiServ B24 ISO87",
  "(15) FDR/NYCE ISO87",
  "(25) FDR ISO87",
  "(16) FSCC ISO87",
  "(17) Interpro ISO87",
  "(20) jhaPassPort ISO87",
  "(40) LynxGate CAT ISO93",
  "(23) MAC Star ISO87",
  "(35) MC PTS ISO93",
  "(42) Metavante B24 ISO87",
  "(07) MPS ANSI",
  "(19) NYCE ISO87",
  "(24) PostBridge ISO87",
  "(32) PPS VIP ISO87",
  "(21) Star NE ISO87",
  "(34) Shazam ISO93",
  "(38) Vantiv ISO87",
  "(11) Visa DPS ISO87",
  "","Network/Message Format")
]
END

PROCEDURE SETARRAYCONSTANTS
[  Initialize various arrays referenced in PowerOn
|
|  Return: PROCESSORNAME(X)
|          SERVICENAME(X)
|          ROUTINGCODE(X)
|          RPTNAME(X)
|          TRANTYPE(X)
]
 PROCESSORNAME(26)="ACI"
 PROCESSORNAME(41)="Alaric"
 PROCESSORNAME(02)="Bevertec"
 PROCESSORNAME(36)="Certegy B24"
 PROCESSORNAME(33)="Certegy VIP" 
 PROCESSORNAME(09)="CO-OP" 
 PROCESSORNAME(10)="CO-OP/SCC"
 PROCESSORNAME(13)="CUSC-NGN" 
 PROCESSORNAME(06)="EDS"
 PROCESSORNAME(08)="eFunds"
 PROCESSORNAME(28)="elan"
 PROCESSORNAME(39)="EPOC" 
 PROCESSORNAME(03)="FIS ISOI" 
 PROCESSORNAME(29)="FiServ B24"
 PROCESSORNAME(15)="FDR/NYCE"
 PROCESSORNAME(25)="FDR"
 PROCESSORNAME(16)="FSCC" 
 PROCESSORNAME(17)="Interpro"
 PROCESSORNAME(20)="CPS/jhaPassPort"
 PROCESSORNAME(40)="LynxGate"
 PROCESSORNAME(23)="MAC Star"
 PROCESSORNAME(35)="MC PTS"
 PROCESSORNAME(42)="Metavante"
 PROCESSORNAME(07)="MPS"
 PROCESSORNAME(19)="NYCE"
 PROCESSORNAME(24)="Postbridge"
 PROCESSORNAME(32)="CPS" 
 PROCESSORNAME(21)="StarNE"
 PROCESSORNAME(34)="Shazam"
 PROCESSORNAME(38)="Vantiv"
 PROCESSORNAME(11)="Visa DPS"

 SERVICENAME(SERVICEISS)="Issuer"
 SERVICENAME(SERVICEACQ)="Acquirer"
 SERVICENAME(SERVICESBI)="SB Issuer"
 SERVICENAME(SERVICESBA)="SB Acquirer"
 ROUTINGCODE(SERVICEISS)=0
 ROUTINGCODE(SERVICEACQ)=1
 ROUTINGCODE(SERVICESBI)=0
 ROUTINGCODE(SERVICESBA)=1
 SELECTDATECHR=FORMAT("99/99",SELECTDATE)
 RPTNAME(RPTSUMMARY)=PROCESSORNAME(NETWORKMSGFORMAT)+" - Summary "+SELECTDATECHR
 RPTNAME(RPTSETTLE)=PROCESSORNAME(NETWORKMSGFORMAT)+" - Settle "+SELECTDATECHR
 RPTNAME(RPTSYSTEM)=PROCESSORNAME(NETWORKMSGFORMAT)+" - System "+SELECTDATECHR
 RPTNAME(RPTDIFF1)=PROCESSORNAME(NETWORKMSGFORMAT)+" - Diff 1 "+SELECTDATECHR
 RPTNAME(RPTDIFF2)=PROCESSORNAME(NETWORKMSGFORMAT)+" - Diff 2 "+SELECTDATECHR
 RPTNAME(RPTEXCEPTIONS)=PROCESSORNAME(NETWORKMSGFORMAT)+" - Except "+SELECTDATECHR
 RPTDESC(RPTSETTLE)="Report is for Network Settlement Date "+SELECTDATECHR
 RPTDESC(RPTSYSTEM)="Report is for Credit Union System Date "+SELECTDATECHR
 RPTDESC(RPTDIFF1)="Report Contains Items for System Date "+SELECTDATECHR+
                   " that have a Settlement Date after "+SELECTDATECHR
 RPTDESC(RPTDIFF2)="Report contains items for System Date "+SELECTDATECHR+
                   " that have a Settlement Date before "+SELECTDATECHR
 RPTDESC(RPTEXCEPTIONS)="Report contains exception items for System Date "+SELECTDATECHR+
                   " that must be hand posted. "

 SELECTDATECHR=FORMAT("99/99",SELECTDATE-1)
 RPTNAME(RPTDIFF1YESTERDAY)=PROCESSORNAME(NETWORKMSGFORMAT)+" - Diff 1 "+SELECTDATECHR
 RPTDESC(RPTDIFF1YESTERDAY)="Report Contains Items for System Date "+SELECTDATECHR+
                   " that have a Settlement Date after "+SELECTDATECHR

 SELECTDATECHR=FORMAT("99/99",SELECTDATE+1)
 RPTNAME(RPTDIFF2TOMORROW)=PROCESSORNAME(NETWORKMSGFORMAT)+" - Diff 2 "+SELECTDATECHR
 RPTDESC(RPTDIFF2TOMORROW)="Report contains items for System Date "+SELECTDATECHR+
                   " that have a Settlement Date before "+SELECTDATECHR

 TRANTYPE(0)=TRANCODEINVALID
 TRANTYPE(1)=TRANCODEINQ           [Inquiry]
 TRANTYPE(2)=TRANCODEDEP           [Deposit]
 TRANTYPE(3)=TRANCODEWD            [Withdrawal]
 TRANTYPE(4)=TRANCODEXFER          [Transfer]
 TRANTYPE(5)=TRANCODEWD            [Fee Withdrawal]
 TRANTYPE(6)=TRANCODEINQ           [Hold Placement]
 TRANTYPE(7)=TRANCODEDEP           [Payment Enclosed]
 TRANTYPE(8)=TRANCODEINQ           [GL]
 TRANTYPE(9)=TRANCODEDEP           [Hand Post Deposit]
 TRANTYPE(10)=TRANCODEXFER         [Hand Post Transfer]
 TRANTYPE(11)=TRANCODEINQ          [Member Verify]
 TRANTYPE(12)=TRANCODEINQ          [Statement Print]
 TRANTYPE(13)=TRANCODEDEP          [Hand Post Pmt Rev] [PEMCO HAS XFRS IN HERE]
 TRANTYPE(14)=TRANCODEINQ          [PIN Offset Change]
 TRANTYPE(15)=TRANCODEDEP          [Credit]
 TRANTYPE(16)=TRANCODEINQ          [Special Purchase]
END

#INCLUDE "RB.PRINTDENIALREASON.INC"


