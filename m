Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE6CC4167B
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Nov 2023 01:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tKcO0SASSi/T/bFYj08bTJr44P0yqQBUXw2zKxdRGcM=; b=YUXDa+jt69EeZonuTTkyd/16K4
	BhjHR5n2lvHfMf5koGZ4MVjczPm42y82F9yCt1eAuxZvYK3gfEZx8imhbYCOfQ7IWFm6vdLeki3Vb
	9i0c3bym81QykUnxNJVW8rD18lvIUsC4m/kLBDM7+BMhNc1mHi10nG0ibRqyPQrJYSTH3WsrO+WAc
	yzeHslLEzFsxbiCYxSeqocMgeOQGXFI2ph8YHwh7180u45WViWB6ybicVp40cAcGMB+w1x+wJp8FF
	DKSo8LG2F/TNK7RPYNMTpeAZETB8F1h50ZL1H/Uhrr8lrYeoYrs2yok6N5rtrsM50xmVMuMFPSz55
	4wylmmVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1GA7-007ZS4-2A;
	Fri, 10 Nov 2023 01:18:19 +0000
Received: from mail-pl1-x664.google.com ([2607:f8b0:4864:20::664])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1GA4-007ZRN-1s
	for linux-nvme@lists.infradead.org;
	Fri, 10 Nov 2023 01:18:18 +0000
Received: by mail-pl1-x664.google.com with SMTP id d9443c01a7336-1cc3388621cso20472045ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 09 Nov 2023 17:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1699579095; x=1700183895; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tKcO0SASSi/T/bFYj08bTJr44P0yqQBUXw2zKxdRGcM=;
        b=AZVj473GI141ueuA/ea9A0rzCYaaFi/IrxOGOxFLM70I6uJZktcrV61Ne1L4KfhEkT
         NoGCzKAtnuQzVCvArt3o92VpGTbFvXqJ2ekkCvxbNaQhzPp5RrthK/NOlEiciTz3qTgf
         1rBm43MQ1SI+aWFpbsQa1fvcW5l/UqZwtstRbuYhjJkUM/nb/HxO4TcPv1QEQqGUVu1E
         cSjQKOHxfcbooS2gVPfHmT3sIzPdg+1vCAXG1mhXJpmdDueQ8kX5X6AgZRZe6vnKsK3n
         u4ckXZL4OjC2SvyLFhVd4sCWXz+AlrMWkKsAiyYZc+z+rn/E2bDIT0gMA9LMBsaTWd5n
         P34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699579095; x=1700183895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKcO0SASSi/T/bFYj08bTJr44P0yqQBUXw2zKxdRGcM=;
        b=plQ37vf0vOOFH2P1Ia9oh96iMpqXYOlMmF4U9oRxFZ92aOsOsNk0nuMh3uHrPU6uim
         gjzEH3ZIZKSpXpaWxTLBW2GLQiqD3NtRPswpxp6QpzRjKfxFgdNMdh06a5l2LCkMu/9b
         fMbKweJr6exn5iFCK5dSSxch11kh5+8MHKpLELn/MWalVf19FfPYzQS9egFA5Aokypeg
         mh87ygi/jXJC7ul9+c3XrPgouinkOUqGaU9Y/HKm+Ep86QnZyGAT6sFSe9J4vqngBmiw
         FG3Y1bW+SfZ5+I/gKl6TfVse7kXBAgw2pFGi5mtPiDFcwEo8+z8dcZHJLOWA09jQitKL
         kxLA==
X-Gm-Message-State: AOJu0Ywp3lxeeUKGzaVtSyhBFROAM0MirmmypgDI1j3LPzI0S2/AcrjW
	bjCsuGtfir7xqzzDPvYdFI1MXoEGZrvrwuTlfJYS/ZdlFUx0sC3YL1TyHNSuOfDjyZclTOmTjQB
	nTLlb/+5+r9hrGAf603KLSdG4BR1OftXQshziDRqqtENXIBFzCrZ9sOoT3mktujx1GWMwKpze8A
	I5cj0GBF2rpJGAARacsTjhKRKjzC8I9sihUODWZS4bEsqnN0vjkw==
X-Google-Smtp-Source: AGHT+IHAFWAVKCr2xARfgXGg+wv2lRyVPf67FgKwz/308b/ECpR6cezpnrDozpdAgpQDYnpLFqYmdKneW8PC
X-Received: by 2002:a17:902:ea03:b0:1cc:6101:2094 with SMTP id s3-20020a170902ea0300b001cc61012094mr1556143plg.14.1699579094949;
        Thu, 09 Nov 2023 17:18:14 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id j6-20020a170902c3c600b001bbc690e283sm837044plj.123.2023.11.09.17.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 17:18:14 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3281C3402D2;
	Thu,  9 Nov 2023 18:18:14 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 2323CE4017C; Thu,  9 Nov 2023 18:18:14 -0700 (MST)
Date: Thu, 9 Nov 2023 18:18:14 -0700
From: Uday Shankar <ushankar@purestorage.com>
To: "Ewan D. Milne" <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org, tsong@purestorage.com
Subject: Re: [PATCH 2/3] nvme: multipath: only update ctrl->nr_active when
 using queue-depth iopolicy
Message-ID: <ZU2E1j4zyUGYw7en@dev-ushankar.dev.purestorage.com>
References: <20231107212331.9413-1-emilne@redhat.com>
 <20231107212331.9413-2-emilne@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107212331.9413-2-emilne@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231109_171816_707371_342A5D90 
X-CRM114-Status: GOOD (  24.33  )
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

On Tue, Nov 07, 2023 at 04:23:30PM -0500, Ewan D. Milne wrote:
> The atomic updates of ctrl->nr_active are unnecessary when using
> numa or round-robin iopolicy, so avoid that cost on a per-request basis.
> Clear nr_active when changing iopolicy and do not decrement below zero.
> (This handles changing the iopolicy while requests are in flight.)

Instead of trying to handle a changing iopolicy while requests are in
flight, can we quiesce I/O when we change the iopolicy? That should let
us simplify/speed up the logic in the I/O path a bit
(atomic_dec_if_positive seems to hide a cmpxchg loop on most
architectures, which can be slower than an atomic_dec).

> 
> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> ---
>  drivers/nvme/host/core.c      |  2 +-
>  drivers/nvme/host/multipath.c | 21 ++++++++++++++++++---
>  drivers/nvme/host/nvme.h      |  2 ++
>  3 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 75a1b58a7a43..9bc19755be77 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -110,7 +110,7 @@ struct workqueue_struct *nvme_delete_wq;
>  EXPORT_SYMBOL_GPL(nvme_delete_wq);
>  
>  static LIST_HEAD(nvme_subsystems);
> -static DEFINE_MUTEX(nvme_subsystems_lock);
> +DEFINE_MUTEX(nvme_subsystems_lock);
>  
>  static DEFINE_IDA(nvme_instance_ida);
>  static dev_t nvme_ctrl_base_chr_devt;
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 4c2690cddef3..e184e7c377bc 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -133,7 +133,8 @@ void nvme_mpath_start_request(struct request *rq)
>  	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
>  		return;
>  
> -	atomic_inc(&ns->ctrl->nr_active);
> +	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD)
> +		atomic_inc(&ns->ctrl->nr_active);
>  	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
>  	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
>  						      jiffies);
> @@ -147,7 +148,8 @@ void nvme_mpath_end_request(struct request *rq)
>  	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
>  		return;
>  
> -	atomic_dec(&ns->ctrl->nr_active);
> +	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD)
> +		atomic_dec_if_positive(&ns->ctrl->nr_active);
>  	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
>  			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
>  			 nvme_req(rq)->start_time);
> @@ -848,6 +850,19 @@ static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
>  			  nvme_iopolicy_names[READ_ONCE(subsys->iopolicy)]);
>  }
>  
> +void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
> +{
> +	struct nvme_ctrl *ctrl;
> +
> +	WRITE_ONCE(subsys->iopolicy, iopolicy);
> +
> +	mutex_lock(&nvme_subsystems_lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		atomic_set(&ctrl->nr_active, 0);
> +	}
> +	mutex_unlock(&nvme_subsystems_lock);
> +}
> +
>  static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
>  		struct device_attribute *attr, const char *buf, size_t count)
>  {
> @@ -857,7 +872,7 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
>  
>  	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
>  		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
> -			WRITE_ONCE(subsys->iopolicy, i);
> +			nvme_subsys_iopolicy_update(subsys, i);
>  			return count;
>  		}
>  	}
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index f0f3fd8b4197..c4469bc38d89 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -49,6 +49,8 @@ extern struct workqueue_struct *nvme_wq;
>  extern struct workqueue_struct *nvme_reset_wq;
>  extern struct workqueue_struct *nvme_delete_wq;
>  
> +extern struct mutex nvme_subsystems_lock;
> +
>  /*
>   * List of workarounds for devices that required behavior not specified in
>   * the standard.
> -- 
> 2.20.1
> 
> 

