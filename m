Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2964C43603
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 09:10:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45FB214AF
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 09:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mxd29OLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45FB214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7w2bKlUv0FNdQy37VrCb7o3vExyHuVHXgttiAfn7zyM=; b=mxd29OLQ9uZv/K
	DuQY5DD/Y3DvxcM5HsHY5Rihc7UDQ4Ns1UFNQ2K58eG6MKTH+FiQ0l7vC9RT+NTpVMlu5Cq9LRKc2
	+rWRdUhO04CLMTY9it7ZqtJ9+J6lARtcDJOpH+eglDDhAsdYFSpU4YkKA4mXJem+MhPjD1LJorpiA
	NDjzzc371jtSfTC014V3bYJDr4Mk8/QUU0xM71jGJmDv2U1yRmDLWltFxMA62ZmpQWGu6TId8x12c
	GMEm/2YW9hmbzI+TYB40Tk6o3hITmcvByW13XL424mnTOO5rbT3m86bd3vWPYxogRpIM54WVu8Y3+
	Dkr9yL/tpQ0fyYijB6Ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifKTv-0003wy-2x; Thu, 12 Dec 2019 09:09:59 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifKTs-0003wX-L1
 for linux-nvme@lists.infradead.org; Thu, 12 Dec 2019 09:09:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 320FB68B05; Thu, 12 Dec 2019 10:09:53 +0100 (CET)
Date: Thu, 12 Dec 2019 10:09:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 1/4] nvme/pci: Disable interrupts for threaded handler
Message-ID: <20191212090952.GB2399@lst.de>
References: <20191209175622.1964-1-kbusch@kernel.org>
 <20191209175622.1964-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191209175622.1964-2-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_010956_840824_1D666466 
X-CRM114-Status: UNSURE (   5.85  )
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
 ming.lei@redhat.com, tglx@linutronix.de, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 10, 2019 at 02:56:19AM +0900, Keith Busch wrote:
> +	if (!to_pci_dev(nvmeq->dev->dev)->msix_enabled)
> +		writel(1 << nvmeq->cq_vector, nvmeq->dev->bar + NVME_REG_INTMS);
> +
> +	disable_irq_nosync(irq);

Why do we need both the device-level disable and disable_irq_nosync
for the non-MSI-X case here?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
