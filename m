Return-Path: <SRS0=MLi/=DB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC86C2D0E2
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 07:05:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1CC2395B
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 07:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="v00+KRjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1CC2395B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NzQqX+k8MsTtR4jsPZPWsYQNwd65dayj/PptqnUh5KE=; b=v00+KRjfp2Cxkfo3/c4IOCSnX
	spgQHUlsYiBJ0gNS7plfkcjgSAHqzKd05ZZBr/hXJlEfXB9O7MMtHI32XjK13iMG76yaHLupC3rM1
	I0dXYdsFq9cdCEo/yWz9CUz9SEF0qpnvpHz+PIlgsfy15PiZHF0HlfflmpEsiPTZlyBiNvxH4R3QS
	p22qGafm4m2Z9E3yjAkyj1Rw/q7y6pTsv/8OiBoRQmvmPP2cidVH+ri96Jq8jpKpKJzUDC60YeTA9
	9UBWIgbfNzvs5h9PXJ06mIMNe1hoQNe9PhEgvZZfyLCquA7YFHX0KPWk0wKpFVy/XoNciPA3D9TsV
	xvSM6B86Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLLJU-0001ES-Nr; Thu, 24 Sep 2020 07:05:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLLJQ-0001CI-OJ
 for linux-nvme@lists.infradead.org; Thu, 24 Sep 2020 07:05:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E107268B02; Thu, 24 Sep 2020 09:04:57 +0200 (CEST)
Date: Thu, 24 Sep 2020 09:04:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [RFC] nvme/pci: allocate separate interrupt for reserved
 non-polled IO queue
Message-ID: <20200924070457.GA10717@lst.de>
References: <20200922042816.92192-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200922042816.92192-1-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200924_030504_911981_F2BB7B22 
X-CRM114-Status: GOOD (  19.68  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@fb.com, joseph.qi@linux.alibaba.com, hch@lst.de,
 linux-nvme@lists.infradead.org, xiaoguang.wang@linux.alibaba.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 22, 2020 at 12:28:16PM +0800, Jeffle Xu wrote:
> One queue will be reserved for non-polled IO when nvme.poll_queues is
> greater or equal than the number of IO queues that the nvme controller
> can provide. Currently the reserved queue for non-polled IO will reuse
> the interrupt used by admin queue in this case, e.g, vector 0.
> 
> This can work and the performance may not be an issue since the admin
> queue is used unfrequently. However this behaviour may be inconsistent
> with that when nvme.poll_queues is smaller than the number of IO
> queues available.
> 
> Thus allocate separate interrupt for this reserved queue, and thus make
> the behaviour consistent.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

This code looks good, but the function already is a mess without the
addition.  What do you think about this variant?


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 899d2f4d7ab612..43055138d59a47 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2038,31 +2038,29 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 		.calc_sets	= nvme_calc_irq_sets,
 		.priv		= dev,
 	};
-	unsigned int irq_queues, this_p_queues;
+	unsigned int irq_queues, poll_queues;
 
 	/*
-	 * Poll queues don't need interrupts, but we need at least one IO
-	 * queue left over for non-polled IO.
+	 * Poll queues don't need interrupts, but we need at least one I/O queue
+	 * left over for non-polled I/O.
 	 */
-	this_p_queues = dev->nr_poll_queues;
-	if (this_p_queues >= nr_io_queues) {
-		this_p_queues = nr_io_queues - 1;
-		irq_queues = 1;
-	} else {
-		irq_queues = nr_io_queues - this_p_queues + 1;
-	}
-	dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
+	poll_queues = min(dev->nr_poll_queues, nr_io_queues - 1);
+	dev->io_queues[HCTX_TYPE_POLL] = poll_queues;
 
-	/* Initialize for the single interrupt case */
+	/*
+	 * Initialize for the single interrupt case, will be updated in
+	 * nvme_calc_irq_sets().
+	 */
 	dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
 	dev->io_queues[HCTX_TYPE_READ] = 0;
 
 	/*
-	 * Some Apple controllers require all queues to use the
-	 * first vector.
+	 * Some Apple controllers require all queues to use the first vector.
 	 */
 	if (dev->ctrl.quirks & NVME_QUIRK_SINGLE_VECTOR)
 		irq_queues = 1;
+	else
+		irq_queues = 1 + (nr_io_queues - poll_queues);
 
 	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
 			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
