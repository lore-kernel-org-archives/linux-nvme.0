From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 28 Jun 2017 09:50:15 +0300
Subject: Deadlock on device removal event for NVMeF target
In-Reply-To: <20170627193157.GA29768@ssaleem-MOBL4.amr.corp.intel.com>
References: <20170626225920.GA11700@ssaleem-MOBL4.amr.corp.intel.com>
 <56030fcd-b8a0-fc0e-18e5-985ebf16a82e@grimberg.me>
 <20170627193157.GA29768@ssaleem-MOBL4.amr.corp.intel.com>
Message-ID: <61858a46-ebf1-a5bd-5213-65dadaadb84d@grimberg.me>


>> How about the (untested) alternative below:
>> --
>> [PATCH] nvmet-rdma: register ib_client to not deadlock in device
>>    removal
>>
>> We can deadlock in case we got to a device removal
>> event on a queue which is already in the process of
>> destroying the cm_id is this is blocking until all
>> events on this cm_id will drain. On the other hand
>> we cannot guarantee that rdma_destroy_id was invoked
>> as we only have indication that the queue disconnect
>> flow has been queued (the queue state is updated before
>> the realease work has been queued).
>>
>> So, we leave all the queue removal to a separate ib_client
>> to avoid this deadlock as ib_client device removal is in
>> a different context than the cm_id itself.
>>
>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>> ---
> 
> Yes. This patch fixes the problem I am seeing.

Awsome,

Adding your Tested-by tag.

Thanks!
