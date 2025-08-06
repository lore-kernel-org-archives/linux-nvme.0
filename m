Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58983CA0EC2
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Aug 2025 14:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TAOOnAX8nq/lkhsBlfMjp74jq+Pj/en0JPpFC1TNhkk=; b=zzrB2OlD9CvD3+HUWWbpwEtarI
	gon+wOObiaOreEO6QPwASos8EPeoHO8UJzzaV6z1GJYVbIiPzXarRh9YOiWg7HVWeBo9/c99rYHZr
	gewG5dtSdUReznLYKlVLgojupvnvzIPrc8oPuszybLrIn9mt5+F+vadAK/y3Y9Fuhj78vzCAFAdsJ
	pRJ7cs5JTSYU7Byl0WF9n2KLCyAQrHCbCjc/jUsk0P5r3Og6paxyL7BIvt3lhMd34CFR/DA9n0m3j
	2etqgSjBl6TnvnaJMr6vSaLscVCq2Fl++hMVVleg5ETPbuCJn/ybtZp8whBQEiPStn+HV+Bp+p6x1
	/upPB6oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujfYi-0000000FV93-3yeT;
	Wed, 06 Aug 2025 14:56:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujfY0-0000000FV20-1Gy0
	for linux-nvme@lists.infradead.org;
	Wed, 06 Aug 2025 14:55:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5F97D68B05; Wed,  6 Aug 2025 16:55:14 +0200 (CEST)
Date: Wed, 6 Aug 2025 16:55:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] nvme: remove virtual boundary for sgl capable
 devices
Message-ID: <20250806145514.GB20102@lst.de>
References: <20250805195608.2379107-1-kbusch@meta.com> <20250805195608.2379107-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805195608.2379107-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_075520_483727_6055E89D 
X-CRM114-Status: GOOD (  11.86  )
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

On Tue, Aug 05, 2025 at 12:56:08PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The nvme virtual boundary is only for the PRP format. Devices that can
> use the SGL format don't need it for IO queues. Drop reporting it for
> such PCIe devices; fabrics target will continue to use the limit.

That's not quite true any more as of 6.17.  We now also rely it for
efficiently mapping multiple segments into a single IOMMU mapping.
So by not enforcing it for IOMMU mode.  In many cases we're better
off splitting I/O rather forcing a non-optimized IOMMU mapping.


