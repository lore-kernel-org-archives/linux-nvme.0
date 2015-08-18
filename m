From: axboe@fb.com (Jens Axboe)
Date: Tue, 18 Aug 2015 11:51:46 -0600
Subject: [PATCH 1/2] nvme: remove spurious use of *_to_cpup helpers
In-Reply-To: <20150817201237.GC9645@linux.intel.com>
References: <1439838580-29647-1-git-send-email-hch@lst.de>
 <1439838580-29647-2-git-send-email-hch@lst.de>
 <20150817201237.GC9645@linux.intel.com>
Message-ID: <55D370B2.9060006@fb.com>

On 08/17/2015 02:12 PM, Matthew Wilcox wrote:
> On Mon, Aug 17, 2015@09:09:39PM +0200, Christoph Hellwig wrote:
>> Switch to the normal endianess helpers that take an integer instead of
>> the pointer to it.
>
> Why?  Some CPUs have a 'load-reversed-endian' instruction, which can be
> used in the _to_cpup() cases, but not in the _to_cpu() cases.
>
>> -				cqe->command_id, le16_to_cpup(&cqe->sq_id));
>> +				cqe->command_id, le16_to_cpu(cqe->sq_id));

All those nvme equipped sparc and s390's? :-)

Joke aside, do we really have that 'load-reversed-endian' addition to 
the endianness conversion API just because of two rather esoteric 
platforms? Seems silly.

-- 
Jens Axboe
