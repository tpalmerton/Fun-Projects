<#-- Add to: ENTER EMAIL ADDRESS -->
<#-- Test Report IDs: ENTER REPORT ID-->
<#-- Template Name: Settlements Report -->
<#-- Creator: TPalmerton -->
<#-- Issue URL: ENTER ISSUE URL  -->
<#-- Template targets reimbursed confirmed (stateNum == 6) and reimbursed withdrawing (stateNum == 3) / report-level export -->
<#if addHeader>
    Date of Settlement Report,<#t>
    Reimbursement Initiated Date,<#t>
    Report Withdrawing Status,<#t>
    Estimated Deposit Date,<#t>
    Company,<#t>
    Debit Amount,<#t>
    Payment ID,<#t>
    Description,<#t>
    GL Category,<#t>
    Tag1,<#t>
    Submitter Email,<#t>
    Report Submitted To,<#t>
    Report First Approved<#t>
    Receipt Link<#lt>
</#if> 
<#assign blank = "">
<#list reports as report>
    <#if expense.modifiedCreated?has_content>
        <#assign created = expense.modifiedCreated?date("yyyy-MM-dd")>
    <#else>
        <#assign created = expense.created?date("yyyy-MM-dd")>
    </#if>
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
        <#assign accountType = "Vendor">
        <#assign offsetAccount = "WFDISB">
        <#assign offsetAccountType = "Bank">
        <#assign method = "Expensify">
        <#if report.stateNum == 6>
            <#assign reportState = "Confirmed">
        <#else>
            <#assign reportState = "Withdrawing">
        </#if>
            ${.now?string("yyyy-MM-dd")},<#t>  <#-- Date of Settlement Report -->
            ${report.reimbursed?date("yyyy-MM-dd")?string("yyyy-MM-dd")},<#t><#--  Reimbursement Initiated Date-->
            ${reportState},<#t><#--  Report Withdrawing Status -->
            ${expectedDate},<#t><#--  Estimated Deposit Date -->
            ${report.policyName},<#t>  <#-- Company -->
            ${reimbursableTotal?string("0.00")},<#t>  <#-- Debit Amount -->
            ${report.reportID},<#t>  <#-- Payment ID -->
            ${expense.comment},<#t>  <#-- Description -->
            ${expense.category},<#t>  <#-- GL Category (if applicable) -->
            ${expense.ntag1},<#t>  <#-- Tag1 (if applicable) -->
            ${report.submitterEmail},<#t>  <#-- Submitter Email -->
            ${blank},<#t>  <#-- Report Submitted To (if applicable) -->
            ${blank}<#t>  <#-- Report First Approved (if applicable) -->
            ${expense.receiptObject.url}<#lt><#-- Receipt Link -->
    </#if>
</#list>
