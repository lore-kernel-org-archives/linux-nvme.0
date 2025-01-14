Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7713E77188
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jan 2025 17:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8rnOJsm4+GqEpFh+VHsUvDT7eGGvgUhRe/ppRK2TdV0=; b=KPKYZVg0DL1gG6sZ7nnqCsn6Ho
	sDNZ5TeWuhqvgCRH8LZZhV3HVbikEi0ife7DcXSmXId+pUClylkvxfsqXugZnaZ8x0stVmdWQB6to
	rDPmUGPthyeUwsYYCuqEB5sMzPGftBLQmFwHgkkOiycxrd8tTQGEdOQVQ0enr4sQpI4K+7f5ygrU7
	CstcKUg+fEvpYk+TAsgVYLiHEd+m6WdHz1blBANunA98TXC/tnt5GM0T+54udK+DULHjS4xDIY/tG
	WBhou3HzD6Elu5bwbYrfV2ocK+39UpIWwSUA6X+WI3y+3813ZchXi4QZPS9HAmssqg+RSfDBDOYz5
	FP5EtT9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXkPK-000000098Uq-1KZO;
	Tue, 14 Jan 2025 17:08:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXkOc-000000098Nl-09HE
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jan 2025 17:08:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736874483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rnOJsm4+GqEpFh+VHsUvDT7eGGvgUhRe/ppRK2TdV0=;
	b=MDUKOWBQv1HEyEFqgKdtB33x/U+C1stkh9RaFzYDmBuV+a4Mkn0/q53ALfaOt7I7F0giDW
	e6wu2Y+US6q1eS4q7ZcbL0WqLjr4N/q4OZzW4cC5tfFibbvBe7l1UscSil9vIr1ysv++Tl
	mx0jTQT2EVNawsmz/s3WRFo0BUNPWFo=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-Lk3W-luAPFuYkL27aGlLGg-1; Tue, 14 Jan 2025 12:06:32 -0500
X-MC-Unique: Lk3W-luAPFuYkL27aGlLGg-1
X-Mimecast-MFC-AGG-ID: Lk3W-luAPFuYkL27aGlLGg
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e5740c858beso7565867276.2
        for <linux-nvme@lists.infradead.org>; Tue, 14 Jan 2025 09:06:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736874391; x=1737479191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rnOJsm4+GqEpFh+VHsUvDT7eGGvgUhRe/ppRK2TdV0=;
        b=mnIaxfa1wOn3VMYHMz7I3xdyNlpCLo4iNH4RYTbUH1JRqQzdGJAnQYJgJaKlEUBk/W
         f/P9cq4o+Z3Hm9IHnBHWYWVMY9o0JmasE8qFF6jpXVnvC8g2bJ46msuCEwrdW4ZXxQbI
         a/VafOhUHZleRzI0f7RLFenJP0Wwz1mmQmwFl0dawhpfGaoo470pUcODANZ8MgDuHkB4
         5z9unFABXS6OD4h8y7pwd9WXiHX2G6FC5nAu3OQLCp+a1t+lt/PCP2u6ky8p/mlVMhnr
         nkDtGgmx+mAbyNSyNzC3sTcUXZGpW9g56XsRFcCe+QijTSl2Jeytx1VZ4kBEu2uFBt2O
         w3tg==
X-Forwarded-Encrypted: i=1; AJvYcCWlNud2pG1DqEQfB5AnjhqyahcBToVHrjBRvXTqVsW11/iCVXsLxzjXRB/vCmxUEaudLpVyUdCcWyFp@lists.infradead.org
X-Gm-Message-State: AOJu0YzYGpY72htPA7gAVeWwKmyTrvntJUU1zGCXfO8p8n1AGhFOnu7Z
	pRJAaneEbPFpDfDK3WWDlcE8QPRraFNUC954/GpdMjQ7sVEtbPoF/3f0gEDH+nDZtZd6ScjqeT/
	7QYmHGFupohR7Gc9KtgBdWF21YR/D2E87wZEKt0OZXJSSOFedfQmK+M4Ub+eoWCVa6lDL5xPMMd
	HmvLaRwNiKHvPMBomSaohDg0n6dxRyshu3hBUjNpI=
X-Gm-Gg: ASbGncuxwIGwOlk3PBq96Bfro1vTNvHM0En2CbFjZftlTNsohFfVxT+xrBJlVAPpMZ6
	MCU2g6UtVrS564/VulpeDUnjjbg4+qBminy6SmA==
X-Received: by 2002:a05:690c:3693:b0:6ef:5abd:d0d with SMTP id 00721157ae682-6f530f28e53mr199640117b3.0.1736874391211;
        Tue, 14 Jan 2025 09:06:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuuaHGaYvRUR+jHlIIALDc9+JYr8oGD6pdEVumgbNrhVG1Qdgv/Slwqx+42kt/oW7+T7Nv+RY1nCRJUlv2Eus=
X-Received: by 2002:a05:690c:3693:b0:6ef:5abd:d0d with SMTP id
 00721157ae682-6f530f28e53mr199638857b3.0.1736874389936; Tue, 14 Jan 2025
 09:06:29 -0800 (PST)
MIME-Version: 1.0
References: <20250113124446.830697-1-ming.lei@redhat.com>
In-Reply-To: <20250113124446.830697-1-ming.lei@redhat.com>
From: Ewan Milne <emilne@redhat.com>
Date: Tue, 14 Jan 2025 12:06:19 -0500
X-Gm-Features: AbW1kvaBYsDpb_wkMZtxoj9YLXtjNX9x2zBMcqDwnegH2B4rs1IfK0ONXIoA09g
Message-ID: <CAGtn9r=bqfqm6d0ipf6pc5Rure=NdkxdX+K=gTp4iAQ6qUYVtQ@mail.gmail.com>
Subject: Re: [RFC PATCH] nvme-fc: move tagset removal to nvme_fc_delete_ctrl()
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	Marco Patalano <mpatalan@redhat.com>, James Smart <james.smart@broadcom.com>, 
	Sagi Grimberg <sagi@grimberg.me>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cheyNu1XeNKs_YfmWADe6GSQwNUqhO_J3MvmL2J23go_1736874391
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_090806_146362_F4648B08 
X-CRM114-Status: GOOD (  38.14  )
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

Hi Ming-

So there is definitely something wrong, because we are recently
starting to see a 100% reproducible
warning on a couple of our test systems (but not another one) where
the nvme_fc_ctrl kref decrements to
zero on command completion.  However, I'm not sure that this patch
addresses the underlying issue.
If there was an outstanding command on the admin queue, there should
have been a corresponding
kref taken in nvme_fc_start_fcp_op() so we should not be in
nvme_fc_ctrl_free() until after it completes.
and the kref should not be zero at the end of command completion.

Normally, we would have already done through the code path in the
bottom of __nvme_fc_abort_outstanding_ios()
which should have resulted in no commands outstanding either on the
admin_q or the io queues prior to the
->free_ctrl() callback to nvme_fc_free_ctrl() which I think should be
the last put on the nvme_fc_ctrl object.

I think there there is also a problem with your change regarding when
the tagsets are removed,
which addresses WARN_ON() in blk_mq_run_hw_queue():

        WARN_ON_ONCE(!async && in_interrupt());

...because moving the removal of the tagsets to earlier in
nvme_fc_delete_ctrl() is removing the tagsets
to be prior to the the nvme_fc_delete_association() call which then
calls __nvme_fc_abort_outstanding_ios()
which invokes blk_mq_tagset_busy_iter() on the tagsets.  Perhaps
moving the tagset removal to after the
nvme_fc_delete_assocation() call would address your specific concern
regarding the correct execution context?

I think the real problem is that nvme_fc_ctrl_free() is called due to
the kref put when the command completes.
This shouldn't happen.  The last put should happen when the core code
calls ->free_ctrl().

Below is the stack trace we see for those interested.  The test is
doing a echo 1 > /sys/..../delete_controller.

I can't reproduce this on my otherwise identical system (connected to
different storage fabric arrays though).
So we have to run any experiments through the test automation instead
of interactively.

-Ewan

[ 4095.189976] ------------[ cut here ]------------
[ 4095.194596] WARNING: CPU: 9 PID: 38355 at block/blk-mq.c:2325
blk_mq_run_hw_queue+0x26/0x280
[ 4095.203036] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4
dns_resolver nfs lockd grace netfs sunrpc dm_service_time dm_multipath
amd_atl intel_rapl_msr intel_rapl_common amd64_edac dell_pc
platform_profile edac_mce_amd kvm_amd dell_wmi sparse_keymap rfkill
dell_smbios video dcdbas ipmi_ssif mgag200 kvm i2c_algo_bit
drm_client_lib drm_shmem_helper drm_kms_helper dell_wmi_descriptor
wmi_bmof rapl pcspkr i2c_piix4 ptdma i2c_smbus k10temp ipmi_si
acpi_power_meter acpi_ipmi ipmi_devintf ipmi_msghandler drm fuse xfs
libcrc32c sd_mod sg qla2xxx nvme_fc nvme_fabrics nvme_keyring ahci
crct10dif_pclmul nvme_core libahci crc32_pclmul nvme_auth crc32c_intel
libata ghash_clmulni_intel ccp scsi_transport_fc tg3 megaraid_sas
sp5100_tco wmi dm_mirror dm_region_hash dm_log dm_mod
[ 4095.271190] CPU: 9 UID: 0 PID: 38355 Comm: kworker/u65:3 Not
tainted 6.13.0-rc4+ #1
[ 4095.278851] Hardware name: Dell Inc. PowerEdge R6515/04F3CJ, BIOS
2.13.3 09/12/2023
[ 4095.286515] Workqueue:  0x0 (writeback)
[ 4095.290361] RIP: 0010:blk_mq_run_hw_queue+0x26/0x280
[ 4095.295334] Code: 90 90 90 90 0f 1f 44 00 00 41 57 41 56 41 55 41
54 55 48 89 fd 53 89 f3 40 84 f6 75 1c 65 f7 05 34 e9 40 4e 00 ff ff
00 74 02 <0f> 0b f6 85 a8 00 00 00 10 0f 85 16 02 00 00 48 8b 85 b8 00
00 00
[ 4095.314088] RSP: 0018:ffffb8ca0056cea8 EFLAGS: 00010206
[ 4095.319321] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[ 4095.326455] RDX: ffff9c82cb227728 RSI: 0000000000000000 RDI: ffff9c82d1e=
73e00
[ 4095.333585] RBP: ffff9c82d1e73e00 R08: 0000000000000000 R09: ffffb8ca005=
6ccf8
[ 4095.340720] R10: ffffb8ca0056ccf0 R11: ffffffffb33e1348 R12: 00000000000=
00000
[ 4095.347851] R13: ffff9c82ddfd1380 R14: 0000000000000010 R15: ffffffffb30=
070e0
[ 4095.354986] FS:  0000000000000000(0000) GS:ffff9c862f380000(0000)
knlGS:0000000000000000
[ 4095.363078] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4095.368825] CR2: 0000563f2b03c0b0 CR3: 000000011dfe6000 CR4: 00000000003=
50ef0
[ 4095.375966] Call Trace:
[ 4095.378418]  <IRQ>
[ 4095.380439]  ? __warn+0x84/0x130
[ 4095.383679]  ? blk_mq_run_hw_queue+0x26/0x280
[ 4095.388046]  ? report_bug+0x18a/0x1a0
[ 4095.391721]  ? handle_bug+0x53/0x90
[ 4095.395222]  ? exc_invalid_op+0x14/0x70
[ 4095.399063]  ? asm_exc_invalid_op+0x16/0x20
[ 4095.403261]  ? blk_mq_run_hw_queue+0x26/0x280
[ 4095.407626]  blk_mq_run_hw_queues+0x63/0x120
[ 4095.411908]  __blk_freeze_queue_start+0x64/0x70
[ 4095.416447]  blk_queue_start_drain+0x18/0x50
[ 4095.420728]  blk_mq_destroy_queue+0x30/0x60
[ 4095.424915]  nvme_remove_io_tag_set+0x26/0x40 [nvme_core]
[ 4095.430330]  nvme_fc_ctrl_free+0x2e/0x130 [nvme_fc]
[ 4095.435219]  blk_complete_reqs+0x40/0x50
[ 4095.439154]  handle_softirqs+0xd3/0x2b0
[ 4095.443004]  __irq_exit_rcu+0xcd/0xf0
[ 4095.446673]  sysvec_call_function_single+0x71/0x90
[ 4095.451468]  </IRQ>



On Mon, Jan 13, 2025 at 7:45=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Now target is removed from nvme_fc_ctrl_free() which is the ctrl->ref
> release handler. And even admin queue is unquiesced there, this way
> is definitely wrong because the ctr->ref is grabbed when submitting
> command.
>
> And Marco observed that nvme_fc_ctrl_free() can be called from request
> completion code path, and trigger kernel warning since request completes
> from softirq context.
>
> Fix the issue by moveing target removal into nvme_fc_delete_ctrl(),
> which is also aligned with nvme-tcp and nvme-rdma.
>
> Cc: Marco Patalano <mpatalan@redhat.com>
> Cc: Ewan Milne <emilne@redhat.com>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/nvme/host/fc.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index b81af7919e94..b94b4e50a3df 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2389,17 +2389,11 @@ nvme_fc_ctrl_free(struct kref *ref)
>                 container_of(ref, struct nvme_fc_ctrl, ref);
>         unsigned long flags;
>
> -       if (ctrl->ctrl.tagset)
> -               nvme_remove_io_tag_set(&ctrl->ctrl);
> -
>         /* remove from rport list */
>         spin_lock_irqsave(&ctrl->rport->lock, flags);
>         list_del(&ctrl->ctrl_list);
>         spin_unlock_irqrestore(&ctrl->rport->lock, flags);
>
> -       nvme_unquiesce_admin_queue(&ctrl->ctrl);
> -       nvme_remove_admin_tag_set(&ctrl->ctrl);
> -
>         kfree(ctrl->queues);
>
>         put_device(ctrl->dev);
> @@ -3288,6 +3282,13 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
>
>         cancel_work_sync(&ctrl->ioerr_work);
>         cancel_delayed_work_sync(&ctrl->connect_work);
> +
> +       if (ctrl->ctrl.tagset)
> +               nvme_remove_io_tag_set(&ctrl->ctrl);
> +
> +       nvme_unquiesce_admin_queue(&ctrl->ctrl);
> +       nvme_remove_admin_tag_set(&ctrl->ctrl);
> +
>         /*
>          * kill the association on the link side.  this will block
>          * waiting for io to terminate
> --
> 2.47.0
>


