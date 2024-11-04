Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5805D132C0
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 13:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9dQMIo4U+a5p71IonR9Lfh1NJeFSo+vQhuHuUkSOZEo=; b=YrEPGiQF0I5d0ofuKgo8P1nZJO
	t5+ZGs9giM3/0Fgv/YD0GQDjdnS7o/aUta5xi2Xc053R4UH1LVjlbjgYSDM7lpJGdtHzqQZ4RwpBZ
	lfXdleGT2I7au+JyvcynS2b6gcBBU6jbCZvc9WAIlbhHMDnwLGWvvyIxHwQRDcOtphnY3ypC85Qza
	BY+nFjUr0V7DqpimF0v1Es5L/POKx0+t9KKi/ugp6iOYS3uBnAbKWviDGlupbgCr0E/1UbLzYmWKi
	ib4lv9+nlclolM7k2K6JmeFggtDWJeslNzEMbaCZj20dIRHj1261bvtdYltUHD6IeKgBQ2a/1VDTz
	QZOaxP3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7wwz-0000000DoRk-1BbK;
	Mon, 04 Nov 2024 13:16:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7www-0000000DoQs-3VLc
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 13:16:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 39374227AAF; Mon,  4 Nov 2024 14:16:52 +0100 (CET)
Date: Mon, 4 Nov 2024 14:16:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Breno Leitao <leitao@debian.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] nvme/host: Fix RCU list traversal to use SRCU primitive
Message-ID: <20241104131652.GB14373@lst.de>
References: <20241104-nvme_rcu-v1-1-ecb19f5c95fa@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104-nvme_rcu-v1-1-ecb19f5c95fa@debian.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_051655_043701_8F8C7EF8 
X-CRM114-Status: GOOD (  17.53  )
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

On Mon, Nov 04, 2024 at 04:24:40AM -0800, Breno Leitao wrote:
> The code currently uses list_for_each_entry_rcu() while holding an SRCU
> lock, triggering false positive warnings with CONFIG_PROVE_RCU=y
> enabled:
> 
>   drivers/nvme/host/core.c:3770 RCU-list traversed in non-reader section!!
> 
> While the list is properly protected by SRCU lock, the code uses the wrong
> list traversal primitive. Replace list_for_each_entry_rcu() with
> list_for_each_entry_srcu() to correctly indicate SRCU-based protection
> and eliminate the false warning.

I didn't even know there was such as thing as list_for_each_entry_srcu,
but apparently it's been there for a while.  Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> Something similar will need to be done for multipath. I will get it done
> once I get some feedback about this patch first.

Thanks!


