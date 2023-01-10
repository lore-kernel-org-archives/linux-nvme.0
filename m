Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED08C46467
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jan 2023 06:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yBv1IU1wES+NyoaTOX0QVfxRIF7E7k/iSEhA+ATH5ck=; b=kFD5ejlxBUtmZT+5kbrvXASQSb
	Lh8sJ7bYotemZsXh+RPEIkgW+HKvz3/DmpJC+HgWzdCfBLwAWrDz0EWAycgdGzDkP5WXnHPKe3bmt
	fXkGf4ax0yWp/Lem3adCc48qoPFEYvOc90de316vnXQ2bdOCE258r4dbMn/Tr5EtLWX7/qmQx2EVs
	77dtrYT1EYPRmdtlla70RUrixPy2XOHvZJ79qpcX7YpAN4bTmTnCzX/N8RP9DejvfXAT0hugOuqOE
	uD4guED3DCSCdNwNWUGAF2+dnK5+MdA/SvftNKc3EkJcJFyZaKDxloRlbwceJeUWgotuZiVDKQPGu
	osza0RgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF8Zr-005Xrk-Vn; Tue, 10 Jan 2023 06:57:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF8Zp-005Xq5-G0
	for linux-nvme@lists.infradead.org; Tue, 10 Jan 2023 06:57:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BFF2F68D06; Tue, 10 Jan 2023 07:57:38 +0100 (CET)
Date: Tue, 10 Jan 2023 07:57:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: axboe@kernel.dk, kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
	hare@suse.de, bvanassche@acm.org, snitzer@kernel.org,
	dm-devel@redhat.com, damien.lemoal@opensource.wdc.com,
	linux-nvme@lists.infradead.org, hch@lst.de,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	Luis Chamberlain <mcgrof@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 6/7] dm-zone: use generic helpers to calculate offset
 from zone start
Message-ID: <20230110065738.GE10289@lst.de>
References: <20230106083317.93938-1-p.raghav@samsung.com> <CGME20230106083322eucas1p1ce3ca7b02ca87bb2be8543291e223338@eucas1p1.samsung.com> <20230106083317.93938-7-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106083317.93938-7-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230109_225741_695968_1A6D9655 
X-CRM114-Status: GOOD (  19.99  )
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

On Fri, Jan 06, 2023 at 09:33:16AM +0100, Pankaj Raghav wrote:
> Use the bdev_offset_from_zone_start() helper function to calculate
> the offset from zone start instead of open coding.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  drivers/md/dm-zone.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index 3dafc0e8b7a9..ac6fc1293d41 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -390,7 +390,8 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
>  	case REQ_OP_WRITE_ZEROES:
>  	case REQ_OP_WRITE:
>  		/* Writes must be aligned to the zone write pointer */
> -		if ((clone->bi_iter.bi_sector & (zsectors - 1)) != zwp_offset)
> +		if (bdev_offset_from_zone_start(md->disk->part0,
> +						clone->bi_iter.bi_sector) != zwp_offset)

I can't see how this actually cleans antyhing up, while it does add an
overly long line.

>  		if (clone->bi_status == BLK_STS_OK &&
>  		    bio_op(clone) == REQ_OP_ZONE_APPEND) {
>  			orig_bio->bi_iter.bi_sector +=
> -				clone->bi_iter.bi_sector & mask;
> +				bdev_offset_from_zone_start(disk->part0, clone->bi_iter.bi_sector);

Same here.

