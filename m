From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Jun 2017 19:32:22 +0300
Subject: [PATCH v2 3/4] nvme-pci: factor out the cqe reading mechanics
 from __nvme_process_cq
In-Reply-To: <20170619161953.GD21765@localhost.localdomain>
References: <1497796090-14808-1-git-send-email-sagi@grimberg.me>
 <1497796090-14808-4-git-send-email-sagi@grimberg.me>
 <20170619161953.GD21765@localhost.localdomain>
Message-ID: <dd21f59c-b668-c81f-0b0c-248708e1d145@grimberg.me>


>> Also, maintain a consumed counter to rely on for doorbell and
>> cqe_seen update instead of directly relying on the cq head and phase.
>>
>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> 
> Looks like this particular change failed to produce the best diff. :)

:(

>> -	nvme_ring_cq_doorbell(nvmeq);
>> +		if (tag && *tag == cqe.command_id) {
>> +			*tag = -1;
>> +			break;
> 
> This 'break' is new. We're already holding the lock, why wouldn't we
> want to reap all the completions?

Oddly enough I (re)noticed it now too. I guess that my thought was that
if we were invoked from ->poll, it means that the user wants the
completion asap and willing to put some extra efforts in order to get
it faster... So if you think about it, any action you take post finding
the completion is not what the user wants...

This absolutely needs to be documented, or actually come as a separate 
patch... I can also get rid of it if its a dumb idea...
