Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E2BC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 09:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ywK1T3hHSaP1zVJ6DsbE6n/kNo9zvt5tdGx1f7MruU0=; b=LZapIiOzK+B+yg8b/i4K55wz4M
	0H97G4X8ejfdqsg9HWpfyZoJqAvt9fHVUxAd7/fCeDN6ssrUAmTlbxqRj1KQnbgyDSgBTevFo6P2f
	c3++5JFU4CUujlqqPyL8vV3BK2k/IsCzxXGFSe1hIAVt15TlDxPFGdVN9/Fr+iD4MSB8mrZr0PuGR
	6SxZoSlPUxH5F8ADUUrBGx1UZ23ixa6LUDi3gGZf+CnesvMwSWA3V+dTMdzrjh7HqAabVNddlff7m
	PLBcxY4JBwDJhyl4iuhQZKs2Bu9IFJw555jR9x6mxFi1bHVBt5CCQSdYLqed0tM0cXnlosZRVLw7z
	OepVvEdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWxDd-00DEa6-7K; Wed, 23 Mar 2022 09:23:53 +0000
Received: from mail-ej1-f45.google.com ([209.85.218.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWxDZ-00DEY3-Bn
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 09:23:51 +0000
Received: by mail-ej1-f45.google.com with SMTP id yy13so1589546ejb.2
 for <linux-nvme@lists.infradead.org>; Wed, 23 Mar 2022 02:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ywK1T3hHSaP1zVJ6DsbE6n/kNo9zvt5tdGx1f7MruU0=;
 b=xp4yeyO63/FyehYHWgK4bi9U9rUsff+VR2GGaN2sjtleP9dZCIoEyaEmkpsBurDLD2
 jA5NCw0mEVK9421O0KUhH2wcUILnnY6vY0+taQkoe+xPI2Xdnph2Rw4MwL5J1tTu/BBq
 nT6KFbD68U8jMNYJrgdzq8PRAYsIUfdvNS7V2H6Y1u4rqyaHEBzowcn21HgjpJ9LBfW2
 rdS4PPBR2i9fFn+DHe3tqR6mU4iP+Sx/yl7ygtyrqDjI4NhtfOjmF7iA1/nUiFH7eSx0
 HGqbOXfYmUgOi2CXzvo1N5rTtvtzJYNuu56FhJ7UTC6mZc5C4IAH2FlsB2Y+jziFle9Y
 ybbw==
X-Gm-Message-State: AOAM532J8RseBI9D6ivKoUUx1kYHy7j5lNsEHKwR0caPcSqR3qGjkAkB
 Xkd0p5WMJTTEO3K+DjD1cso=
X-Google-Smtp-Source: ABdhPJyuXsy31TLA6tAqaE6ZztafkyRICuTTbn1NuUcm1zWLchc3vTj866IK3ca/iI/LjviqhRVg8A==
X-Received: by 2002:a17:906:a1d3:b0:6d0:80ea:2fde with SMTP id
 bx19-20020a170906a1d300b006d080ea2fdemr29413318ejb.344.1648027426813; 
 Wed, 23 Mar 2022 02:23:46 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.129.dynamic.barak-online.net.
 [85.65.206.129]) by smtp.gmail.com with ESMTPSA id
 z21-20020a1709063a1500b006da6436819dsm9548923eje.173.2022.03.23.02.23.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Mar 2022 02:23:46 -0700 (PDT)
Message-ID: <da6814ad-0746-c8a6-77ed-e72cb9683034@grimberg.me>
Date: Wed, 23 Mar 2022 11:23:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/1] nvme/mpath: fix hang when disk goes live over
 reconnect
Content-Language: en-US
To: Anton Eidelman <anton.eidelman@gmail.com>,
 linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com
Cc: ushankar@purestorage.com, Anton Eidelman <anton@lightbitslabs.com>
References: <20210918215729.388968-1-anton@lightbitslabs.com>
 <20220323035551.1524128-1-anton@lightbitslabs.com>
 <20220323035551.1524128-2-anton@lightbitslabs.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220323035551.1524128-2-anton@lightbitslabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_022349_456827_9290AAD8 
X-CRM114-Status: GOOD (  32.78  )
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



On 3/23/22 05:55, Anton Eidelman wrote:
> nvme_mpath_init_identify() invoked from nvme_init_identify()
> fetches a fresh ANA log from the ctrl.
> This is essential to have an up to date path states
> for both existing namespaces and for those scan_work
> may discover once the ctrl is up.
> 
> This happens in the following cases:
> 1) A new ctrl is being connected.
> 2) An existing ctrl is successfully reconnected.
> 3) An existing ctrl is being reset.
> 
> While in (1) ctrl->namespaces is empty, (2 & 3) may have namespaces,
> and nvme_read_ana_log() may call nvme_update_ns_ana_state().
> 
> This result in a hang when the ANA state of an existing namespace
> changes and makes the disk live: nvme_mpath_set_live() issues
> IO to the namespace through the ctrl,
> which does NOT have IO queues yet.

Given that setting the path as live triggers I/O, it makes perfect
sense to do it only after we have I/O queues that can accept this
I/O.

> 
> See sample hang below.
> 
> Solution:
> - nvme_update_ns_ana_state() to call set_live only if ctrl is live
> - nvme_read_ana_log() call from nvme_mpath_init_identify()
>    therefore only fetches and parses the ANA log;
>    any erros in this process will fail the ctrl setup as appropriate;
> - a separate function nvme_mpath_update()
>    is called in nvme_start_ctrl();
>    this parses the ANA log without fetching it.
>    At this point the ctrl is live,
>    therefore, disks can be set live normally.
> 
> Sample failure:
>      nvme nvme0: starting error recovery
>      nvme nvme0: Reconnecting in 10 seconds...
>      block nvme0n6: no usable path - requeuing I/O
>      INFO: task kworker/u8:3:312 blocked for more than 122 seconds.
>            Tainted: G            E     5.14.5-1.el7.elrepo.x86_64 #1
>      Workqueue: nvme-wq nvme_tcp_reconnect_ctrl_work [nvme_tcp]
>      Call Trace:
>       __schedule+0x2a2/0x7e0
>       schedule+0x4e/0xb0
>       io_schedule+0x16/0x40
>       wait_on_page_bit_common+0x15c/0x3e0
>       do_read_cache_page+0x1e0/0x410
>       read_cache_page+0x12/0x20
>       read_part_sector+0x46/0x100
>       read_lba+0x121/0x240
>       efi_partition+0x1d2/0x6a0
>       bdev_disk_changed.part.0+0x1df/0x430
>       bdev_disk_changed+0x18/0x20
>       blkdev_get_whole+0x77/0xe0
>       blkdev_get_by_dev+0xd2/0x3a0
>       __device_add_disk+0x1ed/0x310
>       device_add_disk+0x13/0x20
>       nvme_mpath_set_live+0x138/0x1b0 [nvme_core]
>       nvme_update_ns_ana_state+0x2b/0x30 [nvme_core]
>       nvme_update_ana_state+0xca/0xe0 [nvme_core]
>       nvme_parse_ana_log+0xac/0x170 [nvme_core]
>       nvme_read_ana_log+0x7d/0xe0 [nvme_core]
>       nvme_mpath_init_identify+0x105/0x150 [nvme_core]
>       nvme_init_identify+0x2df/0x4d0 [nvme_core]
>       nvme_init_ctrl_finish+0x8d/0x3b0 [nvme_core]
>       nvme_tcp_setup_ctrl+0x337/0x390 [nvme_tcp]
>       nvme_tcp_reconnect_ctrl_work+0x24/0x40 [nvme_tcp]
>       process_one_work+0x1bd/0x360
>       worker_thread+0x50/0x3d0
> 
> Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
> ---
>   drivers/nvme/host/core.c      |  1 +
>   drivers/nvme/host/multipath.c | 12 +++++++++++-
>   drivers/nvme/host/nvme.h      |  4 ++++
>   3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3c0461129bca..d4495fa97657 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4509,6 +4509,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>   	if (ctrl->queue_count > 1) {
>   		nvme_queue_scan(ctrl);
>   		nvme_start_queues(ctrl);
> +		nvme_mpath_update(ctrl);
>   	}
>   
>   	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index c97d7f843977..a22d455f48a9 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -613,7 +613,8 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
>   	ns->ana_state = desc->state;
>   	clear_bit(NVME_NS_ANA_PENDING, &ns->flags);
>   

I think we need a comment here explaining this. something like:

	/*
	 * nvme_mpath_set_live() will trigger I/O to the mpath
	 * device node and in turn to this path device, however we
	 * cannot accept this I/O if the ctrl is not live, this may
	 * deadlock if called from the nvme_mpath_init_identify and
	 * the controller will never complete initialization, preventing
	 * I/O from completing. For this we will reprocess the ANA log
	 * page again once the controller will be fully initialized.
	 */

> -	if (nvme_state_is_live(ns->ana_state))
> +	if (nvme_state_is_live(ns->ana_state) &&
> +		(ns->ctrl->state == NVME_CTRL_LIVE))

No need for the brackets I think, and

Alignment should be:
	if (nvme_state_is_live(ns->ana_state) &&
	    ns->ctrl->state == NVME_CTRL_LIVE)

>   		nvme_mpath_set_live(ns);
>   }
>   
> @@ -700,6 +701,15 @@ static void nvme_ana_work(struct work_struct *work)
>   	nvme_read_ana_log(ctrl);
>   }
>   
> +void nvme_mpath_update(struct nvme_ctrl *ctrl)
> +{
> +	u32 nr_change_groups = 0;
> +
> +	mutex_lock(&ctrl->ana_lock);
> +	nvme_parse_ana_log(ctrl, &nr_change_groups, nvme_update_ana_state);
> +	mutex_unlock(&ctrl->ana_lock);
> +}
> +
>   static void nvme_anatt_timeout(struct timer_list *t)
>   {
>   	struct nvme_ctrl *ctrl = from_timer(ctrl, t, anatt_timer);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 1ea908d43e17..76f7a5f37379 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -781,6 +781,7 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
>   void nvme_mpath_remove_disk(struct nvme_ns_head *head);
>   int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
>   void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl);
> +void nvme_mpath_update(struct nvme_ctrl *ctrl);
>   void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
>   void nvme_mpath_stop(struct nvme_ctrl *ctrl);
>   bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
> @@ -852,6 +853,9 @@ static inline int nvme_mpath_init_identify(struct nvme_ctrl *ctrl,
>   "Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.\n");
>   	return 0;
>   }
> +void nvme_mpath_update(struct nvme_ctrl *ctrl)
> +{
> +}
>   static inline void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
>   {
>   }

