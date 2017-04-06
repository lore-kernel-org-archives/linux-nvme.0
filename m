From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 6 Apr 2017 16:53:40 +0200
Subject: [PATCH] nvme_fc: avoid double kfree(), don't call
 nvme_cleanup_cmd() in nvme_unmap_data()
In-Reply-To: <1491488190-5564-1-git-send-email-emilne@redhat.com>
References: <1491488190-5564-1-git-send-email-emilne@redhat.com>
Message-ID: <20170406145340.GD3768@linux-x5ow.site>

Hi Ewan,

On Thu, Apr 06, 2017@10:16:30AM -0400, Ewan Milne wrote:
> nvme_cleanup_cmd() is already called by callers of nvme_unmap_data().
				nvme_fc_unmap_data()? ^

And besides this, in nvme_fc_complete_rq() it is called before
nvme_fc_unmap_data() in nvme_fc_start_fcp_op() afterwards. Even if this is a
correct behaviour (i.e. doesn't harm as we're not touching
req->special_vec.bv_page in nvme_fc_unmap_data() it at a first sight looks
like an error. Care to adjust it?

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
