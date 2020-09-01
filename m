Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A60DC433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 17:38:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B81D2071B
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 17:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VGYd5MzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B81D2071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xUvzawVqS6iLuVoKxljZLDgLhW0vHlojCiarqbdra0M=; b=VGYd5MzT8l/DFo8mZP4+LV2t7
	9mvmwjPcxxvPri3Vv1zOmjw0TVk1w5Ojola4wX5OW5raHcUCfvPacaQRwFhuDjKRiUesTKn/vdM4F
	A4YKSmE8BQ8ICIGrqH+3yBAmQ9c99pbjHsVBq0DZZF5N+BkdDKdVKbHESfAjiC1QEX9B+D35Sw9QQ
	Ixth7Z6l4nNmpVqjOkDmkxaUDUiiWymyul9rCMuGDqPYsVfsxJpeGJhRodyOTMP+JP6QMvPByEr3f
	7pqmSRCblMiFApVS35wCJVsb7drQ/RGLxDg2TIF+zqv289RAxCCNh/kZIwSAjRQ47VWY1oCn8qaLm
	yxBoTMP8w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDAF6-00007q-Rv; Tue, 01 Sep 2020 17:38:48 +0000
Received: from elvis.franken.de ([193.175.24.41])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDAF4-00007F-U1; Tue, 01 Sep 2020 17:38:47 +0000
Received: from uucp (helo=alpha)
 by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
 id 1kDAF0-0004vS-00; Tue, 01 Sep 2020 19:38:42 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
 id 46A35C0E70; Tue,  1 Sep 2020 19:38:10 +0200 (CEST)
Date: Tue, 1 Sep 2020 19:38:10 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 22/28] sgiseeq: convert from dma_cache_sync to
 dma_sync_single_for_device
Message-ID: <20200901173810.GA25282@alpha.franken.de>
References: <20200819065555.1802761-1-hch@lst.de>
 <20200819065555.1802761-23-hch@lst.de>
 <20200901152209.GA14288@alpha.franken.de>
 <20200901171241.GA20685@alpha.franken.de>
 <20200901171627.GA8255@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200901171627.GA8255@lst.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_133847_166876_4B16F751 
X-CRM114-Status: GOOD (  15.87  )
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
Cc: alsa-devel@alsa-project.org, linux-ia64@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-nvme@lists.infradead.org, linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-mm@kvack.org, Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>,
 linux-scsi@vger.kernel.org, iommu@lists.linux-foundation.org,
 Ben Skeggs <bskeggs@redhat.com>, Matt Porter <mporter@kernel.crashing.org>,
 linux-media@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 Pawel Osciak <pawel@osciak.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 01, 2020 at 07:16:27PM +0200, Christoph Hellwig wrote:
> Well, if IP22 doesn't speculate (which I'm pretty sure is the case),
> dma_sync_single_for_cpu should indeeed be a no-op.  But then there
> also shouldn't be anything in the cache, as the previous
> dma_sync_single_for_device should have invalidated it.  So it seems like
> we are missing one (or more) ownership transfers to the device.  I'll
> try to look at the the ownership management in a little more detail
> tomorrow.

this is the problem:

       /* Always check for received packets. */
        sgiseeq_rx(dev, sp, hregs, sregs);

so the driver will look at the rx descriptor on every interrupt, so
we cache the rx descriptor on the first interrupt and if there was
$no rx packet, we will only see it, if cache line gets flushed for
some other reason. kick_tx() does a busy loop checking tx descriptors,
with just sync_desc_cpu...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
