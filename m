Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9923C43458
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2026 09:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tieW/eVjjWrf11XMiXEH+nomrZbnzJDV4FXYFxX9Hv4=; b=MvWhM9WT+g1iPlJ29DTz4w/s3D
	uiVGZsg3cooSh1p/It5n6OYSv9rOhgnUz0bO1dOU1n7TP2APuJbrwGw7lYvnqR7+226wmhI32SE14
	GY88MYean8SdHDod7u1nLiLEdDZNiRnXpbTeUL77V++UJYMdn2OBLkTtmxAf7TuFd6RgtTQcgke19
	sIs8EuKBTyd48OuS6pnzgc1r9KKVeprsd6WnAQDF868NYcg48vxBmtqKDoHTYpvetiEALoVGilTRY
	5rS3oihdx7J3QwCrFVnePNPQ8dSAvGdsj5aPNGpK4tjmqa9jHeV4r6FwCvR0gCAGNbMYIKK+1gwfh
	itJ1I1Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whOZK-0000000Gkcg-1og0;
	Wed, 08 Jul 2026 09:27:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whOZH-0000000Gkbk-1ILH
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jul 2026 09:27:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 58AF268BFE; Wed,  8 Jul 2026 11:27:41 +0200 (CEST)
Date: Wed, 8 Jul 2026 11:27:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH RFC] nvme: fix NS head cdev lifetime
Message-ID: <20260708092740.GB6513@lst.de>
References: <20260706130146.617258-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706130146.617258-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_022747_494614_16B5DFD0 
X-CRM114-Status: GOOD (  28.69  )
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

On Mon, Jul 06, 2026 at 01:01:46PM +0000, John Garry wrote:
> Sashiko bot reported a potential problem for the NS head cdev lifetime in
> the libmultipath refactoring in [0].
> 
> Currently the NS head .open and .release file_operations methods take a
> reference to the nvme_ns_head to ensure that this structure does not
> disappear while we have files open.
> 
> When we teardown the NS head, we call nvme_cdev_del() -> cdev_device_del()
> -> cdev_del(). However after cdev_del() returns, cdevs already open will
> remain and their fops will still be callable. As such, we can still
> reference the cdev after the nvme_ns_head reference count drops to 0 (and
> is freed).
> 
> This can be shown with an application which delays between opening the cdev
> and issuing the ioctl while the NS head is being torn down:

Can you wire this up to blktests?

> When all fds for the cdev disappear, the cdev removal path puts a
> reference to the parent object, which is the nvme_ns_head.cdev_device - see
> cdev_default_release() -> kobject_put(parent). We can use the lifetime
> of the cdev_device to resolve this lifetime issue.
> 
> Fix the lifetime for the cdev by making adding the cdev add take a
> reference to the NS head and drop that reference in the
> nvme_ns_head.cdev_device release function.
> 
> [0] https://lore.kernel.org/linux-scsi/20260703102918.3723667-1-john.g.garry@oracle.com/T/#m67265e2906d617acd2743c0a00809246d0cfc506
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
> Setting as RFC as I am not sure if this is the best solution.
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 453c1f0b2dd09..c7578b7ed6b76 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3887,7 +3887,7 @@ static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
>  	return 0;
>  }
>  
> -static void nvme_cdev_rel(struct device *dev)
> +void nvme_cdev_rel(struct device *dev)
>  {
>  	ida_free(&nvme_ns_chr_minor_ida, MINOR(dev->devt));
>  }

Can we unify this and the ns_head version by checking of which type
the device is somehow?  I think driver_data would still be free to
optionally point to the ns_head for eexample.
  
> +	if (nvme_tryget_ns_head(head)) {
> +		if (nvme_cdev_add(name, &head->cdev, &head->cdev_device,
> +			&nvme_ns_head_chr_fops, THIS_MODULE,
> +			nvme_cdev_ns_head_rel)) {

Messed up indenttation here as continuations in an conditional/loop
should not be indented the ssame way as the body.

This could be merged a bit anywya:

	if (nvme_tryget_ns_head(head) &&
	    nvme_cdev_add(name, &head->cdev, &head->cdev_device,
			&nvme_ns_head_chr_fops, THIS_MODULE)) {
		dev_err(disk_to_dev(head->disk),
			"Unable to create the %s device\n", name);
		nvme_put_ns_head(head);
		return;
	}

but shouldn't we warn for the nvme_tryget_ns_head failure as well?
Or can that even happen here?


