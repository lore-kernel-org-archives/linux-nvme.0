Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565B7CD37AA
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2024 19:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pR+GE7v/79mQcGl0dQYoY9J/vxRODgwSO5I3nFp6zPk=; b=kr6ACJoUJPtTogfG7jKAD2uqaO
	gJZjLtnkPepXykFMB7OwIp/ITaRFu87suXBkRil0ON/kieMgLlwTECDZEW5G3/3aqvjwG1kHIgE4L
	ZZVXIz/70VwQi8+pp0/8LOw9DX0F3xPt2Zab4DfJK0hkSwq8lgScZ2/CQGQs6Cr+oSX6wG2aR4euX
	ltMfetb8eWX+avcD9YxL4rRDr6MIsuPuKHFNW5668zMKwWLhvj8DPy4LS+evOweVZiKmj/yzmy5hd
	v0rtsFx14tcGGPQq6aUt/qRj+1erF4es7N+gl3Yh4eo+yZbkMGvg9x65Oty74GxXqI4xzHE+rCoJG
	hOPSHlqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slZMQ-00000001d1y-0e5Q;
	Tue, 03 Sep 2024 19:38:42 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slZME-00000001d02-3wKl
	for linux-nvme@lists.infradead.org;
	Tue, 03 Sep 2024 19:38:32 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42bb9d719d4so42963085e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 03 Sep 2024 12:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392307; x=1725997107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pR+GE7v/79mQcGl0dQYoY9J/vxRODgwSO5I3nFp6zPk=;
        b=h8cuk8gSujS4om+dY3yrD2yYly8R/bfosWhNkP09f5z2ZHwz5IwLYiGOmB/Q3LO3KX
         pIDhHlj1P8jSRrk0xaBhCvwkDgea5C3uV1IP1L8vmMaKtcylFIGazynON18U3bCU845G
         RvRtHuB7Cwh8TUp/PssddZmcbDtx0cr9zIE8xUKj86mn0muyOf+R00BLgNGJKyV/Iuz5
         dkX1rm10z5p4f18/LO+/91elptv0iyKb051fYxwId+kiV7l2G5t2sEbNtEINKYM5UK5n
         w2zGB+w8J3OaJL5yhaBOU1PqbldE1++Q6lm/A6HHVRPZEEeZ80A789X/NXI3LSka3OXZ
         0XOg==
X-Forwarded-Encrypted: i=1; AJvYcCXG0oU1EoadtcALyDg98IECqxCYWrXfxmC3MjKSj0tOYScHmH2JhwEehlfPZX3TFCDIKTPI5IpmlZUm@lists.infradead.org
X-Gm-Message-State: AOJu0Yyf7Cx9ftHLC3IZERKDqQ4aRs49tmoMCItfGDveXGvBO7WeZU6I
	cDwxshup2JZDf9oNPs+QA1FOgUiAPJC5IxJqm2c+Y0da/5DaXt7H
X-Google-Smtp-Source: AGHT+IGFCa0Ie70tvLbMd4JGPSBUm/8zNLa1r68tKTnwqcvc1aUAUkJcsiMYke/rl8uIGMcCI4qmFQ==
X-Received: by 2002:a05:600c:1e19:b0:426:641f:25e2 with SMTP id 5b1f17b1804b1-42c8810315dmr35196055e9.25.1725392306154;
        Tue, 03 Sep 2024 12:38:26 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-253.bb.netvision.net.il. [89.138.71.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42baf1b0c18sm198786365e9.37.2024.09.03.12.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 12:38:25 -0700 (PDT)
Message-ID: <1acc9b52-e3dc-4142-91d4-48eba61d4fd0@grimberg.me>
Date: Tue, 3 Sep 2024 22:38:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-multipath: fix I/O stall when remapping
 namespaces
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240903180345.35253-1-hare@kernel.org>
 <20240903180345.35253-3-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240903180345.35253-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_123831_332666_6F892079 
X-CRM114-Status: GOOD (  27.48  )
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




On 03/09/2024 21:03, Hannes Reinecke wrote:
> During repetitive namespace remapping operations (ie removing a namespace and
> provision a different namespace with the same NSID) on the target the
> namespace might have changed between the time the initial scan
> was performed, and partition scan was invoked by device_add_disk()
> in nvme_mpath_set_live(). We then end up with a stuck scanning process:
>
> [<0>] folio_wait_bit_common+0x12a/0x310
> [<0>] filemap_read_folio+0x97/0xd0
> [<0>] do_read_cache_folio+0x108/0x390
> [<0>] read_part_sector+0x31/0xa0
> [<0>] read_lba+0xc5/0x160
> [<0>] efi_partition+0xd9/0x8f0
> [<0>] bdev_disk_changed+0x23d/0x6d0
> [<0>] blkdev_get_whole+0x78/0xc0
> [<0>] bdev_open+0x2c6/0x3b0
> [<0>] bdev_file_open_by_dev+0xcb/0x120
> [<0>] disk_scan_partitions+0x5d/0x100
> [<0>] device_add_disk+0x402/0x420
> [<0>] nvme_mpath_set_live+0x4f/0x1f0 [nvme_core]
> [<0>] nvme_mpath_add_disk+0x107/0x120 [nvme_core]
> [<0>] nvme_alloc_ns+0xac6/0xe60 [nvme_core]
> [<0>] nvme_scan_ns+0x2dd/0x3e0 [nvme_core]
> [<0>] nvme_scan_work+0x1a3/0x490 [nvme_core]
>
> This happens when we have several paths, some of which are inaccessible,
> and the active paths are removed first. Then nvme_find_path() will requeue
> I/O in the ns_head (as paths are present), but the requeue list is never
> triggered as all remaining paths are inactive.
> This patch checks for NVME_NSHEAD_DISK_LIVE when selecting a path,
> and requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared once
> the last path has been removed to properly terminate pending I/O.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/multipath.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index c9d23b1b8efc..1b1deb0450ab 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -407,6 +407,9 @@ static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
>   
>   inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>   {
> +	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
> +		return NULL;
> +
>   	switch (READ_ONCE(head->subsys->iopolicy)) {
>   	case NVME_IOPOLICY_QD:
>   		return nvme_queue_depth_path(head);
> @@ -421,6 +424,9 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>   {
>   	struct nvme_ns *ns;
>   
> +	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
> +		return NULL;
> +
>   	list_for_each_entry_rcu(ns, &head->list, siblings) {
>   		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
>   			continue;
> @@ -967,11 +973,15 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
>   {
>   	if (!head->disk)
>   		return;
> -	kblockd_schedule_work(&head->requeue_work);
> -	if (test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
> +	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
>   		nvme_cdev_del(&head->cdev, &head->cdev_device);
>   		del_gendisk(head->disk);
>   	}
> +	/*
> +	 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
> +	 * to allow multipath to fail all I/O.
> +	 */
> +	kblockd_schedule_work(&head->requeue_work);

Not sure how this helps given that you don't wait for srcu to synchronize
before you kick the requeue.

>   }
>   
>   void nvme_mpath_remove_disk(struct nvme_ns_head *head)

Why do you need to clear NVME_NSHEAD_DISK_LIVE ? In the last posting you 
mentioned that ns_remove is stuck on srcu_synchronize? Can you explain 
why nvme_find_path is able to find a path given that it is already 
cleared NVME_NS_READY ? oris it nvme_available_path that is missing a 
check? Maybe can do with checking NVME_NS_READY instead?

