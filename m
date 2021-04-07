Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7243C433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 15:48:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4D561262
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 15:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4D561262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sfNRDBV091D+cd0AFKf8n8wHykIwukDbxFRCzS66rwc=; b=FMwkdbi3OCGqHNKymqYg7gFh+
	jqH6V7i3JmlIriJO6NSsF2idTljqRs7cMjo4DcVHynTq42oF/CTMFfxV/pCqW6SSb28Ex1N8R0Pmv
	reHhs39a7fKJ3adLWuixd34F5NnChV+9gzySLrEdfKCcchL5/dHYxG1bSEwxnZWW4ccspeXih+K6x
	YaEQqljX5d61xlnLKJATmvVfNwS1Kya+H6rTbBFEOt+YywYPMqm1uSDW9Es5LN/+qJXGDF9u2hXzp
	V5y5vKKCyVKih6QxTjrxqHoXVFvKhhiIX0BDwy6BYfK5mRFMRhulvAKE3bzCw4RxLMhaV75DirIaD
	lRLk0yI3g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUAP6-005JjQ-Io; Wed, 07 Apr 2021 15:47:41 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUAP0-005JiE-Q3
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 15:47:37 +0000
Received: by mail-pj1-x102d.google.com with SMTP id
 d5-20020a17090a2a45b029014d934553c4so732330pjg.1
 for <linux-nvme@lists.infradead.org>; Wed, 07 Apr 2021 08:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=D0+zXtL/JPOx7YjV0U2x/LSoYZfiNbBX5Wm76NrIrlE=;
 b=i/2foTQD2ZCAFkPU/EhKRRX4WImrxJh8VejCi/zqxnqTjpm3bFkaPmJ2cmOWFXMZZT
 YbUCb9PYEy7kVSclC0a0V0w4YRdNM6uchL/UR02cCJmwrm7zQw41gLmGQrRqo4kyTY0h
 YDN07quNIbNjrKGw6lywQEWJ3FHeMIWZ54czCC/hH9P9Xe4Qkf84T76oXA80IroQhmba
 8UazsxfTOleg8/rvyazw9N12cuukVcI8eBkdaamExms+xE8JiM/1CB3NGzCGBr7IBp1C
 7K1CqXZ7qXe87+w6Mf4xo++GaUtl5xUXurrKU79de7C4VmdWANUyvE8iN7PrcVwY8n6v
 1N7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=D0+zXtL/JPOx7YjV0U2x/LSoYZfiNbBX5Wm76NrIrlE=;
 b=A14D6u3I8iwVDVOkkyD+M380zFpIfK7bqQNQ9Lkxgjd+JUffyWayHyEEGBYfLWtz0m
 n8eO75/Ghd2uERJ+rf0KDVPqh5OcBAvgvstL1rXzpSV+2ipv6xrLR0iKcJbt6zYf+14X
 rkblZxUHn8pvycVricQCFvETJlQTSp5bbLbUjuYTk7AyWy9HStWQX/Bs2moxOFoV2C4R
 dowTYRBjzP6wxws9D9w77+Lh/v8lNU7LZfiMc2/e/EQQMhe562+TGG2HxeaRhmR47seb
 2LMWvLS2TMWtLddfp4eDfL8Ec4UHjWxckCYW/KOYaLAhEXkPTrqHzvRbKa3CPQzKGgvb
 4a/Q==
X-Gm-Message-State: AOAM533qPmB6vmtNs2MaxMaVSJ755FM2g6l45hbly/ef4Vd8RaRz5CMa
 AXt2rFV/CFSIH66jHYh7ntM=
X-Google-Smtp-Source: ABdhPJySrh2XFN9ZfV6Ohyb+UetqJTj2tcYoYDh5B8bwE08/33aMlsNA8+YFvEh/X4957cHRJFZccw==
X-Received: by 2002:a17:90a:af8a:: with SMTP id
 w10mr3781501pjq.114.1617810453350; 
 Wed, 07 Apr 2021 08:47:33 -0700 (PDT)
Received: from localhost ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id q14sm22822851pgt.54.2021.04.07.08.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Apr 2021 08:47:32 -0700 (PDT)
Date: Thu, 8 Apr 2021 00:47:30 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V2 1/1] nvme: introduce generic per-namespace chardev
Message-ID: <20210407154730.GC8667@localhost>
References: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
 <20210406064841.103393-2-minwoo.im.dev@gmail.com>
 <20210407131527.GA15142@lst.de> <20210407141128.GB2805@localhost>
 <20210407142152.GA20466@lst.de> <20210407153536.GA8667@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210407153536.GA8667@localhost>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_164735_074731_E9802818 
X-CRM114-Status: GOOD (  37.16  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 21-04-08 00:35:36, Minwoo Im wrote:
> On 21-04-07 16:21:52, Christoph Hellwig wrote:
> > On Wed, Apr 07, 2021 at 11:11:28PM +0900, Minwoo Im wrote:
> > > Then can we have like this ?  The following diff is just considering the
> > > ns_head only, but just conceptually, not hanging out with bdev, it's
> > > just get the reference.
> > 
> > FYI, this is what I did today.  Not really tested yet and at least
> > one known issue.  Busy with calls for now, but I hope to have something
> > ready tonight:
> > 
> > http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-generic
> 
> Here's an additional patch based on the branch above:
> 
> 1. During the `nvme list` command, controller ioctl for the ns_head has
>    been not coming out from the mutex_lock_killable(&nvme_subsystems_lock)
>    because it just gets the controller reference and return it without
>    unlocking it.  So the first change point of this patch is to unlock the
>    mutex right before the return.  But, Is this a real issue? because
>    this changes are not from this series though.....
> 
> 2. Can we have the check whether the ns_head has disk allocated or not
>    by getting `disk` pointer out of the #ifdef CONFIG_NVME_MULTIPATH?
>    If it's not allocated due to some reasons (e.g., !multipath, or CMIC
>    does not support multiple controllers, or some failures during the
>    allocations), disk will never be allocated.  So, I tried to pull the
>    `disk` pointer out of the #ifdef from the nvme_ns_head, but maybe
>    this is not what you have intended....  It would be great if you can
>    give some feedback on this.
> 
> I had a quick tests based on the branch with the following patch:
>   - !CONFIG_NVME_MULTIPATH
>   - CONFIG_NVME_MULTIPATH && !multipath

Forgot to mention a case:
    - CONFIG_NVME_MULTIPATH && multipath

>   - Basic I/O for /dev/ng* chardev through `nvme io-passthru` command.
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2b04fc451f09..f05eff5b7c30 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2016,6 +2016,7 @@ struct nvme_ctrl *nvme_find_get_live_ctrl(struct nvme_subsystem *subsys)
>  		if (ctrl->state != NVME_CTRL_LIVE)
>  			continue;
>  		nvme_get_ctrl(ctrl);
> +		mutex_unlock(&nvme_subsystems_lock);
>  		return ctrl;
>  	}
>  
> @@ -3687,8 +3688,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>  	nvme_get_ctrl(ctrl);
>  
>  	device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups);
> -	// XXX: only for the !multipath case
> -	nvme_add_ns_cdev(ns);
> +	if (!nvme_ns_head_multipath(ns->head))
> +		nvme_add_ns_cdev(ns);
>  
>  	nvme_mpath_add_disk(ns, id);
>  	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
> @@ -3733,8 +3734,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  	synchronize_srcu(&ns->head->srcu); /* wait for concurrent submissions */
>  
>  	if (ns->disk->flags & GENHD_FL_UP) {
> -		// XXX: only for !multipath
> -		cdev_device_del(&ns->cdev, &ns->cdev_device);
> +		if (!nvme_ns_head_multipath(ns->head))
> +			cdev_device_del(&ns->cdev, &ns->cdev_device);
>  		del_gendisk(ns->disk);
>  		blk_cleanup_queue(ns->queue);
>  		if (blk_get_integrity(ns->disk))
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index dc1846d3e4f2..91ff75b41ed6 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -417,8 +417,9 @@ struct nvme_ns_head {
>  	struct cdev		cdev;
>  	struct device		cdev_device;
>  
> -#ifdef CONFIG_NVME_MULTIPATH
>  	struct gendisk		*disk;
> +
> +#ifdef CONFIG_NVME_MULTIPATH
>  	struct bio_list		requeue_list;
>  	spinlock_t		requeue_lock;
>  	struct work_struct	requeue_work;
> @@ -429,6 +430,11 @@ struct nvme_ns_head {
>  #endif
>  };
>  
> +static inline bool nvme_ns_head_multipath(struct nvme_ns_head *head)
> +{
> +	return !!head->disk;
> +}
> +
>  enum nvme_ns_features {
>  	NVME_NS_EXT_LBAS = 1 << 0, /* support extended LBA format */
>  	NVME_NS_METADATA_SUPPORTED = 1 << 1, /* support getting generated md */

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
