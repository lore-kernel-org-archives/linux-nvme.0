Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916CDC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jul 2022 14:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yOEXfdgzQn/mEPzfGiwDQbB373lcG85jZTVmTVCLEO8=; b=SLwsizmNfobkquIqzxiWcj+gAT
	Z7HQUZDsIEWkWcONgQh7Erlr7r4ldlwv5PgRWZcymEinyWuOSsw3tOtnF0IOIMdud3fWh9zTqueXw
	XusvoeEHY56HdbReF3kFfqutqR8pfxpB2SgPSzi2V51wy4mRzCV9bnbnM0/8rW5pkK6o/il8n4VEL
	XVscfz/br+GYMMYWSvKPcCvCfjUWvLasc3l9LT5vqoIPGzzZlLXwp3cZkqQogTkZdQXMdtrDcEFes
	4kupdG3Rjx76aP39cqL+nfoGWj4pqG/MFkGBV9afUYnVvhZJfrJeF05ODE9Dw7TLh6sIW8+XyfPee
	pX2xeGZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDoLe-009ilD-V1; Tue, 19 Jul 2022 14:37:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDoLc-009ihK-83
	for linux-nvme@lists.infradead.org; Tue, 19 Jul 2022 14:37:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0A84768AFE; Tue, 19 Jul 2022 16:37:03 +0200 (CEST)
Date: Tue, 19 Jul 2022 16:37:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <j.granados@samsung.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
	kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	gost.dev@samsung.com, k.jensen@samsung.com,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH 3/5] nvme: refactor namespace probing
Message-ID: <20220719143703.GA21148@lst.de>
References: <20220718052503.235270-1-hch@lst.de> <CGME20220718052850epcas5p24450d4c756d1eb0db6f4cc9c24bb184d@epcas5p2.samsung.com> <20220718052503.235270-4-hch@lst.de> <20220719070845.GB22571@test-zns> <20220719130048.gkvgei44m3ssqklv@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719130048.gkvgei44m3ssqklv@localhost>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_073716_476196_079ED48D 
X-CRM114-Status: GOOD (  19.84  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 19, 2022 at 03:00:48PM +0200, Joel Granados wrote:
> > +++ b/drivers/nvme/host/core.c
> > @@ -2011,8 +2011,10 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
> > 
> >        if (blk_queue_is_zoned(ns->queue)) {
> >                ret = nvme_revalidate_zones(ns);
> > -               if (ret && !nvme_first_scan(ns->disk))
> > +               if (ret && !nvme_first_scan(ns->disk)) {
> > +                       kfree(id);
> >                        return ret;
> > +               }
> >        }
> > 	
> 
> Should we also take care to hide the device?
> As I read it the call to nvme_revalidate_zones can return a -ENODEV
> (through blk_revalidate_disk_zones) which is the original condition to
> hide the block device.

Yes, I think we need something like the patch below folded in.  This
unfreezes before setting the hidden flag and setting the ns ready,
but I can't see why we'd need it frozen for that.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bbdf0f95331f3..e6025f80744f6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2012,7 +2012,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (blk_queue_is_zoned(ns->queue)) {
 		ret = nvme_revalidate_zones(ns);
 		if (ret && !nvme_first_scan(ns->disk))
-			return ret;
+			goto out_free_id;
 	}
 
 	if (nvme_ns_head_multipath(ns->head)) {
@@ -2029,6 +2029,8 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	return 0;
 
 out_unfreeze:
+	blk_mq_unfreeze_queue(ns->disk->queue);
+out_free_id:
 	/*
 	 * If probing fails due an unsupported feature, hide the block device,
 	 * but still allow other access.
@@ -2038,7 +2040,6 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		set_bit(NVME_NS_READY, &ns->flags);
 		ret = 0;
 	}
-	blk_mq_unfreeze_queue(ns->disk->queue);
 	kfree(id);
 	return ret;
 }

