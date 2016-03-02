From: keith.busch@intel.com (Keith Busch)
Date: Wed, 2 Mar 2016 19:17:05 +0000
Subject: [PATCH 4/5] block: fix blk_rq_get_max_sectors for driver
 private requests
In-Reply-To: <1456938434-20387-5-git-send-email-hch@lst.de>
References: <1456938434-20387-1-git-send-email-hch@lst.de>
 <1456938434-20387-5-git-send-email-hch@lst.de>
Message-ID: <20160302191705.GD27636@localhost.localdomain>

On Wed, Mar 02, 2016@06:07:13PM +0100, Christoph Hellwig wrote:
> Driver private request types should not get the artifical cap for the
> FS requests.  This is important to use the full device capabilities
> for internal command or NVMe pass through commands.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reported-by: Jeff Lien <Jeff.Lien at hgst.com>
> Tested-by: Jeff Lien <Jeff.Lien at hgst.com>
> ---

Looks good if we can depend on the enum order. Maybe a more explicit
check for the one type that does support checking chunk sectors instead:

	if (unlikely(rq->cmd_type != REQ_TYPE_FS))

But it looks fine as-is, too.

Reviewed-by: Keith Busch <keith.busch at intel.com>
