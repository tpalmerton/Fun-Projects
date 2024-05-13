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
            ${.now?string("yyyy-MM-dd")},<#t>  <#-- Date of Settlement Report -->
            ${report.reimbursed?date("yyyy-MM-dd")?string("yyyy-MM-dd")},<#t><#--  Reimbursement Initiated Date-->
            ${reportState},<#t><#--  Report Withdrawing Status -->
            ${expectedDate},<#t><#--  Estimated Deposit Date -->
            ${report.policyName},<#t>  <#-- Company -->
            ${reimbursableTotal?string("0.00")},<#t>  <#-- Debit Amount -->
            ${report.reportID},<#t>  <#-- Payment ID -->
            ${expense.comment},<#t>  <#-- Description -->
            ${category},<#t>  <#-- GL Category (if applicable) -->
            ${ntag1},<#t>  <#-- Tag1 (if applicable) -->
            ${report.submitterEmail},<#t>  <#-- Submitter Email -->
            ${blank},<#t>  <#-- Report Submitted To (if applicable) -->
            ${blank}<#lt>  <#-- Report First Approved (if applicable) -->
            ${expense.receiptObject.url}<#lt><#-- Receipt Link -->
    </#if>
</#list>







ADDITIONAL HELP
<#-- added to: sklopf@ideo.com, sgupta@ideo.com, zzhou@ideo.com -->
<#-- test reportIDs:  -->
<#-- template name: Accrual -- Reimbursable -->
<#-- creator: Ray -->
<#-- issue URL: https://github.com/Expensify/Expensify/issues/81543 -->
<#if (addHeader == true)>
    Policy Name,<#t>
    Employee Email Address,<#t>
    Custom Field 1,<#t>
    Transaction Date,<#t>
    Amount,<#t>
    Currency,<#t>
    Expense Status,<#t>
    Project/NonProject,<#t>
    Project ID,<#t>
    Project Name,<#t>
    Client Name,<#t>
    Project Entity,<#t>
    Studio,<#t>
    Department,<#t>
    Merchant,<#t>
    GL Code,<#t>
    Comment,<#t>
    Project Group ID,<#t>
    Receipt Link<#lt>
</#if>
<#list reports as report>
    <#list report.transactionList as expense>
        <#if expense.modifiedCreated?has_content>
            <#assign created = expense.modifiedCreated?date("yyyy-MM-dd")>
        <#else>
            <#assign created = expense.created?date("yyyy-MM-dd")>
        </#if>
        <#if expense.modifiedMerchant?has_content>
            <#assign merchant = expense.modifiedMerchant>
        <#else>
            <#assign merchant = expense.merchant>
        </#if>
        <#if expense.convertedAmount?has_content>
            <#assign amount = expense.convertedAmount/100>
        <#elseif expense.modifiedAmount?has_content>
            <#assign amount = expense.modifiedAmount/100>
        <#else>
            <#assign amount = expense.amount/100>
        </#if>
        <#assign ntag2Array = expense.ntag2?split("-")>
        <#assign ntagGlCodeArray = expense.ntag2GlCode?split("-")>
        <#if expense.reimbursable>
            <#-- Policy Name -->${report.policyName},<#t>
            <#-- Employee Email Address -->${report.accountEmail},<#t>
            <#-- Custom Field 1 -->${report.submitterUserID},<#t>
            <#-- Transaction Date -->${created?string("M/d/yyyy")},<#t>
            <#-- Amount -->${amount?string("0.00")},<#t>
            <#-- Currency -->${expense.currency},<#t>
            <#-- Expense Status -->${report.status},<#t>
            <#-- Project/NonProject -->${expense.ntag1},<#t>
            <#-- Project ID -->"${ntag2Array[2]?replace("\"", "")}",<#t>
            <#-- Project Name -->"${ntag2Array[1]?replace("\"", "")}",<#t>
            <#-- Client Name -->"${ntag2Array[0]?replace("\"", "")}",<#t>
            <#-- Project Entity -->"${ntag2Array[3]?replace("\"", "")}",<#t>
            <#-- Studio -->"${ntagGlCodeArray[1]?replace("\"", "")}",<#t>
            <#-- Department -->"${ntagGlCodeArray[2]?replace("\"", "")}",<#t>
            <#-- Merchant -->${merchant},<#t>
            <#-- GL Code -->${expense.categoryGlCode},<#t>
            <#-- Comment -->${expense.comment},<#t>
            <#-- Project Group ID -->"${ntagGlCodeArray[3]?replace("\"", "")}",<#t>
            <#-- Receipt Link -->${expense.receiptObject.url}<#lt>
        </#if>
    </#list>
</#list>
