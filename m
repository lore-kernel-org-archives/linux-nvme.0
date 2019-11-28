Return-Path: <SRS0=mBQh=ZU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E24C432C0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 07:17:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E40F9215E5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 07:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mrbwE0We"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40F9215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JJgErNwo7Up0djRy/jfzFED3+lepBnQSVfDGNyMn3DQ=; b=mrbwE0WenF+PaS
	DHJXyniayLsiTYjP9iz8H80O8r87KIUdeKj3/ntdDnn1JGVW85fDt8T+y0r6Qw3bifMJXcze6KyiH
	sRPHtkA7rUAwHbml0fvqtCTsLgJFcWInFio6ee9R3Dlk99qR2xu4OJMHxEU8da6hru5TChAsvJw22
	sj0CHOcy+WRgnssOGpak8v/KFVNP5SVz7z+W6W0aEyJxsNEXoKYafQKJPpxKvz0npHwWgdDW2vQHG
	0qZOmsmH3fYyqwpuFazmkEmbTVAGPiV5vS+gVcrsUTuSVfmEGOm9K+ZSF3Q3D7OhNCTm8RQLZteYU
	QV+mDg3yRMJTWHzG3YMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iaE3Z-0003KV-1f; Thu, 28 Nov 2019 07:17:41 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaE3W-0003KA-6n
 for linux-nvme@lists.infradead.org; Thu, 28 Nov 2019 07:17:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9D4C668B05; Thu, 28 Nov 2019 08:17:30 +0100 (CET)
Date: Thu, 28 Nov 2019 08:17:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/4] PCI/MSI: Export __pci_msix_desc_mask_irq
Message-ID: <20191128071730.GA20330@lst.de>
References: <20191127175824.1929-1-kbusch@kernel.org>
 <20191127175824.1929-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191127175824.1929-2-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191127_231738_396102_34590D8C 
X-CRM114-Status: UNSURE (   7.18  )
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

On Thu, Nov 28, 2019 at 02:58:21AM +0900, Keith Busch wrote:
> Export the fast msix mask so that drivers may use these in timing
> sensitive contexts.

Always good to add Thomas for interesting irq handling bits..

I'm not sure directly calling this API is a good idea, as it basicall
ends up being called through the various irq_chip drivers.

I think we really need a way to communicate down the disable_irq
path that we don't need to flush MMIO writes instead.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
