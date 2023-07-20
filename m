Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7B7C04A6A
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jul 2023 07:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XmUAzaGCzoWbWvtXNBg4FVEPOLhmW8pW6NX9HZAN6II=; b=PorscI0sFrnT9vkbY6C7mv7KRR
	sziL1ASstht/YKIp8Jp2pFL/HsqKJAwr38gnDZBwVldFtxJqrsIC6ZoRjY5sUAifcOOghkoT0Hgio
	fv84xL/7m971c2eH0EmbLWrlJiCDFRmtjGLFlkk3fmSBkk3QvjnZxO1igKsEg4+nPdA1y+EQ2t+Vr
	BPab2952T+lWFe6veRTeytweQsANTsPm3zMMX4V7Ba9atq/Qr1MkKLiZqcSoNvgqOwMlGDPYceVLe
	pDXWeMh89nmh1qOZeN2Lv83riiEkow0yrv/YAjojbB7m9y3CykpNZaJG01nuIYkb5ZkNf3JT0KEHR
	7L93GC3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMOXF-00ACEl-2G;
	Thu, 20 Jul 2023 07:57:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMOXD-00ACDp-01
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jul 2023 07:57:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 156026732D; Thu, 20 Jul 2023 09:57:11 +0200 (CEST)
Date: Thu, 20 Jul 2023 09:57:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, willy@infradead.org, hare@suse.de,
	djwong@kernel.org, bvanassche@acm.org, ming.lei@redhat.com,
	dlemoal@kernel.org, nitheshshetty@gmail.com, gost.dev@samsung.com,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 4/9] fs, block: copy_file_range for def_blk_ops for
 direct block device
Message-ID: <20230720075710.GC5042@lst.de>
References: <20230627183629.26571-1-nj.shetty@samsung.com> <CGME20230627184029epcas5p49a29676fa6dff5f24ddfa5c64e525a51@epcas5p4.samsung.com> <20230627183629.26571-5-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627183629.26571-5-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230720_005715_184543_4745C748 
X-CRM114-Status: GOOD (  22.83  )
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

> +/* Copy source offset from source block device to destination block
> + * device. Returns the length of bytes copied.
> + */
> +ssize_t blkdev_copy_offload_failfast(
> +		struct block_device *bdev_in, loff_t pos_in,
> +		struct block_device *bdev_out, loff_t pos_out,
> +		size_t len, gfp_t gfp_mask)

This is an odd and very misnamed interface.

Either we have a klkdev_copy() interface that automatically falls back
to a fallback (maybe with an opt-out), or we have separate
blkdev_copy_offload/blkdev_copy_emulated interface and let the caller
decide.  But none of that really is "failfast".

Also this needs to go into the helpers patch and not a patch that is
supposed to just wire copying up for block device node.

> index b07de77ef126..d27148a2543f 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1447,7 +1447,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>  		return -EOVERFLOW;
>  
>  	/* Shorten the copy to EOF */
> -	size_in = i_size_read(inode_in);
> +	size_in = i_size_read(file_in->f_mapping->host);

generic_copy_file_checks needs to be fixed to use ->mapping->host both
or inode_in and inode_out at the top of the file instead of this
band aid.  And that needs to be a separate patch with a Fixes tag.

> @@ -1708,7 +1709,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
>  	/* Don't copy dirs, pipes, sockets... */
>  	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
>  		return -EISDIR;
> -	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
> +
> +	if ((!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode)) &&
> +		(!S_ISBLK(inode_in->i_mode) || !S_ISBLK(inode_out->i_mode)))

This is using weird indentation, and might also not be doing
exactly what we want.  I think the better thing to do here is to:

 1) check for the accetable types only on the in inode
 2) have a check that the mode matches for the in and out inodes

And please do this as a separate prep patch instead of hiding it here.


