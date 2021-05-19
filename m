Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B13FC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 00:37:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D675A60FDB
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 00:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D675A60FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nSJFKKnNQh3mofUeT2AYOuQO7Rq3RkyZUU3nK2pjnic=; b=n9vjwHrvOJbxx7c2efDBhxAcW
	zCKigNKr3g0XyLQhQiJLLInLa1t3jkYveiuiPJbYRezy2MW84JCxHhhQ1K0aPXhQKoBRrEjtwCB4T
	EaxKFaLyhXSqy6+JUT8SpIS/sfjqW5rxlGYFIpvIKDfAJUOjGFLEci+vA+q6VJvffXERz0JsuyNZB
	uVkWguL0K00py3T14Hk3iTgwajOyJnzkxayG70LsIG3QCRzJ3IB25wKS1LnTrNzTDGmDSYYChAkPy
	yorGB3ZSu9LU5eZrXfD1Rp9Lqo3iHiAdq0AZ2u9HAf9NK7BHdz0CamBPjTG8AwuPf0qX+sOLk45Mf
	eoDhsTifA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljAD1-002HRh-9C; Wed, 19 May 2021 00:37:11 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljACv-002HRC-UF
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 00:37:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=sR8phy45LGO6JpGJU9QLHjKxt3oCuy24Pjb7cFNtizw=; b=oYvHPY2Fmvgwrn2M5d7uKVFMMG
 uNqctd6K5MX2/f11Q4XKwIw9fhx4DMtl8u0YtHM7a11V1gPfxbFnKNiSZB3Mxa9IeQWGEWvWYrVM0
 iAS76PtPrxhgc99t4Eyi7F/kFhIg6fTIqu6euHCs1au+JZkJmGcE0dETUl96AL7uMGlEm1cyvw9EQ
 TlYcGQCab1U2GLZD+aznWahWvAVCQXiaUvBJtRoXLjS9sp92vxLuQy6ZiO7b5xpBpOjOWiqheh+Ft
 dpd5AI++LbKSEesHOrPKqEqiLcMxClezzNDhRnZh7lZ0S/XVJD9yPhbou2fVM/QDRvd3OskF91uRz
 oKxZenFQ==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljACs-00F39C-C3
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 00:37:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621384619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sR8phy45LGO6JpGJU9QLHjKxt3oCuy24Pjb7cFNtizw=;
 b=CFHts02QrZAg/CV7AMGptMd4Qq8hxAim+4nXO8dJFA6+drqyeTT7s8z6MgcnU6h+tt/e9W
 bbjnhaJUeh3tCePwHtosR3pNySf38mHFByT1+1w29ukRvx3GTpwuMu7JXgysDyAyzIyikh
 KNZSWmRJnevd6X4J5U987cVGamEGffE=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-rIoSJwOpPUeC-RYNDOwDuw-1; Tue, 18 May 2021 20:36:57 -0400
X-MC-Unique: rIoSJwOpPUeC-RYNDOwDuw-1
Received: by mail-yb1-f199.google.com with SMTP id
 c9-20020a2580c90000b02904f86395a96dso15658405ybm.19
 for <linux-nvme@lists.infradead.org>; Tue, 18 May 2021 17:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sR8phy45LGO6JpGJU9QLHjKxt3oCuy24Pjb7cFNtizw=;
 b=YoowBP133GMN7P1YGkX6rd63xXzQvKQlyCjLHAWKaVKS8DIaa81PSyHdV0+mMpy1X+
 CoAlFAFcZP114q6INoZXe5gDBGOYXjNMe55k+xr04JMqr9D3vHqPaqNqs4d1HJfNXqP2
 fIhHwiM7JgxjXFpqZqhYQDLxYpn1/k5Sd9t07xLZh5Zm7X2Y/s+q0WpRiI+Qa5rFALeB
 m8XQcevIBsZ2BPF69s4isJXUT/z26QUjyMZosmWfetlJoR7KvoSdBiA4EezzR3s/o51M
 tVZHh2Id13RxkTpjh3fxZlcCCwKlkM6up5uYP4a4BBelSE/jBct55Cn5vRLiwtgWWIfx
 5KZw==
X-Gm-Message-State: AOAM533F3ojn0zj+mT8ydIYlk+gYmFVBl6xjj+NbpIxXyur0ZmpVswlk
 ZejbMWzZEHLb3qcpi0NsxtRSp0zu52fqZ0MHfZUJwZqClB2miZMvrPZrgK91vdRP0DFzhAvqbuG
 rQq7DVMXnZgFkD4jTaqhNLNfDrt9/UR5JY1iaehV2wJg=
X-Received: by 2002:a25:1884:: with SMTP id 126mr11157782yby.124.1621384616617; 
 Tue, 18 May 2021 17:36:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/fjFcijgTLQMeji2REprXg5g+4Z32i5MnKjj6cxZxlfV0Thv4gdP3P+h/y6QEAS0xeVjEQPYHC5dNN4lTwnk=
X-Received: by 2002:a25:1884:: with SMTP id 126mr11157762yby.124.1621384616385; 
 Tue, 18 May 2021 17:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs-hAaHhWU4Kb4NrQ9Fvi7DiH95P=Q=7zK-inxpeZtztkw@mail.gmail.com>
 <3243ab72-ffe3-e655-ef0a-d695885ce2c5@grimberg.me>
 <CAHj4cs9uOHRgRe9PJ3_0A4NMo4T1q4XzCYG6UAV-V=RZ39i1iQ@mail.gmail.com>
 <CAHj4cs-JawWOTNBnQ3OTeNXUb_zeH3-5MrPQWK0=1QPfEJ7ROA@mail.gmail.com>
 <201a97a9-e42f-8d8e-3cc7-e5cf8ba816c2@grimberg.me>
 <423b7c5e-deb7-3547-6ca4-8f4476e9eb03@suse.de>
 <CAHj4cs-3sY=E643N89Gs46M0-KLivJP2WeXsB8bCftNq1kAe9g@mail.gmail.com>
In-Reply-To: <CAHj4cs-3sY=E643N89Gs46M0-KLivJP2WeXsB8bCftNq1kAe9g@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 19 May 2021 08:36:44 +0800
Message-ID: <CAHj4cs_NVzgA8=gC9MKSakdDgBR4ghLQv6H8tw_BgxUUvA+Uew@mail.gmail.com>
Subject: Re: [bug report] blktests nvme/022 lead kernel WARNING and NULL
 pointer
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
 skt-results-master@redhat.com, Bruno Goncalves <bgoncalv@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_173702_517992_AE84794F 
X-CRM114-Status: GOOD (  23.97  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Hannes

Gentle ping here.

On Wed, May 12, 2021 at 8:32 AM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> On Sun, May 9, 2021 at 4:44 PM Hannes Reinecke <hare@suse.de> wrote:
> >
> > On 5/7/21 9:50 PM, Sagi Grimberg wrote:
> > >
> > >>> Hi Sagi
> > >>>
> > >>> Bisect shows bellow commits was the first bad commit.
> > >>>
> > >>> commit a70b81bd4d9d2d6c05cfe6ef2a10bccc2e04357a (refs/bisect/bad)
> > >>> Author: Hannes Reinecke <hare@suse.de>
> > >>> Date:   Fri Apr 16 13:46:20 2021 +0200
> > >>>
> > >>>      nvme: sanitize KATO setting
> > >>>
> > >>
> > >> Hi Sagi
> > >> This issue has been consistently reproduced with blktests on recent
> > >> linux-block/for-next, do you have a chance to check it?
> > >
> > > I had not, Hannes can you have a look?
> > >
> > Can you check if this patch helps?
> >
> > diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> > index 74b3b150e1a5..a48d8219cf90 100644
> > --- a/drivers/nvme/target/loop.c
> > +++ b/drivers/nvme/target/loop.c
> > @@ -458,6 +458,9 @@ static void nvme_loop_reset_ctrl_work(struct
> > work_struct *work)
> >                  container_of(work, struct nvme_loop_ctrl, ctrl.reset_work);
> >          int ret;
> >
> > +       /* reset_work might run concurrently to delete_work */
> > +       if (ctrl->state == NVME_CTRL_DELETING)
> > +               return;
> >          nvme_stop_ctrl(&ctrl->ctrl);
> >          nvme_loop_shutdown_ctrl(ctrl);
> >
>
> Hi Hannes
> The issue still can be reproduced with this patch, here is the full log:
>
> <12>[  213.737602] run blktests nvme/022 at 2021-05-11 20:29:23
> <6>[  213.857826] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> <6>[  213.879592] nvmet: creating controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:7bc1767264664586a5ebf3ec1cdca2b9.
> <6>[  213.893281] nvme nvme0: creating 128 I/O queues.
> <6>[  213.910709] nvme nvme0: new ctrl: "blktests-subsystem-1"
> <4>[  214.943818] nvme nvme0: resetting controller
> <3>[  224.004540] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> <3>[  224.010452] nvmet: ctrl 1 fatal error occurred!
> <6>[  224.014997] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> <4>[  227.734741] ------------[ cut here ]------------
> <4>[  227.739348] WARNING: CPU: 110 PID: 1648 at
> drivers/nvme/target/loop.c:469 nvme_loop_reset_ctrl_work+0x5c/0x110
> [nvme_loop]
> <4>[  227.750386] Modules linked in: nvme_loop nvme_fabrics nvmet
> nvme_core rpcrdma rdma_ucm ib_srpt ib_isert iscsi_target_mod
> target_core_mod ib_iser libiscsi ib_umad scsi_transport_iscsi ib_ipoib
> rdma_cm iw_cm ib_cm rfkill mlx5_ib ib_uverbs ib_core sunrpc
> coresight_etm4x i2c_smbus coresight_tmc coresight_replicator
> coresight_tpiu mlx5_core joydev acpi_ipmi psample ipmi_ssif mlxfw
> ipmi_devintf ipmi_msghandler coresight_funnel coresight thunderx2_pmu
> vfat fat fuse zram ip_tables xfs ast i2c_algo_bit drm_vram_helper
> drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec
> drm_ttm_helper ttm drm crct10dif_ce ghash_ce gpio_xlp i2c_xlp9xx uas
> usb_storage aes_neon_bs
> <4>[  227.809227] CPU: 110 PID: 1648 Comm: kworker/u513:2 Not tainted
> 5.13.0-rc1.fix+ #1
> <4>[  227.816784] Hardware name: HPE Apollo 70
> /C01_APACHE_MB         , BIOS L50_5.13_1.16 07/29/2020
> <4>[  227.826511] Workqueue: nvme-reset-wq nvme_loop_reset_ctrl_work [nvme_loop]
> <4>[  227.833376] pstate: 40400009 (nZcv daif +PAN -UAO -TCO BTYPE=--)
> <4>[  227.839370] pc : nvme_loop_reset_ctrl_work+0x5c/0x110 [nvme_loop]
> <4>[  227.845451] lr : nvme_loop_reset_ctrl_work+0x54/0x110 [nvme_loop]
> <4>[  227.851532] sp : ffff800020c43d80
> <4>[  227.854833] x29: ffff800020c43d80 x28: 0000000000000000 x27:
> ffff00080d1b73c0
> <4>[  227.861959] x26: ffff00080d1fb76c x25: 0000000000000000 x24:
> ffff0008126be8c0
> <4>[  227.869082] x23: 0000000000000000 x22: ffff000826eafb00 x21:
> ffff0008126be4b0
> <4>[  227.876205] x20: ffff0008126be000 x19: ffff0008126be8b8 x18:
> 0000000000000020
> <4>[  227.883328] x17: 00000000f911e638 x16: 0000000032ecb495 x15:
> 000000000000000f
> <4>[  227.890452] x14: 0000000000000003 x13: 0000000000000000 x12:
> ffff008b822d32d0
> <4>[  227.897575] x11: ffff008b822d3230 x10: 0000000000000001 x9 :
> ffff800009058e74
> <4>[  227.904699] x8 : ffff008b7cfeaab8 x7 : fffffffffffc0000 x6 :
> ffff000000000000
> <4>[  227.911822] x5 : 000000008040002a x4 : 0000000000000000 x3 :
> ffff0008126be4bc
> <4>[  227.918946] x2 : 0000000000000001 x1 : ffff0008126be4bc x0 :
> 0000000000000000
> <4>[  227.926069] Call trace:
> <4>[  227.928503]  nvme_loop_reset_ctrl_work+0x5c/0x110 [nvme_loop]
> <4>[  227.934237]  process_one_work+0x1f0/0x4ac
> <4>[  227.938239]  worker_thread+0x22c/0x40c
> <4>[  227.941976]  kthread+0x11c/0x120
> <4>[  227.945193]  ret_from_fork+0x10/0x18
> <4>[  227.948759] ---[ end trace 57e2d1ace7d39024 ]---
> <1>[  228.355440] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000008
> <1>[  228.364215] Mem abort info:
> <1>[  228.366996]   ESR = 0x96000004
> <1>[  228.370037]   EC = 0x25: DABT (current EL), IL = 32 bits
> <1>[  228.375336]   SET = 0, FnV = 0
> <1>[  228.378377]   EA = 0, S1PTW = 0
> <1>[  228.381505] Data abort info:
> <1>[  228.384372]   ISV = 0, ISS = 0x00000004
> <1>[  228.388194]   CM = 0, WnR = 0
> <1>[  228.391149] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000897413000
> <1>[  228.397576] [0000000000000008] pgd=0000000000000000, p4d=0000000000000000
> <0>[  228.404354] Internal error: Oops: 96000004 [#1] SMP
> <4>[  228.409220] Modules linked in: nvme_loop nvme_fabrics nvmet
> nvme_core rpcrdma rdma_ucm ib_srpt ib_isert iscsi_target_mod
> target_core_mod ib_iser libiscsi ib_umad scsi_transport_iscsi ib_ipoib
> rdma_cm iw_cm ib_cm rfkill mlx5_ib ib_uverbs ib_core sunrpc
> coresight_etm4x i2c_smbus coresight_tmc coresight_replicator
> coresight_tpiu mlx5_core joydev acpi_ipmi psample ipmi_ssif mlxfw
> ipmi_devintf ipmi_msghandler coresight_funnel coresight thunderx2_pmu
> vfat fat fuse zram ip_tables xfs ast i2c_algo_bit drm_vram_helper
> drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec
> drm_ttm_helper ttm drm crct10dif_ce ghash_ce gpio_xlp i2c_xlp9xx uas
> usb_storage aes_neon_bs
> <4>[  228.468051] CPU: 5 PID: 2015 Comm: kworker/u513:7 Tainted: G
>    W         5.13.0-rc1.fix+ #1
> <4>[  228.476822] Hardware name: HPE Apollo 70
> /C01_APACHE_MB         , BIOS L50_5.13_1.16 07/29/2020
> <4>[  228.486548] Workqueue: nvme-delete-wq nvme_delete_ctrl_work [nvme_core]
> <4>[  228.493166] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO BTYPE=--)
> <4>[  228.499160] pc : percpu_ref_kill_and_confirm+0x94/0xb0
> <4>[  228.504288] lr : percpu_ref_kill_and_confirm+0x20/0xb0
> <4>[  228.509414] sp : ffff800020f63c90
> <4>[  228.512715] x29: ffff800020f63c90 x28: 0000000000000000 x27:
> ffff0008214969c0
> <4>[  228.519840] x26: ffff000809dc8b6c x25: 0000000000000000 x24:
> ffff00084f1d00d0
> <4>[  228.526963] x23: ffff00084f1d00b0 x22: ffff0008126be130 x21:
> ffff80000939a590
> <4>[  228.534087] x20: 0000000000000000 x19: ffff00084f1d0090 x18:
> 0000000000000020
> <4>[  228.541210] x17: 0000000000000000 x16: 0000000000000000 x15:
> 0000000000000013
> <4>[  228.548334] x14: 0000000000000003 x13: 0000000000000000 x12:
> 0000000000000040
> <4>[  228.555457] x11: ffff000800401918 x10: ffff00080040191a x9 :
> ffff8000090589ac
> <4>[  228.562580] x8 : ffff008b7cfeaab8 x7 : 0000000000000018 x6 :
> ffff000000000000
> <4>[  228.569703] x5 : 0000000000000000 x4 : ffff008b85321400 x3 :
> 0000000000000001
> <4>[  228.576827] x2 : 0000000000000000 x1 : ffff800011035d20 x0 :
> ffff80001147f000
> <4>[  228.583952] Call trace:
> <4>[  228.586385]  percpu_ref_kill_and_confirm+0x94/0xb0
> <4>[  228.591163]  nvmet_sq_destroy+0xf0/0x194 [nvmet]
> <4>[  228.595777]  nvme_loop_destroy_io_queues+0x6c/0xa0 [nvme_loop]
> <4>[  228.601598]  nvme_loop_shutdown_ctrl+0x64/0xc0 [nvme_loop]
> <4>[  228.607071]  nvme_loop_delete_ctrl_host+0x20/0x30 [nvme_loop]
> <4>[  228.612805]  nvme_do_delete_ctrl+0x5c/0x74 [nvme_core]
> <4>[  228.617939]  nvme_delete_ctrl_work+0x20/0x44 [nvme_core]
> <4>[  228.623246]  process_one_work+0x1f0/0x4ac
> <4>[  228.627244]  worker_thread+0x184/0x40c
> <4>[  228.630981]  kthread+0x11c/0x120
> <4>[  228.634197]  ret_from_fork+0x10/0x18
> <0>[  228.637763] Code: b0004841 3905dc03 91348021 f0006a80 (f9400442)
> <4>[  228.643843] ---[ end trace 57e2d1ace7d39025 ]---



-- 
Best Regards,
  Yi Zhang


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
