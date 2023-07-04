Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB20C001DB
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jul 2023 12:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=grp7IOV96yxy6pAh3ZZU8aXr+Lk0kn7LWhW74Y7myAE=; b=Fc8LgdvIJkL1iZifGV9IuKFzi5
	K9Q6lkxCNY1XIagKa3vrw4dOgU1D0ZKFLh9JE/XNaDxLWO6BEFUpvOHs7PwVM/XCPv9SR9cBgFs5a
	Z8LCot4spn2Ck5FuZLBA5qhr9GJQzXlAVF+VD9aAfSKXGH3IlsHjyNy4GC9oQXkCNVo5IAAnFMvhd
	HJKUGHUUKJEuEpIjRBQx/6ZmBvg0dCNz9WFOMi4Ms8byWKir5LMLdMxPJZzjn12Nn6BCDv+2HPGGN
	g3mrPj0vxXwpXKm4W6o3KJRKqIj4PrP71mDQiCND56py5phr44/CxDB7k4Cnp5wF+a4164AajFrG9
	NRGvIGoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qH1G2-00Fo04-1c;
	Wed, 05 Jul 2023 12:05:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGitQ-00Dp56-0d;
	Tue, 04 Jul 2023 16:28:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1A3D9612CF;
	Tue,  4 Jul 2023 16:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8C9C433C7;
	Tue,  4 Jul 2023 16:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688488122;
	bh=ZbfFFniWhSahnp7jSJ3oIaV9POCcbiLvynkhKSgpXe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYhrvsNpwqCJwn41eekT5X8PaPVwBQ6ub8Netmz5zCPt/qzVPnkLxH2Kjiq9nv1Cm
	 yUeZjhUrBrMq2ThgKqf6VqdUdYp1P2/zpT5yvYD7siJiybpmyKwoPpaa5gXpr6CMMv
	 akxinQnPPwXHrxodKNqiTb/6JTMYG4lY9mmxI0dhS9y7wawVJYcWdRHa64BuE/8weJ
	 eX7co1v82fmGWp5kKAm9BaeWX8/tRjFqKX1EDWvGtKd5aZ5LCCXaAY86lmuE5eezEu
	 Ix6OVXIAm9Wp1Cia2H4ClFO9rKC6nhjukt+dwjQnGXu6F26u0+VUNsprhPIs/s+nRo
	 qHwq5/jxHTM8Q==
Date: Tue, 4 Jul 2023 10:28:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Alasdair Kergon <agk@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anna Schumaker <anna@kernel.org>, Chao Yu <chao@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Kleikamp <shaggy@kernel.org>, David Sterba <dsterba@suse.com>,
	dm-devel@redhat.com, drbd-dev@lists.linbit.com,
	Gao Xiang <xiang@kernel.org>, Jack Wang <jinpu.wang@ionos.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	Joern Engel <joern@lazybastard.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-bcache@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
	linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Mike Snitzer <snitzer@kernel.org>, Minchan Kim <minchan@kernel.org>,
	ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Song Liu <song@kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
	target-devel@vger.kernel.org, Ted Tso <tytso@mit.edu>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH 01/32] block: Provide blkdev_get_handle_* functions
Message-ID: <ZKRItBRhm8f5Vba/@kbusch-mbp>
References: <20230629165206.383-1-jack@suse.cz>
 <20230704122224.16257-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704122224.16257-1-jack@suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230704_092844_315538_45D66782 
X-CRM114-Status: GOOD (  16.48  )
X-Mailman-Approved-At: Wed, 05 Jul 2023 05:05:12 -0700
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

On Tue, Jul 04, 2023 at 02:21:28PM +0200, Jan Kara wrote:
> +struct bdev_handle *blkdev_get_handle_by_dev(dev_t dev, blk_mode_t mode,
> +		void *holder, const struct blk_holder_ops *hops)
> +{
> +	struct bdev_handle *handle = kmalloc(sizeof(struct bdev_handle),
> +					     GFP_KERNEL);

I believe 'sizeof(*handle)' is the preferred style.

> +	struct block_device *bdev;
> +
> +	if (!handle)
> +		return ERR_PTR(-ENOMEM);
> +	bdev = blkdev_get_by_dev(dev, mode, holder, hops);
> +	if (IS_ERR(bdev))
> +		return ERR_CAST(bdev);

Need a 'kfree(handle)' before the error return. Or would it be simpler
to get the bdev first so you can check the mode settings against a
read-only bdev prior to the kmalloc?

> +	handle->bdev = bdev;
> +	handle->holder = holder;
> +	return handle;
> +}
> +EXPORT_SYMBOL(blkdev_get_handle_by_dev);
> +
>  /**
>   * blkdev_get_by_path - open a block device by name
>   * @path: path to the block device to open
> @@ -884,6 +902,28 @@ struct block_device *blkdev_get_by_path(const char *path, blk_mode_t mode,
>  }
>  EXPORT_SYMBOL(blkdev_get_by_path);
>  
> +struct bdev_handle *blkdev_get_handle_by_path(const char *path, blk_mode_t mode,
> +		void *holder, const struct blk_holder_ops *hops)
> +{
> +	struct bdev_handle *handle;
> +	dev_t dev;
> +	int error;
> +
> +	error = lookup_bdev(path, &dev);
> +	if (error)
> +		return ERR_PTR(error);
> +
> +	handle = blkdev_get_handle_by_dev(dev, mode, holder, hops);
> +	if (!IS_ERR(handle) && (mode & BLK_OPEN_WRITE) &&
> +	    bdev_read_only(handle->bdev)) {
> +		blkdev_handle_put(handle);
> +		return ERR_PTR(-EACCES);
> +	}
> +
> +	return handle;
> +}
> +EXPORT_SYMBOL(blkdev_get_handle_by_path);

