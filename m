From: bvanassche@acm.org (Bart Van Assche)
Date: Tue, 23 Jul 2019 13:54:52 -0700
Subject: [PATCH 2/5] blk-mq: introduce
 blk_mq_tagset_wait_completed_request()
In-Reply-To: <20190723010616.GC30776@ming.t460p>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-3-ming.lei@redhat.com>
 <c2722892-9cbf-0747-58a8-91a99b72bc53@acm.org>
 <20190723010616.GC30776@ming.t460p>
Message-ID: <d4d3ded9-0012-68c1-7511-f5ac3aa7b1fb@acm.org>

On 7/22/19 6:06 PM, Ming Lei wrote:
> On Mon, Jul 22, 2019@08:25:07AM -0700, Bart Van Assche wrote:
>> On 7/21/19 10:39 PM, Ming Lei wrote:
>>> blk-mq may schedule to call queue's complete function on remote CPU via
>>> IPI, but doesn't provide any way to synchronize the request's complete
>>> fn.
>>>
>>> In some driver's EH(such as NVMe), hardware queue's resource may be freed &
>>> re-allocated. If the completed request's complete fn is run finally after the
>>> hardware queue's resource is released, kernel crash will be triggered.
>>>
>>> Prepare for fixing this kind of issue by introducing
>>> blk_mq_tagset_wait_completed_request().
>>
>> An explanation is missing of why the block layer is modified to fix this
>> instead of the NVMe driver.
> 
> The above commit log has explained that there isn't sync mechanism in
> blk-mq wrt. request completion, and there might be similar issue in other
> future drivers.

That is not sufficient as a motivation to modify the block layer because 
there is already a way to wait until request completions have finished, 
namely the request queue freeze mechanism. Have you considered to use 
that mechanism instead of introducing 
blk_mq_tagset_wait_completed_request()?

Thanks,

Bart.
