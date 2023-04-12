Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871E4C77B6E
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ExGf/HrikYP43vuFdeeps8x9nHFxJu561L3Id/Q0nV4=; b=hwx97kKtHiVvYyKe0EgbLKCXlN
	XR/hHVZy7k8aljOVwga7G6TB1suoDbQm7P9s8mtG/mvZt3VlzBuj+F0COZJe3i7kO2lnGNjk1GNPj
	sVHITSWEsslZ+M2+TaXVqUKRImbFZSNldYn8Uxi1xPLRHIgT9G0xg2CVgfsGGTkkXFa/70AToTvMb
	quJ5VCng+WDHtlHHjDuGPY+ql/NnnzqZri5kfmmys6hpZyZuJ1eT89F+U/rY8M4XiDlOwjsti6khG
	MMcQCrN3EvvT/9HBC6X5OQH2XncP5APNSxVC9hyA3H6gBzYgv1bM4qiEwN4CJSjd3re17Ag25SRJD
	7LQ+7A2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmdjJ-003sWi-0E;
	Wed, 12 Apr 2023 16:53:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmdjE-003sTw-06
	for linux-nvme@lists.infradead.org;
	Wed, 12 Apr 2023 16:53:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681318429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ExGf/HrikYP43vuFdeeps8x9nHFxJu561L3Id/Q0nV4=;
	b=ZK0euSDqMG4o9uCkEppis21RIoPinKYGlyyIgD0b3H5O99O4ieiSC6FMqFjWjbJjF43i6x
	sB+EOsb8VyCdfHXeS3SPGbHr9vDnLG06UghUwFMEvkrmrKScjCyWYBoWq2j8pEu4v+/EzF
	D7mSrJcxyQoPj5RKSmvFDV7pIR6cL88=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-tlZJ2NVkO5aL6bF0l6Oi2w-1; Wed, 12 Apr 2023 12:53:48 -0400
X-MC-Unique: tlZJ2NVkO5aL6bF0l6Oi2w-1
Received: by mail-pj1-f69.google.com with SMTP id lp6-20020a17090b4a8600b00244a02d7bbcso5290566pjb.8
        for <linux-nvme@lists.infradead.org>; Wed, 12 Apr 2023 09:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681318425; x=1683910425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExGf/HrikYP43vuFdeeps8x9nHFxJu561L3Id/Q0nV4=;
        b=d0PK2eNFOa0wm3g1xWwirCGqrX5KdJ3e9TJCMQ1vs0w0nJMbXDfoJGhJyrRK6nUZzG
         48aVVjy8bh141n80q5gviHD+8x46IYq+b9v5L5UXNZ41kC4hVeBD0q/WCwHqsiMRhfkK
         DX797+x0sFATQgL3WfLn3zTvRec8/QHNuId/+VlnWiZNDeKEwZNV7mAD+5sYo/kKP1db
         vZ4C5e4YYyLpdtTtp4+iHwED+C1Y1NViylJufUDGRgR9MvkrnlD6aKyksCntA+pX+dyD
         HrWIyS/aZC2Q45HY6S4mzKxhZW4IGROdRi54AqHNjhBE1ciLnuX7SyIYNHvRBudrefGJ
         SOpw==
X-Gm-Message-State: AAQBX9eFPPbqeTqYkScgIqktswfdUHUX5F1ENydPW8njwR+jKUxmF9s6
	kTvAX8omyUDKS8FMHT60hF6oHC6QP6rDqm/zaFuJ+SgkvjDN1BV0/GgVid8GVfo95OmhWV21Kzd
	cCoSuDOjHSp41wrcIMSEp2E+lh75e9XoxbYdIuBKSukg=
X-Received: by 2002:a17:902:a617:b0:1a5:f26:b6bf with SMTP id u23-20020a170902a61700b001a50f26b6bfmr2369995plq.10.1681318424599;
        Wed, 12 Apr 2023 09:53:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350Ys+L9g+l18xvamLllXffZbBJL/d4xQX4i5pdRWTw9BrOFVOB03NuI1AS8hmKVozejqWqmTBvfrLNb9kn7jn6I=
X-Received: by 2002:a17:902:a617:b0:1a5:f26:b6bf with SMTP id
 u23-20020a170902a61700b001a50f26b6bfmr2369985plq.10.1681318424078; Wed, 12
 Apr 2023 09:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230412084904.162324-1-ming.lei@redhat.com>
In-Reply-To: <20230412084904.162324-1-ming.lei@redhat.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 13 Apr 2023 00:53:32 +0800
Message-ID: <CAHj4cs8o8LkzQ-HTEiyp16sxv3Q2E_MyLhWJJVuxMhDD+SZzhg@mail.gmail.com>
Subject: Re: [PATCH] nvme-fcloop: fix "inconsistent {IN-HARDIRQ-W} ->
 {HARDIRQ-ON-W} usage"
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	James Smart <jsmart2021@gmail.com>, Minwoo Im <minwoo.im.dev@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230412_095352_226900_9BB64FFC 
X-CRM114-Status: GOOD (  23.34  )
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

Thanks Ming, below issue was fixed by this patch, feel free to add:

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>

[ 6238.578857] run blktests nvme/012 at 2023-04-12 07:47:19
[ 6240.616008] ------------[ cut here ]------------
[ 6240.620657] raw_local_irq_restore() called with IRQs enabled
[ 6240.626331] WARNING: CPU: 25 PID: 184 at
kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x21/0x30
[ 6240.636082] Modules linked in: loop nvme_fcloop nvmet_fc nvmet
nvme_fc nvme_fabrics nvme_core nvme_common rpcsec_gss_krb5 auth_rpcgss
nfsv4 dns_resolver nfs lockd grace fscache netfs rfkill sunrpc vfat
fat dm_multipath intel_rapl_msr intel_rapl_common
intel_uncore_frequency intel_uncore_frequency_common isst_if_common
skx_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm
ipmi_ssif mgag200 i2c_algo_bit drm_shmem_helper drm_kms_helper
irqbypass iTCO_wdt syscopyarea rapl mei_me iTCO_vendor_support
sysfillrect dell_smbios intel_cstate dcdbas wmi_bmof
dell_wmi_descriptor intel_uncore acpi_ipmi pcspkr sysimgblt mei
i2c_i801 ipmi_si lpc_ich i2c_smbus ipmi_devintf ipmi_msghandler
dax_pmem acpi_power_meter drm fuse xfs libcrc32c nd_pmem nd_btt sd_mod
t10_pi sg crct10dif_pclmul crc32_pclmul crc32c_intel ahci libahci
ghash_clmulni_intel tg3 megaraid_sas libata wmi nfit libnvdimm
dm_mirror dm_region_hash dm_log dm_mod
[ 6240.717780] CPU: 25 PID: 184 Comm: ksoftirqd/25 Kdump: loaded Not
tainted 6.3.0-rc5+ #1
[ 6240.725787] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
2.17.1 11/15/2022
[ 6240.733360] RIP: 0010:warn_bogus_irq_restore+0x21/0x30
[ 6240.738509] Code: 90 90 90 90 90 90 90 90 90 80 3d fa 4d d8 01 00
74 05 c3 cc cc cc cc 48 c7 c7 a0 29 ce 8c c6 05 e5 4d d8 01 01 e8 df
d1 c7 fd <0f> 0b c3 cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90
90 90
[ 6240.757264] RSP: 0018:ffffc90001257d60 EFLAGS: 00010286
[ 6240.762506] RAX: 0000000000000000 RBX: 0000000000000200 RCX: 00000000000=
00000
[ 6240.769647] RDX: 0000000000000103 RSI: ffffffff8cf64b60 RDI: 00000000000=
00001
[ 6240.776787] RBP: ffff8884dd61a048 R08: 0000000000000001 R09: ffffc900012=
57b5f
[ 6240.783930] R10: fffff5200024af6b R11: 0000000000000001 R12: ffff8884dd6=
1a010
[ 6240.791070] R13: dffffc0000000000 R14: ffff8884dd619f50 R15: ffff8884dd6=
19f50
[ 6240.798210] FS:  0000000000000000(0000) GS:ffff888efe400000(0000)
knlGS:0000000000000000
[ 6240.806306] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6240.812066] CR2: 000055c5feb5c0a0 CR3: 00000003a0a32002 CR4: 00000000007=
706e0
[ 6240.819211] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 6240.826350] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 6240.833493] PKRU: 55555554
[ 6240.836215] Call Trace:
[ 6240.838674]  <TASK>
[ 6240.840791]  _raw_spin_unlock_irqrestore+0x6c/0x70
[ 6240.845600]  flush_end_io+0x88f/0xb70
[ 6240.849290]  ? __pfx_flush_end_io+0x10/0x10
[ 6240.853486]  blk_mq_end_request+0x145/0x400
[ 6240.857686]  blk_complete_reqs+0xa7/0xe0
[ 6240.861626]  __do_softirq+0x200/0x8f6
[ 6240.865311]  ? __pfx_run_ksoftirqd+0x10/0x10
[ 6240.869600]  ? smpboot_thread_fn+0x6b/0x910
[ 6240.873799]  run_ksoftirqd+0x36/0x60
[ 6240.877388]  smpboot_thread_fn+0x556/0x910
[ 6240.881498]  ? __pfx_smpboot_thread_fn+0x10/0x10
[ 6240.886134]  kthread+0x29f/0x340
[ 6240.889381]  ? __pfx_kthread+0x10/0x10
[ 6240.893145]  ret_from_fork+0x29/0x50
[ 6240.896756]  </TASK>
[ 6240.898959] irq event stamp: 715386
[ 6240.902459] hardirqs last  enabled at (715396):
[<ffffffff8a7f600b>] __up_console_sem+0x6b/0x80
[ 6240.911160] hardirqs last disabled at (715405):
[<ffffffff8a7f5ff0>] __up_console_sem+0x50/0x80
[ 6240.919862] softirqs last  enabled at (714456):
[<ffffffff8c9e6d9b>] __do_softirq+0x5db/0x8f6
[ 6240.928388] softirqs last disabled at (714461):
[<ffffffff8a646b16>] run_ksoftirqd+0x36/0x60
[ 6240.936828] ---[ end trace 0000000000000000 ]---
On Wed, Apr 12, 2023 at 4:52=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> fcloop_fcp_op() could be called from flush request's ->end_io(flush_end_i=
o) in
> which the spinlock of fq->mq_flush_lock is grabbed with irq saved/disable=
d.
>
> So fcloop_fcp_op() can't call spin_unlock_irq(&tfcp_req->reqlock) simply
> which enables irq unconditionally.
>
> Fixes the warning by switching to spin_lock_irqsave()/spin_unlock_irqrest=
ore()
>
> Fixes: c38dbbfab1bc ("nvme-fcloop: fix inconsistent lock state warnings")
> Cc: James Smart <jsmart2021@gmail.com>
> Cc: Minwoo Im <minwoo.im.dev@gmail.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/nvme/target/fcloop.c | 48 ++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 5c16372f3b53..c780af36c1d4 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -614,10 +614,11 @@ fcloop_fcp_recv_work(struct work_struct *work)
>         struct fcloop_fcpreq *tfcp_req =3D
>                 container_of(work, struct fcloop_fcpreq, fcp_rcv_work);
>         struct nvmefc_fcp_req *fcpreq =3D tfcp_req->fcpreq;
> +       unsigned long flags;
>         int ret =3D 0;
>         bool aborted =3D false;
>
> -       spin_lock_irq(&tfcp_req->reqlock);
> +       spin_lock_irqsave(&tfcp_req->reqlock, flags);
>         switch (tfcp_req->inistate) {
>         case INI_IO_START:
>                 tfcp_req->inistate =3D INI_IO_ACTIVE;
> @@ -626,11 +627,11 @@ fcloop_fcp_recv_work(struct work_struct *work)
>                 aborted =3D true;
>                 break;
>         default:
> -               spin_unlock_irq(&tfcp_req->reqlock);
> +               spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>                 WARN_ON(1);
>                 return;
>         }
> -       spin_unlock_irq(&tfcp_req->reqlock);
> +       spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>
>         if (unlikely(aborted))
>                 ret =3D -ECANCELED;
> @@ -655,8 +656,9 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
>                 container_of(work, struct fcloop_fcpreq, abort_rcv_work);
>         struct nvmefc_fcp_req *fcpreq;
>         bool completed =3D false;
> +       unsigned long flags;
>
> -       spin_lock_irq(&tfcp_req->reqlock);
> +       spin_lock_irqsave(&tfcp_req->reqlock, flags);
>         fcpreq =3D tfcp_req->fcpreq;
>         switch (tfcp_req->inistate) {
>         case INI_IO_ABORTED:
> @@ -665,11 +667,11 @@ fcloop_fcp_abort_recv_work(struct work_struct *work=
)
>                 completed =3D true;
>                 break;
>         default:
> -               spin_unlock_irq(&tfcp_req->reqlock);
> +               spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>                 WARN_ON(1);
>                 return;
>         }
> -       spin_unlock_irq(&tfcp_req->reqlock);
> +       spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>
>         if (unlikely(completed)) {
>                 /* remove reference taken in original abort downcall */
> @@ -681,9 +683,9 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
>                 nvmet_fc_rcv_fcp_abort(tfcp_req->tport->targetport,
>                                         &tfcp_req->tgt_fcp_req);
>
> -       spin_lock_irq(&tfcp_req->reqlock);
> +       spin_lock_irqsave(&tfcp_req->reqlock, flags);
>         tfcp_req->fcpreq =3D NULL;
> -       spin_unlock_irq(&tfcp_req->reqlock);
> +       spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>
>         fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
>         /* call_host_done releases reference for abort downcall */
> @@ -699,11 +701,12 @@ fcloop_tgt_fcprqst_done_work(struct work_struct *wo=
rk)
>         struct fcloop_fcpreq *tfcp_req =3D
>                 container_of(work, struct fcloop_fcpreq, tio_done_work);
>         struct nvmefc_fcp_req *fcpreq;
> +       unsigned long flags;
>
> -       spin_lock_irq(&tfcp_req->reqlock);
> +       spin_lock_irqsave(&tfcp_req->reqlock, flags);
>         fcpreq =3D tfcp_req->fcpreq;
>         tfcp_req->inistate =3D INI_IO_COMPLETED;
> -       spin_unlock_irq(&tfcp_req->reqlock);
> +       spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>
>         fcloop_call_host_done(fcpreq, tfcp_req, tfcp_req->status);
>  }
> @@ -807,13 +810,14 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
>         u32 rsplen =3D 0, xfrlen =3D 0;
>         int fcp_err =3D 0, active, aborted;
>         u8 op =3D tgt_fcpreq->op;
> +       unsigned long flags;
>
> -       spin_lock_irq(&tfcp_req->reqlock);
> +       spin_lock_irqsave(&tfcp_req->reqlock, flags);
>         fcpreq =3D tfcp_req->fcpreq;
>         active =3D tfcp_req->active;
>         aborted =3D tfcp_req->aborted;
>         tfcp_req->active =3D true;
> -       spin_unlock_irq(&tfcp_req->reqlock);
> +       spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>
>         if (unlikely(active))
>                 /* illegal - call while i/o active */
> @@ -821,9 +825,9 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
>
>         if (unlikely(aborted)) {
>                 /* target transport has aborted i/o prior */
> -               spin_lock_irq(&tfcp_req->reqlock);
> +               spin_lock_irqsave(&tfcp_req->reqlock, flags);
>                 tfcp_req->active =3D false;
> -               spin_unlock_irq(&tfcp_req->reqlock);
> +               spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>                 tgt_fcpreq->transferred_length =3D 0;
>                 tgt_fcpreq->fcp_error =3D -ECANCELED;
>                 tgt_fcpreq->done(tgt_fcpreq);
> @@ -880,9 +884,9 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
>                 break;
>         }
>
> -       spin_lock_irq(&tfcp_req->reqlock);
> +       spin_lock_irqsave(&tfcp_req->reqlock, flags);
>         tfcp_req->active =3D false;
> -       spin_unlock_irq(&tfcp_req->reqlock);
> +       spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>
>         tgt_fcpreq->transferred_length =3D xfrlen;
>         tgt_fcpreq->fcp_error =3D fcp_err;
> @@ -896,15 +900,16 @@ fcloop_tgt_fcp_abort(struct nvmet_fc_target_port *t=
gtport,
>                         struct nvmefc_tgt_fcp_req *tgt_fcpreq)
>  {
>         struct fcloop_fcpreq *tfcp_req =3D tgt_fcp_req_to_fcpreq(tgt_fcpr=
eq);
> +       unsigned long flags;
>
>         /*
>          * mark aborted only in case there were 2 threads in transport
>          * (one doing io, other doing abort) and only kills ops posted
>          * after the abort request
>          */
> -       spin_lock_irq(&tfcp_req->reqlock);
> +       spin_lock_irqsave(&tfcp_req->reqlock, flags);
>         tfcp_req->aborted =3D true;
> -       spin_unlock_irq(&tfcp_req->reqlock);
> +       spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>
>         tfcp_req->status =3D NVME_SC_INTERNAL;
>
> @@ -946,6 +951,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport=
,
>         struct fcloop_ini_fcpreq *inireq =3D fcpreq->private;
>         struct fcloop_fcpreq *tfcp_req;
>         bool abortio =3D true;
> +       unsigned long flags;
>
>         spin_lock(&inireq->inilock);
>         tfcp_req =3D inireq->tfcp_req;
> @@ -958,7 +964,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport=
,
>                 return;
>
>         /* break initiator/target relationship for io */
> -       spin_lock_irq(&tfcp_req->reqlock);
> +       spin_lock_irqsave(&tfcp_req->reqlock, flags);
>         switch (tfcp_req->inistate) {
>         case INI_IO_START:
>         case INI_IO_ACTIVE:
> @@ -968,11 +974,11 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localpo=
rt,
>                 abortio =3D false;
>                 break;
>         default:
> -               spin_unlock_irq(&tfcp_req->reqlock);
> +               spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>                 WARN_ON(1);
>                 return;
>         }
> -       spin_unlock_irq(&tfcp_req->reqlock);
> +       spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>
>         if (abortio)
>                 /* leave the reference while the work item is scheduled *=
/
> --
> 2.31.1
>
>


--=20
Best Regards,
  Yi Zhang


