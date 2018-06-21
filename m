From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 21 Jun 2018 09:02:18 -0600
Subject: [PATCH] nvme: use __GFP_NOWARN for iod allocation
In-Reply-To: <20180621145812.GB17825@infradead.org>
References: <4cb394ca-7032-ea67-5bb1-ef331e42ace2@kernel.dk>
 <b054a000-c7ad-9926-b45f-2771a98b7d23@kernel.dk>
 <b51cce4d-d0c9-fb4e-d5ac-2e48e23e18f7@kernel.dk>
 <20180621070954.GA21304@infradead.org>
 <ce58c5ca-e2cd-de6a-a021-7f65b56d8a21@kernel.dk>
 <20180621145812.GB17825@infradead.org>
Message-ID: <87f5c54b-dc09-817b-0660-440a75af7407@kernel.dk>

On 6/21/18 8:58 AM, Christoph Hellwig wrote:
> On Thu, Jun 21, 2018@08:39:47AM -0600, Jens Axboe wrote:
>> That may be the case, but it's a lot less of an issue than SCSI is,
>> since the command overhead is suitably small. So I don't see a big issue
>> with limiting it.
> 
> 
> Not if you are using NVMe over FC, which uses exactly the same
> protocol to transfer a 64 byte NVMe SQ vs a typically 16 byte SCSI CDB..

I should have prefaced that with saying "for pci-e". For fabrics, I
agree.

>> Besides, having to do higher order allocations for an
>> IO is bound to pose much bigger issues than having two smaller IOs
>> instead. That's especially true in production, where memory allocation
>> stalls are pretty frequent.
> 
> 
> But the whole point of our chained sg allocator is that we don't do
> high order allocations, but multiple smaller ones and then chain
> them.

>From a quick look, the fabric code goes through the same nvme_queue_rq()
and ends up doing the same iod->sg allocation. I don't see any use of
chained sg lists, we're allocating one big sg table for the command.

-- 
Jens Axboe
