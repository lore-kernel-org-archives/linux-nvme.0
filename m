From: hch@lst.de (Christoph Hellwig)
Date: Mon, 2 Oct 2017 18:16:54 +0200
Subject: [PATCH 4/6] nvme: display 'NMIC' namespace attribute
In-Reply-To: <1506952559-1588-5-git-send-email-hare@suse.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-5-git-send-email-hare@suse.de>
Message-ID: <20171002161654.GC11048@lst.de>

On Mon, Oct 02, 2017@03:55:57PM +0200, Hannes Reinecke wrote:
> From: Johannes Thumshirn <jthumshirn at suse.de>
> 
> To figure out if a namespace is shared via multipath we need to expose
> the 'NMIC' value to sysfs.

What for?
