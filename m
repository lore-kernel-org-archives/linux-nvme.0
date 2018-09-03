From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 3 Sep 2018 16:26:27 -0600
Subject: [PATCH v5 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
In-Reply-To: <20180901082812.GB670@lst.de>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-8-logang@deltatee.com>
 <b5ab8fa3-34ac-3117-fa0d-5206c3939435@kernel.dk>
 <20180901082812.GB670@lst.de>
Message-ID: <5f79c012-c6e1-56bb-62fd-0689181fb2c9@deltatee.com>



On 01/09/18 02:28 AM, Christoph Hellwig wrote:
> On Thu, Aug 30, 2018@01:11:18PM -0600, Jens Axboe wrote:
>> I think this belongs in the caller - both the validity check, and
>> passing in NOMERGE for this type of request. I don't want to impose
>> this overhead on everything, for a pretty niche case.
> 
> It is just a single branch, which will be predicted as not taken
> for non-P2P users.  The benefit is that we get proper error checking
> by doing it in the block code.

I personally agree with Christoph. But if there's consensus in the other
direction or this is a real blocker moving this forward, I can remove it
for the next version.

Logan
