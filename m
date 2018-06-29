From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 29 Jun 2018 09:24:54 +0200
Subject: [PATCHv2 1/4] nvme: trace nvme queue identifiers
In-Reply-To: <20180628214956.13877-2-keith.busch@intel.com>
References: <20180628214956.13877-1-keith.busch@intel.com>
 <20180628214956.13877-2-keith.busch@intel.com>
Message-ID: <20180629072454.7lposg6xt54xg6x3@linux-x5ow.site>

On Thu, Jun 28, 2018@03:49:53PM -0600, Keith Busch wrote:
>  
> +static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
> +					   unsigned nsid);

This looks like a leftover from something different.

Otherwise,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
