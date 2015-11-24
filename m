From: keith.busch@intel.com (Keith Busch)
Date: Tue, 24 Nov 2015 15:14:06 +0000
Subject: [PATCH] NVMe: Split shutdown work
In-Reply-To: <20151124073448.GA17979@infradead.org>
References: <1448302665-9703-1-git-send-email-keith.busch@intel.com>
 <20151124073448.GA17979@infradead.org>
Message-ID: <20151124151406.GA3936@localhost.localdomain>

On Mon, Nov 23, 2015@11:34:48PM -0800, Christoph Hellwig wrote:
> to me.  I think I finally found the culprit, and it's this text:
> 
> "This feature shall only be issued during initialization prior to creation
>  of any I/O Submission and/or Completion Queues. The value allocated shall
>  not change between resets."
> 
> To be this doesn't indicated that it can legitimately fail. but rather
> that we must not even submit it during a reset or resume.  One more
> reason for a proper state model..

Security locked drives may reject "set feature". Some of my drives in
manufacturing mode also fail it.

I think the driver is doing the right thing after every CC.EN transition
and before IO queue creation. The spec wording sounds odd, but it wouldn't
make sense if you're not allowed to change for a reset or resume. That's
pretty much the same scenario when the driver initially probes it:
we don't know what state UEFI left it.

I'll send a new revision that makes nvme_dev_shutdown reentrant so we
don't need the awkward "queue_work + flush_work".
