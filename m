Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92262C3DA6F
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Aug 2023 02:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BAs3vHnqB82jyF9T0JKZy08jGuQDnnwXLjj44ySrvFg=; b=TOAJbdMpJmMSZOwFlkvknSDA++
	hgNw60YOROj/56K8LNSMNjLH6AuAM6HM5Ak+LFRZa0YM1uWQnDEkphGHmgj2ICC8hv8+88AHO9wGU
	NsqVsU77uDEko1M2iVxH28BifS/xLZAiRpM7a4YGXr414v/fKuqLOgB1HwSKKs9VFxiF4kjZhw/L0
	CIz71CUYdExEHrvabSBAT9dZ6GjMATqn8UTtnStJNWJ52A2SFK2tVPpJUIfJDQHeiKsE8DUGqbfXj
	gwIQNhABGRqzw4LZa2ayFOeeGdPzwwwbTuObXZVQSCWSO63vsUawR56ahYCnhfJmthXHJWcRvLg1w
	aWMuF1mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZMpB-00495t-1g;
	Fri, 25 Aug 2023 02:45:25 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZMp8-00495F-0A;
	Fri, 25 Aug 2023 02:45:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BAs3vHnqB82jyF9T0JKZy08jGuQDnnwXLjj44ySrvFg=; b=qG/yF0qNQFz1HErcIOwDpMsE95
	yvpWaJiccPJne5E6IKKdLk49il4mSFXaxO10+cPRq4RqC2mgW99o+1yf2c4bs81MOg47gz2QA9ZFT
	aLJydE8tWV8lzCMv2+NeX7mQCMknUB5EhVQiqQN5lBaCEsUTiWdC5wvrGaIvwhXVRrB8AFK90tiyv
	FLjfEbnlTWQpGxkRRGa9YbyGmW5wSGD0SSIG8KNS+lDxJs8er6W0jn8lCxtIFwizoom7apeGKhs9v
	c0WlIDcCZSTbrPU9y3Jy4WWr/hC4ZjXs2RvO1eOF4P2UntF/l1INZ+xsvc1Hck8kt4ukocelH0IdQ
	bSBNV7lw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qZMoj-000edp-26;
	Fri, 25 Aug 2023 02:44:57 +0000
Date: Fri, 25 Aug 2023 03:44:57 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Christian Brauner <brauner@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 01/30] block: also call ->open for incremental partition
 opens
Message-ID: <20230825024457.GD95084@ZenIV>
References: <20230608110258.189493-1-hch@lst.de>
 <20230608110258.189493-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608110258.189493-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230824_194522_093114_D4764975 
X-CRM114-Status: GOOD (  14.04  )
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

On Thu, Jun 08, 2023 at 01:02:29PM +0200, Christoph Hellwig wrote:

> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -683,9 +683,6 @@ static int blkdev_get_part(struct block_device *part, fmode_t mode)
>  	struct gendisk *disk = part->bd_disk;
>  	int ret;
>  
> -	if (atomic_read(&part->bd_openers))
> -		goto done;
> -
>  	ret = blkdev_get_whole(bdev_whole(part), mode);
>  	if (ret)
>  		return ret;
> @@ -694,9 +691,10 @@ static int blkdev_get_part(struct block_device *part, fmode_t mode)
>  	if (!bdev_nr_sectors(part))
>  		goto out_blkdev_put;
>  
> -	disk->open_partitions++;
> -	set_init_blocksize(part);
> -done:
> +	if (!atomic_read(&part->bd_openers)) {
> +		disk->open_partitions++;
> +		set_init_blocksize(part);
> +	}

[with apologies for very late (and tangential) reply]

That got me curious about the ->bd_openers - do we need it atomic?
Most of the users (and all places that do modifications) are
under ->open_mutex; the only exceptions are
	* early sync logics in blkdev_put(); it's explicitly racy -
see the comment there.
	* callers of disk_openers() in loop and nbd (the ones in
zram are under ->open_mutex).  There's driver-private exclusion
around those, but in any case - READ_ONCE() is no worse than
atomic_read() in those cases.

Is there something subtle I'm missing here?

