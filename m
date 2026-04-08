Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84628FD5F78
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 05:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FGVZvsJ7+aFUi9R2AonAN1Szz4uf3rqKeEpjoICbM3I=; b=2QhX3bnv/UGNbRaVGAUDMLpuky
	TiEWmOzPm4/hNFtdKrobIW1Mo8QpPOpeFkQXS/JLQR8Gi6yQq06WUjOyukitUcr9vW2erEhObZ1UU
	MpKYSaUGpLTskWHzhtNljxsr31ibxKJ5xIYRr2M8U0G5Dh0o1yAS++uGAt7/QwuVGZ12OmsYDDsHU
	tR7hN8wk6gyB2KYO77wOev5w40jM/GPaYM+zhRH9tPxk/67mKsyhIIF4PJZkfEYsdUR07J0s/CzBW
	8NugOvvWCWYwzxsN8q8UNhADk0TJFh02zwdWAnL5hLlecPs8PIvk5I/Vm/ZHroamxlZ3uiYmxHSGB
	aEW29b+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wALBG-00000008GxV-3fde;
	Wed, 08 Apr 2026 05:10:22 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wALBD-00000008GxA-3rp7;
	Wed, 08 Apr 2026 05:10:19 +0000
Date: Tue, 7 Apr 2026 22:10:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: Re: [PATCH 2/6] block: use integrity interval instead of sector as
 seed
Message-ID: <adXjO5y6tLLVz77C@infradead.org>
References: <20260403194109.2255933-1-csander@purestorage.com>
 <20260403194109.2255933-3-csander@purestorage.com>
 <adNUE67FpIGF_x7Q@infradead.org>
 <CADUfDZqHyTDO6aYed+mtChU9m3iPgW=hghwfifuCV8Z_CzxoFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqHyTDO6aYed+mtChU9m3iPgW=hghwfifuCV8Z_CzxoFQ@mail.gmail.com>
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

On Tue, Apr 07, 2026 at 09:48:52AM -0700, Caleb Sander Mateos wrote:
> On Sun, Apr 5, 2026 at 11:35 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Fri, Apr 03, 2026 at 01:41:05PM -0600, Caleb Sander Mateos wrote:
> > >  void bio_integrity_setup_default(struct bio *bio)
> > >  {
> > >       struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
> > >       struct bio_integrity_payload *bip = bio_integrity(bio);
> > >
> > > -     bip_set_seed(bip, bio->bi_iter.bi_sector);
> > > +     bip_set_seed(bip, bio_integrity_intervals(bi, bio->bi_iter.bi_sector));
> >
> > Should we simply switch bip_set_seed to take a bio bvec_iter argument and
> > lift all this logic into it?  That feels a lot less fragile.
> 
> Perhaps I'm misunderstanding the suggestion, but how would that work
> for initializing the seed from struct uio_meta in
> bio_integrity_map_iter()?
> 
> bip_set_seed(bio_integrity(bio), meta->seed);

Just open code the assignment there as the code must be build with
blk-integrityu support?


