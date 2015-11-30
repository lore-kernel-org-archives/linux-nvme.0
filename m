From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 30 Nov 2015 00:47:18 -0800
Subject: [PATCH] NVMe: Shutdown fixes
In-Reply-To: <20151125193851.GA16415@infradead.org>
References: <1448407814-12544-1-git-send-email-keith.busch@intel.com>
 <20151125085537.GA19066@infradead.org>
 <20151125160544.GA2587@localhost.localdomain>
 <20151125164257.GB4321@infradead.org>
 <20151125165703.GC2587@localhost.localdomain>
 <20151125170842.GA29291@infradead.org>
 <20151125172845.GD2587@localhost.localdomain>
 <20151125175512.GA23638@infradead.org>
 <20151125182439.GE2587@localhost.localdomain>
 <20151125193851.GA16415@infradead.org>
Message-ID: <20151130084718.GA12727@infradead.org>

On Wed, Nov 25, 2015@11:38:51AM -0800, Christoph Hellwig wrote:
> I'll give this a spin the next day.  I assume you and Jns will be out
> for a long weekend starting tomorrow, so I should have a new series
> ready for review.  I'll fold a modified version of your patch in, as I
> think we should get this right from the start.

Can you review the code in
http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-req.11
and see if this fits your intention?

I've only sent out the hopefully uncontroversial first part for now
to limit the amount of patch traffic on the list.
