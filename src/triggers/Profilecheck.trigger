trigger Profilecheck on Account (after Update) {
Map<Id,Set<Id>> accountAndRelatedMembersMap = new Map<Id,Set<Id>>();
for(Account ac:Trigger.New){
system.debug('account owner ===='+ac.owner.profile.name);
system.debug('account owner ID ===='+ac.OwnerId);
accountAndRelatedMembersMap.put(ac.id,new Set<Id>{ac.OwnerId});
}
system.debug('accountAndRelatedMembersMap==='+accountAndRelatedMembersMap);

}