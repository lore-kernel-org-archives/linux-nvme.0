From: hch@lst.de (Christoph Hellwig)
Date: Wed, 5 Sep 2018 22:11:52 +0200
Subject: [PATCH v5 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
In-Reply-To: <bcc1b3cf-2fd9-fa61-9cfb-b0e4d84e5d94@kernel.dk>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-8-logang@deltatee.com>
 <b5ab8fa3-34ac-3117-fa0d-5206c3939435@kernel.dk>
 <20180901082812.GB670@lst.de>
 <5f79c012-c6e1-56bb-62fd-0689181fb2c9@deltatee.com>
 <59b28977-8f2a-6228-2050-03fae6bdbedd@kernel.dk>
 <1b4283da-44df-4a02-3167-e295243cef78@deltatee.com>
 <09258b9b-3aed-9890-b31a-bd70a133966c@kernel.dk>
 <20180905195647.GA1626@lst.de>
 <bcc1b3cf-2fd9-fa61-9cfb-b0e4d84e5d94@kernel.dk>
Message-ID: <20180905201152.GA1893@lst.de>

On Wed, Sep 05, 2018@01:54:31PM -0600, Jens Axboe wrote:
> On 9/5/18 1:56 PM, Christoph Hellwig wrote:
> > On Wed, Sep 05, 2018@01:45:04PM -0600, Jens Axboe wrote:
> >> The point is that the caller doesn't necessarily know where the bio
> >> will end up, hence the caller can't fully check if the whole stack
> >> supports P2P.
> > 
> > The caller must necessarily know where the bio will end up, as for P2P
> > support we need to query if the bio target is P2P capable vs the
> > source of the P2P memory.
> 
> Then what's the point of having the check at all?

Just an additional little safe guard.  If you think it isn't worth
it I guess we can just drop it for now.
