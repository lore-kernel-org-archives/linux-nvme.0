Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A292EC74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 11:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tlYdf0oD3XbnROhVpvr7ozRGQ51z4vIH01wpFVje8Fw=; b=u2W+uuuFJCA/SkSdIuFVUiypv4
	6NMf20kdbwivwk5Q+pgfQgLmWLhDsAZ152TTbSIu3pOYRPHzFDCiIGW9rQCpjpTeZYzKJM83wecxs
	JqtXlcoGlCxNZnEq6WXnFuuSEEYvq6YQEJveKu++tcFtONSllKqvUMFyof/vNFwviyoPiZvN6Wka+
	Az3cQqoBSxqU8F4V+mZ2nURVIeDqCJBg5erLO7I7unRQCsRskcdM3qHTmOAUbRH7todRMCxvWGko9
	ExQo1NPZc5l3aeGgWaS7AKCGr9OtM/NhY9lOKnfWaGLGTLnXJBcVuyicFpOMNid8E04qt/ssaQa6u
	Xcj4adIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peZra-00C8lU-1J;
	Tue, 21 Mar 2023 11:09:10 +0000
Received: from mail-ed1-f51.google.com ([209.85.208.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peZrX-00C8jv-1G
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 11:09:08 +0000
Received: by mail-ed1-f51.google.com with SMTP id ek18so58086779edb.6
        for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 04:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679396945; x=1681988945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlYdf0oD3XbnROhVpvr7ozRGQ51z4vIH01wpFVje8Fw=;
        b=Yd+VgTrF2W2T81I9v8XUVaqeIuw2dEBvJADchayw9rkENhL/kK3JQhM2urmogRkWtH
         BM96BPJ1qWeY6wPw+iUTAOiHPS5DXFp5QA4BT2Kg3a4yk5vDIa1/qLNUykujR3p5oSgO
         4lieZyNhco2kVRymxhpIW+UfH8gBwvw7/yZnhOPQCq2l/XYNEtMFtkS3HqNP9w4YMm09
         PJSkeql508SEeqIOv/qMHCDcTDRKFWYoG2ussYxXW4D/XMN5TqEKi6YGvj8/YMhLD+E3
         nJQRzeAIEm8nqyPDWZj3RULYXL4TK8S4WQLl6o3KGTyIwr3EcQqSm7oCOoXIEDJQYalt
         d2zQ==
X-Gm-Message-State: AO0yUKXuN+NVbIuV3/ImEzHGHXOmouhVjjs1nb6tJ/UZngNcQiPE62vK
	efZko19JcctWx+cVn67Zb+o=
X-Google-Smtp-Source: AK7set/CxBC4yLKLhwTkyBrObkrJISMBfOB5Z0rmXNYxYxS8N0ZsX2h7kjFH6O7YzJLG5Q14GN5ADA==
X-Received: by 2002:a17:906:7485:b0:933:37f4:2ff4 with SMTP id e5-20020a170906748500b0093337f42ff4mr1837408ejl.0.1679396945118;
        Tue, 21 Mar 2023 04:09:05 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906318b00b008d606b1bbb1sm5624160ejy.9.2023.03.21.04.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 04:09:04 -0700 (PDT)
Message-ID: <042385ef-285e-5179-941b-ab37f490c1d8@grimberg.me>
Date: Tue, 21 Mar 2023 13:09:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] nvme: fix heap-use-after-free and oops in bio_endio for
 nvme multipath
Content-Language: en-US
To: Lei Lei2 Yin <yinlei2@lenovo.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "cybeyond@foxmail.com" <cybeyond@foxmail.com>
References: <PS1PR03MB493948DD1ECFAF150EE7B2F688819@PS1PR03MB4939.apcprd03.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <PS1PR03MB493948DD1ECFAF150EE7B2F688819@PS1PR03MB4939.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_040907_458551_DB98922F 
X-CRM114-Status: GOOD (  25.33  )
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



On 3/21/23 12:50, Lei Lei2 Yin wrote:
>  From b134e7930b50679ce48e5522ddd37672b1802340 Mon Sep 17 00:00:00 2001
> From: Lei Yin <yinlei2@lenovo.com>
> Date: Tue, 21 Mar 2023 16:09:08 +0800
> Subject: [PATCH] nvme: fix heap-use-after-free and oops in bio_endio for nvme
>   multipath
> 
> When blk_queue_split works in nvme_ns_head_submit_bio, input bio will be
> splited to two bios. If parent bio is completed first, and the bi_disk
> in parent bio is kfreed by nvme_free_ns, child will access this freed
> bi_disk in bio_endio. This will trigger heap-use-after-free or null
> pointer oops.

Can you explain further? It is unclear to me how we can delete the ns
gendisk

> 
> The following is kasan report:
> 
> BUG: KASAN: use-after-free in bio_endio+0x477/0x500
> Read of size 8 at addr ffff888106f2e3a8 by task kworker/1:1H/241
> 
> CPU: 1 PID: 241 Comm: kworker/1:1H Kdump: loaded Tainted: G           O
>        5.10.167 #1
> Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> Workqueue: kblockd nvme_requeue_work [nvme_core]
> Call Trace:
>   dump_stack+0x92/0xc4
>   ? bio_endio+0x477/0x500
>   print_address_description.constprop.7+0x1e/0x230
>   ? record_print_text.cold.40+0x11/0x11
>   ? _raw_spin_trylock_bh+0x120/0x120
>   ? blk_throtl_bio+0x225/0x3050
>   ? bio_endio+0x477/0x500
>   ? bio_endio+0x477/0x500
>   kasan_report.cold.9+0x37/0x7c
>   ? bio_endio+0x477/0x500
>   bio_endio+0x477/0x500
>   nvme_ns_head_submit_bio+0x950/0x1130 [nvme_core]
>   ? nvme_find_path+0x7f0/0x7f0 [nvme_core]
>   ? __kasan_slab_free+0x11a/0x150
>   ? bio_endio+0x213/0x500
>   submit_bio_noacct+0x2a4/0xd10
>   ? _dev_info+0xcd/0xff
>   ? _dev_notice+0xff/0xff
>   ? blk_queue_enter+0x6c0/0x6c0
>   ? _raw_spin_lock_irq+0x81/0xd5
>   ? _raw_spin_lock+0xd0/0xd0
>   nvme_requeue_work+0x144/0x18c [nvme_core]
>   process_one_work+0x878/0x13e0
>   worker_thread+0x87/0xf70
>   ? __kthread_parkme+0x8f/0x100
>   ? process_one_work+0x13e0/0x13e0
>   kthread+0x30f/0x3d0
>   ? kthread_parkme+0x80/0x80
>   ret_from_fork+0x1f/0x30
> 
> Allocated by task 52:
>   kasan_save_stack+0x19/0x40
>   __kasan_kmalloc.constprop.11+0xc8/0xd0
>   __alloc_disk_node+0x5c/0x320
>   nvme_alloc_ns+0x6e9/0x1520 [nvme_core]
>   nvme_validate_or_alloc_ns+0x17c/0x370 [nvme_core]
>   nvme_scan_work+0x2d4/0x4d0 [nvme_core]
>   process_one_work+0x878/0x13e0
>   worker_thread+0x87/0xf70
>   kthread+0x30f/0x3d0
>   ret_from_fork+0x1f/0x30
> 
> Freed by task 54:
>   kasan_save_stack+0x19/0x40
>   kasan_set_track+0x1c/0x30
>   kasan_set_free_info+0x1b/0x30
>   __kasan_slab_free+0x108/0x150
>   kfree+0xa7/0x300
>   device_release+0x98/0x210
>   kobject_release+0x109/0x3a0
>   nvme_free_ns+0x15e/0x1f7 [nvme_core]
>   nvme_remove_namespaces+0x22f/0x390 [nvme_core]
>   nvme_do_delete_ctrl+0xac/0x106 [nvme_core]
>   process_one_work+0x878/0x13e0
>   worker_thread+0x87/0xf70
>   kthread+0x30f/0x3d0
>   ret_from_fork+0x1f/0x30
> 
> Signed-off-by: Lei Yin <yinlei2@lenovo.com>
> ---
>   drivers/nvme/host/nvme.h | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index c3e4d9b6f9c0..b441c5ce4157 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -749,8 +749,17 @@ static inline void nvme_trace_bio_complete(struct request *req,
>   {
>   	struct nvme_ns *ns = req->q->queuedata;
>   
> -	if ((req->cmd_flags & REQ_NVME_MPATH) && req->bio)
> +	if ((req->cmd_flags & REQ_NVME_MPATH) && req->bio) {
>   		trace_block_bio_complete(ns->head->disk->queue, req->bio);
> +
> +		/* Point bio->bi_disk to head disk.
> +		 * This bio maybe as other bio's parent in bio chain. If this bi_disk
> +		 * is kfreed by nvme_free_ns, other bio may get this bio by __bio_chain_endio
> +		 * in bio_endio, and access this bi_disk. This will trigger heap-use-after-free
> +		 * or null pointer oops.
> +		 */
> +		req->bio->bi_disk = ns->head->disk;
> +	}

This is absolutely the wrong place to do this. This is a tracing
function, it should not have any other logic.

What tree is this against anyways? There is no bi_disk in struct bio 
anymore.

