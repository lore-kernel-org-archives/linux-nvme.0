Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36672C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 10:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eL2aotdkjKhLpQVavwR0kfWg6XIIYQUiyBYBJKhYQvg=; b=1QzXTILuIf50EBT8MwI4mo0+Ou
	cPWyuSALmx6hLsKxLDGcx5turY3sFb59rUdinE1srxtoyizgBzGQpyavWhSZpaa7SzHNSk6bcJor3
	/hpss8w1AvSuZB9qmAEbJl4GvFaESJppALIGX44zWfPsHpcEBpj4/VEfbyO1d1h5meBgpLA6g4lru
	gUUe8A3JMaDK9CN83lr2/f4++dSTrJT4K8Jv24X4l+N0MLu3usYb0HmpSg/Gc9iatkB29jQlHXlWg
	7unZOYivmQ8/CP98G8gExAnVZsO/hYW4Pr3gYH0EXgBtoiljCGAI9i9Fdcyuxjnmz/uuNVCddj/5U
	BYcUnckQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUREZ-00CWpf-4W; Wed, 16 Mar 2022 10:50:27 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUREW-00CWoV-2H
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 10:50:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5923368B05; Wed, 16 Mar 2022 11:50:16 +0100 (CET)
Date: Wed, 16 Mar 2022 11:50:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 kanchan Joshi <joshi.k@samsung.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: Fix zns drives without append support to
 export correct permissions
Message-ID: <20220316105016.GA9393@lst.de>
References: <CGME20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180@eucas1p2.samsung.com>
 <20220316093423.17906-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316093423.17906-1-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_035024_299664_C81F3EE2 
X-CRM114-Status: GOOD (  15.61  )
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

On Wed, Mar 16, 2022 at 10:34:23AM +0100, Pankaj Raghav wrote:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 51c08f206cbf..cde33f2a3a5a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1855,8 +1855,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  	blk_queue_max_write_zeroes_sectors(disk->queue,
>  					   ns->ctrl->max_zeroes_sectors);
>  
> -	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
> -		test_bit(NVME_NS_FORCE_RO, &ns->flags));
> +	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO));

This will now set a namespace that was read-only due to unsupported ZNS
features writable during revalidation.

>   * Fill in the status and result information from the CQE, and then figure out
>   * if blk-mq will need to use IPI magic to complete the request, and if yes do
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 9f81beb4df4e..4ab685fa02b4 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -113,6 +113,7 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>  	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
>  	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
> +	nvme_set_disk_mode_ro(ns);

And this will set a disk that is read-only due to NVME_NS_ATTR_RO
writable if the controller supports all essential ZNS features.

