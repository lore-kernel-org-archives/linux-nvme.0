Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4E1C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 17:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CU5vNoZ2DyJnMSSsv6FKJaOR1+kQZIFv71gVo+f6jqA=; b=g3oI8ChCHdpKV4pX1SXxTMkxfd
	+uhX7ZrrKaLDIwBYuHgkNcdVX/0uhczNf1WpQamlMSG9cvxgCDTfJmwq4W0HhrEbJTnDvz067vqzJ
	wfahL1B+Q6BRIiVuPMOLnxBxPxx5XgtPUlwQHH2H04oZuHt2Uids5823gu/EsdmKfVcwgu4wGG4GV
	GXecjhjnAJXTbj1rI+HffVhs/BmrcztgpV3h1M2qHoirZ7mT4FKVge8KeP61d2m4rST5UxnAxVPil
	hELeFBEfyjKJnzgI9WPgNMJulOh6ved0NC+lcOf0wwDS0AO4kvi2zOvq1VuNU20fquEs9kzPHd3At
	4/kHFZ3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk81v-0083cV-Eq; Thu, 28 Apr 2022 17:34:15 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nk81u-0083c3-7l; Thu, 28 Apr 2022 17:34:14 +0000
Date: Thu, 28 Apr 2022 10:34:14 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
 axboe@kernel.dk, snitzer@kernel.org, hch@lst.de,
 naohiro.aota@wdc.com, sagi@grimberg.me, dsterba@suse.com,
 johannes.thumshirn@wdc.com, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, clm@fb.com, gost.dev@samsung.com,
 chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 josef@toxicpanda.com, jonathan.derrick@linux.dev, agk@redhat.com,
 kbusch@kernel.org, kch@nvidia.com, linux-nvme@lists.infradead.org,
 dm-devel@redhat.com, bvanassche@acm.org, jiangbo.365@bytedance.com,
 linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 16/16] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Message-ID: <YmrQFu9EbMmrL2Ys@bombadil.infradead.org>
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160313eucas1p1feecf74ec15c8c3d9250444710fd1676@eucas1p1.samsung.com>
 <20220427160255.300418-17-p.raghav@samsung.com>
 <2ffc46c7-945f-ba26-90db-737fccd74fdf@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ffc46c7-945f-ba26-90db-737fccd74fdf@opensource.wdc.com>
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

On Thu, Apr 28, 2022 at 08:42:41AM +0900, Damien Le Moal wrote:
> On 4/28/22 01:02, Pankaj Raghav wrote:
> > From: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > Today dm-zoned relies on the assumption that you have a zone size
> > with a power of 2. Even though the block layer today enforces this
> > requirement, these devices do exist and so provide a stop-gap measure
> > to ensure these devices cannot be used by mistake
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > ---
> >  drivers/md/dm-zone.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> > index 57daa86c19cf..221e0aa0f1a7 100644
> > --- a/drivers/md/dm-zone.c
> > +++ b/drivers/md/dm-zone.c
> > @@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
> >  	struct request_queue *q = md->queue;
> >  	unsigned int noio_flag;
> >  	int ret;
> > +	struct block_device *bdev = md->disk->part0;
> > +	sector_t zone_sectors;
> > +	char bname[BDEVNAME_SIZE];
> > +
> > +	zone_sectors = bdev_zone_sectors(bdev);
> > +
> > +	if (!is_power_of_2(zone_sectors)) {
> > +		DMWARN("%s: %s only power of two zone size supported\n",
> > +		       dm_device_name(md),
> > +		       bdevname(bdev, bname));
> > +		return 1;
> > +	}
> 
> Why ?
> 
> See my previous email about still allowing ZC < ZS for non power of 2 zone
> size drives. dm-zoned can easily support non power of 2 zone size as long
> as ZC == ZS for all zones.

Great, thanks for the heads up.

> The problem with dm-zoned is ZC < ZS *AND* potentially variable ZC per
> zone. That cannot be supported easily (still not impossible, but
> definitely a lot more complex).

I see thanks.

Testing would still be required to ensure this all works well with npo2.
So I'd prefer to do that as a separate effort, even if it is easy. So
for now I think it makes sense to avoid this as this is not yet well
tested.

As with filesystem support, we've even have gotten hints that support
for npo2 should be easy, but without proper testing it would not be
prudent to enable support for users yet.

One step at a time.

  Luis

