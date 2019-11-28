Return-Path: <SRS0=mBQh=ZU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AC0C432C0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 17:59:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3642D20656
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 17:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RjTvNYPc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlGsourj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3642D20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=inEKn4+z/rMa61lEwtABOOiUvm12bUCHTJqZDdcJdd8=; b=RjTvNYPc9eBW2d
	vucKMsDacqi055U4fRXlnwhD9+e7oMBuAv2W+mRIkfhJvN55sKFsLjkBVgZKMcshvHUBlXPMpL8ux
	cbpElgtEuEpRieX0cBBcFPoAQhnoh9cxC+9vIP63KzZO2apR+A8mqRpO6/XnyWTFfSiak4JLhjKXs
	3Di89f/XPHNITDHZVfgP1vZcSkPCuOqK7DM2LG/vWkgeJRWpGSLKlOHGrEG40dFJO8XqTTvjftcJ7
	OKjzgfi9oIStI3uuZb7WB1STVMTSxJE6tDacaDJkQTRF+ay6ldVFQAYqD4op+T1amlH7RWmTya1S/
	6hVCaHm7T3/lo25xVbaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iaO4Q-0001di-UV; Thu, 28 Nov 2019 17:59:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaO4N-0001d8-Bz
 for linux-nvme@lists.infradead.org; Thu, 28 Nov 2019 17:59:12 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E9DBD20656;
 Thu, 28 Nov 2019 17:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574963950;
 bh=5KQJHyogY7J9qErpwnfD9e98zQexFaAp9tyoFcW7Rk8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dlGsourjFCo4APy7pih03qAYTMlFvRcoBkrd5IfLkRgBaAZeqx31NV1ggbE9Pd3bl
 /TwMGKlXTXLcJmfVeZ/8TGUyvhTIWNDPtW9ik/1+CnwtPWvTWiEUmoKk2Erj7IiWPU
 vxJH9FMd/GpwPSDKsuLYnGQX+MIyHiy2rP7FVNjk=
Date: Fri, 29 Nov 2019 02:59:04 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/4] nvme: Threaded interrupt handling improvements
Message-ID: <20191128175904.GA3011@redsun51.ssa.fujisawa.hgst.com>
References: <20191127175824.1929-1-kbusch@kernel.org>
 <20191128075047.GC20659@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191128075047.GC20659@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191128_095911_432779_48DC4098 
X-CRM114-Status: UNSURE (   7.98  )
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
Cc: bigeasy@linutronix.de, helgaas@kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, ming.lei@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 28, 2019 at 08:50:47AM +0100, Christoph Hellwig wrote:
> +	if (to_pci_dev(nvmeq->dev->dev)->msix_enabled)
> +		__pci_msix_desc_mask_irq(irq_get_msi_desc(irq), 1);
> +	else
> +		writel(1 << nvmeq->cq_vector, nvmeq->dev->bar + NVME_REG_INTMS);

Oh, we know which branch this would take before we register the callback,
so smaller specialized functions don't need if/else checks. I even want
to remove the shadow doorbell checks for normal devices by giving each
different submission/completion callbacks too. They are individually
unmeasurable, but maybe they'll add up! :D

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
