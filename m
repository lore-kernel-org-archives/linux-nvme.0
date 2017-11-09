From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 9 Nov 2017 13:08:04 +0200
Subject: [PATCH v2 1/3] nvme-rdma: don't suppress send completions
In-Reply-To: <20171109091858.GA16966@lst.de>
References: <20171108100616.26605-1-sagi@grimberg.me>
 <20171108100616.26605-2-sagi@grimberg.me> <20171109091858.GA16966@lst.de>
Message-ID: <921c4331-9456-3783-423a-9c5c5e405131@grimberg.me>


>> The entire completions suppress mechanism is currently
>> broken because the HCA might retry a send operation
>> (due to dropped ack) after the nvme transaction has completed.
>>
>> In order to handle this, we signal all send completions (besides
>> async event which is not racing anything).
> 
> Oh well, so much for all these unsignalled completion optimizations..
> 
> So in which cases do unsignalled completions work at all?

Probably in cases where no in-capsule data is used we're fine because
the command buffers mappings are long lived, and for non-RPC like
applications.

> Seems like we need to fix up a lot of other ULPs as well.

Probably only those that support in-capsule data (which I hear
SRP does too these days).

>> -	 */
>> -	if (nvme_rdma_queue_sig_limit(queue) || flush)
>> -		wr.send_flags |= IB_SEND_SIGNALED;
>> +	wr.send_flags = IB_SEND_SIGNALED;
> 
> But..  Is there any benefit in just setting IB_SIGNAL_ALL_WR on the QP?

There is one case I still don't want to signal send completion, thats
the AEN request. It doesn't have a request structure, and preferred not
to check on it for every send completion, and its not racing anything
(mentioned this above).

I can change that though if there is a strong desire.
