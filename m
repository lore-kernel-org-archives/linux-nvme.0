Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0979FC2BD09
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 16:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2z+L892RuLkLdU/yLKxc9A76zA7YkALiVddMP6Lfit0=; b=xFJyrL50BDudtwaSsWPrflrgmO
	+f8jAc5fUKau6Qw9pbnhKZJvNwRMmD71iJYTU9QIZ8aDFP5JopG913wJh4yucFW7qCztBQYq2KePZ
	5LdoeWv9IewjXHVigawOAbuCz4Ot8m7p/HawOq0BzQx1oJ1IPTbpzvLC6fAWmTDviC+CbU+2Poff4
	cM1B1EJiEA+3SZIsg43aZJq2BKQd/gRuJ0UVg2ShLuey+5wCmZFguC4YNB3+5T+K7/42/bi0EgS9Q
	BeKf6ul7OuEcv4RHBCKMWXNoBl8CDl1BVUY/ksDPh1V+CVPQeVrq6CDMyt030DOcKBrQwsA7Dtdo2
	4f0b+sRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLmMR-0000000HRrB-2Z83;
	Mon, 24 Jun 2024 16:16:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLmMO-0000000HRpu-2RNX
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 16:16:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1662D68CFE; Mon, 24 Jun 2024 18:15:59 +0200 (CEST)
Date: Mon, 24 Jun 2024 18:15:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH] nvme-pci: let platform handle subsystem reset fallout
Message-ID: <20240624161558.GA16570@lst.de>
References: <20240624160756.1978565-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624160756.1978565-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_091604_901251_2AE3F1CC 
X-CRM114-Status: GOOD (  19.25  )
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

On Mon, Jun 24, 2024 at 09:07:56AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Scheduling reset_work after a nvme subsystem reset is expected to fail,
> but this also prevents potential handling the platform may provide from
> successfully recovering the link without re-enumeration. Provide a pci
> specific operation that safely initiates a subsystem reset, and instead
> of scheduling reset work, read back the status register to trigger a
> pcie read error.

What does platform mean here?

> @@ -653,6 +654,8 @@ static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
>  
>  	if (!ctrl->subsystem)
>  		return -ENOTTY;
> +	if (ctrl->ops->subsystem_reset)
> +		return ctrl->ops->subsystem_reset(ctrl);
>  	if (!nvme_wait_reset(ctrl))
>  		return -EBUSY;

Branching out into a method but having the default inline here
without any comment explaining it feels weird.

If apple nvme devices supported subsystems resets, the PCIe version
would probably the right thing to do for them as well, but my guess
is they don't anyway.  So maybe return -ENOTTY if no method is
weird up, and turn the old generic one into nvmf_subsystem_reset in
fabrics.c?

> +	/*
> +	 * Taking the shutdown_lock ensures the iomap is not being altered by

s/iomap/BAR mapping/ ?

> +	writel(0x4E564D65, dev->bar + NVME_REG_NSSR);

And now that we're duplicating this constant it could really use a
symbolic name.

> +	/* Read back to trigger platform error handling, if any */
> +	readl(dev->bar + NVME_REG_CSTS);

.. also to flush the posted write above.


