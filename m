From: james.smart@broadcom.com (James Smart)
Date: Thu, 23 May 2019 08:46:40 -0700
Subject: [PATCH 3/4] nvme-fc: fail reconnect if state change fails
In-Reply-To: <f59abb21-c3e8-1aa3-9246-f4141862aa69@suse.de>
References: <20190520063624.50338-1-hare@suse.de>
 <20190520063624.50338-4-hare@suse.de>
 <alpine.LRH.2.21.9999.1905221035410.9636@mvluser05.qlc.com>
 <f59abb21-c3e8-1aa3-9246-f4141862aa69@suse.de>
Message-ID: <e430d6e0-6f0f-8cc1-aba8-f33faa519267@broadcom.com>

On 5/22/2019 10:33 PM, Hannes Reinecke wrote:
> On 5/22/19 7:43 PM, Arun Easi wrote:
>>
>> Question: There is a path in nvme_fc_resume_controller() that schedules
>> connect_work when controller state is NVME_CTRL_NEW. I am not quite sure
>> when this is exercised; but if it does, it conflicts with this
>> expectation.
>>
> To my understanding, the transition from NEW to LIVE is only valid for
> PCI; NVMe-oF implementations should always move to CONNECTING first, ie
> they should have a transition NEW -> CONNECTING -> LIVE.
>
> Cheers,
>
> Hannes

I confirm what Hannes says - when the fc transport moved to an 
asynchronous connect using the reconnect path, as part of controller 
initial allocation, it moves from NEW to (temporarily) RESETTING to 
CONNECTING then schedules the reconnect which should go from there to 
LIVE in the normal path.? That NEW scheduling connect_work, although 
still present no long occurs. It was from the pre-async connect.

-- james
