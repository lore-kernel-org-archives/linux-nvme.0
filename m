From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 27 Jan 2017 09:00:08 +0100
Subject: [PATCH] nvme: make nvmf_register_transport require a create_ctrl
 callback
In-Reply-To: <2cc9ed5f-c9af-fd9d-2c90-04541ceebab6@grimberg.me>
References: <20170126152228.15330-1-jthumshirn@suse.de>
 <2cc9ed5f-c9af-fd9d-2c90-04541ceebab6@grimberg.me>
Message-ID: <20170127080008.GA4501@linux-x5ow.site>

On Thu, Jan 26, 2017@06:30:47PM +0200, Sagi Grimberg wrote:
> 
> > static void __exit nvme_fc_exit_module(void)
> >diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> >index 557f29b..80f3695 100644
> >--- a/drivers/nvme/host/rdma.c
> >+++ b/drivers/nvme/host/rdma.c
> >@@ -2063,8 +2063,7 @@ static int __init nvme_rdma_init_module(void)
> > 		return ret;
> > 	}
> >
> >-	nvmf_register_transport(&nvme_rdma_transport);
> >-	return 0;
> >+	return = nvmf_register_transport(&nvme_rdma_transport);

Gah typo and I had only fc enabled in my .config.

Sorry.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
