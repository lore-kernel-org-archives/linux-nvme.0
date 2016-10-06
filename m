From: hch@lst.de (Christoph Hellwig)
Date: Thu, 6 Oct 2016 11:32:52 +0200
Subject: [PATCH 2/2] nvme: Delete created IO queues on reset
In-Reply-To: <1475699566-5284-2-git-send-email-keith.busch@intel.com>
References: <1475699566-5284-1-git-send-email-keith.busch@intel.com>
 <1475699566-5284-2-git-send-email-keith.busch@intel.com>
Message-ID: <20161006093252.GA4999@lst.de>

On Wed, Oct 05, 2016@04:32:46PM -0400, Keith Busch wrote:
> Commit c21377f8 (Suspend all queues before deletion) decrements the
> online queue count prior to our attempt to delete those IO queues, so
> the driver ended up not having the controller delete any. This patch
> uses the queue_count instead of online_queues.

What if not all queues were online before?  Should we take a
a snapshot of ->online_queues before suspending the queues and
then use that later?
