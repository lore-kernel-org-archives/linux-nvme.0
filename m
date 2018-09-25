From: hare@suse.de (Hannes Reinecke)
Date: Tue, 25 Sep 2018 17:20:41 +0200
Subject: [PATCH] nvme: call nvme_complete_rq on NVME_MPATH failures
In-Reply-To: <b4ddf69f-923e-5a15-ecaa-8fc05ed214bf@broadcom.com>
References: <20180921184920.12902-1-jsmart2021@gmail.com>
 <2b1f30b5-a07c-6e67-9d87-abb797747410@suse.de>
 <b4ddf69f-923e-5a15-ecaa-8fc05ed214bf@broadcom.com>
Message-ID: <ecbe2d3c-b970-d6f7-8090-bf8df1073cc0@suse.de>

On 9/24/18 8:01 PM, James Smart wrote:
> On 9/24/2018 2:32 AM, Hannes Reinecke wrote:
>>
>>> +??? nvmerq->status = NVME_SC_ABORT_REQ;
>>>
>> Shouldn't we use '0x371' (as per TP 4028) for this?
>> Description said 'Command Aborted By host: The command was aborted as 
>> a result of host action (e.g., the host disconnected the Fabric 
>> connection).' which seem to be a pretty good match ...
> 
> Possibly - but...? If it was the transport that did a real io abort, it 
> would make sense. But in this case, the io never even got started, so 
> why mark it aborted ?? If it really was aborted, then doing a ctlr reset 
> and incrementing retry counters may make sense. But if just bounced due 
> to not being able to talk to the controller right now - those things 
> should happen. So I still think we need a different value specific for 
> the linux stack.
> 
Hmm. Can we even define linux-only return values?
I hope we don't need to go creating an TPAR just for that ...
But other than that I'm fine with use an internal return code here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
