Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB07ECD4F54
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 06:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q9aV0Ct8j8x+VbvsXPKmm/pmXIO0lpmi8IIp1arRQRw=; b=yanu5f+8DnxVld/AeNE26OuetJ
	xSeKiLhTUu5oSGo/Bt5XKnz55QT6srwYLGQD/0mXH5NbI4W5fyxOEN2oP6EEuLv2aJ7HTW/ZXeNMh
	mHTbjCKV9dzQ7W7AjJ9AV7/on5tS8J0F8KqhrpACkioWA1Mnbx7gjsWkPiaTZKvUeMwFvmMtbP8e+
	YwUbbs8txl7rKh0jUxjmI2mM/ZjqFH01ekTD/SCmnnJ+AgAsH3663/2UAR3rsXj88tNA963vhHwhg
	MFQ5MknrjjP68mfxyDdcOAUSAhLpfVsq4AtD4RmJJEYjNCoxHVnnEOqHQkjU5rkSPxFMhAbnQ/5qP
	06fFZ4Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPEKK-00000000PlJ-0syV;
	Tue, 19 May 2026 06:53:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPEKH-00000000Pjo-2At9
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 06:53:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EE7C668CFE; Tue, 19 May 2026 08:53:03 +0200 (CEST)
Date: Tue, 19 May 2026 08:53:03 +0200
From: "hch@lst.de" <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Message-ID: <20260519065303.GA7918@lst.de>
References: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com> <agtnJb5a5uIqH-65@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agtnJb5a5uIqH-65@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_235313_700731_C70DC7F3 
X-CRM114-Status: GOOD (  17.36  )
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

On Mon, May 18, 2026 at 01:23:17PM -0600, Keith Busch wrote:
> On Mon, May 18, 2026 at 02:52:56PM +0000, Achkinazi, Igor wrote:
> > @@ -511,6 +511,13 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
> >         ns = nvme_find_path(head);
> >         if (likely(ns)) {
> >                 bio_set_dev(bio, ns->disk->part0);
> > +               /*
> > +                * Mark the bio as remapped to the per-path namespace disk so
> > +                * that bio_check_eod() is skipped on resubmission (e.g. from
> > +                * bio splitting in blk_mq_submit_bio).  The EOD check already
> > +                * passed on the multipath head disk.
> > +                */
> > +               bio_set_flag(bio, BIO_REMAPPED);
> 
> Any reason nvme multipath can't call submit_bio_noacct_nocheck()
> directly instead? If it's safe to skip the eod check here, then it
> looks safe to skip everything else too.

We really shouldn't expose that, and it doesn't quite to the
right checks here.

But I think the proper fix is to stop using bio_set_dev entirely.
We do not want to associate the bio with a new blkg as those are
basically not going to exist for the underlying devices.  I'm also
not sure we want to allow another round of BPF throttling either.

