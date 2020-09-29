Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017C6C4346E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:48:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833F92067D
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L2D5gkmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833F92067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bqkWo6YEKLe6w4zWMWvVwIJqfS8ZsM3M7Bf1kje1PLc=; b=L2D5gkmAUclKWZk9L6/Codcfv
	aHSVF/OvJwSILW8g3yxA1erYtF8eJuuR28I30pO6AJ+bmkOC1ceRdJ83gPidAX4xwT6VForxbTRS3
	tqWB2tyXawsJhjGipO78KLR5bVXbtsn1qI3ih1OgMewFliQpO0pCNqrqDtGuIFkpr2j72VgWDoVLg
	zzJCnCkF4oDTTJSkVk1Y4bF3jZbK8GLdzna3x+YEUo7E7nAg3366gY+rYK4ZQszoxTI27iHV+ETnO
	ehs07Owt44BsdHYl1AVSlE93F6deyVnzZOsHCEnz35KpwdeWI1O77Z4Z/vm0gSARzNPdJuTg+mMTX
	Tc93eznpw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNBIu-0001wC-Nl; Tue, 29 Sep 2020 08:48:08 +0000
Received: from mail-pj1-f65.google.com ([209.85.216.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNBIs-0001vb-Mq
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 08:48:07 +0000
Received: by mail-pj1-f65.google.com with SMTP id v14so2260486pjd.4
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 01:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5Fz6KGcE6tLRhOAPPVZPdSqaMDq9btUoqeCNx11RbTI=;
 b=QC3MLZFONE7nH44VROmZ2/3ok82tm6hN0fTzn4z/iFPDujTlsTzEIxkuKmbuaH6KRR
 CzrU05HHes8UAIUCk6923BspKMLrKZ3s6YR9l+uUo6Qetn/QZm8wlkmuUJkV6q21iTZh
 wCnB1WF+HxjU10wIx8zFt8pam1GsC2xOCgILTL8D8X7Eb9a8L5L+kM1QXZLeR0QE3z9T
 TBp5C6rkwN2sCacwTr7Jg/rBQPeoxXFdx1xS6vO5CKOpMY8sy75nl0zHpDZzpb1Gn6AM
 r6dWptgT//vdiQ5o3kclxrgwEN88gc3FNEWx5ewP8Oc4q1hakCg11HjlIUHhAeCQQDQu
 AUVg==
X-Gm-Message-State: AOAM533y1zAnfnnmem/sRxWf7jEiaoq+6nHeywTyMYnlXJ5dsXc2amcN
 /dL0B3Xaiw5enJKsPX3B8Hk=
X-Google-Smtp-Source: ABdhPJw/cx+bbRK/Rvr2RXIxN9a7WnY6jEdGpRRZX/w5vdVM7nZhIVzXgusWDRk13xpMen1zVkOzMQ==
X-Received: by 2002:a17:90a:b387:: with SMTP id
 e7mr3059590pjr.228.1601369285777; 
 Tue, 29 Sep 2020 01:48:05 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id a27sm4765268pfk.52.2020.09.29.01.48.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 01:48:05 -0700 (PDT)
Subject: Re: [PATCH 10/20] nvme: freeze the queue over ->lba_shift updates
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-11-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <39b98188-2803-2f49-e225-8d3fbe3bfb1f@grimberg.me>
Date: Tue, 29 Sep 2020 01:48:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928123502.435373-11-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_044806_758218_42ADEE73 
X-CRM114-Status: GOOD (  24.25  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Ensure that there can't be any I/O in flight went we change the disk
> geometry in nvme_update_ns_info, most notable the LBA size by lifting
> the queue free from nvme_update_disk_info into the caller

The queue is frozen on the queue logical block size, why should
we care about I/O while ns->lba_shift?

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 443aba9c9fdd11..82cd03c0ba21ba 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2021,7 +2021,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>   		/* unsupported block size, set capacity to 0 later */
>   		bs = (1 << 9);
>   	}
> -	blk_mq_freeze_queue(disk->queue);
> +
>   	blk_integrity_unregister(disk);
>   
>   	atomic_bs = phys_bs = bs;
> @@ -2086,8 +2086,6 @@ static void nvme_update_disk_info(struct gendisk *disk,
>   		set_disk_ro(disk, true);
>   	else
>   		set_disk_ro(disk, false);
> -
> -	blk_mq_unfreeze_queue(disk->queue);
>   }
>   
>   static inline bool nvme_first_scan(struct gendisk *disk)
> @@ -2133,6 +2131,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>   	struct nvme_ctrl *ctrl = ns->ctrl;
>   	int ret;
>   
> +	blk_mq_freeze_queue(ns->disk->queue);
>   	/*
>   	 * If identify namespace failed, use default 512 byte block size so
>   	 * block layer can use before failing read/write for 0 capacity.
> @@ -2150,30 +2149,39 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>   			dev_warn(ctrl->device,
>   				"failed to add zoned namespace:%u ret:%d\n",
>   				ns->head->ns_id, ret);
> -			return ret;
> +			goto out_unfreeze;
>   		}
>   		break;
>   	default:
>   		dev_warn(ctrl->device, "unknown csi:%u ns:%u\n",
>   			ns->head->ids.csi, ns->head->ns_id);
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto out_unfreeze;
>   	}
>   
>   	ret = nvme_configure_metadata(ns, id);
>   	if (ret)
> -		return ret;
> +		goto out_unfreeze;
>   	nvme_set_chunk_sectors(ns, id);
>   	nvme_update_disk_info(ns->disk, ns, id);
> +	blk_mq_unfreeze_queue(ns->disk->queue);
> +
>   #ifdef CONFIG_NVME_MULTIPATH
>   	if (ns->head->disk) {
> +		blk_mq_freeze_queue(ns->head->disk->queue);
>   		nvme_update_disk_info(ns->head->disk, ns, id);
>   		blk_stack_limits(&ns->head->disk->queue->limits,
>   				 &ns->queue->limits, 0);
>   		blk_queue_update_readahead(ns->head->disk->queue);
>   		nvme_update_bdev_size(ns->head->disk);
> +		blk_mq_unfreeze_queue(ns->head->disk->queue);
>   	}
>   #endif
>   	return 0;
> +
> +out_unfreeze:
> +	blk_mq_unfreeze_queue(ns->disk->queue);
> +	return ret;
>   }
>   
>   static int nvme_validate_ns(struct nvme_ns *ns)
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
