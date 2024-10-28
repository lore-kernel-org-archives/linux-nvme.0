Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE72D13596
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 11:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2dMhzZ889RDfsy8tcjpKFLN5w9Dkved6xghCCdHoINk=; b=pZtZcZxE1jrNQ3uxXLxwkfgAIb
	vyy3CRLS4Ljt/Elt6HPyKMPnB+P8SlhAIQ9jru5rlEkm3/6MIcnj+4qVMCE5umSV48hCPh7FvN3rH
	2SoKfw6wMyD9Xp5ISQ2jDOFBa1V3zPXqhlIMrjepueJrVm2IXGlc4eLdtK5kSsbeQveiwklaZk1Fa
	8JI/ugJYYSiIFw97AVcaupvAfQlMmQt7hCEKu1lqUsDkb1RySCA1EmVwC38IZWX6r71ESdkO83olm
	23lz3c3gvcXpe6QakaoGYZq2PGsR9yXMJsG9uFmoleoCtfi1NhKdEnBnhshK44ECH5j/eq65vxsVh
	EkzIXXuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5ONx-0000000Adv1-2akV;
	Mon, 28 Oct 2024 11:58:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5ONu-0000000AduZ-3E1S
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 11:58:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E2B2368BFE; Mon, 28 Oct 2024 12:58:05 +0100 (CET)
Date: Mon, 28 Oct 2024 12:58:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hch@lst.de, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv9 3/7] block: allow ability to limit partition write
 hints
Message-ID: <20241028115805.GD8517@lst.de>
References: <20241025213645.3464331-1-kbusch@meta.com> <20241025213645.3464331-4-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025213645.3464331-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_045810_974672_9E1652F1 
X-CRM114-Status: GOOD (  18.99  )
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

On Fri, Oct 25, 2024 at 02:36:41PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> When multiple partitions are used, you may want to enforce different
> subsets of the available write hints for each partition. Provide a
> bitmap attribute of the available write hints, and allow an admin to
> write a different mask to set the partition's allowed write hints.

Trying my best Greg impersonator voice: This needs to be documented
in Documentation/ABI/stable/sysfs-block.

That would have also helped me understanding it.  AFAIK the split here
is an opt-in, which means the use case I explained in the previous
case would still not work out of the box, right?

> +	max_write_hints = bdev_max_write_hints(bdev);
> +	if (max_write_hints) {
> +		int size = BITS_TO_LONGS(max_write_hints) * sizeof(long);
> +
> +		bdev->write_hint_mask = kmalloc(size, GFP_KERNEL);
> +		if (!bdev->write_hint_mask) {
> +			free_percpu(bdev->bd_stats);
> +			iput(inode);
> +			return NULL;
> +		}
> +		memset(bdev->write_hint_mask, 0xff, size);
> +	}

This could simply use bitmap_alloc().  Similarly the other uses
would probably benefit from using the bitmap API.

> +	struct block_device *bdev = dev_to_bdev(dev);
> +	unsigned short max_write_hints = bdev_max_write_hints(bdev);
> +
> +	if (max_write_hints)
> +		return sprintf(buf, "%*pb\n", max_write_hints, bdev->write_hint_mask);
> +	else
> +		return sprintf(buf, "0");

No need for the else.  And if you write this as:

	if (!max_write_hints)
		return sprintf(buf, "0");
	return sprintf(buf, "%*pb\n", max_write_hints, bdev->write_hint_mask);

you'd also avoid the overly long line.

> +
> +static ssize_t part_write_hint_mask_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf, size_t count)
> +{
> +	struct block_device *bdev = dev_to_bdev(dev);
> +	unsigned short max_write_hints = bdev_max_write_hints(bdev);
> +	unsigned long *new_mask;
> +	int size;
> +
> +	if (!max_write_hints)
> +		return count;
> +
> +	size = BITS_TO_LONGS(max_write_hints) * sizeof(long);
> +	new_mask = kzalloc(size, GFP_KERNEL);
> +	if (!new_mask)
> +		return -ENOMEM;
> +
> +	bitmap_parse(buf, count, new_mask, max_write_hints);
> +	bitmap_copy(bdev->write_hint_mask, new_mask, max_write_hints);

What protects access to bdev->write_hint_mask?


