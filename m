From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 2 Sep 2018 19:24:16 +0300
Subject: [PATCH] nvmet-rdma: fix possible bogus dereference under heavy
 load
In-Reply-To: <003801d441f0$fdc37a70$f94a6f50$@opengridcomputing.com>
References: <20180901011447.32287-1-sagi@grimberg.me>
 <20180901074414.GA32538@lst.de>
 <003801d441f0$fdc37a70$f94a6f50$@opengridcomputing.com>
Message-ID: <4d094f13-bcc1-0cea-2c2b-efdf232e51a9@mellanox.com>



On 9/1/2018 3:40 PM, Steve Wise wrote:
> 
> 
>> -----Original Message-----
>> From: Christoph Hellwig <hch at lst.de>
>> Sent: Saturday, September 1, 2018 2:44 AM
>> To: Sagi Grimberg <sagi at grimberg.me>
>> Cc: linux-nvme at lists.infradead.org; Steve Wise
>> <swise at opengridcomputing.com>; Christoph Hellwig <hch at lst.de>
>> Subject: Re: [PATCH] nvmet-rdma: fix possible bogus dereference under
>> heavy load
>>
>> On Fri, Aug 31, 2018@06:14:47PM -0700, Sagi Grimberg wrote:
>>> Currently we always repost the recv buffer before we send a response
>>> capsule back to the host. Since ordering is not guaranteed for send
>>> and recv completions, it is posible that we will receive a new request
>>> from the host before we got a send completion for the response capsule.
>>>
>>> Today, we pre-allocate 2x rsps the length of the queue, but in reality,
> under
>>> heavy load there is nothing that is really preventing the gap to expand
>>> until we exhaust all our rsps.
>>
>> This is a little scary and means we have the same issue in all other
>> protocol drivers.  It also means that there probably is no point in
>> allocating twice the queue length as it will be wasted most of the
>> time, but still not enough.
> 
> I'm not sure the other protocols have this issue.  Where is the similar
> issue in ib_isert?
> 
> If we made the rsp struct part of the nvmet_rdma_cmd, then we could remove
> this issue and the list management involved with the nvmet_rdma_rsp struct.
> Then we're ensured that when we get a nvme command from the host via a
> recv_done completion, we have a rsp.

I'm not sure this is so simple since we destroy the rdma_rw_ctx during 
the send completion (that will tell us that the RDMA op finished), that 
happens after we post_recv the nvmet_rdma_cmd.

we also can't check during send completion:
  if (rsp->req.sg != &rsp->cmd->inline_sg)
                 sgl_free(rsp->req.sg);

since the cmd was post_recv'ed (Sagi can you handle this in V2 ? can 
simply add pointer in rsp to this.) We need to make sure we don't count 
on rsp-cmd assosiacion after post_recv call (maybe remove it ??).

for now the proposed solution looks fine (With Christoph's and the above 
comments).
But we must also check the return value from nvmet_rdma_get_rsp and in 
case we got NULL we should add the cmd to a new cmd_wait_list.
Thoughts ?


> 
> Steve
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&amp;data=02%7C01%7Cmaxg%40mellanox.com%7Ce5872db21a5c4ac6656b08d61008319c%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636714024720448674&amp;sdata=ii1zaSdMNtoNDFvefX5zEEvqdsaet0gLAe0M04JmGtc%3D&amp;reserved=0
> 
