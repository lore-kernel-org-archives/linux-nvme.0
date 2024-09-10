Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63ADCECE564
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 07:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e4t2sEgbuV1qakcylLo7vbLeGXmEzy45ufFoMlrIsps=; b=cel41xQYDfpyMH1VF0Tbg5HZo5
	VOLnTjWt2RIJOEeJAIRH/Gt5T7xTBhwSizrLlsB0wu7yVV+HrO9KyeOrRwHSWzCtNgnDh99H8+dT6
	UTBzR9la+9YSCx4ICRB4tiyqH7rsDJvt0bFCLMdtt4PnfAegCcsWKOrz7Q0lupndGEDmZPfPvZDzU
	rNs0zTJn+8PWzai0NQ5boVofhgqaJACpg4hTZ6ghm+saXoxrxp4rY4Hxc+ap991JlPVesbW0LWpo9
	uWbnatD09gfRurujnBOWu59n9k7+NmMRUaFz4paU48NV7GJWy9KqSHOqkCJ1c9AhH6unnDB049OWC
	a2DRhoSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snvkW-00000004hFg-31wh;
	Tue, 10 Sep 2024 07:57:20 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snvkU-00000004hEr-2Oun
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 07:57:19 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374b25263a3so3104551f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 10 Sep 2024 00:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725955037; x=1726559837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4t2sEgbuV1qakcylLo7vbLeGXmEzy45ufFoMlrIsps=;
        b=BPEE22q4l25ToGw8zQx3plsDaIH3nNtffd19sup9lFcU4Ks+32vH3rjf/6oEzbZGZK
         bVmfMymPAx68fmi6VMJ3R3uMKHmWGipL25XgPF9I6E6CxMzFtESan++FaCj6dbVnEhGW
         rHU2dRmUuPjHlYriPI5ufYlQQ2CIsCfOQsvbfKHI4wG1d/A0gTortZCFzdRvfw382eoM
         sZKnDJ4iDBK+lmvIgn4VZCmLQJNn6R6cuLhcKPybkP9XVgMAJ+3V9QRL5UvL19LRACDu
         70PCuJiCYBp4x8nqytGzreMlCZMtVaAPTwHeix6Kog6aYDAwJEuvPrYF8kvF17By9C8O
         SFRg==
X-Forwarded-Encrypted: i=1; AJvYcCVxXJbDXZEwgusK3qiqkC45TGRdvz/Vz8r5b/FUrF346cuT+3s03ltP7Gk5z3izfNhG83hOOvQNuWUF@lists.infradead.org
X-Gm-Message-State: AOJu0YwAfhPI+Q+si9qdC6MccqgQxRigx2aCI8v6DSDtrEeWAtICyVQU
	LH241oTChHxpJ+tLKykMpPkrJmU+LdqthxEhdNNaH6UVIraVCVm0vXYMjg==
X-Google-Smtp-Source: AGHT+IFyR6Rq5kmfZDXcN3zfBg2/O4SlF8wkgtcQ7/+gZ42EF8+SAkKavJz8H6TZMmK/o44H8iWyIA==
X-Received: by 2002:a05:6000:1286:b0:374:ba83:8d73 with SMTP id ffacd0b85a97d-378949ef80cmr4987999f8f.8.1725955036631;
        Tue, 10 Sep 2024 00:57:16 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789566523fsm8125237f8f.27.2024.09.10.00.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 00:57:16 -0700 (PDT)
Message-ID: <58a80656-81d0-498d-a3e3-80ce9df6478c@grimberg.me>
Date: Tue, 10 Sep 2024 10:57:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: 'nvme disconnect' hangs after remapping
 namespaces
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240909071930.146343-1-hare@kernel.org>
 <20240909071930.146343-4-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240909071930.146343-4-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_005718_654714_8907DFF5 
X-CRM114-Status: GOOD (  20.70  )
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




On 09/09/2024 10:19, Hannes Reinecke wrote:
> During repetitive namespace map and unmap operations on the target
> (disabling the namespace, changing the UUID, enabling it again)
> the initial scan will hang as the target will be returning
> PATH_ERROR and the I/O is constantly retried:
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
> Calling 'nvme disconnect' on controllers with these namespaces
> will hang as the disconnect operation tries to flush scan_work:
>
> [<0>] __flush_work+0x389/0x4b0
> [<0>] nvme_remove_namespaces+0x4b/0x130 [nvme_core]
> [<0>] nvme_do_delete_ctrl+0x72/0x90 [nvme_core]
> [<0>] nvme_delete_ctrl_sync+0x2e/0x40 [nvme_core]
> [<0>] nvme_sysfs_delete+0x35/0x40 [nvme_core]
> [<0>] kernfs_fop_write_iter+0x13d/0x1b0
> [<0>] vfs_write+0x404/0x510
>
> before the namespaces are removed, and the controller state
> DELETING_NOIO (which would abort any pending I/O) is set only
> afterwards.
>
> This patch calls 'nvme_kick_requeue_lists()' when entering
> DELETING state for a controller to ensure all pending I/O
> is flushed, and also disables failover for any commands which
> are completed with an error afterwards, breaking the infinite
> retry loop.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/core.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 651073280f6f..142babce1963 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -381,6 +381,8 @@ enum nvme_disposition {
>   
>   static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>   {
> +	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
> +
>   	if (likely(nvme_req(req)->status == 0))
>   		return COMPLETE;
>   
> @@ -393,6 +395,8 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>   		return AUTHENTICATE;
>   
>   	if (req->cmd_flags & REQ_NVME_MPATH) {
> +		if (nvme_ctrl_state(ctrl) == NVME_CTRL_DELETING)
> +			return COMPLETE;

This looks wrong. What if I disconnect from one path and there are other
eligible paths?

