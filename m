Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39747EE4996
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Aug 2023 05:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4VvC7ARMv+rWSmxbCrAo+4Fws2W+OhxdfWe6Kk+0rLw=; b=c7Ea42XrcEd7jzsJgWDi3UsZ9K
	z5acSEJHhSKSBS6eaZMFBfzf9MzxSxmy23dtr9moH/WHmntaeHnxc+mWyov68PEurrj1xhh5oEg56
	pnfdJbq4SK9rvAxhsdGWsXEN9zCivqbC80/7qVZTtB7Wq2m3w2RzO1tFfzCSIAhMBdnMVw8rNj6RT
	LqsYbgk4MwDUzmp/L919TXNKd+0kC14D6emGfrDL1c+a4vWSqixEJqNNtMgcOhLR6ihjNu1WDKPRn
	pLrUGdoAVIm4heQU/dNBUvj6/rgjsmlOdv87DMcfCLSTp/oPTo70AihrSAcSZTSdINO0hHDIWo/I9
	uKb9tJDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qXxmO-00DCOS-0W;
	Mon, 21 Aug 2023 05:48:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qXxmK-00DCMr-1D
	for linux-nvme@lists.infradead.org;
	Mon, 21 Aug 2023 05:48:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692596914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4VvC7ARMv+rWSmxbCrAo+4Fws2W+OhxdfWe6Kk+0rLw=;
	b=HBMOiaoyofkJP7cUNRqHHpBtWrQM9FgfhUbms1+AhxMO8KQFbuEcLoV3E8FRVLsCMpBgVf
	J4vQ3RA4/b8JvcNZsflzjzCq+DKVZq4OBcj8SU+lih4Y8O4DA+ukZeM/iPA/os5mlQQG9N
	CRE6Q62LNIfSgHJhCp7n32N4S2sDqc8=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-t42zHMblPJeyr0IbPJ5bkA-1; Mon, 21 Aug 2023 01:48:28 -0400
X-MC-Unique: t42zHMblPJeyr0IbPJ5bkA-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6b9cf208fb5so3655956a34.3
        for <linux-nvme@lists.infradead.org>; Sun, 20 Aug 2023 22:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692596908; x=1693201708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VvC7ARMv+rWSmxbCrAo+4Fws2W+OhxdfWe6Kk+0rLw=;
        b=e5eaJG4uWH1hPRGcwrSPe2dZjxjud32dbQ5D3TiY1xWdhVXijvKooh9FCoe9NxolJU
         IhhrjdsySpg003uHvTDEdwRULoozHvzM18dBv12wJzVBCh7XheEmOPvFlW5g67JTjknO
         96KW+tFj2ApAHTajnwWD2YkfA1mB9y7WY2F4shZwqMcMI/R+1xguY7MP50Wqs4tIu/IH
         848JvUtuYldt/d71oB+I70irZWGH1W2YAa0RrgV/A6LDzrb7EJIxwRYqQd2XcXCqvRRX
         cXOaOw9NmZea7J2ImqVP5SFBKrFWE/Fjmg+A6vI9BtvQ44/dqBOSdrzqt5winm+BDRNv
         Y3Ig==
X-Gm-Message-State: AOJu0Yxbd2uwS5u0X9LgD1n4rLAbMp0NWthZSd1d6Iax7/P4P+gK+1su
	M1ed311tI+ZpOIGQbcEj/EEwbYr6IHuOeec+SCLSqAyl2ABvx46Yme+04gKitBz6twbaeo+m2Hu
	7oxIeiKuc8ryndi3Rl/n0Gh93MzgWDlqGtVNH/O867LBogOVomQh+sQ==
X-Received: by 2002:a05:6870:e304:b0:1bf:9fa2:bf94 with SMTP id z4-20020a056870e30400b001bf9fa2bf94mr8100168oad.5.1692596907673;
        Sun, 20 Aug 2023 22:48:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBiJyh0JKoUNzYe6/EnYriQlgWSiM9JSgNIYZNCGx500rNykk4ODWm3Wb6Sclh07HnWUYi0z9PVDCXk4M90NM=
X-Received: by 2002:a05:6870:e304:b0:1bf:9fa2:bf94 with SMTP id
 z4-20020a056870e30400b001bf9fa2bf94mr8100152oad.5.1692596907412; Sun, 20 Aug
 2023 22:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230731103758.117533-1-mlombard@redhat.com>
In-Reply-To: <20230731103758.117533-1-mlombard@redhat.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 21 Aug 2023 13:48:16 +0800
Message-ID: <CAHj4cs9_CngM4EXNEC_r1+wiE1+xyZgxOwGk8h6FSLG5QkSV6A@mail.gmail.com>
Subject: Re: [PATCH] nvme-rdma: do not try to stop unallocated queues
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	Maurizio Lombardi <mlombard@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230820_224840_542666_87A73732 
X-CRM114-Status: GOOD (  18.34  )
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

Tested-by: Yi Zhang <yi.zhang@redhat.com>

Thanks Maurizio, verified the below warning issue was fixed by this patch:

[  849.714153] nvme nvme2: Reconnecting in 10 seconds...
[  859.925767] nvme nvme2: Connect rejected: status -104 (reset by remote h=
ost).
[  859.933169] nvme nvme2: rdma connection establishment failed (-104)
[  859.949151] nvme nvme2: Failed reconnect attempt 60
[  859.954682] nvme nvme2: Removing ctrl: NQN "testnqn"
[  860.071263] ------------[ cut here ]------------
[  860.075909] DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
[  860.075924] WARNING: CPU: 4 PID: 355 at kernel/locking/mutex.c:582
__mutex_lock+0x116b/0x1490
[  860.089432] Modules linked in: nvme_rdma nvme_tcp nvme_fabrics
sch_mqprio sch_mqprio_lib 8021q garp mrp stp llc rfkill vfat fat
opa_vnic intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common rpcrdma isst_if_common skx_edac nfit
libnvdimm sunrpc ipmi_ssif x86_pkg_temp_thermal intel_powerclamp
coretemp rdma_ucm ib_srpt kvm_intel ib_isert ib_umad hfi1
iscsi_target_mod kvm ib_ipoib target_core_mod rdmavt mgag200 ib_iser
irqbypass iTCO_wdt rapl iTCO_vendor_support libiscsi drm_shmem_helper
intel_cstate dell_smbios scsi_transport_iscsi dcdbas mlx5_ib
intel_uncore wmi_bmof dell_wmi_descriptor drm_kms_helper i2c_algo_bit
acpi_ipmi mei_me pcspkr i2c_i801 mei lpc_ich ipmi_si i2c_smbus
intel_pch_thermal ipmi_devintf ipmi_msghandler iw_cxgb4
acpi_power_meter bnxt_re libcxgb rdma_cm ib_uverbs iw_cm ib_cm ib_core
drm fuse xfs libcrc32c sd_mod sg crct10dif_pclmul csiostor
crc32_pclmul crc32c_intel mlx5_core cxgb4 nvme ahci libahci mlxfw
nvme_core psample bnxt_en ghash_clmulni_intel nvme_common
[  860.089610]  pci_hyperv_intf libata megaraid_sas tg3 tls wmi
scsi_transport_fc t10_pi dm_mirror dm_region_hash dm_log dm_mod
[  860.190140] CPU: 4 PID: 355 Comm: kworker/u97:14 Tainted: G
W          6.5.0-rc6+ #1
[  860.198492] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS
2.13.3 12/13/2021
[  860.206066] Workqueue: nvme-delete-wq nvme_delete_ctrl_work [nvme_core]
[  860.212722] RIP: 0010:__mutex_lock+0x116b/0x1490
[  860.217349] Code: 08 84 d2 0f 85 cf 02 00 00 8b 05 5c 26 f4 01 85
c0 0f 85 c9 ef ff ff 48 c7 c6 a0 39 ae b6 48 c7 c7 80 37 ae b6 e8 d5
07 bf fd <0f> 0b e9 af ef ff ff 65 48 8b 1c 25 00 3e 20 00 48 89 d8 4d
89 ef
[  860.236105] RSP: 0018:ffffc9000810faf0 EFLAGS: 00010286
[  860.241342] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[  860.248479] RDX: 0000000000000002 RSI: 0000000000000004 RDI: 00000000000=
00001
[  860.255619] RBP: ffffc9000810fc50 R08: 0000000000000001 R09: ffffed117ad=
7df99
[  860.262761] R10: ffff888bd6befccb R11: 0000000000000001 R12: 00000000000=
00000
[  860.269901] R13: ffff888c50158210 R14: dffffc0000000000 R15: 00000000000=
00002
[  860.277046] FS:  0000000000000000(0000) GS:ffff888bd6a00000(0000)
knlGS:0000000000000000
[  860.285146] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  860.290900] CR2: 00007fb92d0694d0 CR3: 000000091f06c003 CR4: 00000000007=
706e0
[  860.298042] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  860.305186] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  860.312324] PKRU: 55555554
[  860.315045] Call Trace:
[  860.317499]  <TASK>
[  860.319615]  ? __warn+0xc9/0x350
[  860.322855]  ? __mutex_lock+0x116b/0x1490
[  860.326877]  ? report_bug+0x326/0x3c0
[  860.330553]  ? handle_bug+0x3c/0x70
[  860.334060]  ? exc_invalid_op+0x14/0x50
[  860.337909]  ? asm_exc_invalid_op+0x16/0x20
[  860.342119]  ? __mutex_lock+0x116b/0x1490
[  860.346142]  ? __pfx___lock_acquired+0x10/0x10
[  860.350605]  ? nvme_rdma_stop_queue+0x1b/0xa0 [nvme_rdma]
[  860.356020]  ? find_held_lock+0x33/0x120
[  860.359957]  ? local_clock_noinstr+0x9/0xc0
[  860.364150]  ? __pfx___mutex_lock+0x10/0x10
[  860.368350]  ? __pfx___lock_release+0x10/0x10
[  860.372728]  ? down_read+0xbe/0x4c0
[  860.376232]  ? __up_read+0x1fe/0x760
[  860.379818]  ? __kmem_cache_free+0xc2/0x2c0
[  860.384015]  ? __pfx___up_read+0x10/0x10
[  860.387953]  ? nvme_rdma_stop_queue+0x1b/0xa0 [nvme_rdma]
[  860.393363]  nvme_rdma_stop_queue+0x1b/0xa0 [nvme_rdma]
[  860.398598]  nvme_rdma_teardown_io_queues.part.0+0xc6/0x210 [nvme_rdma]
[  860.405223]  nvme_rdma_delete_ctrl+0x59/0x110 [nvme_rdma]
[  860.410639]  nvme_do_delete_ctrl+0x14b/0x230 [nvme_core]
[  860.415976]  process_one_work+0x952/0x1660
[  860.420088]  ? __lock_acquired+0x207/0x7b0
[  860.424199]  ? __pfx_process_one_work+0x10/0x10
[  860.428742]  ? __pfx___lock_acquired+0x10/0x10
[  860.433203]  ? worker_thread+0x15a/0xef0
[  860.437140]  worker_thread+0x5be/0xef0
[  860.440903]  ? __pfx_worker_thread+0x10/0x10
[  860.445180]  kthread+0x2f1/0x3d0
[  860.448420]  ? __pfx_kthread+0x10/0x10
[  860.452184]  ret_from_fork+0x2d/0x70
[  860.455772]  ? __pfx_kthread+0x10/0x10
[  860.459532]  ret_from_fork_asm+0x1b/0x30
[  860.463478]  </TASK>
[  860.465678] irq event stamp: 769087
[  860.469178] hardirqs last  enabled at (769087):
[<ffffffffb5202c31>] __free_object+0x611/0xcf0
[  860.477790] hardirqs last disabled at (769086):
[<ffffffffb5202d92>] __free_object+0x772/0xcf0
[  860.486407] softirqs last  enabled at (768672):
[<ffffffffb66571ab>] __do_softirq+0x5db/0x8f6
[  860.494933] softirqs last disabled at (768665):
[<ffffffffb424b63c>] __irq_exit_rcu+0xbc/0x210
[  860.503551] ---[ end trace 0000000000000000 ]---
[  860.540254] nvme nvme2: Property Set error: 880, offset 0x14



On Mon, Jul 31, 2023 at 6:43=E2=80=AFPM Maurizio Lombardi <mlombard@redhat.=
com> wrote:
>
> Trying to stop a queue which hasn't been allocated will result
> in a warning due to calling mutex_lock() against an uninitialized mutex.
>
>  DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
>  WARNING: CPU: 4 PID: 104150 at kernel/locking/mutex.c:579
>
>  Call trace:
>   RIP: 0010:__mutex_lock+0x1173/0x14a0
>   nvme_rdma_stop_queue+0x1b/0xa0 [nvme_rdma]
>   nvme_rdma_teardown_io_queues.part.0+0xb0/0x1d0 [nvme_rdma]
>   nvme_rdma_delete_ctrl+0x50/0x100 [nvme_rdma]
>   nvme_do_delete_ctrl+0x149/0x158 [nvme_core]
>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  drivers/nvme/host/rdma.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index d433b2ec07a6..00b13336125e 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -638,6 +638,9 @@ static void __nvme_rdma_stop_queue(struct nvme_rdma_q=
ueue *queue)
>
>  static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
>  {
> +       if (!test_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
> +               return;
> +
>         mutex_lock(&queue->queue_lock);
>         if (test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags))
>                 __nvme_rdma_stop_queue(queue);
> --
> 2.39.3
>
>


--=20
Best Regards,
  Yi Zhang


