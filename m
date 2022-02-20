Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1293BC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Feb 2022 13:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vOTkxu0gV+CZ2HawZ0ycfOq+l7ehH0FwgtGOj1NnFPc=; b=odHOFYFr6NfE5qepO+DWs0V7Ae
	xbuAl/Fb2IOURdhMbrenSeppF5I3ovVOnY59JDkmnfrAqG8NO5PC560pz7EvBZwDmGo4I6WpH8/EJ
	pm1tgFOnzP8QIogiTi/oloXC2v33cfTPa1pX0qEE1kPfoIVpGrw5WhEIjRrA1wsi7QF13g+i/oCXT
	F9FpLkINhX5AQrT5oY2XEZGK9yeUfOCIO5Q2uo9Aoxk1u0gkDf37hPDDhzxHuYM6xlvnJ9NqIOcQX
	ar4fmHCjMtlDJdVDsBl+BOFc367CJdiocBT7HWsdIOHgUB97OzzbK+xezUuoiiG7RwdFgsrdJjRBi
	dP1rykAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nLlol-001N2O-DC; Sun, 20 Feb 2022 12:59:59 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nLloi-001N1a-EP
 for linux-nvme@lists.infradead.org; Sun, 20 Feb 2022 12:59:57 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 bg21-20020a05600c3c9500b0035283e7a012so9553089wmb.0
 for <linux-nvme@lists.infradead.org>; Sun, 20 Feb 2022 04:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=vOTkxu0gV+CZ2HawZ0ycfOq+l7ehH0FwgtGOj1NnFPc=;
 b=sjT3ba79mlX3MHxHelsoZ0E2EjogJQctNWM9SUx4KbDI6CupadNYraWfaEmRafODzK
 zTDlY9hf81CaKF6/MvH6FTD3SkYxaF31Ufdtmte6+8xWHpSFi1dpBnMUm585wM+HtA0+
 O/85Awb8XSFjS9Zn3Q98yX3MP3+iwV/2P4W8FHgJNacS5Y2b9Cb2bEjS61ciZeNn+TNe
 ClpBDhdXCKD96ryPhKRcFfgwi0I8ie1HPDOb4eOAehrRKcIeiPFQI3h1luHPdjtpOi/O
 00bNj1ydmHp5opOzmr9KwQtBKVbyozkaN4Ai8rCV3BT3VWisyNLcDHAQd7uYsaFCmDHo
 9kLg==
X-Gm-Message-State: AOAM5327tKdExDE5XAA35Lrdn3Oj258FCYp2m9s0c7WoQjuQlaLWYFEc
 DCogJo6TRpaU9PgqF2F5aR8=
X-Google-Smtp-Source: ABdhPJzbTisc7kPYpRzmtNuvkK2e/RypY55/7A41zd9AktjdiT/iPDZKqrU4IGtixvsa5QDzodXZ2A==
X-Received: by 2002:a05:600c:35cd:b0:34d:4e6:2834 with SMTP id
 r13-20020a05600c35cd00b0034d04e62834mr14397402wmq.25.1645361994850; 
 Sun, 20 Feb 2022 04:59:54 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 r11-20020a05600c2c4b00b0037c0522c727sm4608760wmg.21.2022.02.20.04.59.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Feb 2022 04:59:54 -0800 (PST)
Message-ID: <9e0c81a2-e39e-c0b5-dd85-268037cd8c67@grimberg.me>
Date: Sun, 20 Feb 2022 14:59:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Warning: hit due WQ_MEM_RECLAIM for ib_addr work queue
Content-Language: en-US
To: Gopal Tiwari <gopalkrishna.tiwari@gmail.com>,
 linux-nvme@lists.infradead.org
Cc: gtiwari@redhat.com
References: <20220211081308.256810-1-gopalkrishna.tiwari@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220211081308.256810-1-gopalkrishna.tiwari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220220_045956_560413_858D9A72 
X-CRM114-Status: GOOD (  15.06  )
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


> Hi Team,
> 
> We have following warning
> 
>   13:25:49  kernel: workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_rdma_reconnect_ctrl_work [nvme_rdma] is flushing !WQ_MEM_RECLAIM ib_addr:process_one_req [ib_core]
>   13:25:49  kernel: WARNING: CPU: 7 PID: 1067276 at kernel/workqueue.c:2620 check_flush_dependency+0x110/0x130
>   13:25:49  kernel: CPU: 7 PID: 1067276 Comm: kworker/u65:3 Kdump: loaded Not tainted 4.18.0-348.9.1.el8_5.test.x86_64 #1
>   13:25:49  kernel: Workqueue: nvme-wq nvme_rdma_reconnect_ctrl_work [nvme_rdma]
>   13:25:49  kernel: RIP: 0010:check_flush_dependency+0x110/0x130
>   13:25:49  kernel: Code: ff ff 48 8b 50 18 48 8d 8b b0 00 00 00 49 89 e8 48 81 c6 b0 00 00 00 48 c7 c7 50 b6 8c 82 c6 05 d3 1e 6d 01 01 e8 09 40 fe ff <0f> 0b e9 0a ff ff ff 80 3d c1 1e 6d 01 00 75 95 e9 41 ff ff ff 66
>   13:25:49  kernel: RSP: 0018:ffffa9e4072b3c70 EFLAGS: 00010082
>   13:25:49  kernel: RAX: 0000000000000000 RBX: ffff8c87c5136800 RCX: 0000000000000000
>   13:25:49  kernel: RDX: 0000000000000001 RSI: ffffffff836dffa9 RDI: 0000000000000046
>   13:25:49  kernel: RBP: ffffffffc06fc380 R08: ffffffff836dff20 R09: 0000000000029a00
>   13:25:49  kernel: R10: 0002ee301d21f585 R11: 000000000010490c R12: ffff8c844c5b4740
>   13:25:49  kernel: R13: ffff8c87c3d9bb00 R14: 0000000000000001 R15: ffff8c84538da178
>   13:25:49  kernel: FS:  0000000000000000(0000) GS:ffff8c87af1c0000(0000) knlGS:0000000000000000
>   13:25:49  kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   13:25:49  kernel: CR2: 00007f8e63a4f000 CR3: 0000000160b3c000 CR4: 0000000000350ee0
>   13:25:49  kernel: Call Trace:
>   13:25:49  kernel: flush_work+0x8b/0x1c0
>   13:25:49  kernel: ? lock_timer_base+0x67/0x80
>   13:25:49  kernel: ? try_to_del_timer_sync+0x4d/0x80
>   13:25:49  kernel: ? work_busy+0x80/0x80
>   13:25:49  kernel: __cancel_work_timer+0x105/0x190
>   13:25:49  kernel: rdma_addr_cancel+0xa3/0xc0 [ib_core]
>   13:25:49  kernel: _destroy_id+0x17/0x240 [rdma_cm]
>   13:25:49  kernel: nvme_rdma_alloc_queue+0x193/0x200 [nvme_rdma]
>   13:25:49  kernel: nvme_rdma_setup_ctrl+0x34/0xa70 [nvme_rdma]
>   13:25:49  kernel: ? __switch_to_asm+0x41/0x70
>   13:25:49  kernel: ? __switch_to+0x10c/0x470
>   13:25:49  kernel: ? finish_task_switch+0xaa/0x2e0
>   13:25:49  kernel: nvme_rdma_reconnect_ctrl_work+0x22/0x70 [nvme_rdma]
>   13:25:49  kernel: process_one_work+0x1a7/0x360
>   13:25:49  kernel: ? create_worker+0x1a0/0x1a0
>   13:25:49  kernel: worker_thread+0x30/0x390
>   13:25:49  kernel: ? create_worker+0x1a0/0x1a0
>   13:25:49  kernel: kthread+0x116/0x130
>   13:25:49  kernel: ? kthread_flush_work_fn+0x10/0x10
>   13:25:49  kernel: ret_from_fork+0x22/0x40
>   
>   Seems like in IB code path for WQ ib_core WQ_MEM_RECLAIM removed with 39baf10310e6.  As per the description of the patch
> 
>      "The ib_addr workqueue is not memory reclaim path due to its
>      nature of invoking callback that might allocate memory or don't free any
>      memory under memory pressure."
>   
>   I see other patch when hits similar warnings related to flag WQ_MEM_RECLAIM
>   
> commit 659e3c71d106b0dd4ce6520e4dcd6e
> Author: Jack Wang <jinpu.wang@cloud.ionos.com>
> Date:   Fri Jul 24 16:45:08 2020 +0530
> 
>      RDMA/rtrs: remove WQ_MEM_RECLAIM for rtrs_wq
>      
> Do you think nvme-core should also do the same to stop this warning ?. Let me know if you agree with removing the flag I can send a patch
> or any other suggestion to avoid the warning would be helpful.

The wq that hosts reconnect/reset work does allocate memory though.

