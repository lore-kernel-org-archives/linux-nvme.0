Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3250C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 08:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Brqxrkf8nmujbCoLFZcgsb4qtVO5v7SbHWT5DsPzQuU=; b=1sjuU4Z1s0O3ulp5mSFWrsb33i
	649ainH+2zE81J4mouSgBtIVKUZxgMZ8WwI1wOLW/98J0PE/FvqPlaMs1Ws6Mb64WRnJPh/3Cs5IU
	01PH20Rj2PebNQpEWiAQT7rr7nEn3v+Hsp9PrOrKiE7E6S1NcnaQiPKe/DmDbXSH1SrJsK6m+v2/j
	f5RkGqwsp6U/DQbRnCYtyLJL7l64le3U9bwqnptlUdZ58APxBD/x3ySIjFKSZ/o9e7r5ojoEafGkK
	sG7URQcYOcI/cvFuceU2yNVqsVSlzUyJ9lxI6mo9kFd5v8LtX6LV3pKrbNX8OcDlOuuVc6anfvEBj
	QMNQ4feA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTgPc-004csM-PE; Mon, 14 Mar 2022 08:50:44 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTgK1-004aIO-FI
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 08:44:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5FF9768BFE; Mon, 14 Mar 2022 09:44:50 +0100 (CET)
Date: Mon, 14 Mar 2022 09:44:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Johannes Thumshirn <johannes.thumshirn@edc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 kanchan Joshi <joshi.k@samsung.com>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Fix zns drives without append support to export
 correct permissions
Message-ID: <20220314084449.GA5866@lst.de>
References: <CGME20220311201638eucas1p18b9c5ecb3442b5a53bba233591d34db0@eucas1p1.samsung.com>
 <20220311201608.275384-1-p.raghav@samsung.com>
 <07484796-d692-6247-427f-20d0e9ac6193@opensource.wdc.com>
 <6929490b-5a73-5dd3-d5a4-afe9d3c9b347@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6929490b-5a73-5dd3-d5a4-afe9d3c9b347@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_014457_722372_748CAD97 
X-CRM114-Status: GOOD (  14.00  )
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

On Mon, Mar 14, 2022 at 09:36:35AM +0100, Pankaj Raghav wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 51c08f206cbf..cde33f2a3a5a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1855,8 +1855,7 @@ static void nvme_update_disk_info(struct gendisk
> *disk,
>  	blk_queue_max_write_zeroes_sectors(disk->queue,
>  					   ns->ctrl->max_zeroes_sectors);
> 
> -	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
> -		test_bit(NVME_NS_FORCE_RO, &ns->flags));
> +	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO));
>  }

This creates a race window during revalidation where the zone will be
set writable here only to be set read-only again a little later.

