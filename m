From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 May 2018 10:17:12 +0200
Subject: [PATCH 08/14] nvmet: implement the changed namespaces log
In-Reply-To: <20180528065342.hi74ewwbvkoqsj6x@linux-x5ow.site>
References: <20180526102735.31404-1-hch@lst.de>
 <20180526102735.31404-9-hch@lst.de>
 <20180528065342.hi74ewwbvkoqsj6x@linux-x5ow.site>
Message-ID: <20180529081712.GD1416@lst.de>

On Mon, May 28, 2018@08:53:42AM +0200, Johannes Thumshirn wrote:
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> 
> As a side note, what happens if more than 1024 Namespaces are changed
> (apart from setting the 1st element to 0xffffffff and zeroing out the
> rest)?
> 
> The Spec is pretty silent in this regard.

The spec is completly clear on this:

>From 5.14.1.4:

"If more than 1024 namespaces have changed attributes since the last time the
 log page was read, the first entry in the log page shall be set to FFFFFFFFh
 and the remainder of the list shall be zero-filled."

Once we don't know what changed we'll have to do a full rescan using
Identify.
