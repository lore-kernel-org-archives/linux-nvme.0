Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8F4C531D4
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2026 14:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aCJwlHCHMUM4DjLud4Jjwmt9s1TTIQpG3/GG5AQfZR8=; b=KmXcvf+WKcLxK15Hx7nohuSJLp
	iu6izv/ab0iFrMd+oW4slpJstUCm35TRwFF5wmsvSW6byl4Jf4SZafSBK1inlML9qbKwi9gZD1spD
	P1hRAjgHZ24pAqB/VtMycZZts94i9BtCP7B6LX5xjr4qb8DJSPEfoe5fG5Z+nXVpcC+AUFXGmv9cs
	P/ij2BkW8Ae7nIa6B0wi//YVRBC9Ht+sgB2AeP0mZ2RF29PGSdTnZFfsa37HviWCNPR6vhN5w9+De
	rHe3uiofwmDN1tVJSK5kAKFslWyRFbkF95rN56Nnyp3TEDa/HY2o3flK+pxZ7OlhASem7O6VTnVBD
	T51I9zxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmuhA-0000000EWqp-2JS7;
	Thu, 23 Jul 2026 14:46:44 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmuh9-0000000EWqX-2li0
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jul 2026 14:46:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1938F412EC;
	Thu, 23 Jul 2026 14:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D1E1F000E9;
	Thu, 23 Jul 2026 14:46:40 +0000 (UTC)
Date: Thu, 23 Jul 2026 08:46:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Fengnan Chang <changfengnan@bytedance.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bvanassche@acm.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Jun Zeng <jun1.zeng@intel.com>,
	Gang Cao <gang.cao@intel.com>, Jun I Jin <jun.i.jin@intel.com>,
	Liang A Fang <liang.a.fang@intel.com>, Yong Hu <yong.hu@intel.com>,
	linux-kernel@vger.kernel.org, Guzebing <guzebing@bytedance.com>
Subject: Re: [RFC PATCH] nvme-pci: adaptively poll completions on busy queues
Message-ID: <amIpPcMAClxDbaiU@kbusch-mbp>
References: <20260723120556.58670-1-changfengnan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723120556.58670-1-changfengnan@bytedance.com>
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

On Thu, Jul 23, 2026 at 08:05:56PM +0800, Fengnan Chang wrote:
> +static void nvme_adaptive_mask_irq(struct nvme_queue *nvmeq, int irq)
> +{
> +	struct nvme_dev *dev = nvmeq->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev->dev);
> +
> +	if (pdev->msi_enabled) {
> +		writel(BIT(nvmeq->cq_vector), dev->bar + NVME_REG_INTMS);
> +		readl(dev->bar + NVME_REG_INTMS);

Why do you have the readl? That's not necesary.

> +	} else {
> +		disable_irq_nosync(irq);
> +	}
> +}
> +
> +static void nvme_adaptive_unmask_irq(struct nvme_queue *nvmeq, int irq)
> +{
> +	struct nvme_dev *dev = nvmeq->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev->dev);
> +
> +	clear_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flags);
> +	if (pdev->msi_enabled) {
> +		writel(BIT(nvmeq->cq_vector), dev->bar + NVME_REG_INTMC);
> +		readl(dev->bar + NVME_REG_INTMS);

Same here.

