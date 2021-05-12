Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30362C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 00:33:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA2161221
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 00:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA2161221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZEVsn6cHIkpKIPY2zewpLSTDXlBztAn4VTsj/8pBySM=; b=YF/CCn9czHFbaDBbPxRgMd5CZ
	3jpRcULEYmATnosM9wMWlOCiYeeANIp0SaJ0JInogU62s44R1WUp7oHDxagWOgntl+Wbdyl2D/o5x
	7L8MSK6iOeCmthgTL5LDaL3EHexqVarfflOf/XvYX9qXx7duORSmqkh3EY7vqtGk5bSaMeMxz5/6k
	WGIHin1X4dD3wgz5TNYciOS53CaWIORlCO85ySLhUzLgwaE/kmHi/JZ457g8rYUUaOAAhs2vzTD/W
	8spQAH+Bki/eEvlgt8UkeKJ/LwNvldtjn69fROybglCc2wWnyBZYU8uY39dvSJSS4U4Bv3+eYl85s
	M9QBusRnw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgcnw-001bxS-NM; Wed, 12 May 2021 00:32:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgcns-001bwp-1T
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 00:32:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620779548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JWw4CmAPrix3witFYY0LKVVhbNU4iTYfr/iYaQ6Ii/g=;
 b=RmNA0L2b/3eHH4ojKN0YHyBUmE3gjWNxgHw6PaID8hu5wuukGr26G55tFIq25xR9IrYSzt
 sU0pxoOHWxx7PyFQPmQpyKvKItmWVJGdSVGn2O9hL3hflJxRC376bRrBpyJMv/3aesdCFG
 yCqa3giRj39cMI4HQu3FA2gSwQq0m4I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620779559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JWw4CmAPrix3witFYY0LKVVhbNU4iTYfr/iYaQ6Ii/g=;
 b=SjAOGJNZIw1YS84BvXEQG5jG1+Wb3+8ezkKLZusxh4hMIIQVsaUM2W5Y+rU2/p3U0ZZgxA
 rVXsgLTYWOmXVu/q7xyMF5D1A5INuR0cygQCdj3d74/slZVzPGGsg5GKG1/wWJEFLQsQ99
 P1pudPvakuEeT4whKj3rjkITJ8AEr8s=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-5kZnYvMbOuW_-mQR3_Ii_w-1; Tue, 11 May 2021 20:32:26 -0400
X-MC-Unique: 5kZnYvMbOuW_-mQR3_Ii_w-1
Received: by mail-yb1-f199.google.com with SMTP id
 s10-20020a252c0a0000b02904f8e566d0f2so8982871ybs.3
 for <linux-nvme@lists.infradead.org>; Tue, 11 May 2021 17:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JWw4CmAPrix3witFYY0LKVVhbNU4iTYfr/iYaQ6Ii/g=;
 b=jTaehLGUR+q8l7Ix8KIZUxukPUkPOewllqJO2VG29Wj/WnC8EV+CJu2HnXlVLc4CYC
 MpFB10eTdzHy8cGVtY5TCIYuGiHPaNJ/3QlsHH+Y6KMHyIk0TibwzIdf7UXH9XPKvd3V
 qdT82aPM/U5+Odh80ydy6K3XwPsnAZhtKH46EEvNVgRmTncQYCnx4PMWTFpf4gL/tVSD
 brala1J3NK5gv6O8lje5dp6MmdvHiMy+mcgwtDfG51X7YClTuDtXtfRn+AJF1a1OSIcN
 bFa6/sMNKXqAVvOhncyQXYYUORE9DyH6u6rgkHJc3Eh9+9b53sJpq+NJf4N+YTszvyj6
 KkBQ==
X-Gm-Message-State: AOAM533M+Rahp45Mw3N6KRgfKZaHp6H9LxDL8fwt91LDujmcdVw/Zp3I
 lod3Hh+wpel/8p/CwX8ai6gNYc3ieGUA6HHunDsE29nV6qBYOj0lbQYTH+v1IHctYPIDLr9hyGC
 j4cj9EePHMrtE8kJfxheZMq3UCAcZt6bA9mOKpFY8zcM=
X-Received: by 2002:a25:6084:: with SMTP id
 u126mr44040059ybb.198.1620779545760; 
 Tue, 11 May 2021 17:32:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxa+67DSRyIelwQHwo0rrpTcEXs9eF+A1BH+vIV4N0ybxAnIqQFxEF3K81PUvMkopHsDgXrlvVTy4650zU+1sg=
X-Received: by 2002:a25:6084:: with SMTP id
 u126mr44040031ybb.198.1620779545459; 
 Tue, 11 May 2021 17:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs-hAaHhWU4Kb4NrQ9Fvi7DiH95P=Q=7zK-inxpeZtztkw@mail.gmail.com>
 <3243ab72-ffe3-e655-ef0a-d695885ce2c5@grimberg.me>
 <CAHj4cs9uOHRgRe9PJ3_0A4NMo4T1q4XzCYG6UAV-V=RZ39i1iQ@mail.gmail.com>
 <CAHj4cs-JawWOTNBnQ3OTeNXUb_zeH3-5MrPQWK0=1QPfEJ7ROA@mail.gmail.com>
 <201a97a9-e42f-8d8e-3cc7-e5cf8ba816c2@grimberg.me>
 <423b7c5e-deb7-3547-6ca4-8f4476e9eb03@suse.de>
In-Reply-To: <423b7c5e-deb7-3547-6ca4-8f4476e9eb03@suse.de>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 12 May 2021 08:32:14 +0800
Message-ID: <CAHj4cs-3sY=E643N89Gs46M0-KLivJP2WeXsB8bCftNq1kAe9g@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20210512_013244_538774_EC3FCB78 
X-CRM114-Status: GOOD (  19.67  )
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

On Sun, May 9, 2021 at 4:44 PM Hannes Reinecke <hare@suse.de> wrote:
>
> On 5/7/21 9:50 PM, Sagi Grimberg wrote:
> >
> >>> Hi Sagi
> >>>
> >>> Bisect shows bellow commits was the first bad commit.
> >>>
> >>> commit a70b81bd4d9d2d6c05cfe6ef2a10bccc2e04357a (refs/bisect/bad)
> >>> Author: Hannes Reinecke <hare@suse.de>
> >>> Date:   Fri Apr 16 13:46:20 2021 +0200
> >>>
> >>>      nvme: sanitize KATO setting
> >>>
> >>
> >> Hi Sagi
> >> This issue has been consistently reproduced with blktests on recent
> >> linux-block/for-next, do you have a chance to check it?
> >
> > I had not, Hannes can you have a look?
> >
> Can you check if this patch helps?
>
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index 74b3b150e1a5..a48d8219cf90 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -458,6 +458,9 @@ static void nvme_loop_reset_ctrl_work(struct
> work_struct *work)
>                  container_of(work, struct nvme_loop_ctrl, ctrl.reset_work);
>          int ret;
>
> +       /* reset_work might run concurrently to delete_work */
> +       if (ctrl->state == NVME_CTRL_DELETING)
> +               return;
>          nvme_stop_ctrl(&ctrl->ctrl);
>          nvme_loop_shutdown_ctrl(ctrl);
>

Hi Hannes
The issue still can be reproduced with this patch, here is the ful log:

<12>[  213.737602] run blktests nvme/022 at 2021-05-11 20:29:23
<6>[  213.857826] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
<6>[  213.879592] nvmet: creating controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:7bc1767264664586a5ebf3ec1cdca2b9.
<6>[  213.893281] nvme nvme0: creating 128 I/O queues.
<6>[  213.910709] nvme nvme0: new ctrl: "blktests-subsystem-1"
<4>[  214.943818] nvme nvme0: resetting controller
<3>[  224.004540] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
<3>[  224.010452] nvmet: ctrl 1 fatal error occurred!
<6>[  224.014997] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
<4>[  227.734741] ------------[ cut here ]------------
<4>[  227.739348] WARNING: CPU: 110 PID: 1648 at
drivers/nvme/target/loop.c:469 nvme_loop_reset_ctrl_work+0x5c/0x110
[nvme_loop]
<4>[  227.750386] Modules linked in: nvme_loop nvme_fabrics nvmet
nvme_core rpcrdma rdma_ucm ib_srpt ib_isert iscsi_target_mod
target_core_mod ib_iser libiscsi ib_umad scsi_transport_iscsi ib_ipoib
rdma_cm iw_cm ib_cm rfkill mlx5_ib ib_uverbs ib_core sunrpc
coresight_etm4x i2c_smbus coresight_tmc coresight_replicator
coresight_tpiu mlx5_core joydev acpi_ipmi psample ipmi_ssif mlxfw
ipmi_devintf ipmi_msghandler coresight_funnel coresight thunderx2_pmu
vfat fat fuse zram ip_tables xfs ast i2c_algo_bit drm_vram_helper
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec
drm_ttm_helper ttm drm crct10dif_ce ghash_ce gpio_xlp i2c_xlp9xx uas
usb_storage aes_neon_bs
<4>[  227.809227] CPU: 110 PID: 1648 Comm: kworker/u513:2 Not tainted
5.13.0-rc1.fix+ #1
<4>[  227.816784] Hardware name: HPE Apollo 70
/C01_APACHE_MB         , BIOS L50_5.13_1.16 07/29/2020
<4>[  227.826511] Workqueue: nvme-reset-wq nvme_loop_reset_ctrl_work [nvme_loop]
<4>[  227.833376] pstate: 40400009 (nZcv daif +PAN -UAO -TCO BTYPE=--)
<4>[  227.839370] pc : nvme_loop_reset_ctrl_work+0x5c/0x110 [nvme_loop]
<4>[  227.845451] lr : nvme_loop_reset_ctrl_work+0x54/0x110 [nvme_loop]
<4>[  227.851532] sp : ffff800020c43d80
<4>[  227.854833] x29: ffff800020c43d80 x28: 0000000000000000 x27:
ffff00080d1b73c0
<4>[  227.861959] x26: ffff00080d1fb76c x25: 0000000000000000 x24:
ffff0008126be8c0
<4>[  227.869082] x23: 0000000000000000 x22: ffff000826eafb00 x21:
ffff0008126be4b0
<4>[  227.876205] x20: ffff0008126be000 x19: ffff0008126be8b8 x18:
0000000000000020
<4>[  227.883328] x17: 00000000f911e638 x16: 0000000032ecb495 x15:
000000000000000f
<4>[  227.890452] x14: 0000000000000003 x13: 0000000000000000 x12:
ffff008b822d32d0
<4>[  227.897575] x11: ffff008b822d3230 x10: 0000000000000001 x9 :
ffff800009058e74
<4>[  227.904699] x8 : ffff008b7cfeaab8 x7 : fffffffffffc0000 x6 :
ffff000000000000
<4>[  227.911822] x5 : 000000008040002a x4 : 0000000000000000 x3 :
ffff0008126be4bc
<4>[  227.918946] x2 : 0000000000000001 x1 : ffff0008126be4bc x0 :
0000000000000000
<4>[  227.926069] Call trace:
<4>[  227.928503]  nvme_loop_reset_ctrl_work+0x5c/0x110 [nvme_loop]
<4>[  227.934237]  process_one_work+0x1f0/0x4ac
<4>[  227.938239]  worker_thread+0x22c/0x40c
<4>[  227.941976]  kthread+0x11c/0x120
<4>[  227.945193]  ret_from_fork+0x10/0x18
<4>[  227.948759] ---[ end trace 57e2d1ace7d39024 ]---
<1>[  228.355440] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000008
<1>[  228.364215] Mem abort info:
<1>[  228.366996]   ESR = 0x96000004
<1>[  228.370037]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[  228.375336]   SET = 0, FnV = 0
<1>[  228.378377]   EA = 0, S1PTW = 0
<1>[  228.381505] Data abort info:
<1>[  228.384372]   ISV = 0, ISS = 0x00000004
<1>[  228.388194]   CM = 0, WnR = 0
<1>[  228.391149] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000897413000
<1>[  228.397576] [0000000000000008] pgd=0000000000000000, p4d=0000000000000000
<0>[  228.404354] Internal error: Oops: 96000004 [#1] SMP
<4>[  228.409220] Modules linked in: nvme_loop nvme_fabrics nvmet
nvme_core rpcrdma rdma_ucm ib_srpt ib_isert iscsi_target_mod
target_core_mod ib_iser libiscsi ib_umad scsi_transport_iscsi ib_ipoib
rdma_cm iw_cm ib_cm rfkill mlx5_ib ib_uverbs ib_core sunrpc
coresight_etm4x i2c_smbus coresight_tmc coresight_replicator
coresight_tpiu mlx5_core joydev acpi_ipmi psample ipmi_ssif mlxfw
ipmi_devintf ipmi_msghandler coresight_funnel coresight thunderx2_pmu
vfat fat fuse zram ip_tables xfs ast i2c_algo_bit drm_vram_helper
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec
drm_ttm_helper ttm drm crct10dif_ce ghash_ce gpio_xlp i2c_xlp9xx uas
usb_storage aes_neon_bs
<4>[  228.468051] CPU: 5 PID: 2015 Comm: kworker/u513:7 Tainted: G
   W         5.13.0-rc1.fix+ #1
<4>[  228.476822] Hardware name: HPE Apollo 70
/C01_APACHE_MB         , BIOS L50_5.13_1.16 07/29/2020
<4>[  228.486548] Workqueue: nvme-delete-wq nvme_delete_ctrl_work [nvme_core]
<4>[  228.493166] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO BTYPE=--)
<4>[  228.499160] pc : percpu_ref_kill_and_confirm+0x94/0xb0
<4>[  228.504288] lr : percpu_ref_kill_and_confirm+0x20/0xb0
<4>[  228.509414] sp : ffff800020f63c90
<4>[  228.512715] x29: ffff800020f63c90 x28: 0000000000000000 x27:
ffff0008214969c0
<4>[  228.519840] x26: ffff000809dc8b6c x25: 0000000000000000 x24:
ffff00084f1d00d0
<4>[  228.526963] x23: ffff00084f1d00b0 x22: ffff0008126be130 x21:
ffff80000939a590
<4>[  228.534087] x20: 0000000000000000 x19: ffff00084f1d0090 x18:
0000000000000020
<4>[  228.541210] x17: 0000000000000000 x16: 0000000000000000 x15:
0000000000000013
<4>[  228.548334] x14: 0000000000000003 x13: 0000000000000000 x12:
0000000000000040
<4>[  228.555457] x11: ffff000800401918 x10: ffff00080040191a x9 :
ffff8000090589ac
<4>[  228.562580] x8 : ffff008b7cfeaab8 x7 : 0000000000000018 x6 :
ffff000000000000
<4>[  228.569703] x5 : 0000000000000000 x4 : ffff008b85321400 x3 :
0000000000000001
<4>[  228.576827] x2 : 0000000000000000 x1 : ffff800011035d20 x0 :
ffff80001147f000
<4>[  228.583952] Call trace:
<4>[  228.586385]  percpu_ref_kill_and_confirm+0x94/0xb0
<4>[  228.591163]  nvmet_sq_destroy+0xf0/0x194 [nvmet]
<4>[  228.595777]  nvme_loop_destroy_io_queues+0x6c/0xa0 [nvme_loop]
<4>[  228.601598]  nvme_loop_shutdown_ctrl+0x64/0xc0 [nvme_loop]
<4>[  228.607071]  nvme_loop_delete_ctrl_host+0x20/0x30 [nvme_loop]
<4>[  228.612805]  nvme_do_delete_ctrl+0x5c/0x74 [nvme_core]
<4>[  228.617939]  nvme_delete_ctrl_work+0x20/0x44 [nvme_core]
<4>[  228.623246]  process_one_work+0x1f0/0x4ac
<4>[  228.627244]  worker_thread+0x184/0x40c
<4>[  228.630981]  kthread+0x11c/0x120
<4>[  228.634197]  ret_from_fork+0x10/0x18
<0>[  228.637763] Code: b0004841 3905dc03 91348021 f0006a80 (f9400442)
<4>[  228.643843] ---[ end trace 57e2d1ace7d39025 ]---


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
