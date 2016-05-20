From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 20 May 2016 09:46:08 +0200
Subject: [PATCH v2 1/2] nvme: update and rename nvme_cancel_io to
 nvme_cancel_request
In-Reply-To: <1463605502-27839-2-git-send-email-mlin@kernel.org>
References: <1463605502-27839-1-git-send-email-mlin@kernel.org>
 <1463605502-27839-2-git-send-email-mlin@kernel.org>
Message-ID: <20160520074607.GD4413@c203.arch.suse.de>

On Wed, May 18, 2016@02:05:01PM -0700, Ming Lin wrote:
> From: Ming Lin <ming.l at samsung.com>
> 
> nvme_cancel_io is a bit confusing (given the distinction of io/admin),
> so rename it to nvme_cancel_request.
> 
> And update it a bit to pass in struct nvme_ctrl, so it can be used
> by Fabrics driver also.
> 
> Signed-off-by: Ming Lin <ming.l at samsung.com>

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
