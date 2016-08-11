From: krisman@linux.vnet.ibm.com (Gabriel Krisman Bertazi)
Date: Thu, 11 Aug 2016 15:10:35 -0300
Subject: Oops when completing request on the wrong queue
In-Reply-To: <20160811171655.GA5334@localhost.localdomain> (Keith Busch's
 message of "Thu, 11 Aug 2016 13:16:55 -0400")
References: <87a8gltgks.fsf@linux.vnet.ibm.com>
 <20160811171655.GA5334@localhost.localdomain>
Message-ID: <87d1lfrxb8.fsf@linux.vnet.ibm.com>

Keith Busch <keith.busch at intel.com> writes:

> On Wed, Aug 10, 2016@01:04:35AM -0300, Gabriel Krisman Bertazi wrote:
>> Hi,
>> 
>> We, IBM, have been experiencing eventual Oops when stressing IO at the
>> same time we add/remove processors.  The Oops happens in the IRQ path,
>> when we try to complete a request that was apparently meant for another
>> queue.
>> 
>> In __nvme_process_cq, the driver will use the cqe.command_id and the
>> nvmeq->tags to find out, via blk_mq_tag_to_rq, the request that
>> initiated the IO.  Eventually, it happens that the request returned by
>> that function is not initialized, and we crash inside
>> __blk_mq_complete_request, as shown below.
>
> Could you try the following patch and see if it resolves the issue?

Hi Keith,

Thanks for your response.  I had tried this exact change already on 4.7
with no effect.  Do you think doing it on 4.8-rc1 will yield better
results?

I also verified that the iod, when in __nvme_process_cq, points to the same
queue that queued the command, as expected, but in nvme_timeout,
according to the log I sent earlier, it is pointing to a different nvmeq
(different nvmeq->qid). This is very strange to me.

-- 
Gabriel Krisman Bertazi
