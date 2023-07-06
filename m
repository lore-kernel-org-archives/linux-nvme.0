Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359B4EB64DC
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jul 2023 12:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HNWVFMF7Lt1MvuAG2+jkHI5pPBlSPpW/l/YcAgCNn4w=; b=Ajc37Q9VBjJtjM6Gq9rPp77XZX
	G3BpeWrXuK17PCue/JpbN/3+Aqy3sBotSLOSD3atyPlwjsmSmDvV5uuklkCB4ncCJQZws4nmHi0Zl
	n9aWrZBhZt82U4jKKEANEuGtBpXGL+bfSlSvt2tCASziJ5O6D54ZQcquDjxiJTSDzUNrR/z9TGAyj
	KTpdG1q68A7odm48nz8FHsusQu9vgDuHSkkMyBeml4fXNnfl/dXBa9RS/AAs4g/2n5/8MWl38KKtx
	eBeMGcrzl2ng1GheNXXEnsOg3c4yHqglvJWOPU1R4lvcTp+dkXYr/j4snl6h3pyQ3yG4f48ilKXaw
	E+BtlI1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHOST-001i2C-01;
	Thu, 06 Jul 2023 12:51:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHOSQ-001hyC-1T
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jul 2023 12:51:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B1B9E67373; Thu,  6 Jul 2023 14:51:34 +0200 (CEST)
Date: Thu, 6 Jul 2023 14:51:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] nvme: ensure disabling pairs with unquiesce
Message-ID: <20230706125134.GA12730@lst.de>
References: <20230630174706.3807872-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630174706.3807872-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230706_055138_644786_1F123DEF 
X-CRM114-Status: GOOD (  12.17  )
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

> +static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown);

Can we rename nvme_disable_prepare_reset while we're at it?  The
name already is a bit suboptimal in the xisting code, but with
the new calles becomes really confusing.

nvme_pci_wait_for_reset_and_disable is what I could come up with.
It feels a bit too verbose, but at least it's descriptive.

> +disable:
> +	if (!nvme_disable_prepare_reset(dev, false) &&
> +	    nvme_try_sched_reset(&dev->ctrl))

Why do we wait for a reset just to schedule another reset here?

Also I feel splitting out the changes to wait for reset from those
that add the unquiesce when we can't reset into another patch
would probably help beeing able to understand the changes here.

