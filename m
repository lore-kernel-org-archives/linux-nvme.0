Return-Path: <SRS0=L+eZ=7L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB9FC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 14:17:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 551DC208B8
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 14:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dbHASPMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551DC208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6uqHiuZwHmfy5U0LpEXlI1Do6WhX5AWido7IBIvztCs=; b=dbHASPMXezq99V
	iOvCBfoaVkCphUrNycfRoUhmo1g3Y4s5jWVoxQjOXx9f0uuaUrDjNQioCf60wiE1RmoBQDaSQE2aq
	0cAJH5Kp4ecPmOKd8ZvfPM1ayfEMusAINCSb/iUMTrNYVcTqLnBpEV+Wb4aDwrB5tkUAFdP0SGDmA
	0ONbwGQXge/C4JFGG87/udh5oy5oFAWTbiKvL/Mp7DdWF+BI+3EYQPX3elKNa8AicSl1OnlXEDduK
	zoQBsmXnG9DxYzHKPcjLeTlIZ+2t4sGv9Ghmd0sMxpxOTlZTbBkhXQ9Uow1vD7m/Spe7K6YjApjFz
	RoT95PERkpg7Btmyvsrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jefp7-00089A-TT; Fri, 29 May 2020 14:17:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jefnm-0007o4-Ng
 for linux-nvme@lists.infradead.org; Fri, 29 May 2020 14:16:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0963868B02; Fri, 29 May 2020 16:15:56 +0200 (CEST)
Date: Fri, 29 May 2020 16:15:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kaitao Cheng <pilgrimtao@gmail.com>
Subject: Re: [PATCH v2] blkdev: Replace blksize_bits() with ilog2()
Message-ID: <20200529141555.GA3249@lst.de>
References: <20200529141100.37519-1-pilgrimtao@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200529141100.37519-1-pilgrimtao@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200529_071603_065055_FE1C2EED 
X-CRM114-Status: GOOD (  11.83  )
X-Mailman-Approved-At: Fri, 29 May 2020 07:17:11 -0700
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com,
 linux-nvme@lists.infradead.org, dhowells@redhat.com, clm@fb.com,
 deepa.kernel@gmail.com, houtao1@huawei.com, hch@lst.de,
 linux-s390@vger.kernel.org, bvanassche@acm.org, darrick.wong@oracle.com,
 mark@fasheh.com, satyat@google.com, hch@infradead.org, borntraeger@de.ibm.com,
 gor@linux.ibm.com, ajay.joshi@wdc.com, chaitanya.kulkarni@wdc.com,
 chao@kernel.org, josef@toxicpanda.com, ming.lei@redhat.com,
 viro@zeniv.linux.org.uk, songmuchun@bytedance.com, dsterba@suse.com,
 jaegeuk@kernel.org, jlbec@evilplan.org, sagi@grimberg.me, axboe@kernel.dk,
 balbi@kernel.org, damien.lemoal@wdc.com, martin.petersen@oracle.com,
 joseph.qi@linux.alibaba.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 asml.silence@gmail.com, linux-btrfs@vger.kernel.org, sth@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>  	ns->size = i_size_read(ns->bdev->bd_inode);
> -	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
> +	ns->blksize_shift = ilog2(bdev_logical_block_size(ns->bdev));

This should just be:

	ns->blksize_shift = ns->bdev->bd_inode->i_blkbits;

> diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
> index 777734d1b4e5..55adb134451b 100644
> --- a/drivers/s390/block/dasd_ioctl.c
> +++ b/drivers/s390/block/dasd_ioctl.c
> @@ -228,7 +228,7 @@ dasd_format(struct dasd_block *block, struct format_data_t *fdata)
>  	 */
>  	if (fdata->start_unit == 0) {
>  		struct block_device *bdev = bdget_disk(block->gdp, 0);
> -		bdev->bd_inode->i_blkbits = blksize_bits(fdata->blksize);
> +		bdev->bd_inode->i_blkbits = ilog2(fdata->blksize);

This also needs to set bdev->bd_block_size, so this probably warrants
a separate fix that be backported.  It might be nice to split out
a helper that sets bd_block_size and bd_inode->i_blkbits together
so that such a use is more obvious.

>  	} else if (inode->i_bdev) {
>  		blksize = bdev_logical_block_size(inode->i_bdev);
> -		blkbits = blksize_bits(blksize);
> +		blkbits = ilog2(blksize);

This can just use inode->i_bdev->bd_inode->i_blkbits.

> diff --git a/fs/buffer.c b/fs/buffer.c
> index fc8831c392d7..fa92e0afe349 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -907,7 +907,7 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
>  	loff_t sz = i_size_read(bdev->bd_inode);
>  
>  	if (sz) {
> -		unsigned int sizebits = blksize_bits(size);
> +		unsigned int sizebits = ilog2(size);

bdev->bd_inode->i_blkbits.

> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 1543b5af400e..7ea2cd3effcc 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -1148,7 +1148,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  
>  	if (align & blocksize_mask) {
>  		if (bdev)
> -			blkbits = blksize_bits(bdev_logical_block_size(bdev));
> +			blkbits = ilog2(bdev_logical_block_size(bdev));

bdev->bd_inode->i_blkbits.

> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index cb05f71cf850..b896da27942a 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3458,7 +3458,7 @@ static int check_direct_IO(struct inode *inode, struct iov_iter *iter,
>  
>  	if (align & blocksize_mask) {
>  		if (bdev)
> -			blkbits = blksize_bits(bdev_logical_block_size(bdev));
> +			blkbits = ilog2(bdev_logical_block_size(bdev));

bdev->bd_inode->i_blkbits.

>  		blocksize_mask = (1 << blkbits) - 1;
>  		if (align & blocksize_mask)
>  			return -EINVAL;
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index ec7b78e6feca..2a807657d544 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -203,7 +203,7 @@ static loff_t
>  iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		struct iomap_dio *dio, struct iomap *iomap)
>  {
> -	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
> +	unsigned int blkbits = ilog2(bdev_logical_block_size(iomap->bdev));

iomap->bdev->bd_inode->i_blkbits.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
