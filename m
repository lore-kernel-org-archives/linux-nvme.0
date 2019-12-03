Return-Path: <SRS0=ysN4=ZZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F81CC432C0
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 07:48:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43AD52053B
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 07:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VNGnpdFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AD52053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0P05TN1lqRMjF5r7e8hbTREO6sBTGVnmNXAL0l8m9Fk=; b=VNGnpdFvfy2HJd
	cJbcKwcZjOVnELREH5KIrpZyJrRgAKmJJVTefzDQ3t6rNhTpwT7b7TU1l+/3Zemr9qxLe8vjfc8dv
	LJmW5QwAx1xpnvdYf/HgzN2XPXlxuFLUkK7Jzi4/leA2iByoqcqcjWzbTJaEkCuVsKbxXil+oeDuP
	V9+QiDHlSGaCDkGqypp1d8PVgJgi28ylG+DQ5PJeEXg/8LL1TMuBc1SFOcJd1fGfnRmA5BCh8ltpe
	KSj/XQnBN5Bc+njyyONl/Q8OY7VdnjcOpTcfqysTMJXZUV2qxsCrKY6YKg59Bvzw9JewGSmBYaHcY
	knYfG1DA9KhNKNNHVGFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ic2vC-0001sN-5m; Tue, 03 Dec 2019 07:48:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ic2u6-0000uL-BC
 for linux-nvme@lists.infradead.org; Tue, 03 Dec 2019 07:47:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 764C968BFE; Tue,  3 Dec 2019 08:47:23 +0100 (CET)
Date: Tue, 3 Dec 2019 08:47:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] nvme/pci: Mask device interrupts for threaded
 handlers
Message-ID: <20191203074723.GE23881@lst.de>
References: <20191202222058.2096-1-kbusch@kernel.org>
 <20191202222058.2096-3-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191202222058.2096-3-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_234726_545115_1D54517C 
X-CRM114-Status: UNSURE (   8.02  )
X-CRM114-Notice: Please train this message.
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
Cc: sagi@grimberg.me, bigeasy@linutronix.de, linux-nvme@lists.infradead.org,
 ming.lei@redhat.com, helgaas@kernel.org, tglx@linutronix.de, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 03, 2019 at 07:20:58AM +0900, Keith Busch wrote:
> +static irqreturn_t nvme_irq_thread(int irq, void *data)
> +{
> +	struct nvme_queue *nvmeq = data;
> +
> +	nvme_irq(irq, data);
> +	if (to_pci_dev(nvmeq->dev->dev)->msix_enabled)
> +		__pci_msix_desc_mask_irq(irq_get_msi_desc(irq), 0);
> +	else
> +		writel(1 << nvmeq->cq_vector, nvmeq->dev->bar + NVME_REG_INTMC);

So independent of the indirection issue can we have a theory of operation
on why not using a read to flush the posted writes to disable/enable the
interrupt (either variant) here is fine?  Let's assume we have a worse
case implementation where no write ever gets delivered to the device
until we do a read neither of them will ever hit the device as we don't
really do MMIO reads in nvme during normal operation.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
