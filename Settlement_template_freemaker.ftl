<#-- Add to: ENTER EMAIL ADDRESS -->
<#-- Test Report IDs: ENTER REPORT ID-->
<#-- Template Name: Settlements Report -->
<#-- Creator: TPalmerton -->
<#-- Issue URL: ENTER ISSUE URL  -->
<#-- Template only targets reimbursed confirmed (stateNum == 6) and reimbursed withdrawing (stateNum == 3) / report-level export -->
<#-- Only prints reports that were reimbursed in the current month -->
<#if addHeader>
    Date of Settlement Report,<#t>
    Company,<#t><#-- Merchant -->
    Reimbursement Initiated Date,<#t>
    Report Withdrawing Status,<#t>
    Estimated Deposit Date,<#t>
    Company,<#t>
    Line number,<#t>
    Account type,<#t>
    Account,<#t>
    Credit,<#t>
    Debit,<#t> <#-- Debit Amout -->
    Currency,<#t>
    Offset account,<#t>
    Offset account type,<#t>
    Payment ID,<#t>
    Method of payment,<#t>
    Settlements,<#t>
    Description<#lt> <#-- Not Report ID, description of report_ -->
    Gl Category,<#t>
    Tag1,<#t>
    Submitter Email<#t>
    Report Submitted To<#t>
    Report First Approved,<#t>

</#if>
<#assign blank= "">
<#list reports as report>
    <#if (report.stateNum == 6) || (report.stateNum == 3)>
        <#assign reimbursableTotal = 0>
        <#list report.transactionList as expense>
            <#if (expense.reimbursable == true)>
                <#if expense.convertedAmount?has_content>
                    <#assign amount = (expense.convertedAmount/100)>
                <#elseif expense.modifiedAmount?has_content>
                    <#assign amount = (expense.modifiedAmount/100)>
                <#else>
                    <#assign amount = (expense.amount/100)>
                </#if>
                <#assign reimbursableTotal = reimbursableTotal + amount>
            </#if>
        </#list>
        <#assign expectedDate = "">
        <#list report.actionList as action>
            <#if action.action == "REIMBURSED">
                <#assign expectedDate = action.details.expectedDate?date("yyyy-MM-dd")?string("yyyy-MM-dd")>
            </#if>
        </#list>
        <#assign description = "Expense report number" + " " + report.reportID + "EMP1" + " " + report.submitterUserID>
        <#assign account = report.submitterUserID+"EMP1">
        <#assign accountType = "Vendor">
        <#assign offsetAccount = "WFDISB">
        <#assign offsetAccountType = "Bank">
        <#assign method = "Expensify">
        <#if report.stateNum == 6>
            <#assign reportState = "Confirmed">
        <#else>
            <#assign reportState = "Withdrawing">
        </#if>
        <#if (.now?string("MM") == report.reimbursed?date("yyyy-MM-dd")?string("MM"))>
            <#--  Date of Settlement Report  -->${.now?string("yyyy-MM-dd")},<#t>
            <#--  Reimbursement Initiated Date-->${report.reimbursed?date("yyyy-MM-dd")?string("yyyy-MM-dd")},<#t>
            <#--  Report Withdrawing Status -->${reportState},<#t>
            <#--  Estimated Deposit Date -->${expectedDate},<#t>
            <#--  Company  -->${report.policyName},<#t>
            <#--  Line number  -->${blank},<#t>
            <#--  Account type  -->${accountType},<#t>
            <#--  Account  -->${account},<#t>
            <#--  Credit  -->${blank},<#t>
            <#--  Debit  -->${reimbursableTotal?string("0.00")},<#t>
            <#--  Currency -->${report.currency},<#t>
            <#--  Offset account  -->${offsetAccount},<#t>
            <#--  Offset account type  -->${offsetAccountType},<#t>
            <#--  Payment ID  -->${report.reportID},<#t>
            <#--  Method of payment  -->${method},<#t>
            <#--  Settlements  -->${blank},<#t>
            <#--  Description  -->${description}<#lt>
        </#if>
    </#if>
</#list>













<#-- Add to: ptjohn@ideo.com, sklopf@ideo.com, ebarron@ideo.com -->
<#-- Test Report IDs: 33763992,33712455,33724101-->
<#-- Template Name: Settlements Report (Current Month Only) -->
<#-- Creator: jboniface -->
<#-- Issue URL: https://github.com/Expensify/Expensify/issues/91208  -->
<#-- Template only targets reimbursed confirmed (stateNum == 6) and reimbursed withdrawing (stateNum == 3) / report-level export -->
<#-- Only prints reports that were reimbursed in the current month -->
<#if addHeader>
    Date of Settlement Report,<#t>
    Company,<#t>
    Debit Amount,<#t>
    Payment ID,<#t>
    Description,<#t>
    GL Category,<#t>
    Tag1,<#t>
    Submitter Email,<#t>
    Report Submitted To,<#t>
    Report First Approved<#lt>
</#if>
<#assign blank = "">
<#list reports as report>
    <#if (report.stateNum == 6) || (report.stateNum == 3)>
        <#assign reimbursableTotal = 0>
        <#list report.transactionList as expense>
            <#if (expense.reimbursable == true)>
                <#if expense.convertedAmount?has_content>
                    <#assign amount = (expense.convertedAmount/100)>
                <#elseif expense.modifiedAmount?has_content>
                    <#assign amount = (expense.modifiedAmount/100)>
                <#else>
                    <#assign amount = (expense.amount/100)>
                </#if>
                <#assign reimbursableTotal = reimbursableTotal + amount>
            </#if>
        </#list>
        <#assign expectedDate = "">
        <#list report.actionList as action>
            <#if action.action == "REIMBURSED">
                <#assign expectedDate = action.details.expectedDate?date("yyyy-MM-dd")?string("yyyy-MM-dd")>
            </#if>
        </#list>
        <#assign description = "Expense report number" + " " + report.reportID + "EMP1" + " " + report.submitterUserID>
        <#assign account = report.submitterUserID+"EMP1">
        <#assign accountType = "Vendor">
        <#assign offsetAccount = "WFDISB">
        <#assign offsetAccountType = "Bank">
        <#assign method = "Expensify">
        <#if report.stateNum == 6>
            <#assign reportState = "Confirmed">
        <#else>
            <#assign reportState = "Withdrawing">
        </#if>
        <#if (.now?string("MM") == report.reimbursed?date("yyyy-MM-dd")?string("MM"))>
            ${.now?string("yyyy-MM-dd")},<#t>  <#-- Date of Settlement Report -->
            ${report.policyName},<#t>  <#-- Company -->
            ${reimbursableTotal?string("0.00")},<#t>  <#-- Debit Amount -->
            ${report.reportID},<#t>  <#-- Payment ID -->
            ${comment},<#t>  <#-- Description -->
            ${category},<#t>  <#-- GL Category (if applicable) -->
            ${ntag1},<#t>  <#-- Tag1 (if applicable) -->
            ${report.submitterEmail},<#t>  <#-- Submitter Email -->
            ${blank},<#t>  <#-- Report Submitted To (if applicable) -->
            ${blank}<#lt>  <#-- Report First Approved (if applicable) -->
        </#if>
    </#if>
</#list>
