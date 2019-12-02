Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD77C432C0
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 22:46:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDD020678
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 22:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b8M5WZER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDD020678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q42tpe/DnvxEOwN25j6JEGjoPuFdCYant/j0Q1y1aJM=; b=b8M5WZER9lXXG3
	cEdZwmTyNg0exFaFsN+nZyKa0Kx8IsVlfEFVO6Hz4u/rfyzmlXZj8yd8g6d1TtOLbeCJt9+8KjyF8
	nYCdmnY9PnNJatVOeFR/rC1xSvu/bvaFAKnEAMr1BA8tOUZEOrPTwuVE4OoTYZSY/DaIFxlLh8Tl5
	0A0NookHtsoD7WelBqUxLXSY8VVWd/WCCgQ86q28kFx2C1jWJ5ZGCnz278BUEgg22BCFB4niRMiZn
	dKyODWfHxN7JLYDj67SEDG02PAPKFCOiJyLxUyESgu+/7JQby/sCzXML4LKTodhmnxkHr7+XdCZzj
	3bo/TvgiqLCdsEYoHefA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ibuSI-0008Ub-6k; Mon, 02 Dec 2019 22:46:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibuSE-0008UA-Ny
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 22:46:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4E5DF68BE1; Mon,  2 Dec 2019 23:46:03 +0100 (CET)
Date: Mon, 2 Dec 2019 23:46:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/2] PCI/MSI: Export __pci_msix_desc_mask_irq
Message-ID: <20191202224603.GA14770@lst.de>
References: <20191202222058.2096-1-kbusch@kernel.org>
 <20191202222058.2096-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191202222058.2096-2-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_144606_935043_8EC21AB0 
X-CRM114-Status: UNSURE (   6.73  )
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

On Tue, Dec 03, 2019 at 07:20:57AM +0900, Keith Busch wrote:
> Export the fast msix mask for drivers to use when the read-back is
> undesired.

As said last time calling this seems wrong as it breaks the irq_chip
abstraction.  But looking at the disable_irq_nosync semantics I think
that function should do a non-pasted disable disable for MSI(-X)
interrupts.  Can you look into that?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
