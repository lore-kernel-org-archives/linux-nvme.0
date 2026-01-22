Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305D5C44500
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jan 2026 06:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JUrVui+QVBdebLL4aYR3zPDA4RCr/EF3h74NxjQ/m3I=; b=cWbOBpRyGr7aQ2L6r1TVmGgS8e
	LUNm+IA5ot2qIWOi4QuaLQsmVTbc1exUK2Zsw6Ch+XUN6N3eh4wDPwreRryDMsm/s2u6Gf2qSkSCi
	fslyzdwoeohsmRAvjaxNDAPnyHeX0j0Q/uH5AuZxcTf7j+8G139TIig/bRsPdJ5aD8mS7Eo7WiuDa
	XPHv74n8Cc0QYajWZSYRmgpLiCVsP/TTcGHMHajn/aJU08mKL13++wHbZYL5HCbHSgF/cEVfGV51x
	B4I1JWGfuBPFI4aRGYDrcpOz9gLdd6ffQnOOTuhGXZC4xWgos1hlvJGW0rQ8ao1C8IucfuDIwsX3R
	cSAVWGLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vioLR-00000006VcA-1fcT;
	Thu, 22 Jan 2026 06:39:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vioLO-00000006Vbn-0IjO
	for linux-nvme@lists.infradead.org;
	Thu, 22 Jan 2026 06:39:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 65C80227AA8; Thu, 22 Jan 2026 07:38:57 +0100 (CET)
Date: Thu, 22 Jan 2026 07:38:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: "xiaoke@sangfor.com.cn" <xiaoke@sangfor.com.cn>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	sagi@grimberg.me, axboe@kernel.dk, kbusch@kernel.org
Subject: Re: [PATCH] nvme: don't reject probe due to duplicate IDs for
 single-ported PCIe devices
Message-ID: <20260122063857.GA24621@lst.de>
References: <20230713133042.3981-1-hch@lst.de> <56389e0f-b0b6-49b1-8de3-d8d18e507189@sangfor.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56389e0f-b0b6-49b1-8de3-d8d18e507189@sangfor.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260121_223902_274045_9A8A3538 
X-CRM114-Status: GOOD (  15.63  )
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

On Tue, Jan 20, 2026 at 05:54:25PM +0800, xiaoke@sangfor.com.cn wrote:
>
> I’d like to discuss whether we should revisit the duplicate-ID check
> for NVMe-oF transports, especially in HA dual-active setups.
>
> In such HA configurations, a single LUN is exposed via multiple subsystems
> (one per storage controller) to provide redundancy. Because it represents
> the same namespace, it usually reports the same UUID/NGUID/EUI64 on all 
> paths.

Not in any configuration confirming to the NVMe spec (discounting the
completely broken dispersed namespace feature).

So no, this is exactly what both the spec, and the code try to prevent.

> > +		if ((ns->ctrl->ops->flags & NVME_F_FABRICS) || /* !PCIe */
> > +		    ((ns->ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) &&
> > +		     info->is_shared)) {
>
> Concretely, with two subsystems exposing the same LUN in a dual-active
> HA configuration:

There are no logical units or logical unit numbers in NVMe.


