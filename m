From: hare@suse.de (Hannes Reinecke)
Date: Tue, 6 Aug 2019 16:13:40 +0200
Subject: [PATCH] nvme: Return BLK_STS_TARGET if the DNR bit is set
In-Reply-To: <20190806140716.GA24030@localhost.localdomain>
References: <20190806111036.113233-1-hare@suse.de>
 <31aa1743-2741-7952-d620-7d4ee93d6a99@intel.com>
 <047af640-5b5b-14a1-d2ef-1509702af9c7@suse.de>
 <20190806140716.GA24030@localhost.localdomain>
Message-ID: <31e6f42e-2157-077c-64d4-a5a31caf0aa4@suse.de>

On 8/6/19 4:07 PM, Keith Busch wrote:
> On Tue, Aug 06, 2019@03:53:29PM +0200, Hannes Reinecke wrote:
>> On 8/6/19 3:50 PM, Nadolski, Edmund wrote:
>>> On 8/6/2019 5:10 AM, Hannes Reinecke wrote:
>>>> If the DNR bit is set we should not retry the command, even if
>>>> the standard status evaluation indicates so.
>>>>
>>>> Signed-off-by: Hannes Reinecke <hare at suse.com>
>>>> ---
>>>>  ? drivers/nvme/host/core.c | 7 +++++++
>>>>  ? 1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>> index cc09b81fc7f4..c3e9254f4757 100644
>>>> --- a/drivers/nvme/host/core.c
>>>> +++ b/drivers/nvme/host/core.c
>>>> @@ -279,6 +279,13 @@ void nvme_complete_rq(struct request *req)
>>>>  ????????????? return;
>>>>  ????????? }
>>>>  ????? }
>>>> +??? /*
>>>> +???? * Any pathing error might be retried, but the DNR bit takes
>>>> +???? * precedence. So return BLK_STS_TARGET if the DNR bit is set
>>>> +???? * to avoid retrying.
>>>> +???? */
>>>> +??? if (blk_path_error(status) && nvme_req(req)->status & NVME_SC_DNR)
>>>> +??????? status = BLK_STS_TARGET;
>>>>  ????? blk_mq_end_request(req, status);
>>>>  ? }
>>>>  ? EXPORT_SYMBOL_GPL(nvme_complete_rq);
>>>>
>>>
>>> - If DNR always takes precedence, is the blk_path_error() check still
>>> needed?
>>>
>> It takes precedence in the sense that it should cause the command not to be
>> retried. It should not overwrite any error code indicating a non-retryable
>> error.
> 
> But we're already past the nvme retry logic, which also handles the DNR
> bit. Who is this telling not to retry?
> 
Anything layered on top of it, namely dm-multipath or MD.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
