From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 24 Nov 2015 07:31:07 -0800
Subject: [PATCH] NVMe: Split shutdown work
In-Reply-To: <20151124151406.GA3936@localhost.localdomain>
References: <1448302665-9703-1-git-send-email-keith.busch@intel.com>
 <20151124073448.GA17979@infradead.org>
 <20151124151406.GA3936@localhost.localdomain>
Message-ID: <20151124153107.GA4326@infradead.org>

On Tue, Nov 24, 2015@03:14:06PM +0000, Keith Busch wrote:
> Security locked drives may reject "set feature". Some of my drives in
> manufacturing mode also fail it.

Is there any wording in the spec that allows this?  What number of
I/O queues will show up on these drives?   Allowing to ignore this
failure is defintively black magic and needs long comments explaining
the why and how, or it will get broken accidentally again and again.

> I think the driver is doing the right thing after every CC.EN transition
> and before IO queue creation. The spec wording sounds odd, but it wouldn't
> make sense if you're not allowed to change for a reset or resume. That's
> pretty much the same scenario when the driver initially probes it:
> we don't know what state UEFI left it.

Hmm, true.  Might be a good idea to clarify the spec.

> I'll send a new revision that makes nvme_dev_shutdown reentrant so we
> don't need the awkward "queue_work + flush_work".

We need serialization not just of shutdown calls, but also of shutdown
vs reset.  Thinking about it aren't we doing the shutdown from the
pci_driver ->removal callback with my current branch?
