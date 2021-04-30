Return-Path: <SRS0=VOor=J3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D393C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Apr 2021 16:41:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9624561420
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Apr 2021 16:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9624561420
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:MIME-Version:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=R2qpWBcj/lJB2zignFF/wafVqiDiOfEcSnTKrW86HT0=; b=NwxrsnNDmiCpgBbNb0AiQLHN1D
	9krnvIGdVyKgBYQxpstp+d94ApCcnKa+lzeJkOLyDTewg82bEl+/MfvFYhGt2VV+mac0uXDwITqFn
	RcQa+M/9y+LPiXslGHg+XcXPlJWwVurcMDM9qvNajrvhl1NArZK6YEsd6U1Uxi7NzC/NUbyzXxXEU
	3nID/DiYO4ockXX+Kop0aG+Ig6PsslQn74+pWKiBkMdSw6euj5t1u9bOmnDh8+OljKXDsD8JKl7m9
	5c8OIh5xLZzhV2v/2cMjNeTlb/dDztstObtQYqOCITvffe+4FcCrczpFsZjkyGMuk7NvPZ0fZw3lb
	SRoaDZcA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcWCN-008DMF-Bo; Fri, 30 Apr 2021 16:41:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcWCI-008DLE-NO
 for linux-nvme@lists.infradead.org; Fri, 30 Apr 2021 16:41:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619800843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=m9ZvoA2y9B2r0190G9s7+E2zUw1a2KeJnCCcJ7+UTa4=;
 b=h9LLg4gCCy1qoKM+9Aah+WnHKIDaH7zO9wdoJ3GKplhXsm2L0/5qsaL0k31iKfMYdjSbVs
 3C3CFZCL7PEs1oVJw7pnFwjGG4b1FNfNulPxn48ZQH3K7Vcwg7LpNyDEfrORb4NYXjmfTS
 M3CcaaJqUuC3+pBIYJW4GG7VTQ6Uj34=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619800852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=m9ZvoA2y9B2r0190G9s7+E2zUw1a2KeJnCCcJ7+UTa4=;
 b=H0qNNBZOaFKVedb4O51r5q0Q5yyQh/OM3IgyPDYWwabcaLP36LwKq+usNcxiQ0JUhlPvLW
 TDH4tGtQMXNc/x/ChnxR5M/445J1hL5m4WJTmV/C1cbGZoEZRTFeAskM2HD8eecYCNVCPr
 lEp/TINOTegFwT5EmUvKJueOxR+JTto=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-Q6Z7a5NUMMeazOuylqYTWA-1; Fri, 30 Apr 2021 12:40:41 -0400
X-MC-Unique: Q6Z7a5NUMMeazOuylqYTWA-1
Received: by mail-yb1-f197.google.com with SMTP id
 d89-20020a25a3620000b02904dc8d0450c6so50144594ybi.2
 for <linux-nvme@lists.infradead.org>; Fri, 30 Apr 2021 09:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=m9ZvoA2y9B2r0190G9s7+E2zUw1a2KeJnCCcJ7+UTa4=;
 b=TtnxYMeqrFTHjwa6lvyieBVYqR/iQDJFdins/DS03L2UdGXH4tHk+roaY57+rV7TAW
 wsAA8pdlsZtTcSWwH4ho6Wu4Bm5kMfOzw8SdgLPeDPP/qGh5lcOpN7fZmIHro3Ox5bIf
 8OLPXJ0W0gh4IwR7kIcWjlC+HDck6LdNd65obK2jiK+qgUAR0M7xAnUpSgaEv1051upI
 eXzPIAJVUT6symt4M5LaAps57wQdlfFrvvCEPwNONlrwsREtBCG0MDVVLG+dsJVcZzPP
 AxVBpC06h2c0NHPUG+5dyTMWec/dAKZji7Om5trp6XwJNIzhDhteclXdiBSPcSy5i1Lc
 Zg4A==
X-Gm-Message-State: AOAM533kXFWM2NHWI5+k6RnG2EBzg9D1LpG9oPZy8imZ2HH2MCKeamW+
 6EMfe5a0niMXPaixIoea7AuM3avyD6DcCnibhn6jv5CT8xtG0Cw7UhuWdt0YIwMmutTZhY2S/vD
 lixkEH4cudbExHwkGN6CMtRbbWRy3ULGMwQS9MUwkz28=
X-Received: by 2002:a25:cc8d:: with SMTP id l135mr7489982ybf.89.1619800840979; 
 Fri, 30 Apr 2021 09:40:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGEsgMKeWSRjwN1wjO4rQXyRUY0M96na4uoMJZp/IqC3pPb69T3VZMqHH2BUA4VVMwwsRFujJsxot3fd1yh6c=
X-Received: by 2002:a25:cc8d:: with SMTP id l135mr7489902ybf.89.1619800839922; 
 Fri, 30 Apr 2021 09:40:39 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 1 May 2021 00:40:26 +0800
Message-ID: <CAHj4cs-hAaHhWU4Kb4NrQ9Fvi7DiH95P=Q=7zK-inxpeZtztkw@mail.gmail.com>
Subject: [bug report] blktests nvme/022 lead kernel WARNING and NULL pointer
To: linux-nvme@lists.infradead.org
Cc: skt-results-master@redhat.com, Bruno Goncalves <bgoncalv@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210430_174058_941039_04BCCB61 
X-CRM114-Status: UNSURE (   6.64  )
X-CRM114-Notice: Please train this message.
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

Hello
Recently CKI reproduced this WARNING and NULL pointer with
linux-block/for-next on aarch64, seems it's one regression, I will try
if I can bisect the culprit.

blktests: nvme/022 (test NVMe reset command on NVMeOF file-backed ns)

[ 1879.759978] run blktests nvme/022 at 2021-04-30 12:30:36
[ 1879.804283] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1879.819087] nvmet: creating controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0da758a0-4d84-4133-82dd-9801235b55cd.
[ 1879.833081] nvmet: unhandled identify cns 6 on qid 0
[ 1879.838079] nvme nvme0: creating 128 I/O queues.
[ 1879.852353] nvme nvme0: new ctrl: "blktests-subsystem-1"
[ 1880.879731] nvme nvme0: resetting controller
[ 1889.940458] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[ 1889.946377] nvmet: ctrl 1 fatal error occurred!
[ 1889.950928] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[ 1892.810813] -
[ 1892.815427] WARNING: CPU: 30 PID: 5492 at
drivers/nvme/target/loop.c:466 nvme_loop_reset_ctrl_work+0x48/0xf0
[nvme_loop]
[ 1892.826293] Modules linked in: nvme_loop nvme_fabrics nvme_core
nvmet loop rfkill rpcrdma sunrpc rdma_ucm ib_srpt ib_isert
iscsi_target_mod target_core_mod ib_iser vfat libiscsi fat
scsi_transport_iscsi ib_umad rdma_cm ib_ipoib iw_cm ib_cm mlx5_ib
ib_uverbs i2c_smbus ib_core crct10dif_ce ghash_ce sha1_ce acpi_ipmi
ipmi_ssif ipmi_devintf ipmi_msghandler thunderx2_pmu ip_tables xfs
libcrc32c sr_mod cdrom mlx5_core ast i2c_algo_bit drm_vram_helper
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
drm_ttm_helper ttm drm uas mlxfw sha2_ce tls sha256_arm64 usb_storage
sg psample gpio_xlp i2c_xlp9xx dm_mirror dm_region_hash dm_log dm_mod
[last unloaded: nvmet]
[ 1892.885150] CPU: 30 PID: 5492 Comm: kworker/u513:5 Not tainted 5.12.0+ #1
[ 1892.891926] Hardware name: HPE Apollo 70             /C01_APACHE_MB
        , BIOS L50_5.13_1.16 07/29/2020
[ 1892.901654] Workqueue: nvme-reset-wq nvme_loop_reset_ctrl_work [nvme_loop]
[ 1892.908519] pstate: 40400009 (nZcv daif +PAN -UAO -TCO BTYPE=--)
[ 1892.914513] pc : nvme_loop_reset_ctrl_work+0x48/0xf0 [nvme_loop]
[ 1892.920508] lr : nvme_loop_reset_ctrl_work+0x40/0xf0 [nvme_loop]
[ 1892.926502] sp : fffffe0031b6fd70
[ 1892.929803] x29: fffffe0031b6fd70 x28: 0000000000000000
[ 1892.935105] x27: fffffc081065c0c0 x26: fffffc0807c2c26c
[ 1892.940405] x25: 0000000000000000 x24: fffffc084ae24898
[ 1892.945705] x23: 0000000000000000 x22: fffffc09410c1d00
[ 1892.951004] x21: fffffc084ae24890 x20: fffffc084ae244a0
[ 1892.956305] x19: fffffc084ae24000 x18: 0000000000000012
[ 1892.961604] x17: 0000000000000001 x16: 0000000000000019
[ 1892.966904] x15: fffffe0011d7e7e0 x14: fffffc8ba09cedf8
[ 1892.972204] x13: 0000000000000000 x12: 0000000000000003
[ 1892.977504] x11: fffffc8ba09ced40 x10: fffffe0011d7e7e8
[ 1892.982804] x9 : fffffe000ad60c58 x8 : fffffe8b650f0000
[ 1892.988104] x7 : 0000000000000008 x6 : fffffc0000000000
[ 1892.993403] x5 : 0000000000000000 x4 : ffffffff22f337e0
[ 1892.998703] x3 : fffffc084ae244ac x2 : 0000000000000001
[ 1893.004003] x1 : fffffc084ae244ac x0 : 0000000000000000
[ 1893.009303] Call trace:
[ 1893.011737]  nvme_loop_reset_ctrl_work+0x48/0xf0 [nvme_loop]
[ 1893.017384]  process_one_work+0x1d0/0x438
[ 1893.021385]  worker_thread+0x1f8/0x4d8
[ 1893.025123]  kthread+0x114/0x118
[ 1893.028341]  ret_from_fork+0x10/0x18
[ 1893.031907] ---[ end trace 883109425327ab60 ]---
[ 1893.301843] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000008
[ 1893.310620] Mem abort info:
[ 1893.313401]   ESR = 0x96000006
[ 1893.316442]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1893.321741]   SET = 0, FnV = 0
[ 1893.324783]   EA = 0, S1PTW = 0
[ 1893.327911] Data abort info:
[ 1893.330778]   ISV = 0, ISS = 0x00000006
[ 1893.334600]   CM = 0, WnR = 0
[ 1893.337555] user pgtable: 64k pages, 42-bit VAs, pgdp=0000000a0b750000
[ 1893.344069] [0000000000000008] pgd=0000000000000000,
p4d=0000000000000000, pud=0000000000000000, pmd=0000000000000000
[ 1893.354669] Internal error: Oops: 96000006 [#1] SMP
[ 1893.359535] Modules linked in: nvme_loop nvme_fabrics nvme_core
nvmet loop rfkill rpcrdma sunrpc rdma_ucm ib_srpt ib_ ib_ipoib iw_cm
intf ipmi_msghandrm_kms_helper s64 usb_storage s.418386] CPU: 0 PID:
12871 Comm: kworker/u513:0 Tainted: G        W         5.12.0+ #1
[ 1893.426551] Hardware name: HPE Apollo 70             /C01_APACHE_MB
        , BIOS L50_5.13_1.16 07/29/2020
[ 1893.436277] Workqueue: nvme-delete-wq nvme_delete_ctrl_work [nvme_core]
[ 1893.442892] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO BTYPE=--)
[ 1893.448886] pc : percpu_ref_kill_and_confirm+0x15c/0x178
[ 1893.454189] lr : nvmet_sq_destroy+0xec/0x1f0 [nvmet]
[ 1893.459149] sp : fffffe006466fc70
[ 1893.462449] x29: fffffe006466fc70 x28: 0000000000000000
[ 1893.467750] x27: fffffc8bcee4e5c0 x26: fffffc0807f57a6c
[ 1893.473051] x25: 0000000000000000 x24: fffffc084ae248b8
[ 1893.478351] x23: fffffc0854e600d0 x22: fffffe000ac40600
[ 1893.483650] x21: 0000000000000000 x20: fffffc0854e60090
[ 1893.488950] x19: fffffe0011d7e000 x18: 0000000000000016
[ 1893.494250] x17: 0000000000000001 x16: fffffc084e210598
[ 1893.499550] x15: fffffe0011d7e7e0 x14: fffffc8ba09cee18
[ 1893.504850] x13: 0000000000000000 x12: fffffe006466fc68
[ 1893.510149] x11: 0000000000000040 x10: fffffe001158b2f8
[ 1893.515449] x9 : fffffe000ad608ec x8 : fffffc082000cfc0
[ 1893.520749] x7 : 0000000000000001 x6 : fffffc0000000000
[ 1893.526049] x5 : 0000000000000080 x4 : 0000000000000000
[ 1893.531349] x3 : 0000000000000000 x2 : fffffe0011a4e000
[ 1893.536649] x1 : fffffe0010bdec08 x0 : fffffe0010e95000
[ 1893.541949] Call trace:
[ 1893.544383]  percpu_ref_kill_and_confirm+0x15c/0x178
[ 1893.549335]  nvmet_sq_destroy+0xec/0x1f0 [nvmet]
[ 1893.553945]  nvme_loop_destroy_io_queues+0x64/0x90 [nvme_loop]
[ 1893.559767]  nvme_loop_shutdown_ctrl+0x60/0xb8 [nvme_loop]
[ 1893.565240]  nvme_loop_delete_ctrl_host+0x18/0x20 [nvme_loop]
[ 1893.570973]  nvme_do_delete_ctrl+0x58/0x6c [nvme_core]
[ 1893.576106]  nvme_delete_ctrl_work+0x18/0x38 [nvme_core]
[ 1893.581411]  process_one_work+0x1d0/0x438
[ 1893.585410]  worker_thread+0x150/0x4d8
[ 1893.589148]  kthread+0x114/0x118
[ 1893.592364]  ret_from_fork+0x10/0x18
[ 1893.595929] Code: 39244840 f0003781 d0004d40 91302021 (f9400462)
[ 1893.602139] ---[ end trace 883109425327ab61 ]---
[ 1893.606744] Kernel panic - not syncing: Oops: Fatal exception
[ 1893.612512] SMP: stopping secondary CPUs
[ 1893.616474] Kernel Offset: disabled
[ 1893.619949] CPU features: 0x00046002,63000838
[ 1893.624293] Memory Limit: none
[ 1893.627362] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
