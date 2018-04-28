From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Sat, 28 Apr 2018 22:31:26 +0800
Subject: [PATCH 1/2] nvme: pci: simplify timeout handling
In-Reply-To: <20180428133514.GB5938@localhost.localdomain>
References: <20180426123956.26039-1-ming.lei@redhat.com>
 <20180426123956.26039-2-ming.lei@redhat.com>
 <20180427175157.GB5073@localhost.localdomain>
 <20180428035015.GB5657@ming.t460p>
 <20180428133514.GB5938@localhost.localdomain>
Message-ID: <401cba4e-4a70-291d-54f0-5cb484006587@oracle.com>

Hi Ming and Keith

Let me detail extend more here. :)

On 04/28/2018 09:35 PM, Keith Busch wrote:
>> Actually there isn't the case before, even for legacy path, one .timeout()
>> handles one request only.

Yes, .timeout should be invoked for every timeout request and .timeout should also
handle this only one request in principle
however, nvme_timeout will invoke nvme_dev_disable

> That's not quite what I was talking about.
> 
> Before, only the command that was about to be sent to the driver's
> .timeout() was marked completed. The driver could (and did) compete
> other timed out commands in a single .timeout(), and the tag would
> clear, so we could hanlde all timeouts in a single .timeout().

I think Keith are saying that
before this new blk-mq timeout implementation, the logic of blk_mq_timeout_work is

get _only_ _one_ timeout request
mark completed
invoke .timeout, in nvme, it is nvme_timeout
then nvme_dev_disable is invoked and thus other requests could be completed by blk_mq_complete_request
because they have not been mark completed 

> 
> Now, blk-mq marks all timed out commands as aborted prior to calling
> the driver's .timeout(). If the driver completes any of those commands,
> the tag does not clear, so the driver's .timeout() just gets to be called
> again for commands it already reaped.
> 

After the new blk-mq timeout implementation, 

set the aborted_gstate of _all_ the timeout requests
invoke the .timeout one by one
for the first timeout request's .timeout, in nvme, it is nvme_timeout
nvme_dev_disable is invoked and try to complete all the in-flight requests through blk_mq_complete_request
but timeout requests that have been set aborted_gstate cannot handled by blk_mq_complete_request
so some requests are leaked by nvme_dev_disable
these residual timeout requests will still be handled by blk_mq_timeout_work through invoke .timeout one by one


Thanks
Jianchao


> 
