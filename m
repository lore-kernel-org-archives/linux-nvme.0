Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D85EC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 14:22:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 082C123A33
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 14:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082C123A33
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rKlOG9cRMKNmH4NuBRs0tbSBBhC4hZ1gMjqMOOCEuZg=; b=m4Mg069hKMh/DwxfjPtNfMeHO
	CuufWeUHhHWHQuzrjebjlVy0SLuZFtbeqydT69DO0lOwyIoRhDuzLgxt+uoblckRZ0sOIvbT6NavB
	/MLAyLDEpO6O6Epf8HW+GQVrYKp8Fw+WoXAQarJA9S6QpWYp7oF+SIYF54sUqMmHzhPyrFTHKfkZg
	cf8Cr/cvsTo5nHO7xIO4R8ZYB/rX4Hu45DvNyuDUAqclJbvgeeKmfWfkCRe2HLXAk08Lt9xg3u2oh
	ao2ESg13YC6fZ8c/EwSZvsmVEjRSqTg/Kl/fa6/0q6KcjNf5KW4kg5V0GXsrWvA038t36WkMXf2VA
	FKkrjd0Ew==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmdsM-0006Qp-0d; Tue, 08 Dec 2020 14:21:58 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmdsJ-0006Pk-Gv
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 14:21:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 482E16736F; Tue,  8 Dec 2020 15:21:51 +0100 (CET)
Date: Tue, 8 Dec 2020 15:21:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: javier@javigon.com
Subject: Re: [PATCH V2] nvme: enable char device per namespace
Message-ID: <20201208142151.GA4108@lst.de>
References: <20201208132934.625-1-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201208132934.625-1-javier.gonz@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_092155_817334_E69563B1 
X-CRM114-Status: GOOD (  23.85  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, minwoo.im.dev@gmail.com, kbusch@kernel.org,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A bunch of nitpicks (mostly naming as usual, sorry..):

> +static int __nvme_ns_ioctl(struct gendisk *disk, unsigned int cmd,
> +			   unsigned long arg)
>  {

What about nvme_disk_ioctl instead as that is what it operates on?

> +static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
> +		      unsigned int cmd, unsigned long arg)
> +{
> +	return __nvme_ns_ioctl(bdev->bd_disk, cmd, arg);
> +}
> +
> +static long nvme_cdev_ioctl(struct file *file, unsigned int cmd,
> +			    unsigned long arg)
> +{
> +	return __nvme_ns_ioctl((struct gendisk *)file->private_data, cmd, arg);
> +}

No need for the cast.

Also can we keep all the char device methods together close to the
struct file_operations declaration?  I just prefer to keep the code
a little grouped.

> -static int nvme_open(struct block_device *bdev, fmode_t mode)
> +static int __nvme_open(struct nvme_ns *ns)
>  {
> -	struct nvme_ns *ns = bdev->bd_disk->private_data;
> -
>  #ifdef CONFIG_NVME_MULTIPATH
>  	/* should never be called due to GENHD_FL_HIDDEN */
>  	if (WARN_ON_ONCE(ns->head->disk))
> @@ -1846,12 +1859,24 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
>  	return -ENXIO;
>  }
>  
> +static void __nvme_release(struct nvme_ns *ns)
> +{
> +	module_put(ns->ctrl->ops->module);
> +	nvme_put_ns(ns);
> +}

nvme_ns_open and nvme_ns_release?

> +
> +static int nvme_open(struct block_device *bdev, fmode_t mode)
> +{
> +	struct nvme_ns *ns = bdev->bd_disk->private_data;
> +
> +	return __nvme_open(ns);
> +}
> +
>  static void nvme_release(struct gendisk *disk, fmode_t mode)
>  {
>  	struct nvme_ns *ns = disk->private_data;
>  
> -	module_put(ns->ctrl->ops->module);
> -	nvme_put_ns(ns);
> +	__nvme_release(ns);

No need for the local ns variable in both cases.

> +static int nvme_cdev_open(struct inode *inode, struct file *file)
> +{
> +	struct nvme_ns *ns = container_of(inode->i_cdev, struct nvme_ns, cdev);
> +	int ret;
> +
> +	ret = __nvme_open(ns);
> +	if (!ret)
> +		file->private_data = ns->disk;
> +
> +	return ret;

Do we need the ->private_data assignment at all?  I think the ioctl
handler could just grab it directly from i_cdev.

> +	sprintf(cdisk_name, "nvme%dn%dc", ctrl->instance, ns->head->instance);

And the most important naming decision is this.  I have two issues with
naming still:

 - we aready use the c for controller in the hidden disk naming.  Although
   that is in a different position, but I think this not super intuitive.
 - this is missing multipath support entirely, so once we want to add
   multipath support we'll run into issues.  So maybe use something
   based off the hidden node naming?  E.g.:

	sprintf(disk_name, "nvme-generic-%dc%dn%d", ctrl->subsys->instance,
		ctrl->instance, ns->head->instance);

> +	/* When the device does not support any of the features required by the
> +	 * kernel (or viceversa), hide the block device. We can still rely on
> +	 * the namespace char device for submitting IOCTLs
> +	 */

Normal kernel comment style is the opening

	/*

on its own line.

>  	if (nvme_update_ns_info(ns, id))
> -		goto out_put_disk;
> +		disk->flags |= GENHD_FL_HIDDEN;

I don't think we can do this based on all the error returns.  I think
we'll have to move the flags manipulation into nvme_update_ns_info to
also cover the revalidate case.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
