Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9AAC46467
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jan 2023 11:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mPRx9tVYn2kbnOeFvJNkhEjPmye4jgeCzqnGgv4X+CM=; b=JT3AwOdxOWhCOjmjTChCH/xcJI
	gTt1xz+Tshenye5H76FPKx0+pFINQ5VJXIqYEKbmPuHSldW5XIAIM9dRnM1b1KPH2GIfys5wCaleC
	kW4hb8iDj4YoRgF30nrmbJTxT6wqCrpwvYdn/UZmzdWZcAe++p7CVNmgQqahHLjQzghaA1SkAzM1c
	XE3vJViwN2xVXo0atBh89mwYDdlmWEDVRPXg9zQWF/CPnW6NAIbfdIE3ULGtC7AR+K4vV2h+cHoNs
	uivv20Nwax9g6+hzqmMO4M0025Jmc8yCEEBREYQCKiJFazavnXoQdSw8UDNJYeDnd5q2iD21OQyJZ
	CkF0LWzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCfEK-000vRG-9q; Tue, 03 Jan 2023 11:13:16 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCeZG-000iwC-CA
	for linux-nvme@lists.infradead.org; Tue, 03 Jan 2023 10:30:54 +0000
Received: by mail-wm1-f53.google.com with SMTP id g25-20020a7bc4d9000000b003d97c8d4941so17192757wmk.4
        for <linux-nvme@lists.infradead.org>; Tue, 03 Jan 2023 02:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPRx9tVYn2kbnOeFvJNkhEjPmye4jgeCzqnGgv4X+CM=;
        b=JvapBp0zVDRxZgrJYoU3OF99t9sTMGxKdx9w+NEuzVUB1hjLbDXFQuOE34nLszNi9/
         KVzpPMt9se+IItHtQZGqXulbbvlmbkYdyjca5zel7V+ose/4cW37dcMbztLqKui2GxvK
         o0dMUIJRKK6w/ALC9JAaX9w7sIeTz6pwMUvzEyWb3s35NaVIHXNbkyrM90WeJ32rOJLw
         J/sl7vvJ32HYSmAOLxmjiOCN/r3YLGIyp6SOKWVzSq4wJXGVBz0bF7JEOyBI9xX/Yv16
         mWZLB56Cq1rHUl8nkLz9R0YrVMPweNZcOnC7a58K9cwjLwzF27yG0qSbnsYwGUn1zfKF
         i7sg==
X-Gm-Message-State: AFqh2kq/zP5BCeZvvpABRw19kuqhtL7h/jDqeNagFRbbKCHT9PAHug1i
	h2l7tjue06kMrn0poJDDqZY=
X-Google-Smtp-Source: AMrXdXux6NKKE7GSsnVkUmtL+t/YdUUPxvTj3paeKCNxp9g50/501h0i4EIb2p9rCx7JTDgQCGEgmQ==
X-Received: by 2002:a05:600c:510b:b0:3d2:392e:905f with SMTP id o11-20020a05600c510b00b003d2392e905fmr31471084wms.24.1672741847716;
        Tue, 03 Jan 2023 02:30:47 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c024600b003cfd0bd8c0asm40282865wmj.30.2023.01.03.02.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 02:30:47 -0800 (PST)
Message-ID: <b6b16a5a-d592-eb12-ea30-1535b80d60dc@grimberg.me>
Date: Tue, 3 Jan 2023 12:30:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/4] nvme: fix delete uninitialized controller
Content-Language: en-US
To: Taehee Yoo <ap420073@gmail.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, axboe@fb.com, hch@lst.de, kch@nvidia.com
Cc: james.p.freyensee@intel.com, ming.l@ssi.samsung.com,
 larrystevenwise@gmail.com, anthony.j.knapp@intel.com, pizhenwei@bytedance.com
References: <20230103100357.875854-1-ap420073@gmail.com>
 <20230103100357.875854-2-ap420073@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230103100357.875854-2-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_023050_572384_54FB3BAB 
X-CRM114-Status: GOOD (  24.13  )
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

> nvme-fabric controllers can be deleted by
> /sys/class/nvme/nvme<NS>/delete_controller
> echo 1 > /sys/class/nvme/nvme<NS>/delete_controller
> The above command will call nvme_delete_ctrl_sync().
> This function internally tries to change ctrl->state to NVME_CTRL_DELETING.
> NVME_CTRL_LIVE, NVME_CTRL_RESETTING, and NVME_CTRL_CONNECTING states can
> be changed to NVME_CTRL_DELETING.
> If the state is successfully changed, nvme_do_delete_ctrl() is called,
> which is the actual delete logic of controller.
> 
> controller initialization logic changes ctrl->state.
> NEW -> CONNECTING -> LIVE.
> NVME_CTRL_CONNECTING state doesn't ensure that initialization is done.
> 
> So, delete logic can be called before the finish of controller
> initialization.
> So kernel panic would occur because nvme_do_delete_ctrl() dereferences
> uninitialized values.
> 
> BUG: KASAN: null-ptr-deref in do_raw_spin_trylock+0x67/0x180
> Read of size 4 at addr 00000000000000c0 by task bash/928
> 
> CPU: 7 PID: 928 Comm: bash Not tainted 6.1.0 #35
> nvme nvme0: Connect command failed: host path error
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x57/0x81
>   ? do_raw_spin_trylock+0x67/0x180
>   kasan_report+0xba/0x1f0
> nvme nvme0: failed to connect queue: 0 ret=880
>   ? do_raw_spin_trylock+0x67/0x180
>   ? sysfs_file_ops+0x170/0x170
>   kasan_check_range+0x14a/0x1a0
>   do_raw_spin_trylock+0x67/0x180
>   ? do_raw_spin_lock+0x270/0x270
>   ? nvme_remove_namespaces+0x1bc/0x3d0
>   _raw_spin_lock_irqsave+0x4b/0x90
>   ? blk_mq_quiesce_queue+0x1b/0x160
>   blk_mq_quiesce_queue+0x1b/0x160
>   nvme_tcp_delete_ctrl+0x4b/0x70
>   nvme_do_delete_ctrl+0x135/0x141
>   nvme_sysfs_delete.cold+0x8/0xd
>   kernfs_fop_write_iter+0x34b/0x520
>   vfs_write+0x83a/0xd20
>   ? kernel_write+0x630/0x630
>   ? rcu_read_lock_sched_held+0x12/0x80
>   ? lock_acquire+0x4f4/0x630
>   ? __fget_light+0x51/0x230
>   ksys_write+0xf9/0x1d0
>   ? __ia32_sys_read+0xa0/0xa0
>   ? syscall_enter_from_user_mode+0x1d/0x50
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fc955d10104
> 
> Fixes: 1a353d85b02d ("nvme: add fabrics sysfs attributes")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>   drivers/nvme/host/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d307ae4d8a57..cd4c80ca66d4 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -243,7 +243,8 @@ static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
>   	 * since ->delete_ctrl can free the controller.
>   	 */
>   	nvme_get_ctrl(ctrl);
> -	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
> +	if (test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags) &&
> +	    nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
>   		nvme_do_delete_ctrl(ctrl);

So what is the outcome now? if the controller kept on dangling? what
triggers the controller deletion?

>   	nvme_put_ctrl(ctrl);
>   }

I don't think this is the correct approach.
the delete should fully fence the initialization and then delete
the controller.

In this case, the transport driver should not quiesce a non-existent
queue.

If further synchronization is needed, then it should be added so that
delete will fully fence the initialization.

