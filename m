Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4E4C636CD
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Feb 2023 15:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2isyjokO+gXmR4V1wflIQ4fC51hraweUagTp0P4CRPE=; b=YGN0UjcmWjWLEwfzlhGftMvh2X
	dAS4OJj+2n4IuFiO9oMXXs9L/6St0hINFRo8m2NTVM5M9yturAVI/AyO5/XyhKNIg5mL4JPPejCfM
	GEE0/CJsQ/7YZ7+8vW7iOsxi2esoCKfWsnZp7omw1q18IK0uarmmYJSi/u+/XGHBHWgv0Mxvk9GpV
	LbioEa2YXGAn2J/s1dylCk2otlEQldnOFh0B+P0C0+Z8NJFAHx8vaGNP6PXYWKWcabDo+yl7RgBCr
	mpZQi1LLY4hoCf47TfUf450qKwAiRC7AAVsHXZfUEiVgj3lLLuUMmLWyuY2boIUijODj/qpiIb6kp
	+XtgOd+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQVSZ-006NPN-Gi; Fri, 10 Feb 2023 15:37:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQVSX-006NNk-3t
	for linux-nvme@lists.infradead.org; Fri, 10 Feb 2023 15:37:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7748461DFE;
	Fri, 10 Feb 2023 15:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDA4C433D2;
	Fri, 10 Feb 2023 15:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676043427;
	bh=mwnjrM76cnU8bPiF83jwZwUQ3ICB0L7I1M6uCGAC7Wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SxxA9Y0aPdwUOOHIp1CnJ6r4cflI4E1Up5/3MdO7o76jqSX5XcMZryVxR+r4/hFST
	 3UubnmIl1h5JF5sBBfYiZvpnO7QsBYjwiQyw7ayKODrzdtfNQMIvVRMLcg0nGcMTAj
	 ZzZumg+1V2D+XuRNrebt1k+fqewK12aWPiWeHTOSmKnIEf9OnoE10+L8HOSGR663I+
	 iFUj10E/VLcKcC8BtBrPWGvMUqECx5vWmiJ1noX6HxWkNvDg3TNvaQK14IYV9Hbryv
	 PtrOrZRLhexOCmMnUk9iZrN6EqNZxXMBS0mAYoyUdH9MFS/7XNBOUiEhUeVtD/LXiH
	 VhzNsMeZDEzDA==
Date: Fri, 10 Feb 2023 08:37:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: hch@lst.de, kbusch@meta.com, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH 0/4] nvme patches for 6.3
Message-ID: <Y+Zkn3bj80lR4bZo@kbusch-mbp.dhcp.thefacebook.com>
References: <20230108182219.GD25544@lst.de>
 <fb65a843ba3da23dbb5b7423a2d413c0f263604d.camel@linux.ibm.com>
 <Y+Zhvn1KwbMVmpGx@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+Zhvn1KwbMVmpGx@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_073709_267632_04C80C4B 
X-CRM114-Status: GOOD (  29.65  )
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

On Fri, Feb 10, 2023 at 08:24:46AM -0700, Keith Busch wrote:
> On Fri, Feb 10, 2023 at 03:34:09PM +0100, Niklas Schnelle wrote:
> > Hi Christoph, Hi Keith,
> > 
> > It looks like this series causes crashes on s390x.
> > With current linux-next-20230210 and a Samsung PM173X I get the
> > below[0] crash. Reverting patches 1-3 makes the NVMe work again. I
> > tried reverting just patch 3 and 2/3 but this results in crashes as
> > well and as far as I can see patches 2/3 depend on each other. Not
> > entirely sure what's going on but patch 3 mentions padding to the cache
> > line size and our 256 byte cache lines are definitely unusual. I didn't
> > see any obvious place where this would break things though. I did debug
> > that in the crashing nvme_unmap_data() iod->nr_allocations is -1 and
> > iod->use_sgl is true which is weird since it looks to me like iod-
> > >nr_allocations should only be -1 if sg_list couldn't be allocated from
> > the pool.
> 
> Thanks for the notice.
> 
> I think the driver must have received a request with multiple physical
> segments, but the dma mapping collapsed it to 1. In that case, the driver won't
> use the "simple" sgl, but we don't allocate a descriptor either, so we need to
> account for that. I'll send a fix shortly.

This should fix it:

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a331fbfa9a667..6e8fcbf9306d2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -553,14 +553,16 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 
 	dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
 
-	if (iod->nr_allocations == 0)
+	if (iod->nr_allocations == 0) {
 		dma_pool_free(dev->prp_small_pool, iod->list[0].sg_list,
 			      iod->first_dma);
-	else if (iod->use_sgl)
-		dma_pool_free(dev->prp_page_pool, iod->list[0].sg_list,
-			      iod->first_dma);
-	else
-		nvme_free_prps(dev, req);
+	} else if (iod->nr_allocations > 0) {
+		if (iod->use_sgl)
+			dma_pool_free(dev->prp_page_pool, iod->list[0].sg_list,
+				      iod->first_dma);
+		else
+			nvme_free_prps(dev, req);
+	}
 	mempool_free(iod->sgt.sgl, dev->iod_mempool);
 }
 
--

