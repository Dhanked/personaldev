/**
 * Created by shivani on 24/05/20.
 */
@RestResource(UrlMapping='/case/*/close')
global with sharing class CaseCloseResource {
    @HttpPost
    global static void closeCase(String caseReason) {
        RestRequest req = RestContext.request;
        String[] uriParts = req.requestURI.split('/');
        Id caseId = uriParts[2];
        CaseService.closeCases(new Set<Id> {caseId},caseReason);
    }

}