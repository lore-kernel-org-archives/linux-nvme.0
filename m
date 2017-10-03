From: hare@suse.de (Hannes Reinecke)
Date: Tue, 3 Oct 2017 12:02:38 +0200
Subject: [PATCH 6/6] nvme: ignore retries for multipath devices
In-Reply-To: <20171002162254.GA11497@lst.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-7-git-send-email-hare@suse.de>
 <20171002162254.GA11497@lst.de>
Message-ID: <9d603720-2f86-ab3c-6ba3-9d57afb3568e@suse.de>

On 10/02/2017 06:22 PM, Christoph Hellwig wrote:
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 1ef11ca..ac7676a 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -201,7 +201,8 @@ static inline bool nvme_req_needs_retry(struct request *req)
>>  		return false;
>>  	if (nvme_req(req)->status & NVME_SC_DNR)
>>  		return false;
>> -	if (nvme_req(req)->retries >= nvme_max_retries)
>> +	if (nvme_req(req)->retries >= nvme_max_retries &&
>> +	    !(req->cmd_flags & REQ_NVME_MPATH))
>>  		return false;
>>  	return true;
> 
> All failover logic is inside a nvme_req_needs_retry() conditional,
> so this change looks completely broken - it basically disables
> failover.
> 
Not in our tests.
Without this patch we'd been seeing I/O errors during failover; with
this patch I/O continues on the failover path.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
