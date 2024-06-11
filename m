Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5C9C25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 06:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z1LDZmkEBHIp9iU38AWfhv7rG8QZhHJzSp95Duz4M8g=; b=u95TItlZs0juQNwoHmZRbazY1N
	cnkI7zYfyofMUhhWrSGUKp+msu4BwKlWt9WC4flvTkEo4JT+TQzLOPTKvbTbMwdvnM1yT7TYUuvaw
	0j9C4DLnIRBPg/96QuIbF1inoB8sxsB1C1YGiQ8kGM0AEBqvSvbksAGzDNPX8EeQF3aIhFzzpOyOQ
	tEboP5wRtYy3mA9pS/5uy6CMB0woK879uLv+UL6RgvWoGBv5fYrfKtom+jQG9j8WilPiYkcuiFolc
	WPO9/gJInljbb10M6P6l33q53F+GcOmzNaAuxaKbD8ISuuHcVn7VGVZMg2mwpQHJdErCfJdMUtBqG
	O9Yh7t9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGur3-00000007eQA-3rUz;
	Tue, 11 Jun 2024 06:19:38 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuXC-00000007bcW-1Qcp;
	Tue, 11 Jun 2024 05:59:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 591E8CE19AB;
	Tue, 11 Jun 2024 05:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39B0C2BD10;
	Tue, 11 Jun 2024 05:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718085543;
	bh=ytNiiCLVFE28gHr4h5G30TNqYehF/KogG4pSKSbNQ2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=juelLKuku0LFbgtXG9OzRzRWb3ooPaRYkdEGYbxCY/l/EREHcpsd6y+kWaUp4iBKj
	 Cs53RLnIaSbrZccm/GN9QVCVAOcAI/+By8TM/0/LFmq4RPTUmj+axscKmxzzB5coCx
	 TPpMXPmrdbBJt790n7mZ2SG7cnazZrwM4LN+e2wDErlp27GY0Q5cW5+prp1xuTs+nr
	 t3wCoIWjpcxWO+rGzFp9IqhsxvwTy7jx2vG3FMgsOx4qNL4tLOJuL4SBWR9Le8e1Gu
	 FbIAW9jk7NKo8gZzoXSm3zjx5aS60f2RIO1ZIKWZDZVw79ebRnV6Cm+DP9ptNCmDsn
	 briDJeVws9DJA==
Message-ID: <27e76310-1831-473e-803a-e0294b91463c@kernel.org>
Date: Tue, 11 Jun 2024 14:58:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/26] loop: also use the default block size from an
 underlying block device
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
 <20240611051929.513387-7-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240611051929.513387-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_225906_773237_761404AA 
X-CRM114-Status: GOOD (  18.91  )
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
> Fix the code in loop_reconfigure_limits to pick a default block size for
> O_DIRECT file descriptors to also work when the loop device sits on top
> of a block device and not just on a regular file on a block device based
> file system.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/loop.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 4f6d8514d19bd6..d7cf6bbbfb1b86 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -988,10 +988,16 @@ static int loop_reconfigure_limits(struct loop_device *lo, unsigned short bsize)
>  {
>  	struct file *file = lo->lo_backing_file;
>  	struct inode *inode = file->f_mapping->host;
> +	struct block_device *backing_bdev = NULL;
>  	struct queue_limits lim;
>  
> +	if (S_ISBLK(inode->i_mode))
> +		backing_bdev = I_BDEV(inode);
> +	else if (inode->i_sb->s_bdev)
> +		backing_bdev = inode->i_sb->s_bdev;
> +

Why not move this hunk inside the below "if" ? (backing_dev declaration can go
there too).

>  	if (!bsize)
> -		bsize = loop_default_blocksize(lo, inode->i_sb->s_bdev);
> +		bsize = loop_default_blocksize(lo, backing_bdev);
>  
>  	lim = queue_limits_start_update(lo->lo_queue);
>  	lim.logical_block_size = bsize;

-- 
Damien Le Moal
Western Digital Research


