From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 16 May 2017 09:33:12 +0200
Subject: [PATCH v2 02/10] nvme_fc: Support ctrl_loss_tmo
In-Reply-To: <20170516001024.5281-3-jsmart2021@gmail.com>
References: <20170516001024.5281-1-jsmart2021@gmail.com>
 <20170516001024.5281-3-jsmart2021@gmail.com>
Message-ID: <85cc2c20-fbe9-3ee1-f5d4-366cb8382485@suse.de>

On 05/16/2017 02:10 AM, James Smart wrote:
> Sync with Sagi's recent addition of ctrl_loss_tmo in the core fabrics
> layer.
> 
> Remove local connect limits and connect_attempts variable.
> Use fabrics new nr_connects variable and use of nvmf_should_reconnect()
> Refactor duplicate reconnect failure code.
> 
> Addresses review comment by Sagi on controller reset support:
> http://lists.infradead.org/pipermail/linux-nvme/2017-April/009261.html
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> ---

Thanks,Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
