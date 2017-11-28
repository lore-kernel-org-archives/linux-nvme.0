From: hch@lst.de (Christoph Hellwig)
Date: Tue, 28 Nov 2017 15:26:00 +0100
Subject: [PATCH v3 1/1] nvme-rdma: Fix memory leak during queue allocation
In-Reply-To: <3d575588-a910-a371-fdb3-cb56afcbabcd@mellanox.com>
References: <1511370080-23326-1-git-send-email-maxg@mellanox.com>
 <20171128123647.GC30316@lst.de> <20171128124217.GA30487@lst.de>
 <3d575588-a910-a371-fdb3-cb56afcbabcd@mellanox.com>
Message-ID: <20171128142600.GA441@lst.de>

On Tue, Nov 28, 2017@04:18:38PM +0200, Max Gurtovoy wrote:
>
>
> On 11/28/2017 2:42 PM, Christoph Hellwig wrote:
>> On Tue, Nov 28, 2017@01:36:47PM +0100, Christoph Hellwig wrote:
>>> Looks good and applied to nvme-4.15.
>>>
>>> In the long run I wonder if we want a real queue state machine intead
>>> of the flags..
>>
>> Actually, that was a little fast.  This conflicts with the MR pool
>> switch.
>
> I'll resend f needed.

Yes, please.

>>
>> Also why does it switch from rdma_destroy_qp to ib_destroy_qp?
>>
>
> because the cm_id might be destroyed (see the error flow).

Needs detailed comments please.
