Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBDFC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 16:45:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D14964F04
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 16:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D14964F04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MrGqlAOReXndaWyqd8uROl2IDuq9I8VKiw2FZDQW9gM=; b=n30tM/TmH6VCPAJwZMrxA8RZs
	IGjPdPfBEK0OLSPPmwXbWso902Y/OyWMUGal0jCkpSinGBzR+hYBmSgW4Spi1cpwnEw3Vtv9WyM9s
	DBzY7U13K/vJlZAsrFLdoKnCmTonC7FoQBeC+bb7ZfoS3aL8GtbpEDT1m6vjkN59ww6EH3/rpmD5G
	kbpk5v88+JGW8XCvzPkL1W7rHlur2Q1u2ZFBj9wlDbnK1NsRmreHOh85xiDP9DwtBQ6qoAhlKSNps
	qfpA7Y+X9iM9170nls6gH+kENOE4t5PHtIUTuA4Rw+KTvDu1ses2dVqqiM5nctC+HE94qjyNFRrWm
	UwP3y2uFQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lExHO-0005in-BJ; Wed, 24 Feb 2021 16:44:50 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lExHK-0005i3-Kh
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 16:44:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AF31A67357; Wed, 24 Feb 2021 17:44:43 +0100 (CET)
Date: Wed, 24 Feb 2021 17:44:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: javier@javigon.com
Subject: Re: [PATCH V5 1/2] nvme: enable char device per namespace
Message-ID: <20210224164443.GA11338@lst.de>
References: <20210222190107.8479-1-javier.gonz@samsung.com>
 <20210222190107.8479-2-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210222190107.8479-2-javier.gonz@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_114446_792737_991CD8FE 
X-CRM114-Status: GOOD (  15.84  )
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

> +static inline bool nvme_dev_is_generic(struct device *dev)
> +{
> +	return dev->class == nvme_ns_class;
> +}
> +
> +static inline bool nvme_ns_is_generic(struct nvme_ns *ns)
> +{
> +	return !!ns->minor;
> +}

What does is_generic mean here?  In doubt add a few comments..

>  	/* some standard values */
> @@ -2241,6 +2270,13 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>  	return 0;
>  
>  out_unfreeze:
> +	/*
> +	 * When the device does not support any of the features required by the
> +	 * kernel (or viceversa), hide the block device. We can still rely on
> +	 * the namespace char device for submitting IOCTLs
> +	 */
> +	ns->disk->flags |= GENHD_FL_HIDDEN;
> +

The out_unfreeze case also handles all kinds of real error, so this needs
to move into a better spot, and probably check a specific error code
or even explicit indicator.

> +	struct nvme_ns *ns = container_of(inode->i_cdev, struct nvme_ns, cdev);
> +{
> +	struct nvme_ns *ns = container_of(inode->i_cdev, struct nvme_ns, cdev);

> +	struct nvme_ns *ns = container_of(file->f_inode->i_cdev,
> +				struct nvme_ns, cdev);

Maybe add a little cdev_to_ns() helper?

> -	if (nvme_update_ns_info(ns, id))
> -		goto out_put_disk;
> +	nvme_update_ns_info(ns, id);

I don't think we can simplify ignore all errors here.

> +static inline struct nvme_ns *nvme_get_ns_from_cdev(struct device *dev)
> +{
> +	return dev_get_drvdata(dev);
> +}

I think we can keep this in core.c.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
