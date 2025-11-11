Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C556BCCFA1A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Nov 2025 09:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OFsdecxrCevYGqyF8+zcNMvTD3U6WNHeCarLRrJ3rlo=; b=Vfi+J5VEmXO26pVONv4KA7FZ08
	Wm68CKd73sncPc45WCxoIOPX23zzAEVhrUiMMaCkhIkbLatZTtm3+i3nMnjOaEDpj+yuQE3A77qxc
	c/xygmMucFLahkbGMkZHVRETPHIDAamVqohuHWuzsO0ocy3ILVL+QI44Lh2vZr1hTcyTiA76F6fHl
	msNQz5fHl7vxqzIHy/aJHzbYI5Da8iPJtFJwLX0bmT+Tt72+MmfhkOYVdqDDDpBroHYjWEf7j6Dzj
	mzSzYeSzyvr6LI8ge22dKlIcsLdbFv206M6V5nPIE+U891BBXp9Vn/wtisEYeTRizvd4itABCeaGS
	fQ/TXj8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIkqE-00000006rOc-0vw2;
	Tue, 11 Nov 2025 09:39:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIkqC-00000006rO7-2mvE
	for linux-nvme@lists.infradead.org;
	Tue, 11 Nov 2025 09:39:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70484227A87; Tue, 11 Nov 2025 10:39:03 +0100 (CET)
Date: Tue, 11 Nov 2025 10:39:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai@fnnas.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Message-ID: <20251111093903.GB14438@lst.de>
References: <20251014150456.2219261-1-kbusch@meta.com> <20251014150456.2219261-2-kbusch@meta.com> <aRK67ahJn15u5OGC@casper.infradead.org> <aRLAqyRBY6k4pT2M@kbusch-mbp> <20251111071439.GA4240@lst.de> <024631dc-3c65-49a8-a97a-f9110fd00e9a@fnnas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <024631dc-3c65-49a8-a97a-f9110fd00e9a@fnnas.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_013908_848050_4334AEBD 
X-CRM114-Status: GOOD (  19.20  )
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

On Tue, Nov 11, 2025 at 05:36:39PM +0800, Yu Kuai wrote:
> This can be reproduced 100% with branch for-6.19/block now, just:
> 
> blkdiscard /dev/md0
> 
> Where discard IO will be split to different underlying disks and then
> merge. And for discard bio, bio->bi_io_vec is NULL. So when discard
> bio ends up to the merge path, bio->bi_io_vec will be dereferenced
> unconditionally.

Ah, so it's not a NULL req->bio but bio->bi_io_vec.

> 
> How about following simple fix:
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 3ca6fbf8b787..31f460422fe3 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -740,6 +740,9 @@ u8 bio_seg_gap(struct request_queue *q, struct bio *prev, struct bio *next,
>          gaps_bit = min_not_zero(gaps_bit, prev->bi_bvec_gap_bit);
>          gaps_bit = min_not_zero(gaps_bit, next->bi_bvec_gap_bit);
> 
> +       if (op_is_discard(prev->bi_opf) || op_is_discard(next->bi_opf))
> +               return gaps_bit;
> +

I think the problem is how we even end up here?  The only merging
for discard should be the special multi-segment merge.  So I think
something higher up is messed up


