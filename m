Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6635DD41C00
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 04:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fbfTNaOrIQ/1ZeUjecppVjlsgle23HGXqaixDjgYE34=; b=PeYVbPNj9NulYHNEn/Qip6J4Jp
	zVWBfQ/UVDgxEniVv41wiKQhgfxf4t+l+SVPraSu+Yo6L3TAH26wJNKaGE2zC3lyvi6kThddfVgoU
	mqIc+xmv3nTl0L+QPbWBMVy617kYpKLM6QsEK2bH83EIxZgokvq49ydnossZo2bjaywk5wxVgpXNA
	LXOLF+pZunJ+gg3LYm6W4qAqq6G7ycVdmUmiYSYP1eRlDZDQc/BSNL8JU1AfUm9lsrTbbCeELKk0f
	D92RzzkuEFEVfPXu3HtGp8SbIHvxqeWVzRzzM0RvqU1kXs22rGVHLp8KUrYLxHV9tg5tniipn3yAs
	9UApot8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tB5Ke-00000005l5F-2b7Q;
	Wed, 13 Nov 2024 04:50:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tB5Kb-00000005l4o-1cvm
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 04:50:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CAD4168AFE; Wed, 13 Nov 2024 05:50:12 +0100 (CET)
Date: Wed, 13 Nov 2024 05:50:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 0/2] Using SGLs for userspace commands
Message-ID: <20241113045012.GA20379@lst.de>
References: <20241112210620.2650523-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112210620.2650523-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_205017_591740_160176C8 
X-CRM114-Status: GOOD (  12.15  )
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

On Tue, Nov 12, 2024 at 01:06:18PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Changes from previous version:
> 
>   Merged up to linux 6.12, which had some necessary blk-integrity
>   patches
> 
>   Dropped all the initial "cleanup" patches. This is instead the minimum
>   patchset to satisfy using the feature.

Refresh my brain, but where was the previous version?  A quick
grep for " Using SGLs for userspace commands" on my linux-nvme mailbox
and an internet search don't find results.

Are the previous cleanups the fixes to the block layer metadata/integrity
code to actually properly deal with splitting and merging?


