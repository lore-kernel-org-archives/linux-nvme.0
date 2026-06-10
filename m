Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE148CD8CAD
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 00:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4OZsjnwFhyfsENooiiYgR1pxdxc+gWvdKCR6mawy1Zo=; b=yyA+0KzA0RvxGTfEx6x85Sy1ih
	FNlwfz31/6WSrDYO02gUPOO6FEv21javDkddk7bDMu0/xM2RsfudRgJZ2ttXTTk0AghnN01659FeL
	FmFsauV1rN024RMWcRUlHtUZXZA4ftCR2TID7BmHyZj8d0iQqskMNZQv5WA979RaywpvdDqbpbZLm
	09M5TVcYWTgbJaanJOmy4B7Zmoknxh0gcHkpDr1XfJDK2BZ2iCSR2FIu20KuEmx9ldd4dmIEhGVRb
	rbhe3rD3KPlZuj+BqHQxr9dTHShOxIOKybP0PWtme/MOTIH0GwIe+y7wqXvYmsYjmTEEToLWVnBwF
	mHYYCS5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX6OB-00000006XPs-4B6C;
	Wed, 10 Jun 2026 00:01:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX6O4-00000006XPg-1Mn2
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 00:01:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A13F542A12;
	Wed, 10 Jun 2026 00:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EA71F00893;
	Wed, 10 Jun 2026 00:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781049699;
	bh=4OZsjnwFhyfsENooiiYgR1pxdxc+gWvdKCR6mawy1Zo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mlLDHlY/rC5559/T6gueObV/LbVBhqKfnFT0QO1ZC98AIJNkN3Xg7NNxtXTqf0xhU
	 PAgGu1w317oLh6k6kESkfGV96rzikz2IEY9G8X6Os6Q5cHgrWGY6yjGljJPhEOFw4u
	 Kd1CcoCN+5VQCa6JCV1xJbPhZwxXo048Eg90pzOyxeTVUB3TmRI6ZVRnrWWth1v7/X
	 DAN6pS328qhTyi/rvgU8N2jy4ckqLdfWVBaIO7PzwuXs8E57u5SFv/YnQcZq2iOc5H
	 r6YKrkZzuyuhPCbVIKfuocn3dyKm2YtNZ+NPDwJDwMzgZjbAoOmNPqByV/QmD2pnVp
	 UZT57g6Xk+GEw==
Message-ID: <8214e0b3-c9b7-4881-8357-5f84e2f8b1cb@kernel.org>
Date: Wed, 10 Jun 2026 08:01:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: revalidate zones for namespace heads
To: Yao Sang <sangyao@kylinos.cn>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
References: <20260609063102.2689195-1-sangyao@kylinos.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260609063102.2689195-1-sangyao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2026/06/09 14:31, Yao Sang wrote:
> Zoned multipath namespace heads get BLK_FEAT_ZONED and their limits are
> refreshed from the paths, but the zone state for the head disk is never
> initialized.  The previous nr_zones assignment only updated a single
> field and did not allocate or populate the block layer's per-zone state.
> 
> That leaves the head disk without valid zone condition information.  Code
> using the head device, such as bdev_zone_is_seq(), can then treat a
> sequential zone as non-sequential and submit regular writes to it.
> 
> Add a small helper to run blk_revalidate_disk_zones() for a live zoned
> namespace head after the path limits have been committed and when a path
> becomes live.  Return the error to the namespace update path, and keep the
> live path transition as a warning-only update.  Drop the nr_zones copy, as
> blk_revalidate_disk_zones() updates it together with the rest of the zoned
> disk state.
> 
> Signed-off-by: Yao Sang <sangyao@kylinos.cn>
> ---
> The failure was found with xfstests xfs/643 and xfs/646 on an NVMe
> ZNS multipath namespace. Tracing showed regular REQ_OP_WRITE I/O being
> submitted to sequential zones through the multipath head.
> 
> The head queue had the zoned limits stacked from the path, but the head
> gendisk had not gone through blk_revalidate_disk_zones(). That left the
> block layer per-zone state missing on the head disk, so users of the head
> device could treat sequential zones as non-sequential.

Mentioning the test case that triggered the issue is good, so it would be nice
to include this text in the commit message.

> +#ifdef CONFIG_BLK_DEV_ZONED
> +int nvme_mpath_revalidate_zones(struct nvme_ns_head *head)
> +{
> +	struct gendisk *disk = head->disk;
> +	int ret;
> +
> +	if (!disk || !blk_queue_is_zoned(disk->queue) ||
> +	    !test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
> +		return 0;
> +
> +	ret = blk_revalidate_disk_zones(disk);
> +	if (ret)
> +		dev_warn_ratelimited(disk_to_dev(disk),
> +				     "failed to revalidate zoned namespace head: %d\n",
> +				     ret);
> +	return ret;
> +}
> +#endif /* CONFIG_BLK_DEV_ZONED */

Maybe define this helper in nvme/host/zns.c ? But either way, this depends on
both CONFIG_BLK_DEV_ZONED and CONFIG_NVME_MULTIPATH, so this is also fine as is.

So regardless, with the commit message updated,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

