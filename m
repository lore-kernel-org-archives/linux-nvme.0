From: hch@lst.de (Christoph Hellwig)
Date: Mon, 16 Nov 2015 11:05:27 +0100
Subject: [PATCH 09/12] nvme: properly free resources for cancelled command
In-Reply-To: <20151110202811.GA6506@localhost.localdomain>
References: <1446885906-20967-1-git-send-email-hch@lst.de>
 <1446885906-20967-10-git-send-email-hch@lst.de>
 <20151109185731.GB5386@localhost.localdomain> <20151109192518.GA10681@lst.de>
 <20151109201232.GC5386@localhost.localdomain> <20151110081357.GA21708@lst.de>
 <20151110160344.GB31697@localhost.localdomain>
 <20151110202811.GA6506@localhost.localdomain>
Message-ID: <20151116100527.GA22867@lst.de>

On Tue, Nov 10, 2015@08:28:11PM +0000, Keith Busch wrote:
> > Perhaps I am thinking how probing serially worked before, and don't
> > understand how this works anymore. :)
> > 
> > You're right, we don't really care anymore if the reset handler unwinds
> > it. This path is then safe to see a fake error code.
> 
> Actually this still needs to be a negative error so nvme_reset_work
> doesn't clear "NVME_CTRL_RESETTING" bit. Without that, the driver gets
> in an infinite reset loop.

I don't think this is going to help as we'll never enter the reset loop
now that we have a single reset_work item, oops.

I guess we'll just need to set the aborted status from nvme_timeout
if we are in the reset handler already so that it can handle the
errors directly instead of waiting for another reset_work do be queued
up. I'll try to come up with a version of that.
