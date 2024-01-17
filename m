Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623CBC47DA9
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 14:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7/tSjeLHwcNNY1qIrnbAwCawBMgNGPX58hQ4TkI4XNU=; b=DX9LRn2x98xAojVQUgY5d9SYmn
	PNzu9aFoyqEfai+XsbTUiHY5n0u7GsoSBxyGPLe++VbAIx9D9+s+FFZNc/9lrcwGWSuh7BQNgDfBV
	WtGxvZf24cOILyhlhmjovPJVPqQDyjsnciYKBbcN/uxxAWCUc6dcGGUxF2xjJzmGe9c6dhOo32EiU
	UIbaTLwGenvq4u3zHkY4EDoHzxnECxUJt2NmHAdwxfmO4FCaDunkFQnwIDiN4ibH9OTyrC7cFBLMM
	NuzA9Qz2nPVhdVh75Bxs3dJxqE+hZVUOFOOvzNCK8tuapCEjx2dZnC4xPuLhFvNEg2GcIkTCtaiG5
	jfGyyCpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ6Wm-00Gqyc-1u;
	Wed, 17 Jan 2024 14:04:24 +0000
Received: from mail-oi1-f172.google.com ([209.85.167.172])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ6Wk-00GquX-0h
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 14:04:23 +0000
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bd99b05ca8so472b6e.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 06:04:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705500257; x=1706105057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/tSjeLHwcNNY1qIrnbAwCawBMgNGPX58hQ4TkI4XNU=;
        b=IJIb7db1uZvhNY/KSn2bkff5TUdqZ8PZt0BiFyc32/7qORgMLR6+gCgjHwcoYkbKD9
         Ss3m39fpgDYXOELhAO7UoqwOxGwfg0dIzKkiSlxyNgerkNrJCzIRGpd7iJmo/vux5S06
         uc5XQn/Oh7qnm4VQFD2N431NncvAMXoxerr29aGiIpvxl235pEJXa9KIHpIcP2NQetxo
         ty5ixHLCcWRfeH2cr8p69xEyGbN3M5ixRNEXjIrL+y0NadZ4qhD95gB1PXGW/VsTT9In
         K3145REUYMJqx531luUbz5tkR6vbKw32A5zTwCoL8Uo4zubm79R2qwVz1B7wzwRHHHHM
         73KA==
X-Gm-Message-State: AOJu0Yx+Ltaic9gwfFUxbgNwOj6qMGqtqIQK0ATO0jcoNE8mJ2kPFD9q
	fXAEVSLW9Zggdks4dS+Ts9o=
X-Google-Smtp-Source: AGHT+IESwHVgixBmlf9Abx2wRLMf7HL7e5pF8TVqXlGhE4J+mSylzs+bSAC6iVltbBu4A7zpOCrbmA==
X-Received: by 2002:a05:6870:fb88:b0:210:9e85:edc6 with SMTP id kv8-20020a056870fb8800b002109e85edc6mr1769721oab.5.1705500257045;
        Wed, 17 Jan 2024 06:04:17 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id pa25-20020a0568701d1900b002069e3bcbb5sm3537404oab.18.2024.01.17.06.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 06:04:16 -0800 (PST)
Message-ID: <b926d754-130d-424e-b099-001e14badc50@grimberg.me>
Date: Wed, 17 Jan 2024 16:04:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix bogus request queue reference put
Content-Language: en-US
To: mengfanhui <mengfanhui@kylinos.cn>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240117065043.79192-1-mengfanhui@kylinos.cn>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240117065043.79192-1-mengfanhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_060422_261047_F835C220 
X-CRM114-Status: GOOD (  21.28  )
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



On 1/17/24 08:50, mengfanhui wrote:
> From: Sagi Grimberg <sagi@grimberg.me>
> 
> The mpath disk node takes a reference on the request mpath
> request queue when adding live path to the mpath gendisk.
> However if we connected to an inaccessible path device_add_disk
> is not called, so if we disconnect and remove the mpath gendisk
> we endup putting an reference on the request queue that was
> never taken [1].
> 
> Fix that to check if we ever added a live path (using
> NVME_NS_HEAD_HAS_DISK flag) and if not, clear the disk->queue
> reference.
> 
> [1]:
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 1 PID: 1372 at lib/refcount.c:28 refcount_warn_saturate+0xa6/0xf0
> CPU: 1 PID: 1372 Comm: nvme Tainted: G           O      5.7.0-rc2+ #3
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1 04/01/2014
> RIP: 0010:refcount_warn_saturate+0xa6/0xf0
> RSP: 0018:ffffb29e8053bdc0 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff8b7a2f4fc060 RCX: 0000000000000007
> RDX: 0000000000000007 RSI: 0000000000000092 RDI: ffff8b7a3ec99980
> RBP: ffff8b7a2f4fc000 R08: 00000000000002e1 R09: 0000000000000004
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: fffffffffffffff2 R14: ffffb29e8053bf08 R15: ffff8b7a320e2da0
> FS:  00007f135d4ca800(0000) GS:ffff8b7a3ec80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005651178c0c30 CR3: 000000003b650005 CR4: 0000000000360ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   disk_release+0xa2/0xc0
>   device_release+0x28/0x80
>   kobject_put+0xa5/0x1b0
>   nvme_put_ns_head+0x26/0x70 [nvme_core]
>   nvme_put_ns+0x30/0x60 [nvme_core]
>   nvme_remove_namespaces+0x9b/0xe0 [nvme_core]
>   nvme_do_delete_ctrl+0x43/0x5c [nvme_core]
>   nvme_sysfs_delete.cold+0x8/0xd [nvme_core]
>   kernfs_fop_write+0xc1/0x1a0
>   vfs_write+0xb6/0x1a0
>   ksys_write+0x5f/0xe0
>   do_syscall_64+0x52/0x1a0
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: mengfanhui <mengfanhui@kylinos.cn>
> ---
>   drivers/nvme/host/multipath.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 2dd4137a08b2..3e579e49579c 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -895,6 +895,14 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
>   	/* make sure all pending bios are cleaned up */
>   	kblockd_schedule_work(&head->requeue_work);
>   	flush_work(&head->requeue_work);
> +	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
> +		/*
> +		* if device_add_disk wasn't called, prevent
> +                * disk release to put a bogus reference on the
> +                * request queue
> +                */
> +		head->disk->queue = NULL;
> +	}
>   	put_disk(head->disk);
>   }
>   

How did you see this? disk->queue is allocated in blk_alloc_disk called
in nvme_mpath_alloc_disk... I don't understand how you saw the same
dereference that was addressed by this commit.

