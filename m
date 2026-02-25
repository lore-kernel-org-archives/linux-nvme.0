Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35F0FD3762
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 15:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kPX6WZugCFxIebjTgQTrjGzVepBT4p6bzbLT37IB4lg=; b=q2XB9VMWlguAXhqjL1AOFnmxRt
	83f+NKGCFsPZgIPWVRD+HyjreZeCDvk/DME2wwJNQwa3DvhsxHZc1KIDxV7GLVvE0/XZe5jGBBECF
	i2rSb9RdHKA/OwkkH43oIqEPvcpm6+Ob71oh1cF8qGUJm7K+Y73M4nZnEHyPCAo8DMTjlQlzgcSEt
	8GhpuDiy1CFvmxikonaprFVzrCuBCdYA6UEes7zbDIgLw5isY9bgS3t1XjWGk3rGyG3tgJ7mktsL9
	nC38uzeLwXwVh4c9kkxFUv1p/c4JORpIVl1FKJvn/n/rB/X97YeY6TGHoC34M/33lOoDDFUnOgZ38
	hmrYOcbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvH8K-00000004Pb0-3hO7;
	Wed, 25 Feb 2026 15:49:04 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvH8K-00000004Pad-0laF
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 15:49:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7F77760126;
	Wed, 25 Feb 2026 15:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F75C116D0;
	Wed, 25 Feb 2026 15:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772034543;
	bh=RaSrwPLR4Sem1Lt2v4ifHKpxppPfAz8NYD3EMNdTsSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pkUse5PxFcwbf+SRzZXiiIq59f4ai8efE59MRMV9mr0GHErIxXLI5+rMW8kVndVVj
	 8noe+BA0fs2ZXHP+5ZcU51l+/cRv1dw89FsVEt/v65bIcGtk/AMBpGjxSZpHYRg7uu
	 RWzoUg+kT0p9OPduwqpbY6u7QdautQJELpuQBoNLlQOLtdOAJ2Uc9c7NaTAGI2wEV1
	 Y7JkznoRxdkXMxy/V7BdsN2cbEI32FjlF8MjckA2cVKkW9MViDCSvTJ0OCyUqQPHUK
	 uWQsCnSxtuyGW1n6Kr+bUTwbqOPXHzqC2RGidm38wlJ639QPbgpAZ+K4j0bSSACY71
	 q6YPD4Fy5XpYw==
Date: Wed, 25 Feb 2026 08:49:00 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@fb.com, martin.petersen@oracle.com,
	james.bottomley@hansenpartnership.com, hare@suse.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, michael.christie@oracle.com,
	snitzer@kernel.org, bmarzins@redhat.com, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] libmultipath: Add PR support
Message-ID: <aZ8Z7A4uOFfOTDeY@kbusch-mbp>
References: <20260225153225.1031169-1-john.g.garry@oracle.com>
 <20260225153225.1031169-10-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225153225.1031169-10-john.g.garry@oracle.com>
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

On Wed, Feb 25, 2026 at 03:32:21PM +0000, John Garry wrote:
> +static int mpath_pr_register(struct block_device *bdev, u64 old_key,
> +			u64 new_key, unsigned int flags)
> +{
> +	struct mpath_disk *mpath_disk = dev_get_drvdata(&bdev->bd_device);
> +	struct mpath_head *mpath_head = mpath_disk->mpath_head;
> +	struct mpath_device *mpath_device;
> +	int srcu_idx, ret = -EWOULDBLOCK;
> +
> +	srcu_idx = srcu_read_lock(&mpath_head->srcu);
> +	mpath_device = mpath_find_path(mpath_head);
> +	if (mpath_device)
> +		ret = mpath_head->mpdt->pr_ops->pr_register(mpath_device,
> +				old_key, new_key, flags);
> +	srcu_read_unlock(&mpath_head->srcu, srcu_idx);

Instead of having the lower layer define new mp template functions, why
not use the existing pr_ops from mpath_device->disk->fops->pr_ops?

