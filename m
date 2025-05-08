Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC13C3ABCC
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 17:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WHuoV/KurTZth5DOXophPA05QqgYCrDynTIvhHpWV5k=; b=gC5QI28NhiNz8b7ON70l3rLilg
	L/U+yPbSzf30ITMbEKiuTVZms4MuN6lcivKpAqW4G0cGFXQinrYJvGdZLxj97dHA+UJXB+EBWOp9W
	lVj5Mxb5nUVPhx6RV9vt6H9MO/0OaKnJIqxToAmioL0Lbm5yCJJllXvE/QFBOIRXkaxf35SickRJ+
	191IA/kECcVWGuVb0/TfSavPm/2KVGfL2Va5+51zwA7z9P3GQpHvkwk59K3Jql+AZMQOAwRVKgPqi
	y2kFSKgMZC1hUGFK4fo1WR/NcYtPclfSSi6qDuhhMOdyQdiJZfkFP9wtcaVKPWoSdYh1dp+kRc0Db
	yYxtMt1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD4vl-00000001N1j-2tJg;
	Thu, 08 May 2025 17:21:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD3y7-00000001GMZ-1ieO
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 16:19:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8066067373; Thu,  8 May 2025 18:19:23 +0200 (CEST)
Date: Thu, 8 May 2025 18:19:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHv2] block: always allocate integrity buffer
Message-ID: <20250508161923.GA10610@lst.de>
References: <20250507191424.2436350-1-kbusch@meta.com> <20250508051233.GA27118@lst.de> <aBzYVf3qZkzgFAgy@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBzYVf3qZkzgFAgy@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_091931_595449_23534238 
X-CRM114-Status: GOOD (  16.77  )
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

On Thu, May 08, 2025 at 10:14:13AM -0600, Keith Busch wrote:
> But since you mention it, maybe someone does want to force PRACT on the
> generic read/write path? I considered it a fallback when the kernel
> doesn't have CONFIG_BLK_DEV_INTEGRITY, but we could control it at
> runtime through these attributes too. It would just need a new flag in
> the blk_integrity profile to say if format supports controller-side
> strip/generation and use that to decide if we need to attach an
> unchecked integrity payload or not.

The generate/verify attributes always were my way to force insert/strip
behavior on both SCSI and NVMe for testing.

But yeah, I never tested the PI + other metadata features where this
might or might not work, and we really do need to fix the attribute
for those.

