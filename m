Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FAFC27C65
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 06:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v3xJUcHel03Bt7wBOjl3KhXV1KJXbiZ77LFylmkGds0=; b=uabKYL0JlGKmj5UEmv62VEDUN2
	tZjl1s9Dg59x30dDKy4JtimDw+8ltEr1yltuSuSny9BWotd99A+0iz6JiNjZ8uPi9iyeClknIrEKy
	qYITvY6qWliOhELtIYNZ5yNGA1LS1vQoAPLXVvrFYKkktggbGT/SQlElfnJcjYc8CvvFlOO8Waxqo
	IwmUyFBcnszZDpGBWEvWxgK0U+U4eiIbuSDv8CNV5l7Y04A68ewEeMe14dYK+gStoim/LBTIorebW
	dkFbeVtoEjCzV6DfFPrzBrAmp9DEygnAxs6/IACY0Xp8LCbjYYApW3IDZsnmtzvXwA6sF19ZvTYLq
	WzYv4R5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuqu-00000007eL7-1hXy;
	Tue, 11 Jun 2024 06:19:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuRj-00000007aN8-0DJd;
	Tue, 11 Jun 2024 05:53:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5366D60C88;
	Tue, 11 Jun 2024 05:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFA5C2BD10;
	Tue, 11 Jun 2024 05:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718085206;
	bh=RvinM2CEhnrYy7/V+Hc/2gNsHgLPMfOqlJof5s6pLpY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=acWTCLh69lElyFzhBDitf/FJSPcZHoSKSYkPin9SpKmAkY2E8tt2RX9YMgvNW08VJ
	 pXyQOUrKXLHipujeCeYwwOOV1ng3liGMUrh79LCxXQAnCnsegn/0fa+OxA8G7Re61L
	 fmOHhV3QGFVIYl1a9Zvr8YBZq5o5MC+kVjqKkUi4kq/pw8SNm9WHEEcZBI2M9gnJTB
	 rNM+9TLvbzpYIaLgbWYUi2Bsf66NXsvZZfHsd+k+aOkAbuju2GyIYlvuYfiZ5s0zaB
	 Ghir0etXCncHmfvSSJDhrNjKYgtJ1ghf+Dq41ngHLndOPehGRZnzQ4OTjdqTetZ0XF
	 qcw8t2IN/8aPA==
Message-ID: <ca5a3441-768a-4331-a1c2-a4bdadf2f150@kernel.org>
Date: Tue, 11 Jun 2024 14:53:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/26] loop: stop using loop_reconfigure_limits in
 __loop_clr_fd
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Richard Weinberger <richard@nod.at>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
 Yu Kuai <yukuai3@huawei.com>, Vineeth Vijayan <vneethv@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
 drbd-dev@lists.linbit.com, nbd@other.debian.org,
 linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20240611051929.513387-1-hch@lst.de>
 <20240611051929.513387-4-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240611051929.513387-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_225327_646142_C6F81F4B 
X-CRM114-Status: GOOD (  17.87  )
X-Mailman-Approved-At: Mon, 10 Jun 2024 23:19:24 -0700
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

On 6/11/24 2:19 PM, Christoph Hellwig wrote:
> __loop_clr_fd wants to clear all settings on the device.  Prepare for
> moving more settings into the block limits by open coding
> loop_reconfigure_limits.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/loop.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 93780f41646b75..93a49c40a31a71 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1133,6 +1133,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>  
>  static void __loop_clr_fd(struct loop_device *lo, bool release)
>  {
> +	struct queue_limits lim;
>  	struct file *filp;
>  	gfp_t gfp = lo->old_gfp_mask;
>  
> @@ -1156,7 +1157,14 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
>  	lo->lo_offset = 0;
>  	lo->lo_sizelimit = 0;
>  	memset(lo->lo_file_name, 0, LO_NAME_SIZE);
> -	loop_reconfigure_limits(lo, 512, false);
> +
> +	/* reset the block size to the default */
> +	lim = queue_limits_start_update(lo->lo_queue);
> +	lim.logical_block_size = 512;

Nit: SECTOR_SIZE ? maybe ?

> +	lim.physical_block_size = 512;
> +	lim.io_min = 512;
> +	queue_limits_commit_update(lo->lo_queue, &lim);
> +
>  	invalidate_disk(lo->lo_disk);
>  	loop_sysfs_exit(lo);
>  	/* let user-space know about this change */

Otherwise, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


