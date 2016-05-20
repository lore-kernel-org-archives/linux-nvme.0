From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 20 May 2016 09:45:53 +0200
Subject: [PATCH v2 2/2] nvme: move nvme_cancel_request() to common code
In-Reply-To: <1463605502-27839-3-git-send-email-mlin@kernel.org>
References: <1463605502-27839-1-git-send-email-mlin@kernel.org>
 <1463605502-27839-3-git-send-email-mlin@kernel.org>
Message-ID: <20160520074553.GC4413@c203.arch.suse.de>

On Wed, May 18, 2016@02:05:02PM -0700, Ming Lin wrote:
> From: Ming Lin <ming.l at samsung.com>
> 
> So it can be used by fabrics driver also.
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
