From: hch@lst.de (Christoph Hellwig)
Date: Sat, 1 Sep 2018 10:28:12 +0200
Subject: [PATCH v5 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
In-Reply-To: <b5ab8fa3-34ac-3117-fa0d-5206c3939435@kernel.dk>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-8-logang@deltatee.com>
 <b5ab8fa3-34ac-3117-fa0d-5206c3939435@kernel.dk>
Message-ID: <20180901082812.GB670@lst.de>

On Thu, Aug 30, 2018@01:11:18PM -0600, Jens Axboe wrote:
> I think this belongs in the caller - both the validity check, and
> passing in NOMERGE for this type of request. I don't want to impose
> this overhead on everything, for a pretty niche case.

It is just a single branch, which will be predicted as not taken
for non-P2P users.  The benefit is that we get proper error checking
by doing it in the block code.
