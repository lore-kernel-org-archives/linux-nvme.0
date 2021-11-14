Return-Path: <SRS0=Lvqr=QB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB68C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 10:57:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F24660ED5
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 10:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F24660ED5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DHBHPUiE4ye1HVisi2vFkUMhKTwIb4OH21532yvmNpg=; b=rOF4QKGRrcB/pHhpqAByBFjjmb
	nIbL9Lq/CvpMwWKnmhCzYpu3qvTcjJB/KQnrUR3d/WO76VjtLFA4+9rofVC96ilWhn2E9dOCFZv/5
	NuwAnH14klf45WXiS7aKpDoiWcR/pnkUGzG8EShju33vZYRbBCEaEcmRpkgaWHtjbsZJEQJEm1HwV
	t+3FC15xa69L5d7qjx8T6Hsxvki7UjNNrgVW6s7bMe0ZP8HBQg96UVFkoyBorDSc3EieJMAyHgPmz
	EiqluKdcjdLvSmPwmd8/ZPD4rnrKJkeor1yhCPBBdZNO1uYtI0fPqzDYf8M8mILRiS5Y0wkCMdOZz
	54bcMcXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmDC1-00DYdh-Tx; Sun, 14 Nov 2021 10:57:01 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmDBy-00DYdG-GF
 for linux-nvme@lists.infradead.org; Sun, 14 Nov 2021 10:56:59 +0000
Received: by mail-wr1-f50.google.com with SMTP id d27so24431310wrb.6
 for <linux-nvme@lists.infradead.org>; Sun, 14 Nov 2021 02:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DHBHPUiE4ye1HVisi2vFkUMhKTwIb4OH21532yvmNpg=;
 b=zLAY8YErmLd1DBTOXzSGUDMLLWsHjiUF0NDSGH8ywoTe1T+djhIyfeT6ZbBtIEdUHr
 PDrt8davt7B/cPj/aDuqpoZqcoFCBC2dY5698ahXhQtoCrvz3A1BVHg9CZ7JJc1dvjSt
 upMIGLfE520E19l3PV4y1v1z5L5yJpnK+6I8xyraGdNIjvhWLSQy+GUTSl2vDEyOVSZV
 A8/2cj49sMWw4YkWrVkcOpLIBxZEMe2oL/7HFHbeu9yFWUs6XC6YAeW32GFCcibdcbLC
 cxj2a/cnvYxau+9csqT+YF3gIip8SIn8+qXaQk6wswuk2uaFZ12xR1aywRBNAvAoPFTG
 f9Iw==
X-Gm-Message-State: AOAM533vy8SVstbXehCLKJzVogaF0rih/iHa3ce2ikqW7nJR6XQv45AQ
 vPmz4r3dPuwpASN4XD5TboD7c37toYs=
X-Google-Smtp-Source: ABdhPJxZ25KndkvIjeCds8YeURkMZkVkKMNK5sGB7en1qTB2GJZO34IRL6Bn1XmuCHugeCrLzDasIw==
X-Received: by 2002:a5d:6d01:: with SMTP id e1mr37798247wrq.157.1636887416843; 
 Sun, 14 Nov 2021 02:56:56 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h3sm10645388wrv.69.2021.11.14.02.56.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Nov 2021 02:56:56 -0800 (PST)
Subject: Re: [PATCH] nvme: Add sibling to list after full initialization
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
References: <20211111130603.16547-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bf2ad20e-5c79-54a1-05e9-057f36901990@grimberg.me>
Date: Sun, 14 Nov 2021 12:56:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211111130603.16547-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211114_025658_603519_8C01EDFF 
X-CRM114-Status: GOOD (  26.34  )
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

> Adding the newly created namespace before the object is fully
> initialized is opening a race with nvme_mpath_revalidate_paths() which
> tries to access ns->disk. ns->disk can still be NULL when iterating
> over the sibling list.

But ns->disk is assigned before nvme_init_ns_head is even called.
Maybe you mean that ns->head is NULL?

Where you would just need this?
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8642cf2160c4..19f7cde5bbc6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3878,8 +3878,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, 
unsigned nsid,
                 }
         }

-       list_add_tail_rcu(&ns->siblings, &head->list);
         ns->head = head;
+       list_add_tail_rcu(&ns->siblings, &head->list);
         mutex_unlock(&ctrl->subsys->lock);
         return 0;
--

> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
> I got a few bug reports from our customer hitting this
> quite often:
> 
>   RIP: 0010:nvme_mpath_revalidate_paths+0x27/0xb0 [nvme_core]
>   Code: 44 00 00 0f 1f 44 00 00 55 53 48 8b 6f 50 48 8b 55 00 48 8b 85 10 c5 00 00 48 39 d5 48 8b 48 40 74 20 48 8d 42 d0 48 8b 50 20 <48> 3b 4a 40 74 05 f0 80 60 78 ef 48 8b 50 30 48 39 d5 48 8d 42 d0
>   RSP: 0018:ffffaf1303fffcc0 EFLAGS: 00010283
>   RAX: ffff95f75ef5c400 RBX: ffff95f71f63aa00 RCX: 0000000000200000
>   RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff95f71f63aa00
>   RBP: ffff95f71b1d0000 R08: 0000000800000000 R09: 00000008ffffffff
>   R10: 00000000000007be R11: 0000000000000384 R12: 0000000000000000
>   R13: ffff95f71b1d0000 R14: ffff95f721d79338 R15: ffff95f71f63aa00
>   FS:  0000000000000000(0000) GS:ffff95f77f9c0000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000040 CR3: 000000033940a005 CR4: 00000000003706e0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   Call Trace:
>    nvme_update_ns_info+0x15b/0x2f0 [nvme_core]
>    nvme_alloc_ns+0x27f/0x810 [nvme_core]
>    nvme_validate_or_alloc_ns+0xbb/0x190 [nvme_core]
>    nvme_scan_work+0x155/0x2d0 [nvme_core]
>    process_one_work+0x1f4/0x3e0
>    worker_thread+0x24c/0x3e0
>    ? process_one_work+0x3e0/0x3e0
>    kthread+0x10d/0x130
>    ? kthread_park+0xa0/0xa0
>    ret_from_fork+0x35/0x40
> 
> This patch fixes the problem reported. I am not totally sure why this
> suddenly happens but I guess it is related to 041bd1a1fc73 ("nvme:
> only call synchronize_srcu when clearing current path").
> 
>   drivers/nvme/host/core.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9a2610e147ce..84f52e6c1a02 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3776,7 +3776,6 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
>   		}
>   	}
>   
> -	list_add_tail_rcu(&ns->siblings, &head->list);
>   	ns->head = head;
>   	mutex_unlock(&ctrl->subsys->lock);
>   	return 0;
> @@ -3873,6 +3872,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>   	if (nvme_update_ns_info(ns, id))
>   		goto out_unlink_ns;
>   
> +	mutex_lock(&ctrl->subsys->lock);
> +	list_add_tail(&ns->siblings, &ns->head->list);
> +	mutex_unlock(&ctrl->subsys->lock);

What is the subsys->lock protecting here? I don't see
nvme_mpath_revalidate_paths acquiring it.

