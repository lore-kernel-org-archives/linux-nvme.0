From: james.smart@broadcom.com (James Smart)
Date: Thu, 23 May 2019 09:01:21 -0700
Subject: [PATCH 4/4] nvme-fc: align nvme_fc_delete_association() with exit
 path
In-Reply-To: <6da3909f-cdaa-c6df-81fb-59f71d9f4f30@suse.de>
References: <20190520063624.50338-1-hare@suse.de>
 <20190520063624.50338-5-hare@suse.de>
 <20485830-ae6a-eae1-32f3-940ca2cc1bf3@broadcom.com>
 <6da3909f-cdaa-c6df-81fb-59f71d9f4f30@suse.de>
Message-ID: <678d2403-150e-dcd3-359f-329015c7b588@broadcom.com>



On 5/22/2019 7:00 AM, Hannes Reinecke wrote:
> On 5/21/19 6:25 PM, James Smart wrote:
>>
>> ? no.? This is removing the underlying queues while blk-mq is still 
>> trying to submit to them - causing yet a different set of issues as 
>> the driver will have released contexts but the calldowns are still 
>> happening. Yet another different set of issues would likely appear.?? 
>> no need for this reorg.
>>
> Ah. Hmm. Well, I thought by having both paths identical we can ensure 
> that the error path in the first would actually work.
> Now it's quite hard to test, lat alone validate.
>
> But if you have objections we can surely drop this patch.

I do believe the failure case that you're adding is different - we 
haven't called start controller, so although the io queues and their 
lldd hw queues are live, we haven't done ns scanning and release of 
their queues to push things to the controller - so there won't be live 
ios in the lld that could be referencing the hw queues, nor any path 
that allows pushing of ios to anything other than the admin queue.?? The 
nvmf_ready checks should filter out normal i/o, especially as our state 
is not yet LIVE.? So that's the main difference with the generic change 
in delete association.

Well, if we really wanted to test it right - I would either: a) avoid 
the partial teardowns in the error path for this last state change check 
and just call the delete association routine; or b) do that, but make 
the error path always call delete association and delete association 
knows how to tear down the partially built up association (vs it expects 
a fully built up one now.

But that seems to be adding quite a bit of work for very little return.? 
To be honest, the existing code, that doesn't fail out if LIVE can't be 
transitioned to, isn't bad. There is no re-connect scheduled as it 
completes successfully. So the association is fully built up. If the 
state change failed - the only state that could have transitioned from 
CONNECTING to then fail LIVE is the DELETING state, and its valid to 
finish out successfully and let the delete path do its thing.

My preference is to leave the LIVE transition handling the way it is. 
But I'm ok if you wanted to add the LIVE-transition patch you proposed, 
but this patch in delete association isn't needed.

-- james
