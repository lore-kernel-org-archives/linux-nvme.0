Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F68C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  9 May 2022 16:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oeFX2E5ey4pZOwmjvDjcnRprgKudS5nUCFFZ6mjCjw4=; b=tNir92b/h3FFoa1VAjIuUxLIbK
	Gc3G+WEAt79nLSpV5jn7S+KdbYvw8v9NIzKDnB6C9rw46cdsQBzRHObJlr+bmL3pa63XGWZQPih71
	0+c3gHzeFyXteGSiULW7i9Q8WSQDkcS77JdkHkYXrP0Hczk3SUQjAEM+ZRZj/AJ+Y7XLVv2+v7QI2
	2K5rVgYa4niDc0HOcjzl3FUp6AvNCAlob9U65Wk4KyNRkmGy6eAx/qgc79LTutqCENguynoOBIiZY
	1o6kZ54M/Lksc8uwoacUUg7tGVcET/9nP9xcsRVoXgquQiBDyrPHfQxIfQUOpMs92IcCQwS4T6G8b
	iPEYQ8nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1no5tI-00FGyQ-Dc; Mon, 09 May 2022 16:05:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1no5tF-00FGwF-S9
 for linux-nvme@lists.infradead.org; Mon, 09 May 2022 16:05:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652112339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oeFX2E5ey4pZOwmjvDjcnRprgKudS5nUCFFZ6mjCjw4=;
 b=O2iOyWvHQECbahVRCR3auxpkAXjIms3CLRAk9aCWOL5T5OTpFLoBMhdYq++ssMdDbROcn2
 4TJplDqs1Qfb8Jf0GfVNfwesdJUbm04Q9YTB93Juk+0FiR8Rk0USdGs6t4aBG3vVdbldbX
 KI7iiQythNFaLgijQo9QcsUDHuWIwzI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-_eLvklHJPpOeJmeFOpSfFQ-1; Mon, 09 May 2022 12:05:37 -0400
X-MC-Unique: _eLvklHJPpOeJmeFOpSfFQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 o16-20020ac87c50000000b002f3b8cd6a7fso12371642qtv.13
 for <linux-nvme@lists.infradead.org>; Mon, 09 May 2022 09:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oeFX2E5ey4pZOwmjvDjcnRprgKudS5nUCFFZ6mjCjw4=;
 b=VUF1MjdVLEUfrxEomi8dLNZ6u8SwU/UYt0JsFNVuGJ7SjUCk3tUEFgNEn+B6rsjihq
 XpDBIDT0hDBbXjUPcz9Wj53A43HPgHXJoTO3TdZEPySuvEJnCPt7+aQeoXF6VodWTfQW
 Wv9S879F68Cru3Cp7SosGotQ4GcAagaYKvI3TlYGnBjb7r0pv5YplAbbJRyCHTps0WgU
 H4nc6bmJWukUsHMGZcEuUOBY/Jpbf5ff9FDCLHbDJ8dA64XdfPMDdDmvUf+Ntgh18Pkb
 6OlpRPgEzIGAfz8FxOJ/CYJfdXhkI6E3ecClmPBMz4lEgv/Gh9WdBB/MkQVBZ/W2TkW5
 o/wA==
X-Gm-Message-State: AOAM530ocwW18e5UJGsBAZbDevVG6oDUjBuvfnTuNXZFT3WRlBd5WFZC
 CIyFjb44qjlaw1Ap82jiynPUajqcjjAb6BgFFXCP70O1LSS1F6a6QRZsGwA+Gt/FR6Wk2JgWOiX
 T9+O56bSXKmCywj812Bec5TD0Cg==
X-Received: by 2002:ad4:5504:0:b0:456:35e0:1968 with SMTP id
 az4-20020ad45504000000b0045635e01968mr13785948qvb.126.1652112337405; 
 Mon, 09 May 2022 09:05:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzb2Vrd1ITeAGMSA0ykyWFDZQi/Pj9RpII0I7NdSUoTuyX2v0W9UQn5F/cD9u0YFL4E+wPA+Q==
X-Received: by 2002:ad4:5504:0:b0:456:35e0:1968 with SMTP id
 az4-20020ad45504000000b0045635e01968mr13785891qvb.126.1652112337165; 
 Mon, 09 May 2022 09:05:37 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52]) by smtp.gmail.com with ESMTPSA id
 x14-20020ac8538e000000b002f3bbad9e37sm7663441qtp.91.2022.05.09.09.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 May 2022 09:05:36 -0700 (PDT)
Date: Mon, 9 May 2022 12:05:35 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>, jaegeuk@kernel.org,
 hare@suse.de, dsterba@suse.com, axboe@kernel.dk, hch@lst.de,
 snitzer@kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 bvanassche@acm.org, Luis Chamberlain <mcgrof@kernel.org>,
 gost.dev@samsung.com, Josef Bacik <josef@toxicpanda.com>,
 linux-nvme@lists.infradead.org, jiangbo.365@bytedance.com,
 Jens Axboe <axboe@fb.com>, Chris Mason <clm@fb.com>,
 dm-devel@redhat.com, linux-btrfs@vger.kernel.org,
 Alasdair Kergon <agk@redhat.com>, jonathan.derrick@linux.dev,
 linux-fsdevel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
 Johannes Thumshirn <jth@kernel.org>,
 Keith Busch <kbusch@kernel.org>, matias.bjorling@wdc.com,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3 11/11] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Message-ID: <Ynk7z4FhE2zTrzZh@redhat.com>
References: <20220506081105.29134-1-p.raghav@samsung.com>
 <CGME20220506081118eucas1p17f3c29cc36d748c3b5a3246f069f434a@eucas1p1.samsung.com>
 <20220506081105.29134-12-p.raghav@samsung.com>
 <7f1bd653-6f75-7c0d-9a82-e8992b1476e4@opensource.wdc.com>
 <26ccce4c-da31-4e53-b71f-38adaea852a2@samsung.com>
MIME-Version: 1.0
In-Reply-To: <26ccce4c-da31-4e53-b71f-38adaea852a2@samsung.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=snitzer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220509_090542_022210_DD5048E9 
X-CRM114-Status: GOOD (  18.29  )
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

On Mon, May 09 2022 at  7:03P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> >> ---
> >>  drivers/md/dm-zone.c | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> >> index 3e7b1fe15..27dc4ddf2 100644
> >> --- a/drivers/md/dm-zone.c
> >> +++ b/drivers/md/dm-zone.c
> >> @@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
> >>  	struct request_queue *q = md->queue;
> >>  	unsigned int noio_flag;
> >>  	int ret;
> >> +	struct block_device *bdev = md->disk->part0;
> >> +	sector_t zone_sectors;
> >> +	char bname[BDEVNAME_SIZE];
> >> +
> >> +	zone_sectors = bdev_zone_sectors(bdev);
> >> +
> >> +	if (!is_power_of_2(zone_sectors)) {
> >> +		DMWARN("%s: %s only power of two zone size supported\n",
> >> +		       dm_device_name(md),
> >> +		       bdevname(bdev, bname));
> >> +		return 1;
> > 
> > return -EINVAL;
> > 
> > The error propagates to dm_table_set_restrictions() so a proper error code must
> > be returned.
> > 
> Good point. I will add this in the next rev.

Also, DMWARN already provides the trailing newline, so please remove
the above newline.


