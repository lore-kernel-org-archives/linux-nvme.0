Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01ABDF8E4BB
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 07:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8eAIvWldpTvDOwy3o2gZh4JlJcFWIYJlyf/4cQjBhQM=; b=YhqP8p59cNaky6pjXRBZNZ8Ult
	ogwFRebj5KUQodac1hEgHCu2amHqe/Vbw57YA1vpJl0gb8r3oih333D4lHUUfyTGnTb3lvmOHPorj
	A7DSqwVuRVrJxE1VNYKRTHKl6lXdukqX0vl0q8ivLCKndzqdUaKg/3QW/VrzLR82OyNm5L/tWE4RS
	+nPA8/DTYtMLPnkaJfdfGnd/SkYrhzfd3nP36MkcQ08EOZgb5uXCGLVK5DdrP8CrWwmIASKm6qSmM
	emkVewqG6LF5ndPz1VA6nOUPtZInK5+yAlqlkWw2cbhazTni767NlYTw3oc8pPfoZMudTTc7yKfcw
	1n/yFUeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDe2i-00000003dVW-1W5c;
	Fri, 17 Apr 2026 07:55:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDe2g-00000003dUv-13JK
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 07:55:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7A4CF68CFE; Fri, 17 Apr 2026 09:55:07 +0200 (CEST)
Date: Fri, 17 Apr 2026 09:55:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 6/6] blk-integrity: avoid sector_t in
 bip_{get,set}_seed()
Message-ID: <20260417075507.GD31524@lst.de>
References: <20260416002214.2048150-1-csander@purestorage.com> <20260416002214.2048150-7-csander@purestorage.com> <20260416052325.GE14950@lst.de> <CADUfDZpbOhO9BUW_mFZYh9-UZU26_o3rFGBffNTpepk0ogJhZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUfDZpbOhO9BUW_mFZYh9-UZU26_o3rFGBffNTpepk0ogJhZw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_005510_438070_8EE5006A 
X-CRM114-Status: GOOD (  17.37  )
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

On Thu, Apr 16, 2026 at 06:53:05PM -0700, Caleb Sander Mateos wrote:
> > > +static inline void bip_set_seed(struct bio_integrity_payload *bip,
> > > +                             const struct blk_integrity *bi,
> > > +                             const struct bio *bio)
> > > +{
> > > +     bip->bip_iter.bi_sector =
> > > +             bio_integrity_intervals(bi, bio->bi_iter.bi_sector);
> >
> > The bip is pointed to by the bio, so we don't need to pass it separately.
> > Same for struct blk_integrity.
> 
> I did consider that, but all callers already have bip and bi in
> variables that they also use elsewhere. Seemed like it might be
> slightly more efficient to just pass the precomputed values instead of
> looking them up again. Not a big deal either way. I'll go ahead and
> implement your suggestion.

In general I much prefer API-simplicity over a little bit more
efficiency unless we can show it makes a difference that matters.
And given that this is an inline function where compiler tend to
avoid duplicate dereferences anyway I doubt we'll see a difference
here.


