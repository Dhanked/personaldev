/**
 * Created by shivani on 24/05/20.
 */
public with sharing class CaseService {
    public static void closeCases(Set<Id> caseIds, String caseReason){
        if(caseIds != null && caseIds.size()>0){
            List<Case> listCases = [
                    SELECT
                            Id,Status,Reason
                    FROM Case WHERE ID IN: caseIds];

            for (Case aCase : listCases) {
                aCase.Reason = caseReason;
                aCase.Status = 'Closed';
            }
            try {
                if (listCases != null && listCases.size()>0) {
                    update listCases;
                }

            } catch (Exception e) {

            }


        }

    }
}