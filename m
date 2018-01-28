From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Sun, 28 Jan 2018 17:01:18 +0800
Subject: [PATCH] nvme: don't retry request marked as NVME_REQ_CANCELLED
In-Reply-To: <20180127154356.GA20712@ming.t460p>
References: <20180125081023.13303-1-ming.lei@redhat.com>
 <db07601a-e298-3194-9b02-e7077d57e0a3@oracle.com>
 <20180125101503.GA13375@ming.t460p>
 <6749d736-ffdd-7f8d-c50c-58453b054ef8@oracle.com>
 <20180127133127.GA19560@ming.t460p>
 <e9456baf-a112-b340-378a-71eeab28f97b@oracle.com>
 <20180127154356.GA20712@ming.t460p>
Message-ID: <ead2bb8f-3628-ab15-f2f1-d84ffb1a3ed4@oracle.com>

Hi ming

Thanks for your time to look at this.
That's really appreciated.

On 01/27/2018 11:44 PM, Ming Lei wrote:
>>>> The best way to fix this is to ensure the timeout path has been completed before cancel the
>>>> previously outstanding requests. (Just ignore the case where the nvme_timeout will invoke nvme_dev_disable,
>>>> it has to be fixed by other way.)
>>> Maybe your approach looks a bit clean and simplify the implementation, but seems
>>> it isn't necessary.
>>>
>>> So could you explain a bit what the exact issue you are worrying about? deadlock?
>>> or others?
>> There is indeed potential issue. But it is in very narrow window.
>> Please refer to https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2018_1_19_68&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=vcQM1keq4TzxrKgWxIBOPADXTw7IRtGtWTBlHVIvPn8&s=83k_LmLl0TFLYwkVn4HjZbj5RgIMlLv570rnB5jNRC0&e=
> OK, follows description from the above link:
> 
>> Yes, once controller disabling completes, any started requests will be
>> handled and cannot expire. But before the _boundary_, there could be a
>> nvme_timeout context runs with nvme_dev_disable in parallel. If a timeout
>> path grabs a request, then nvme_dev_disable cannot get and cancel it.
>>
>> So even though the nvme_dev_disable completes, there still could be a request in nvme_timeout context.
>>
>> The worst case is :
>> nvme_timeout                              nvme_reset_work
>> if (ctrl->state == RESETTING )              nvme_dev_disable
>>    nvme_dev_disable                        initializing procedure
>>
>> the nvme_dev_disable run with reinit procedure in nvme_reset_work in parallel.
> OK, that is the issue, the nvme_dev_disable() in nvme_timeout() may
> disable queues again, and cause hang in nvme_reset_work().

Yes. :)

> 
> Looks Keith's suggestion of introducing nvme_sync_queues() should be
> enough to kill the race, but seems nvme_sync_queues() should have been
> called at the entry of nvme_reset_work() unconditionally.

Thanks for your suggestion.

Jianchao
