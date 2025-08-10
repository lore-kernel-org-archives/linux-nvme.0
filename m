Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959BDC87FCF
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Aug 2025 14:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k2gXVp2hJgPIQNEsSUaBNFsi78yitBHEmo4iGkla7GA=; b=IH6+6sD6vazNQtbfuTIiU3Lvx4
	OES6n+zrcsJ0DmkHHoCiUkWySBdnhqfqQ3FVubBsWUDEJvIa/FKjnTueKw3mqtomPsUiCBc90bgK5
	GRcfIQTNGY7FxWhxv9WhSoOjNaFRd3PzLVz7x7/33WEScS2Ekxos4F7bUhwUBpwm6zxNkskNZcZrC
	tucYRwoamFMP/DZSTz6Zyl2QArtdFb2UENrvXEToSKlz33ukHDxhrGJKaYSooMcWqH4ejb7i43plr
	2d8XkngV8XoQxiFQQwAQpzTEHHNeOT5fJYI+EJQi3Og4volnDtqEMN4WodhJo2I7gFaI4x3Smf/gV
	EhxA/j9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul6js-00000005fxU-0qZs;
	Sun, 10 Aug 2025 14:09:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul6jp-00000005fws-3oPd
	for linux-nvme@lists.infradead.org;
	Sun, 10 Aug 2025 14:09:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 947DE68BEB; Sun, 10 Aug 2025 16:09:26 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:09:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 2/8] blk-mq-dma: provide the bio_vec list being
 iterated
Message-ID: <20250810140926.GE4262@lst.de>
References: <20250808155826.1864803-1-kbusch@meta.com> <20250808155826.1864803-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808155826.1864803-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_070930_085536_9B50CF6F 
X-CRM114-Status: GOOD (  10.40  )
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

On Fri, Aug 08, 2025 at 08:58:20AM -0700, Keith Busch wrote:
> +	struct bio_vec                  *bvec;

.. and another thing.  bvec feels a bit confusing as the pointer is not
to the current bvec, but the base bvec table and the name should
express that some how.  Maybe just bvecs for the shortest possible
way to kinda express that?


