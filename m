Return-Path: <SRS0=/YZe=YR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B582CA9EB9
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2019 01:17:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D31972084B
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2019 01:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jURl+oSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31972084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NYD6R53I5keb4RkjZDPEn10m8gHX/n9p5d/RMLrxJ3Y=; b=jURl+oSScb7dv4
	3Hh6tvfqxkWeLU7iJMdD07nFWVeVxvSBW3G1lhgVG5pwBra8cf5yc0j0HE7DbaU5Bh1cJQA7Wiv4L
	wxb4/zilIeo35YofGtLBekLmoASkm0zJMcWKO/MBYG3QiKnaGK+UaLYpnAuNaUwdoMxvo0L1ryvic
	vdoZruw2Fly/xagZdkloQHqEdE3d3VuiiKFS//cT4Mz76aD/LuXEQ4Lkg+8uP84TOGEs+6t5e861N
	fy+jiMOeaHIl1Q6tfAYBwfLyw/GQGq6CMtoioSP9liML1a4im5irp3BnbBH/okaVxQ5y8YiQfxaES
	0juIBuJrRy44TVePMDyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iNRl7-0004YB-NH; Thu, 24 Oct 2019 01:17:49 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iNRl4-0004Xc-GV
 for linux-nvme@lists.infradead.org; Thu, 24 Oct 2019 01:17:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 281F768BE1; Thu, 24 Oct 2019 03:17:44 +0200 (CEST)
Date: Thu, 24 Oct 2019 03:17:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 3/7] nvmet: Introduce common execute function for
 get_log_page and identify
Message-ID: <20191024011743.GC5190@lst.de>
References: <20191023163545.4193-1-logang@deltatee.com>
 <20191023163545.4193-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191023163545.4193-4-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191023_181746_696058_C2B90095 
X-CRM114-Status: UNSURE (   9.18  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 23, 2019 at 10:35:41AM -0600, Logan Gunthorpe wrote:
> Instead of picking the sub-command handler to execute in a nested
> switch statement introduce a landing functions that calls out
> to the appropriate sub-command handler.
> 
> This will allow us to have a common place in the handler to check
> the transfer length in a future patch.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [logang@deltatee.com: separated out of a larger draft patch from hch]
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

First signoff needs to be the From line picked up by git.  I don't really
care if you keep my attribution or not, but if you do it needs From
line for me as the first theing in the mail body, and if not it
should drop by signoff and just say based on a patch from me.

Otherwise the series looks fine.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
