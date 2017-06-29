From: james.smart@broadcom.com (James Smart)
Date: Thu, 29 Jun 2017 09:24:51 -0700
Subject: [PATCH] nvme-rdma: stop keep_alive before nvme_uninit_ctrl
In-Reply-To: <25f0745a-dfe0-21aa-b88b-ad01fee188ce@redhat.com>
References: <1498746799-34110-1-git-send-email-dmilburn@redhat.com>
 <20170629144507.GS3808@linux-x5ow.site>
 <25f0745a-dfe0-21aa-b88b-ad01fee188ce@redhat.com>
Message-ID: <05064fd2-1fd1-a2eb-6179-daf3b7cc4924@broadcom.com>

On 6/29/2017 8:44 AM, David Milburn wrote:
> Hi Johannes,
>
> On 06/29/2017 09:45 AM, Johannes Thumshirn wrote:
>> On Thu, Jun 29, 2017@09:33:19AM -0500, David Milburn wrote:
>>> Its possible for nvme_keep_alive_work() to hit an error
>>> condition after the nvme_uninit_ctrl() in __nvme_rdma_remove_ctrl().
>>> This can lead to usage of NULL pointer in "dev_err(ctrl->device..."
>>> since device has been destroyed by nvme_uninit_ctrl().
>>>
>>> This has been seen during continous loop of (discover, connect,
>>> IO, disconnect).
>>
>> Why can't we stop the keepalive work in nvme core and get rid of the 
>> stopping
>> in fc.c as well?
>>
> Do you mean checking ctrl->device at the beginning of
> nvme_keep_alive_work()? And if device has been removed,
> nvme_stop_keep_alive() and return?
>
> Though still looks like nvme_rdma_error_recovery_work() will
> want to be able to stop keep_alive, and some error handling
> in fc.c.

So calling nvme_stop_keep_alive() prior to nvme_uninit_ctrl() wasn't 
sufficient to avoid the condition ?

It looks like rdma may have missed this on the nvme_rdma_del_ctrl_work() 
call, it calls nvme_uninit_ctrl() then calls nvme_stop_keep_alive().

Granted, there's a race between the stop and further teardown, but that 
should be manageable in the core nvme code around the workaround (e.g. 
called to stop while its executing, work start but see cancelled, etc).

-- james
