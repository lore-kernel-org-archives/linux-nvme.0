Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F44D111A8
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 06:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GczI0dbZTGyiSi2ukNegLcP9BkPJwQdF6rKPEiHJ2ww=; b=zFGqK7Zn6lKLp4zGn4I9IAhAeJ
	EHZOubusHNwRyQ1qx1t+nnOGajn6w/OLokW+2ftvaZT9xXcfhqX8aw3ZY11bP1YP+FLoguIFpaYYC
	8hxIqjdGtHhVhAmUTJe0BnBchK0Q8fasTptZe0G3hydDeQM2PlQ056FS28GM2D8UD9mnlIwaUq70A
	WKFnDaNk4mfPSXGYC28/iRxVFH0jgp9A3GAQnaugabTbpQ54V78hVBlkci5R3YTdL5P7v9lZE12/z
	SAbHzqK528bogGsTfDRh0ei9lUWZMSIZUJpJumJ0uWvQy0vhtouLqpMFOBUz4V7PQUhQPpDwa2i8e
	oG1LSvYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPxaA-000000030FX-2FZS;
	Mon, 01 Dec 2025 06:40:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPxa8-000000030EQ-2C4Y
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 06:40:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 671FC68BEB; Mon,  1 Dec 2025 07:40:16 +0100 (CET)
Date: Mon, 1 Dec 2025 07:40:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Christoph Hellwig <hch@lst.de>,
	Mike Christie <michael.christie@oracle.com>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 3/4] block: add IOC_PR_READ_KEYS ioctl
Message-ID: <20251201064016.GC19461@lst.de>
References: <20251127155424.617569-1-stefanha@redhat.com> <20251127155424.617569-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127155424.617569-4-stefanha@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_224020_703303_8DD2DD18 
X-CRM114-Status: GOOD (  16.84  )
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

On Thu, Nov 27, 2025 at 10:54:23AM -0500, Stefan Hajnoczi wrote:
> +static int blkdev_pr_read_keys(struct block_device *bdev, blk_mode_t mode,
> +		struct pr_read_keys __user *arg)
> +{
> +	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
> +	struct pr_keys *keys_info __free(kfree) = NULL;

Please avoid the use of the __free mess and write readable and maintainable
code instead.

> +	struct pr_read_keys inout;

Inout is not a very good variable name, as it doesn't really have much
of meaning.  

> +	if (copy_from_user(&inout, arg, sizeof(inout)))
> +		return -EFAULT;
> +
> +	/*
> +	 * 64-bit hosts could handle more keys than 32-bit hosts, but this
> +	 * limit is more than enough in practice.
> +	 */
> +	if (inout.num_keys > (U32_MAX - sizeof(*keys_info)) /
> +	                     sizeof(keys_info->keys[0]))
> +		return -EINVAL;
> +
> +	keys_info_len = struct_size(keys_info, keys, inout.num_keys);

Do the size check on the calculate len here?

> +		return ret;
> +
> +	/* Copy out individual keys */
> +	keys_ptr = u64_to_user_ptr(inout.keys_ptr);
> +	num_copy_keys = min(inout.num_keys, keys_info->num_keys);
> +	keys_copy_len = num_copy_keys * sizeof(keys_info->keys[0]);

num_copy_keys is only used once, so maybe drop it?


