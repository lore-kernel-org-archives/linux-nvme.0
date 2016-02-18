From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 18 Feb 2016 09:32:29 +0100
Subject: [PATCH 1/3] nvme: use a work item to submit async event requests
In-Reply-To: <1455732194-30790-2-git-send-email-hch@lst.de>
References: <1455732194-30790-1-git-send-email-hch@lst.de>
 <1455732194-30790-2-git-send-email-hch@lst.de>
Message-ID: <20160218083229.GN18134@c203.arch.suse.de>

On Wed, Feb 17, 2016@07:03:12PM +0100, Christoph Hellwig wrote:
> Use a dedicated work item to submit async event requests instead of the
> global kthread.  This simplifies the code and reduces the latencies to
> resubmit a request once an even notification happened.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
