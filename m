Return-Path: <SRS0=MITl=OJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55328C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Sep 2021 10:19:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E7961212
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Sep 2021 10:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 04E7961212
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DLD/DxsPldp9kUWsTZ01CmSblVtkAz1ZOpsvhMoAchI=; b=j6M6g7cQuW4s4W20BoYg41Z+HC
	Jzi+46d5MQfsewEptv6asbqZMpLYY/hwDb8pR95/kl59M8HcASk+ulGiBvmGmkrUMm1Gi5YV1Tlz+
	0ts5AMR728gdT1ajlC8otaU088T+Mcgb23L1Ll6nB1XGnP608SqdyAMUcvhxOkNadnh6vp9b9lS7v
	46vx9iry2rNSb1H04ECpb1Lg0/z25h3TN0mEjVdDrpNpaVW3gM/nbzQfcnvUQl8vhPar8ddZrfWHN
	fOfV26ODCz9lUQALaVMmN2sZp0TnWi8+sdOyzupznfUO/Qf57LQ3A3UVDIh2cXafgixVXICjKMU2q
	20wEK59Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mRtvF-00H6Kb-SD; Sun, 19 Sep 2021 10:19:45 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mRtvC-00H6K4-Rk
 for linux-nvme@lists.infradead.org; Sun, 19 Sep 2021 10:19:44 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 y198-20020a1c7dcf000000b0030b69a49fe9so1429092wmc.1
 for <linux-nvme@lists.infradead.org>; Sun, 19 Sep 2021 03:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tzoo3IiIO9+GZOEZTaZXf2lG9pmwU3QdfQPXdQGMj2A=;
 b=V1I+VFbI2DNvU2N71knCKpG1DN+LIFkx03jQdnK1P0gX3UkxE7Ziz2l3k4wVUHcWku
 +1fJgO046opjavDxwZfd3eAk/ycHKod/c62t09xuQczH4w0m83tuiwv8VvZeWVtJEEL0
 pY/0koEgmo5XQRczq21L2UYuCxEd4xlmnnUzV2gxRoz4laQSAg1lzffbNpITz629BB7N
 /pMuiRi+65Ls+VIVatKMlSjOHRihsKJIJeMTLQ2FCPUvYyXZsgcpel5BU8ETtFR5uplG
 DlxNt4poYhn8E7m8bgmvj57T+6IsjWHcHRjBr8zVQEZE7dpFRLR2ukpRigo/TU4tTN2M
 wnhQ==
X-Gm-Message-State: AOAM533QxzCwjHoJze58CElKJ6MbZ6lKB1ug9b2CbMM8A61Q5MgWz55u
 i+ntRqNM3TOWfg6YNOGPbmA=
X-Google-Smtp-Source: ABdhPJzSGaeiTV95ALIeqhxiFZIXImmqlDxjOJgicy+7MSU/RJl5kLkVLNVYAuga4SOj/3Nh1P5u+w==
X-Received: by 2002:a05:600c:4788:: with SMTP id
 k8mr3566195wmo.131.1632046781415; 
 Sun, 19 Sep 2021 03:19:41 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id j7sm15252078wrr.27.2021.09.19.03.19.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Sep 2021 03:19:41 -0700 (PDT)
Subject: Re: [PATCH] nvme/mpath: fix hang when disk goes live over reconnect
To: Anton Eidelman <anton.eidelman@gmail.com>,
 linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
References: <20210918215729.388968-1-anton@lightbitslabs.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b6dd0d15-041e-209e-953c-1b991c0738c9@grimberg.me>
Date: Sun, 19 Sep 2021 13:19:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210918215729.388968-1-anton@lightbitslabs.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210919_031942_961915_82C1EB60 
X-CRM114-Status: GOOD (  29.16  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 9/19/21 12:57 AM, Anton Eidelman wrote:
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
> IO to the namespace through the ctrl, which does NOT have IO queues yet.
> See sample hang below.
> 
> Solution:
> - move nvme_read_ana_log() call from nvme_mpath_init_identify()
> into a separate function, nvme_mpath_update().
> - call this function in nvme_start_ctrl() - here the ctrl is ready.
> 
> Downside: in case nvme_read_ana_log() fails, we do not find this out
>    in nvme_mpath_init_identify().
> 
> Alernative solution:
>    nvme_get_log() in nvme_mpath_init_identify(), but don't parse.
>    Then nvme_start_ctrl() can just queue_work(nvme_wq, &ctrl->ana_work),
>    along with scan_work.
>    The ctrl->ana_log_buf contents is valid for scan_work,
>    and ana_work will re-fetch and parse it.
>    Downside: fetching an ANA log from the ctrl twice.
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
>   drivers/nvme/host/core.c      | 1 +
>   drivers/nvme/host/multipath.c | 9 ++++++---
>   drivers/nvme/host/nvme.h      | 4 ++++
>   3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 97f8211cf92c..884ca1f6f80b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4325,6 +4325,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>   	nvme_enable_aen(ctrl);
>   
>   	if (ctrl->queue_count > 1) {
> +		nvme_mpath_update(ctrl);

Does this ordering now becomes subtle as it needs to run before we queue 
the ns scan?

>   		nvme_queue_scan(ctrl);
>   		nvme_start_queues(ctrl);
>   	}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
