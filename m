From: hch@lst.de (Christoph Hellwig)
Date: Wed, 5 Sep 2018 19:16:32 +0200
Subject: [PATCH v2] nvmet-rdma: fix possible bogus dereference under
 heavy load
In-Reply-To: <f7d0cba7-f363-0216-75c6-0be0723974d8@grimberg.me>
References: <20180903104707.5776-1-sagi@grimberg.me>
 <20180904190653.GA2060@lst.de>
 <f7d0cba7-f363-0216-75c6-0be0723974d8@grimberg.me>
Message-ID: <20180905171632.GA31569@lst.de>

On Wed, Sep 05, 2018@08:14:07AM -0700, Sagi Grimberg wrote:
>
>>> -	rsp = list_first_entry(&queue->free_rsps,
>>> +	rsp = list_first_entry_or_null(&queue->free_rsps,
>>>   				struct nvmet_rdma_rsp, free_list);
>>> -	list_del(&rsp->free_list);
>>> +	if (likely(rsp)) {
>>> +		list_del(&rsp->free_list);
>>> +		rsp->allocated = false;
>>
>> Given that we never set allocated to true for something we got from
>> the freelist, and the structures were allocated using kcalloc I don't
>> ?ee why we need to set it to false here.
>
> I have no problem removing it, should I send a new spin?

I can fix it up.
