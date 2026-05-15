Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F06CD343F
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 04:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TFC45Mt3fSJe3xJZXDBbjxnrH076XUtw1GcuBf7H2x8=; b=h3P48zix8D3U1oxLcm4ds39uRO
	hMAzR2TisT11wsG6iLlugaEnl1pxJKsecEiZQr9cCSLX4l5okbQWhyZPpu6tiJWX+5DUlIR4guzOY
	S/HswJLXRZqJ8nEz6NeR48ZrE80N9oyeBwEV4ysZ0tGnZ8ELeoWRyoEri1n2BHNosbyYyN9vzZTY/
	dyiGADM5g3LX5Q1TkYnLBiUO8kyFfHPqbTWdgcGJpK3GbFj0kLkPSA4S6q9i2u4eW3EOA5HNhD7f+
	nhV0BTkxgXMPGXQVcpxh39Z8aBndONOjRnXsnxo1rrzNi1ek1yq4MI/hCfdhYY+FW/3ACcT0ynA7H
	F3fmh2yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkBM-00000007Iz5-3eu3;
	Fri, 15 May 2026 04:29:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkBK-00000007Iy8-05k7
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 04:29:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 20FEA6732A; Fri, 15 May 2026 06:29:42 +0200 (CEST)
Date: Fri, 15 May 2026 06:29:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] nvme-pci: serialize polling interrupt queue with
 shutdown
Message-ID: <20260515042941.GB3433@lst.de>
References: <20260514144544.1752178-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514144544.1752178-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_212950_206992_6547885B 
X-CRM114-Status: GOOD (  14.12  )
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

On Thu, May 14, 2026 at 07:45:44AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Polling an interrupt driven completion queue temporarilly disables the
> irq. If this occurs concurrently with another thread disabling the
> device, the irq vector may have been freed, which makes it available for
> reuse. Reenabling the irq after polling the queue may be referencing a
> stale irq at that point.
> 
> Fix this race by ensuring nvme_poll_irqdisable() can not run
> concurrently with nvme_dev_disable(), and skip polling the completion
> queue if the queue has already been disabled.

Do we need the same change in nvme_suspend_queue?  I.e., should the check
and locking be moved into nvme_poll_irqdisable?


