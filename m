Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD48CCFA0D
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 20:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cVkeDn5QqMcaxmYLdEAi6YbMaR2Ul130WYRsbFccHZg=; b=fhZOtBfqFLGDE2QTcr4f5JKRHw
	pFmGl59tZjfp4TfGpxhkiwdv1W/QaFrbSEa7o6A2iVrIHfhApkTj9KTHqPzJFZ8e6YBx+Jef/G5f/
	svI85lBY2ppOC0waNM4yTiLExIgFbOAul8mfMOlnQQz9ryKRDwWdHLMMR/GwIF3NnhtCYldpAJlrg
	cHJRmOzMOVbaVvNrhlsVIAPGrCavElNAGH6wBzMjImVhS7Mj7AnebRJCyqco5AszNLvnuR3UFKO/k
	RJd0l2wniQlI3c8KPT0ebIt03bVHzO+1Kptyb8sJlkmPM94apl/y2cfls8MY2AXVD/eVkMwTprHHg
	TfxeWcrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGk0b-0000000EMpR-2upx;
	Wed, 05 Nov 2025 20:21:33 +0000
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGk0V-0000000EMp2-0x7E
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 20:21:28 +0000
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-8b1c0dcb3b3so3140685a.2
        for <linux-nvme@lists.infradead.org>; Wed, 05 Nov 2025 12:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762374086; x=1762978886; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVkeDn5QqMcaxmYLdEAi6YbMaR2Ul130WYRsbFccHZg=;
        b=csnXX1dvl0GTyFJxyXKi3XoKOcu9/XGV1+KJ7Sh7Rq93f1m+8ePQIjj4UN8t5ohDhw
         SdvU3JsdVLoc7tHPY0SpjJR0M41qMlhxLTuZofosQQTlHGZQo0aG1uSTLjhDeH5qzVTt
         9QzlwNTXJGbtYmeJJJ13i1mFLhi58WS/BNTHWisNiaQaglJtEZx1KbWpDAg+bdrLOH3t
         vCJTleqO0pQbRwhLR2wvsfjUPWQKNpUJdUlNvqE/bdiyC4+om61hiSm3jVOt72uRUPwP
         8pmr+31/wx6BDu310pSilJ8mtaKcLi23ary3dECbXVr9f50ZwGwhQBOHKrUMdbPBYh8D
         zBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374086; x=1762978886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVkeDn5QqMcaxmYLdEAi6YbMaR2Ul130WYRsbFccHZg=;
        b=Lh3CCHt5xtyn2qWQXUKnlCymsnqSS6twmVz9JDIEWDithEpeBbmOCaARzWlUyBTPKt
         tMfs4bR5XDNdA4sZ5/jpRcZmokCQBEEvvQfPEePq5sd/F7B2L7Ztus9q9CRzMpBCWSCq
         yC/y/XNMjmcL7gu+R57reQPQ57kFglVIbF30l4gnTgTMudsHu9obuOI/35od1sRktCns
         4OrA55EJTXzVulGNL710ABsJTRy6p0bVFq//6I1talxxlg6RmYH2CujtYwIo9lIc3unc
         uzD15ygYoM2+809ygW/q8xSXv0KFxQhDp/mMMW7zNFBmm7UKKFi6X1ubVL22EPtobla6
         l82Q==
X-Gm-Message-State: AOJu0Yyw2JNcTfTV+ICfTgCHyywqHh/9Mr4EmBLT9qbXJfPIuzb1xTnn
	ienu7bG9HmMurl1I7KA3IL4aNgmyhGVtqLn/ESK62i/Bss8XDrOkOr2yF6+aKhPlSRurPVaC2iF
	b1C3WsRRowHNcMWorFO4O2TRacICLYaew/28kSRbAVg==
X-Gm-Gg: ASbGnctEGKGU4uOVfWyHHquu7i4DOmFJ9ZMYjeYoCyhInUZMDWYNGIKXxu7fh7h0A2I
	jfnIWJ7GzIccTB8b1dpSXMDqx2dAxS2nwy0Z08SolC/zSTyqI+7ueAFRVQeCQYq7hv6OMm70isW
	73makaA4veJsVIzvBh1hysoxQMwjHaMquPq6O02tdAvTOtShlUUOEHXgn2Rq/g+hljKc0Mdtrsg
	jyZckrG5/hbreBw578cHBR+sXb31AzAKuYJnNyLS0ET/a22KxTJEHsxOu0T
X-Google-Smtp-Source: AGHT+IF1GPX1s0/AWWbY96tq7K3+pvuvGQA8dDy2+I5QkOplAaH0VxVRfvBpcDczFCCH/nQOwUO1YVw+9UpmJuwor48=
X-Received: by 2002:a05:6214:e8f:b0:880:6fa4:f55c with SMTP id
 6a1803df08f44-8807119c620mr46888226d6.6.1762374085770; Wed, 05 Nov 2025
 12:21:25 -0800 (PST)
MIME-Version: 1.0
References: <20251104225939.3641605-1-kbusch@meta.com>
In-Reply-To: <20251104225939.3641605-1-kbusch@meta.com>
From: Casey Chen <cachen@purestorage.com>
Date: Wed, 5 Nov 2025 12:21:14 -0800
X-Gm-Features: AWmQ_bnRga5KCSJKHZAyrh5Sd8hb5gxvhlDpiAYaDAQBk4_z7RVI6FoDOuNAnJw
Message-ID: <CALCePG1FFQUWg2u-RhY4DQ9uVxd3uMuwSdvyU-r-ssm_dQjY=Q@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix admin request_queue lifetime
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, ming.lei@redhat.com, 
	chaitanyak@nvidia.com, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_122127_427005_ED9247A7 
X-CRM114-Status: GOOD (  21.45  )
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

On Tue, Nov 4, 2025 at 3:00=E2=80=AFPM Keith Busch <kbusch@meta.com> wrote:
>
> From: Keith Busch <kbusch@kernel.org>
>
> The namespaces can access the controller's admin request_queue, and
> stale references on the namespaces may exist. Ensure the request_queue
> is active by moving the controller's 'put' after all references on the
> controller have been released to ensure no one is trying to access the
> request_queue. This fixes a reported use-after-free bug:
>
>   BUG: KASAN: slab-use-after-free in blk_queue_enter+0x41c/0x4a0
>   Read of size 8 at addr ffff88c0a53819f8 by task nvme/3287
>   CPU: 67 UID: 0 PID: 3287 Comm: nvme Tainted: G            E       6.13.=
2-ga1582f1a031e #15
>   Tainted: [E]=3DUNSIGNED_MODULE
>   Hardware name: Jabil /EGS 2S MB1, BIOS 1.00 06/18/2025
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x4f/0x60
>    print_report+0xc4/0x620
>    ? _raw_spin_lock_irqsave+0x70/0xb0
>    ? _raw_read_unlock_irqrestore+0x30/0x30
>    ? blk_queue_enter+0x41c/0x4a0
>    kasan_report+0xab/0xe0
>    ? blk_queue_enter+0x41c/0x4a0
>    blk_queue_enter+0x41c/0x4a0
>    ? __irq_work_queue_local+0x75/0x1d0
>    ? blk_queue_start_drain+0x70/0x70
>    ? irq_work_queue+0x18/0x20
>    ? vprintk_emit.part.0+0x1cc/0x350
>    ? wake_up_klogd_work_func+0x60/0x60
>    blk_mq_alloc_request+0x2b7/0x6b0
>    ? __blk_mq_alloc_requests+0x1060/0x1060
>    ? __switch_to+0x5b7/0x1060
>    nvme_submit_user_cmd+0xa9/0x330
>    nvme_user_cmd.isra.0+0x240/0x3f0
>    ? force_sigsegv+0xe0/0xe0
>    ? nvme_user_cmd64+0x400/0x400
>    ? vfs_fileattr_set+0x9b0/0x9b0
>    ? cgroup_update_frozen_flag+0x24/0x1c0
>    ? cgroup_leave_frozen+0x204/0x330
>    ? nvme_ioctl+0x7c/0x2c0
>    blkdev_ioctl+0x1a8/0x4d0
>    ? blkdev_common_ioctl+0x1930/0x1930
>    ? fdget+0x54/0x380
>    __x64_sys_ioctl+0x129/0x190
>    do_syscall_64+0x5b/0x160
>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
>   RIP: 0033:0x7f765f703b0b
>   Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3=
 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 8b 0d dd 52 0f 00 f7 d8 64 89 01 48
>   RSP: 002b:00007ffe2cefe808 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
>   RAX: ffffffffffffffda RBX: 00007ffe2cefe860 RCX: 00007f765f703b0b
>   RDX: 00007ffe2cefe860 RSI: 00000000c0484e41 RDI: 0000000000000003
>   RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
>   R10: 00007f765f611d50 R11: 0000000000000202 R12: 0000000000000003
>   R13: 00000000c0484e41 R14: 0000000000000001 R15: 00007ffe2cefea60
>    </TASK>
>
> Reported-by: Casey Chen <cachen@purestorage.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fa4181d7de736..0b83d82f67e75 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4901,7 +4901,6 @@ void nvme_remove_admin_tag_set(struct nvme_ctrl *ct=
rl)
>          */
>         nvme_stop_keep_alive(ctrl);
>         blk_mq_destroy_queue(ctrl->admin_q);
> -       blk_put_queue(ctrl->admin_q);
>         if (ctrl->ops->flags & NVME_F_FABRICS) {
>                 blk_mq_destroy_queue(ctrl->fabrics_q);
>                 blk_put_queue(ctrl->fabrics_q);
> @@ -5045,6 +5044,7 @@ static void nvme_free_ctrl(struct device *dev)
>                 container_of(dev, struct nvme_ctrl, ctrl_device);
>         struct nvme_subsystem *subsys =3D ctrl->subsys;
>
> +       blk_put_queue(ctrl->admin_q);

Wait. Do we need to check ctrl->admin_q non-NULL before putting it ?
If nvme_alloc_admin_tag_set() fails, blk_put_queue() would put NULL
and panic kernel.

Casey

>         if (!subsys || ctrl->instance !=3D subsys->instance)
>                 ida_free(&nvme_instance_ida, ctrl->instance);
>         nvme_free_cels(ctrl);
> --
> 2.47.3
>

