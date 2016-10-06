From: keith.busch@intel.com (Keith Busch)
Date: Thu, 6 Oct 2016 11:23:37 -0400
Subject: [PATCH 2/2] nvme: Delete created IO queues on reset
In-Reply-To: <20161006093252.GA4999@lst.de>
References: <1475699566-5284-1-git-send-email-keith.busch@intel.com>
 <1475699566-5284-2-git-send-email-keith.busch@intel.com>
 <20161006093252.GA4999@lst.de>
Message-ID: <20161006152337.GA1778@localhost.localdomain>

On Thu, Oct 06, 2016@11:32:52AM +0200, Christoph Hellwig wrote:
> On Wed, Oct 05, 2016@04:32:46PM -0400, Keith Busch wrote:
> > Commit c21377f8 (Suspend all queues before deletion) decrements the
> > online queue count prior to our attempt to delete those IO queues, so
> > the driver ended up not having the controller delete any. This patch
> > uses the queue_count instead of online_queues.
> 
> What if not all queues were online before?  Should we take a
> a snapshot of ->online_queues before suspending the queues and
> then use that later?

That sounds good. In the worst case, using queue_count may attempt to
delete a queue the adapter didn't create, which just returns an invalid
QID error, and everything continues as normal. But it's easily
avoidable, so I'll send a v2 of this one.
