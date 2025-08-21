Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C2DCA0EF8
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 10:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wwogDOfJoCPJ/ZnrMBN01PitaM0zogVjB2bKrJJTz+I=; b=NXfUKsELQBbFK8w8zZkvBUM9Mk
	nKh1CLiuA87JLZry7Pv2QyfA7BuTTlXsDlbFHUncPESgHt5YbcyfkRllYtQLzH2FYDr5bq1Zgb6sy
	SB/oBZaD7+nhh/13Sfzxcoss6VUviGGoLgLBaIN2wts6BUP7mqx5FbMRkw7AhHAlwBz2NDlSYDleV
	b+VdIHLGkW2po+8Cz2ptGl/XM8GdzmyQDYCj8j19ks3DboPzb51CazHS9CiTPgx0tyv7qko2F2MkQ
	p3JsgevoCNfo/EJNj4Ma/S32K5/X0+8XSQmu4cJhkRZRxgE0OnPT/hUEefSDNBwDnXSJSFUsrDOz2
	obBfDQDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up2Xf-0000000Gc5X-3AGY;
	Thu, 21 Aug 2025 10:29:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up0jY-0000000GGR3-2HJU
	for linux-nvme@lists.infradead.org;
	Thu, 21 Aug 2025 08:33:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0E38B227A88; Thu, 21 Aug 2025 10:33:02 +0200 (CEST)
Date: Thu, 21 Aug 2025 10:33:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH] nvme: fix PI insert on write
Message-ID: <20250821083301.GA29224@lst.de>
References: <20250820081150.2463767-1-hch@lst.de> <CGME20250820162759epcas5p23e1e53a536f502082fc0e869a72f9c41@epcas5p2.samsung.com> <aKXeCrrvy_0crpmn@kbusch-mbp> <c78a7ce0-1bee-4773-9f29-45f68c9fb5ff@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c78a7ce0-1bee-4773-9f29-45f68c9fb5ff@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_013320_720905_A4CD4E63 
X-CRM114-Status: GOOD (  13.69  )
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

On Thu, Aug 21, 2025 at 10:32:13AM +0530, Kanchan Joshi wrote:
> On 8/20/2025 8:09 PM, Keith Busch wrote:
> >> @@ -1039,6 +1039,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
> >>   			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)))
> >>   				return BLK_STS_NOTSUPP;
> >>   			control |= NVME_RW_PRINFO_PRACT;
> >> +			nvme_set_ref_tag(ns, cmnd, req);
> >>   		}
> > Do we need to check that it's type 1 or 2 before setting this?
> 
> Seems so.
> And if the check moves inside nvme_set_ref_tag(), it will keep 
> current/future call-sites simple.

Yes, that was my thought as well when reading Keith' reply.

