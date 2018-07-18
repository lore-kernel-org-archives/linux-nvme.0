From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 18 Jul 2018 15:20:53 +0300
Subject: [PATCHv4 3/4] nvme: Introduce frozen controller state
In-Reply-To: <20180717161748.GE26925@localhost.localdomain>
References: <20180713205609.19701-1-keith.busch@intel.com>
 <20180713205609.19701-4-keith.busch@intel.com>
 <59b9c74b-91f1-7d1b-f20a-5a64dd66a17e@grimberg.me>
 <f2bd494e-0930-9ebf-024f-dc4a547a8bd9@broadcom.com>
 <20180717161748.GE26925@localhost.localdomain>
Message-ID: <7105ce2a-dceb-28ab-c3de-79ec72aa9e4b@grimberg.me>


>>> Having the transport drivers setup a state to indicate nvme-core to
>>> handle it and change it again looks convoluted to me...
>>>
>>
>> I'll second the comment.
>>
>> -- james
> 
> You definitely do not need to use this state if it doesn't make sense
> for your transport. We just need a context that is safe to dispatch
> blocking IO when coming out of a reset. I can move more of this back
> to pci if we want to provide a new nvme_ctrl_ops callback if you really
> don't like a generic solution.

I want stuff in the core that makes sense to all transports, and I
believe this area has much commonality between them. But currently,
the transports do different stuff in their timeout handler which
brings different sets of logic.

rdma simply queues a controller reset, never aborts and is probably
buggy in that area. fc does pretty much the same thing.

I suggest to make pci timeout handler to:
1. abort (if not aborted yet) and return BLK_EH_RESET_TIMER, or
2. queue a reset and return BLK_EH_RESET_TIMER, or
3. fail early the I/O if it is coming from the reset context (state == 
CONNECTING) and return BLK_EH_DONE.

Which at least in my mind makes sense to all transports so if we have it
we can maybe move it up to nvme-core?
