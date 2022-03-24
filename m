Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF4CC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 10:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=syOK6zzeDZ+ot8szTmQSNQxaKeCMsFicGpCGwG6dH3Y=; b=yVE+zs0qpDRn3aHyeM+XVIY1od
	tuvWkbybraqbc8QqDATD0ye/KqeTJf8x1CrNr4OgCRxqKLWy2JqDl8vOHctlCTwSTdJAbWWfvYzJ4
	FG4oeLAY9xuHJbK1en0bjijrN+7gyfeHiKz+vKmXYiBp/EEEhnXZ7xKfa+2Lyk/W8zIptecdGNqBQ
	xcVbVmfdCohtipWJrI/3ML0BEbru0k5nfs8jSSREfB0Le3a5zeI+C7P49j3IVpLe/uonmP3jjVwcL
	B6N9asJCvlsxTG+Nas6+koz2xFW5jv/Jnwyw5qmpnJJmSY/iUYbY8HCWE+uJdCuUkZsrlSEDW3M6O
	80ozeJLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXKsY-00GF7D-AH; Thu, 24 Mar 2022 10:39:42 +0000
Received: from mail-ed1-f53.google.com ([209.85.208.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXKsU-00GF6X-Vh
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 10:39:40 +0000
Received: by mail-ed1-f53.google.com with SMTP id y10so5096379edv.7
 for <linux-nvme@lists.infradead.org>; Thu, 24 Mar 2022 03:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=syOK6zzeDZ+ot8szTmQSNQxaKeCMsFicGpCGwG6dH3Y=;
 b=DAskf/xumJgMHRY7izsfLlxqBbEiWk+RUxLJ5bbq6xoCkdKS06BaaRVlF0oX+ETAu0
 MHGUkXNz8iiW8tqTYvsGC5ctGDVvjs5GB1So7rKc3RM7uDVkZFsGpAU/yapiZSb2pDdC
 67sVZUbVvn/AfDu2xQbhH2DfIppl9cHqaqCjCWYKqbDlDZgsue9DhJUaQitrTrBpI4hL
 uwH+d8NI8nb4HTAPdwZTJCvcwkydYAOQ8PykK4C9WjyL8xq3cQCKR4WVbK8B1C9G7M+o
 SqAFgBhRpdJ/a0z4nJ02qLLCJsHd7RBiHHYpFGc9lv8YNM7bTEcsan1vFOfI65YLXNG+
 +i9Q==
X-Gm-Message-State: AOAM532gO8jfWKw6bfznKxLE2PaKMScBIJPJ7OEx0LvGAF7h1zp9D1zm
 cZUNcFTpWjzwEkIBvbM7SQaBPXfTQ4w=
X-Google-Smtp-Source: ABdhPJwZiypbNeaj+o/Is+9Pjvy0MEUKNacxBSQomARf8O0XMT+IWJDn4N6mVyfNqq5BS1spKiF9eA==
X-Received: by 2002:a05:6402:40cb:b0:419:42de:65b6 with SMTP id
 z11-20020a05640240cb00b0041942de65b6mr5998105edb.66.1648118375662; 
 Thu, 24 Mar 2022 03:39:35 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.129.dynamic.barak-online.net.
 [85.65.206.129]) by smtp.gmail.com with ESMTPSA id
 kw3-20020a170907770300b006b2511ea97dsm974462ejc.42.2022.03.24.03.39.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Mar 2022 03:39:35 -0700 (PDT)
Message-ID: <a51dcb74-9664-41a6-7a05-1aee2ba0572a@grimberg.me>
Date: Thu, 24 Mar 2022 12:39:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Revert "nvme-multipath: fix hang when disk goes live over
 reconnect"
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org
References: <20220324000620.4127-1-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220324000620.4127-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220324_033939_062791_A8383029 
X-CRM114-Status: GOOD (  24.47  )
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


> This reverts commit d50c992edf10b95d2034097405c94fecfbe1ef7f which is
> causing following OOPs:

Hey Chaitanya, can you please elaborate on the scenario that triggered
this?

Thanks.

> <1>[    1.943642] BUG: kernel NULL pointer dereference, address: 0000000000000008
> <1>[    1.943645] #PF: supervisor read access in kernel mode
> <1>[    1.943646] #PF: error_code(0x0000) - not-present page
> <6>[    1.943648] PGD 0 P4D 0
> <4>[    1.943649] Oops: 0000 [#1] PREEMPT SMP NOPTI
> <4>[    1.943651] CPU: 0 PID: 7 Comm: kworker/u96:0 Not tainted 5.17.0-rc2nvme+ #58
> <4>[    1.943653] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> <4>[    1.943654] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
> <4>[    1.943662] RIP: 0010:nvme_parse_ana_log+0x1e/0x160 [nvme_core]
> 
> <4>[    1.943670] RSP: 0018:ffffc90000043e00 EFLAGS: 00010286
> <4>[    1.943672] RAX: 0000000000000000 RBX: ffff888103fd4210 RCX: 0000000000000000
> <4>[    1.943673] RDX: ffffffffc00b62c0 RSI: ffffc90000043e44 RDI: ffff888103fd4210
> <4>[    1.943673] RBP: ffff888103fd4210 R08: 0000000000000001 R09: ffff888100051828
> <4>[    1.943674] R10: 0000000000000000 R11: fffffffffff4a904 R12: 0000000000000000
> <4>[    1.943675] R13: ffff88817daa6500 R14: 0000000000000000 R15: ffff88817daa6505
> <4>[    1.943677] FS:  0000000000000000(0000) GS:ffff888fff200000(0000) knlGS:0000000000000000
> <4>[    1.943678] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[    1.943678] CR2: 0000000000000008 CR3: 00000001788a4000 CR4: 0000000000350ef0
> <4>[    1.943680] Call Trace:
> <4>[    1.943683]  <TASK>
> <4>[    1.943684]  ? nvme_update_ns_ana_state+0x40/0x40 [nvme_core]
> <4>[    1.943690]  nvme_mpath_update+0x4a/0x70 [nvme_core]
> <4>[    1.943695]  nvme_start_ctrl+0x110/0x140 [nvme_core]
> <4>[    1.943700]  process_one_work+0x1af/0x380
> <4>[    1.943709]  worker_thread+0x50/0x3a0
> <4>[    1.943711]  ? rescuer_thread+0x370/0x370
> <4>[    1.943712]  kthread+0xe7/0x110
> <4>[    1.943714]  ? kthread_complete_and_exit+0x20/0x20
> <4>[    1.943716]  ret_from_fork+0x22/0x30
> <4>[    1.943719]  </TASK>
> 
> [0]kdb>
> 
> With this revert not testing can proceed forward.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/core.c      |  1 -
>   drivers/nvme/host/multipath.c | 23 ++---------------------
>   drivers/nvme/host/nvme.h      |  4 ----
>   3 files changed, 2 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8cb1197aac42..ccc5877d514b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4511,7 +4511,6 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>   	if (ctrl->queue_count > 1) {
>   		nvme_queue_scan(ctrl);
>   		nvme_start_queues(ctrl);
> -		nvme_mpath_update(ctrl);
>   	}
>   
>   	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 12d4afde3662..c97d7f843977 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -612,18 +612,8 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
>   	ns->ana_grpid = le32_to_cpu(desc->grpid);
>   	ns->ana_state = desc->state;
>   	clear_bit(NVME_NS_ANA_PENDING, &ns->flags);
> -	/*
> -	 * nvme_mpath_set_live() will trigger I/O to the mpath
> -	 * device node and in turn to this path device, however we
> -	 * cannot accept this I/O if the ctrl is not live.
> -	 * This may deadlock if called from the nvme_mpath_init_identify()
> -	 * and the ctrl will never complete initialization,
> -	 * preventing I/O from completing.
> -	 * For this case we will reprocess the ANA log page
> -	 * in nvme_mpath_update() once the ctrl ready.
> -	 */
> -	if (nvme_state_is_live(ns->ana_state) &&
> -	    ns->ctrl->state == NVME_CTRL_LIVE)
> +
> +	if (nvme_state_is_live(ns->ana_state))
>   		nvme_mpath_set_live(ns);
>   }
>   
> @@ -710,15 +700,6 @@ static void nvme_ana_work(struct work_struct *work)
>   	nvme_read_ana_log(ctrl);
>   }
>   
> -void nvme_mpath_update(struct nvme_ctrl *ctrl)
> -{
> -	u32 nr_change_groups = 0;
> -
> -	mutex_lock(&ctrl->ana_lock);
> -	nvme_parse_ana_log(ctrl, &nr_change_groups, nvme_update_ana_state);
> -	mutex_unlock(&ctrl->ana_lock);
> -}
> -
>   static void nvme_anatt_timeout(struct timer_list *t)
>   {
>   	struct nvme_ctrl *ctrl = from_timer(ctrl, t, anatt_timer);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 76f7a5f37379..1ea908d43e17 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -781,7 +781,6 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
>   void nvme_mpath_remove_disk(struct nvme_ns_head *head);
>   int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
>   void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl);
> -void nvme_mpath_update(struct nvme_ctrl *ctrl);
>   void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
>   void nvme_mpath_stop(struct nvme_ctrl *ctrl);
>   bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
> @@ -853,9 +852,6 @@ static inline int nvme_mpath_init_identify(struct nvme_ctrl *ctrl,
>   "Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.\n");
>   	return 0;
>   }
> -void nvme_mpath_update(struct nvme_ctrl *ctrl)
> -{
> -}
>   static inline void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
>   {
>   }

