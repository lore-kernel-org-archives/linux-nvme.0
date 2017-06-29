From: robert@leblancnet.us (Robert LeBlanc)
Date: Thu, 29 Jun 2017 07:30:17 -0600
Subject: Deadlock on device removal event for NVMeF target
In-Reply-To: <61858a46-ebf1-a5bd-5213-65dadaadb84d@grimberg.me>
References: <20170626225920.GA11700@ssaleem-MOBL4.amr.corp.intel.com>
 <56030fcd-b8a0-fc0e-18e5-985ebf16a82e@grimberg.me>
 <20170627193157.GA29768@ssaleem-MOBL4.amr.corp.intel.com>
 <61858a46-ebf1-a5bd-5213-65dadaadb84d@grimberg.me>
Message-ID: <CAANLjFr++5daZ6Vn8TYxcM0oMyU4PuMztcM5KKM6mOy7HEs7KA@mail.gmail.com>

Could something like this be causing the D state problem I was seeing
in iSER almost a year ago? I tried writing a patch for iSER based on
this, but it didn't help. Either the bug is not being triggered in
device removal, or I didn't line up the statuses correctly. But it
seems that things are getting stuck in the work queue and some sort of
deadlock is happening so I was hopeful that something similar may be
in iSER.

Thanks,
Robert
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Wed, Jun 28, 2017@12:50 AM, Sagi Grimberg <sagi@grimberg.me> wrote:
>
>>> How about the (untested) alternative below:
>>> --
>>> [PATCH] nvmet-rdma: register ib_client to not deadlock in device
>>>    removal
>>>
>>> We can deadlock in case we got to a device removal
>>> event on a queue which is already in the process of
>>> destroying the cm_id is this is blocking until all
>>> events on this cm_id will drain. On the other hand
>>> we cannot guarantee that rdma_destroy_id was invoked
>>> as we only have indication that the queue disconnect
>>> flow has been queued (the queue state is updated before
>>> the realease work has been queued).
>>>
>>> So, we leave all the queue removal to a separate ib_client
>>> to avoid this deadlock as ib_client device removal is in
>>> a different context than the cm_id itself.
>>>
>>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>>> ---
>>
>>
>> Yes. This patch fixes the problem I am seeing.
>
>
> Awsome,
>
> Adding your Tested-by tag.
>
> Thanks!
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
