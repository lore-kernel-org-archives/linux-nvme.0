From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Oct 2015 09:39:40 +0200
Subject: [PATCH 17/18] nvme: move namespace scanning to common code
In-Reply-To: <1445470059.3307.85.camel@linux.intel.com>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-18-git-send-email-hch@lst.de>
 <1445470059.3307.85.camel@linux.intel.com>
Message-ID: <20151022073940.GD20076@lst.de>

On Wed, Oct 21, 2015@04:27:39PM -0700, J Freyensee wrote:
> I know this is basically just a move into core.c, but with the concept
> of namespace management in the 1.2 spec, would something like
> list_for_each_entry_safe() and/or a spinlock be more appropriate?

Yes, someone should sit down and think about the concurrency model
for namespace scanning.  Also we really should look into using Identify
for the active name space list as that will be a lot more efficient for
controllers with lots of namespaces.
