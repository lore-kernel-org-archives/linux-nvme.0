From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 30 Jul 2015 07:52:22 -0700
Subject: [RFC] Multi level NVMe stack
In-Reply-To: <1438214118.24174.9.camel@ssi>
References: <1438214118.24174.9.camel@ssi>
Message-ID: <20150730145222.GA12744@infradead.org>

On Wed, Jul 29, 2015@04:55:18PM -0700, Ming Lin wrote:
> I'm working on a virtio-nvme driver.
> NVMe over Fabrics initiator will probably be available some time.
> 
> I wonder does it make sense to have a multi level NVMe stack(similar as
> SCSI). So we can re-use the NVMe core code.

Hi Ming,

I've put some work in for abstraction, see the work to submit the
internal NVMe command through struct request.

Once we actually get other transports we can split main data structures,
and move the parts sitting above that abstraction out into a separate
module.

>From both looking at the I/O code I'd prefer not to add any abstractions
in the I/O code for.

I'd suggest you prototype the code without big refactoring first,
and then compare your implementation against the NVMe virtualization
extensions from Google and check if it's worth it:

http://lists.infradead.org/pipermail/linux-nvme/2014-July/001076.html
