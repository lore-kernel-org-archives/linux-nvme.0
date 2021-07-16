Return-Path: <SRS0=k+Rq=MI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB47EC12002
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 20:02:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68202613F3
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 20:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68202613F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=Wo2Zm6gFPw7WMgVCU5SMTqtg+jOKnm2Y5q5RqcAq17o=; b=elLotDLiv5CyRn
	uZ5y/EWxvbdpV7EtnMBGtrRQV8rK2VszyHzDnpUV+gOPrmfiB26R8oPxEsY4bR5AFq91x9AXQUfqN
	k2xnA261sDKOqkD5hZIKsZZuhmoCFWfGZNZQzbqDYhHSYRGLSGDv5HYY9SiyjV/cluYAOH4L/qhYo
	s1HKHDL27sfFcwoXLUUbril+iEqvjksbrsoCv9w3VmojQGe9uDpobfpRlTydFcxLSzfP0V34+XXpS
	XxkQUNuG2dpXHLOMP18CDioX9S0Y18u9PkVWJfHrTiy94j4JNRt6Lkpi9zxqUuNUYu4FWF+13bXJd
	DGD6iPlr5afVo+c4DIHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4U24-005BXh-CP; Fri, 16 Jul 2021 20:02:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4U21-005BX8-5s
 for linux-nvme@lists.infradead.org; Fri, 16 Jul 2021 20:01:58 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AFDB613F3;
 Fri, 16 Jul 2021 20:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626465716;
 bh=rFOR2qypUtELpoy2NWUoxm7klREkrZb97itZWXUaaq8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=pi9l/EsCuyB3C2oqdMBel42BqfeYCuwLFgejqa+LxYPXLcBaatM7lXFExmrtCrx3m
 BchR35OeiH7MTAe9IsqKSuyT0fTRX5ESy75Eey5eo44I+o0GVu0+HD8q3NK2wplTV3
 rvwLro/bCPchoWBwM+NyAEfcQNl49rj2ZswFD8SO8W9Rc1aUmIuwtzYm+wdtdEYhpA
 TVUy3EQdryL2kJ8mkzjnJhT7t4mL0Iz5gm3c0fDBCTDIOKqTpGIXzsmdsacrDWWXNE
 elut+xl31sz+UAVfyhC9lCXCLW98XJzlkMow/keBWtNLRRAiIDwHoTevOumlr4avmu
 dBvchD8JHB1Ug==
Date: Fri, 16 Jul 2021 15:01:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed
 if any irq is managed
Message-ID: <20210716200154.GA2113453@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210715120844.636968-2-ming.lei@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210716_130157_280461_3858D573 
X-CRM114-Status: GOOD (  29.22  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 15, 2021 at 08:08:42PM +0800, Ming Lei wrote:
> irq vector allocation with managed affinity may be used by driver, and
> blk-mq needs this info because managed irq will be shutdown when all
> CPUs in the affinity mask are offline.
> 
> The info of using managed irq is often produced by drivers(pci subsystem,

Add space between "drivers" and "(".
s/pci/PCI/

Does this "managed IRQ" (or "managed affinity", not sure what the
correct terminology is here) have something to do with devm?

> platform device, ...), and it is consumed by blk-mq, so different subsystems
> are involved in this info flow

Add period at end of sentence.

> Address this issue by adding one field of .irq_affinity_managed into
> 'struct device'.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/base/platform.c | 7 +++++++
>  drivers/pci/msi.c       | 3 +++
>  include/linux/device.h  | 1 +
>  3 files changed, 11 insertions(+)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 8640578f45e9..d28cb91d5cf9 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -388,6 +388,13 @@ int devm_platform_get_irqs_affinity(struct platform_device *dev,
>  				ptr->irq[i], ret);
>  			goto err_free_desc;
>  		}
> +
> +		/*
> +		 * mark the device as irq affinity managed if any irq affinity
> +		 * descriptor is managed
> +		 */
> +		if (desc[i].is_managed)
> +			dev->dev.irq_affinity_managed = true;
>  	}
>  
>  	devres_add(&dev->dev, ptr);
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 3d6db20d1b2b..7ddec90b711d 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1197,6 +1197,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  	if (flags & PCI_IRQ_AFFINITY) {
>  		if (!affd)
>  			affd = &msi_default_affd;
> +		dev->dev.irq_affinity_managed = true;

This is really opaque to me.  I can't tell what the connection between
PCI_IRQ_AFFINITY and irq_affinity_managed is.

AFAICT the only place irq_affinity_managed is ultimately used is
blk_mq_hctx_notify_offline(), and there's no obvious connection
between that and this code.

>  	} else {
>  		if (WARN_ON(affd))
>  			affd = NULL;
> @@ -1215,6 +1216,8 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  			return nvecs;
>  	}
>  
> +	dev->dev.irq_affinity_managed = false;
> +
>  	/* use legacy IRQ if allowed */
>  	if (flags & PCI_IRQ_LEGACY) {
>  		if (min_vecs == 1 && dev->irq) {
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 59940f1744c1..9ec6e671279e 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -569,6 +569,7 @@ struct device {
>  #ifdef CONFIG_DMA_OPS_BYPASS
>  	bool			dma_ops_bypass : 1;
>  #endif
> +	bool			irq_affinity_managed : 1;
>  };
>  
>  /**
> -- 
> 2.31.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
