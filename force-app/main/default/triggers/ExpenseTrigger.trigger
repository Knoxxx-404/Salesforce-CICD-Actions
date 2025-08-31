/**
 * @description       : This is a description
 * @author            : Sangram Keshari Upadhyaya
 * @group             : 
 * @last modified on  : 01-09-2025
 * @last modified by  : Sangram Keshari Upadhyaya
 * Modifications Log
 * Ver   Date         Author                      Modification
 * 1.0   31-08-2025   Sangram Keshari Upadhyaya   Initial Version
**/

trigger ExpenseTrigger on Expense__c (after insert, after update, after delete, after undelete) {
    Set<Id> invoiceIds = new Set<Id>();

    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
        for(Expense__c e : Trigger.new) {
            if(e.Invoice__c != null) invoiceIds.add(e.Invoice__c);
        }
    }

    if(Trigger.isDelete) {
        for(Expense__c e : Trigger.old){
            if(e.Invoice__c != null) invoiceIds.add(e.Invoice__c);
        }
    }

    if(!invoiceIds.isEmpty()){
        InvoiceService.updateInvoiceTotals(invoiceIds);
    }

}