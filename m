Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC82C5B572
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 05:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6IJBYrqIQXoNLsayeb3J6fl0kokCNKUk+3exnauEa9U=; b=bb/yCEYehZDcYpVCeR4hFMQEFE
	u0i8siv9JauQ6rNBgavXT2rYAwgTCtpVTDiNQkaX5cTVlhXdaIzzikre7BcziuHR3Thv1CsMG/YPh
	/oW2vNp0YLd5zDIzQofoaM8LSIxrHEgiFiyCF8P9mR3VgA5CRIx8cgkGlD9fw7GVP7GEAxGFKDzBN
	DxYef6+BTuqWw63bmIud2cDvK8jelPTgnkfUt+fdq5LMNtPvPmwLOwAqk7u5nlCQ5FA1GSmarlmCi
	IK+7ZcI2mn1sBRg4Xolq4KXgo0osvqk8kePzgf9dX6Y4IFbF2lj8qH/M2s8dc1kUbDpA2429ViPjH
	fF9QW61w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwYo0-000000090nb-1Czt;
	Wed, 19 Aug 2026 05:25:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwYnm-000000090n4-28M0
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 05:25:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1687E68C7B; Wed, 19 Aug 2026 07:25:18 +0200 (CEST)
Date: Wed, 19 Aug 2026 07:25:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: changfengnan <changfengnan@bytedance.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jun1.zeng@intel.com, Guzebing <guzebing@bytedance.com>
Subject: Re: [PATCH] nvme-pci: add adaptive interrupt polling
Message-ID: <20260819052517.GB32364@lst.de>
References: <20260818033846.53790-1-changfengnan@bytedance.com> <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.c71e295f.cf49.450b.ad13.ed0e27cd481a@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.c71e295f.cf49.450b.ad13.ed0e27cd481a@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_222527_827116_A699F14D 
X-CRM114-Status: GOOD (  16.97  )
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

On Tue, Aug 18, 2026 at 11:53:55AM +0800, changfengnan wrote:
> 1. Regarding the NVME_ADAPTIVE_POLL_PERIOD_NS parameter, is it necessary to make it a configurable setting? Perhaps Gen6 SSDs require a smaller value? I currently do not have a testing environment for this, but the default value of 10 us appears to be sufficient for Gen4 and Gen5. 

The most important thing to consider in the short term is not the fastest
possible devices, but the worst.  I.e. consider what this does on really
crappy older cusomer drives, as that is probably the biggest install base
using the Linux nvme driver.

> 2. Should MSI be supported? I do not have a similar environment, so I am unsure how it would perform in such scenarios. 

Or legacy interrupts :)  I don't think we have to support them as long
as we cleanly disable the feature.

> 3. Should it be enabled by default? Although current tests show only a minor performance hit, I still lean toward disabling it by default and waiting to gather more test feedback.

I think it should eventually enabled by default, but I'd also be happy
to merge it fist and then flip the bit later.


