From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 13 Sep 2018 10:14:02 -0600
Subject: [PATCH v6 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
In-Reply-To: <0118d3d8-a2f5-047f-6627-04ac3d0371ad@kernel.dk>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-8-logang@deltatee.com>
 <0118d3d8-a2f5-047f-6627-04ac3d0371ad@kernel.dk>
Message-ID: <5998a8c3-697e-82ac-91d4-a648455a21e9@deltatee.com>



On 12/09/18 06:28 PM, Jens Axboe wrote:
> On 9/12/18 6:11 PM, Logan Gunthorpe wrote:
>> QUEUE_FLAG_PCI_P2P is introduced meaning a driver's request queue
>> supports targeting P2P memory.
>>
>> When a request is submitted we check if PCI P2PDMA memory is assigned
>> to the first page in the bio. If it is, we ensure the queue it's
>> submitted to supports it, and enforce REQ_NOMERGE.
> 
> This changelog is no longer accurate.


Oops, I'll fix this for v7.

Thanks,

Logan
