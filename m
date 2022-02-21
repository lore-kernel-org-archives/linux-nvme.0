Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59A4C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Feb 2022 06:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=He1kT7ozrmK0HGnqbP1KHIkog5ss7P4a5K1jwlusFHU=; b=gbnOtxxwv+fpEPfXWmPbK7oSWp
	8cg9p5EIHdc6wzjILLWMxsXtGPtoV/KaaAhLfzL+5GgGQ7MYu+oNP8OIf0FtDrg3gpRKXCXc5LvzV
	FJ48f5sZtFXyfGq4s8s5fS1Vm3qNc6TYLLTc7XsQ2Zaf/hg2FR9cjJ2v1Wno0GuGPM/Lyt9Nmx/XM
	2AT8RSQ4ozlaUcmofy/Cs+tLp2RkN0cJeFD6OxsYIy492ZGXMQ+WfF1j5y1zMPpKIysH3myizZ4zr
	aUXQKoz1RqQdSFOEnI91QDUOB8iX+naCcu5aJ3MKl0JsZnNXJOo6yo2tooLsd6V7WQZxhvoawT5Tl
	Z/Wf515g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nM1t3-003bIf-Vw; Mon, 21 Feb 2022 06:09:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nM1sz-003bI1-TY
 for linux-nvme@lists.infradead.org; Mon, 21 Feb 2022 06:09:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645423763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=He1kT7ozrmK0HGnqbP1KHIkog5ss7P4a5K1jwlusFHU=;
 b=FCguXpeT0Nq8KpZoKXrHMs3tl/vvAQsiXRseej0rForBpxdJmfhwBzIL7k9P+VXEksWflr
 ABOQcxJFz85mCOVbqQAmlQyFmDRBeBSBH+rOJ0ibclEqPA7Qz/Xeg0RtzdUB+fb72eptEe
 5i21V/NQCjf44UpdGcW3+Zpeo/DPQ14=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-zmqVtIKiPw627yFzDMHVFg-1; Mon, 21 Feb 2022 01:09:22 -0500
X-MC-Unique: zmqVtIKiPw627yFzDMHVFg-1
Received: by mail-pj1-f71.google.com with SMTP id
 n4-20020a17090ade8400b001b8bb511c3bso7664571pjv.7
 for <linux-nvme@lists.infradead.org>; Sun, 20 Feb 2022 22:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=He1kT7ozrmK0HGnqbP1KHIkog5ss7P4a5K1jwlusFHU=;
 b=S46tXLRTfPShu+u2M2Q/se7BXtMRDiu3MV9Ije+DKtpVvtBxPRnCW2AazQ/ICavvIk
 oM7t/AmAoc4U/yDkXgLcXLUJGksm9esPHefQNbbjsoUCRTjQYWNqP04MCbj566K6nwrf
 xWwbE8lzKs+ZJTr8sxx8gSdqzc/ZbJy9l3Yf+7GRAc2+KMF79O7uWkKsiSgwxjSoFBRn
 f6vn5AGbPDOkZq/ho5t7kD/G5gVu5VeGyyPsbM4xv/hczvMCKjY3KNEo/hpaxYEMwuQA
 XmQ4BEt3iXJ8pbSdZDQrJxdAWQ9zF2+jJCjkQUtcRkdBtDUmT5cATAs9he3sQatUnsna
 3bdw==
X-Gm-Message-State: AOAM532PDNliZpijW2UrNTy2G4fEmf4uR/qbiT/hR+wdilzSQImuIzG1
 9VXvyzO6CybVvvZLNh3xa/vCYT/SIxqL+6PK9wrA1jvRx2krTpEfMhebbrJHQH5rsoXtxbTvDbO
 eyKMHP5d80X/CR/p/Pw+9IOq2ZQCrRwhOGCi3dhpE054=
X-Received: by 2002:a17:90b:3607:b0:1b8:efe5:9008 with SMTP id
 ml7-20020a17090b360700b001b8efe59008mr19954282pjb.163.1645423760578; 
 Sun, 20 Feb 2022 22:09:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxN5SNWHrk89SCy4Xc1Jf8cGK10gRrS2bIX6Z5kQZkeeqqwHXXk+K5FUPWwdaKbQdKIiYgu1Rhh3BrjtyDIze4=
X-Received: by 2002:a17:90b:3607:b0:1b8:efe5:9008 with SMTP id
 ml7-20020a17090b360700b001b8efe59008mr19954259pjb.163.1645423760123; Sun, 20
 Feb 2022 22:09:20 -0800 (PST)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 21 Feb 2022 14:09:08 +0800
Message-ID: <CAHj4cs8JubedHJi2z4dUp47afiknpHx_9QAKPmXT5CyWufQr_A@mail.gmail.com>
Subject: [bug report] NVMe/IB: WARNING: possible circular locking dependency
 detected on target after connect
To: RDMA mailing list <linux-rdma@vger.kernel.org>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220220_220926_270786_E62A511A 
X-CRM114-Status: UNSURE (   6.13  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello
The below WARNING was triggered on the target side after a connection
on  5.17.0-rc3, here is the full log, let me if you need any tests for
it, thanks

HW:
# lspci | grep -i mel
04:00.0 Infiniband controller: Mellanox Technologies MT27700 Family [ConnectX-4]
04:00.1 Infiniband controller: Mellanox Technologies MT27700 Family [ConnectX-4]

dmesg:
[  514.481280] null_blk: module loaded
[  523.597381] nvmet: adding nsid 1 to subsystem testnqn
[  523.612212] nvmet_rdma: enabling port 2 (172.31.0.202:4420)
[  525.520199] mlx5_ib0.8008: multicast join failed for
ff12:401b:8008:0000:0000:0000:ffff:ffff, status -22
[  526.543740] mlx5_ib0.8016: multicast join failed for
ff12:401b:8016:0000:0000:0000:ffff:ffff, status -22

[  540.633829] ======================================================
[  540.640765] WARNING: possible circular locking dependency detected
[  540.647709] 5.17.0-rc3.rc3.debug #3 Tainted: G S
[  540.655117] ------------------------------------------------------
[  540.662753] kworker/10:3/1152 is trying to acquire lock:
[  540.669414] ffff88810005c548 ((wq_completion)events){+.+.}-{0:0},
at: flush_workqueue+0xe6/0x1400
[  540.680127]
               but task is already holding lock:
[  540.688047] ffff8883914483e0
(&id_priv->handler_mutex/1){+.+.}-{3:3}, at:
cma_ib_req_handler+0x1709/0x4a60 [rdma_cm]
[  540.700602]
               which lock already depends on the new lock.

[  540.712121]
               the existing dependency chain (in reverse order) is:
[  540.722123]
               -> #10 (&id_priv->handler_mutex/1){+.+.}-{3:3}:
[  540.731728]        lock_acquire+0x1d2/0x5a0
[  540.737298]        __mutex_lock+0x155/0x15f0
[  540.742975]        cma_ib_req_handler+0x1709/0x4a60 [rdma_cm]
[  540.750330]        cm_process_work+0x47/0x190 [ib_cm]
[  540.756928]        cm_req_handler+0x2235/0x6fd0 [ib_cm]
[  540.763727]        cm_work_handler+0x1acf/0x4a30 [ib_cm]
[  540.770637]        process_one_work+0x97e/0x1700
[  540.776770]        worker_thread+0x87/0xb30
[  540.782429]        kthread+0x29d/0x340
[  540.787609]        ret_from_fork+0x22/0x30
[  540.793186]
               -> #9 (&id_priv->handler_mutex){+.+.}-{3:3}:
[  540.802794]        lock_acquire+0x1d2/0x5a0
[  540.808510]        __mutex_lock+0x155/0x15f0
[  540.814331]        cma_ib_req_handler+0xf86/0x4a60 [rdma_cm]
[  540.821736]        cm_process_work+0x47/0x190 [ib_cm]
[  540.828477]        cm_req_handler+0x2235/0x6fd0 [ib_cm]
[  540.835424]        cm_work_handler+0x1acf/0x4a30 [ib_cm]
[  540.842485]        process_one_work+0x97e/0x1700
[  540.848768]        worker_thread+0x87/0xb30
[  540.854575]        kthread+0x29d/0x340
[  540.859903]        ret_from_fork+0x22/0x30
[  540.865628]
               -> #8 ((work_completion)(&(&work->work)->work)){+.+.}-{0:0}:
[  540.877103]        lock_acquire+0x1d2/0x5a0
[  540.882984]        process_one_work+0x8dd/0x1700
[  540.889364]        worker_thread+0x87/0xb30
[  540.895267]        kthread+0x29d/0x340
[  540.900688]        ret_from_fork+0x22/0x30
[  540.906509]
               -> #7 ((wq_completion)ib_cm){+.+.}-{0:0}:
[  540.916268]        lock_acquire+0x1d2/0x5a0
[  540.922155]        flush_workqueue+0x109/0x1400
[  540.928418]        cm_remove_one+0x31d/0x560 [ib_cm]
[  540.935164]        remove_client_context+0xa9/0xf0 [ib_core]
[  540.942712]        disable_device+0x12d/0x210 [ib_core]
[  540.949754]        __ib_unregister_device+0x80/0x160 [ib_core]
[  540.957456]        ib_unregister_device+0x21/0x30 [ib_core]
[  540.964844]        __mlx5_ib_remove+0x88/0xe0 [mlx5_ib]
[  540.971848]        auxiliary_bus_remove+0x55/0x80
[  540.978213]        device_release_driver_internal+0x1e5/0x4a0
[  540.985713]        bus_remove_device+0x2a9/0x570
[  540.991936]        device_del+0x54a/0xd10
[  540.997483]        mlx5_rescan_drivers_locked+0x1d4/0x830 [mlx5_core]
[  541.005879]        mlx5_lag_remove_devices+0xcb/0x110 [mlx5_core]
[  541.013867]        mlx5_do_bond_work+0x83c/0xf00 [mlx5_core]
[  541.021361]        process_one_work+0x97e/0x1700
[  541.027611]        worker_thread+0x87/0xb30
[  541.033361]        kthread+0x29d/0x340
[  541.038627]        ret_from_fork+0x22/0x30
[  541.044272]
               -> #6 (&device->unregistration_lock){+.+.}-{3:3}:
[  541.054465]        lock_acquire+0x1d2/0x5a0
[  541.060212]        __mutex_lock+0x155/0x15f0
[  541.066050]        __ib_unregister_device+0x24/0x160 [ib_core]
[  541.073675]        ib_unregister_device+0x21/0x30 [ib_core]
[  541.081015]        __mlx5_ib_remove+0x88/0xe0 [mlx5_ib]
[  541.087966]        auxiliary_bus_remove+0x55/0x80
[  541.094325]        device_release_driver_internal+0x1e5/0x4a0
[  541.101856]        bus_remove_device+0x2a9/0x570
[  541.108117]        device_del+0x54a/0xd10
[  541.113701]        mlx5_rescan_drivers_locked+0x1d4/0x830 [mlx5_core]
[  541.122096]        mlx5_lag_remove_devices+0xcb/0x110 [mlx5_core]
[  541.130104]        mlx5_do_bond_work+0x83c/0xf00 [mlx5_core]
[  541.137619]        process_one_work+0x97e/0x1700
[  541.143899]        worker_thread+0x87/0xb30
[  541.149689]        kthread+0x29d/0x340
[  541.154988]        ret_from_fork+0x22/0x30
[  541.160678]
               -> #5 (&esw->mode_lock_key#2){+.+.}-{3:3}:
[  541.170295]        lock_acquire+0x1d2/0x5a0
[  541.176080]        down_write+0x9e/0x3d0
[  541.181554]        mlx5_do_bond_work+0x15e/0xf00 [mlx5_core]
[  541.189061]        process_one_work+0x97e/0x1700
[  541.195329]        worker_thread+0x87/0xb30
[  541.201111]        kthread+0x29d/0x340
[  541.206407]        ret_from_fork+0x22/0x30
[  541.212091]
               -> #4 (&esw->mode_lock_key){+.+.}-{3:3}:
[  541.221482]        lock_acquire+0x1d2/0x5a0
[  541.227261]        down_write+0x9e/0x3d0
[  541.232734]        mlx5_do_bond_work+0x129/0xf00 [mlx5_core]
[  541.240242]        process_one_work+0x97e/0x1700
[  541.246503]        worker_thread+0x87/0xb30
[  541.252268]        kthread+0x29d/0x340
[  541.257537]        ret_from_fork+0x22/0x30
[  541.263177]
               -> #3 (mlx5_intf_mutex){+.+.}-{3:3}:
[  541.272098]        lock_acquire+0x1d2/0x5a0
[  541.277828]        __mutex_lock+0x155/0x15f0
[  541.283653]        mlx5_lag_add_mdev+0x36/0x610 [mlx5_core]
[  541.291011]        mlx5_load+0x1b6/0x240 [mlx5_core]
[  541.297671]        mlx5_init_one+0x337/0x470 [mlx5_core]
[  541.304713]        probe_one+0x412/0x5f0 [mlx5_core]
[  541.311366]        local_pci_probe+0xde/0x170
[  541.317274]        work_for_cpu_fn+0x51/0xa0
[  541.323084]        process_one_work+0x97e/0x1700
[  541.329286]        worker_thread+0x538/0xb30
[  541.335100]        kthread+0x29d/0x340
[  541.340309]        ret_from_fork+0x22/0x30
[  541.345905]
               -> #2 (&dev->intf_state_mutex){+.+.}-{3:3}:
[  541.355423]        lock_acquire+0x1d2/0x5a0
[  541.361115]        __mutex_lock+0x155/0x15f0
[  541.366885]        mlx5_init_one+0x2e/0x470 [mlx5_core]
[  541.373799]        probe_one+0x412/0x5f0 [mlx5_core]
[  541.380421]        local_pci_probe+0xde/0x170
[  541.386286]        work_for_cpu_fn+0x51/0xa0
[  541.392052]        process_one_work+0x97e/0x1700
[  541.398195]        worker_thread+0x538/0xb30
[  541.403930]        kthread+0x29d/0x340
[  541.409083]        ret_from_fork+0x22/0x30
[  541.414615]
               -> #1 ((work_completion)(&wfc.work)){+.+.}-{0:0}:
[  541.424600]        lock_acquire+0x1d2/0x5a0
[  541.430253]        process_one_work+0x8dd/0x1700
[  541.436396]        worker_thread+0x87/0xb30
[  541.442049]        kthread+0x29d/0x340
[  541.447204]        ret_from_fork+0x22/0x30
[  541.452748]
               -> #0 ((wq_completion)events){+.+.}-{0:0}:
[  541.462048]        check_prevs_add+0x3fd/0x2480
[  541.468075]        __lock_acquire+0x2402/0x2fa0
[  541.474100]        lock_acquire+0x1d2/0x5a0
[  541.479739]        flush_workqueue+0x109/0x1400
[  541.485770]        nvmet_rdma_queue_connect+0x1c79/0x2610 [nvmet_rdma]
[  541.494059]        cma_cm_event_handler+0xf2/0x530 [rdma_cm]
[  541.501382]        cma_ib_req_handler+0x1a76/0x4a60 [rdma_cm]
[  541.508809]        cm_process_work+0x47/0x190 [ib_cm]
[  541.515456]        cm_req_handler+0x2235/0x6fd0 [ib_cm]
[  541.522294]        cm_work_handler+0x1acf/0x4a30 [ib_cm]
[  541.529225]        process_one_work+0x97e/0x1700
[  541.535380]        worker_thread+0x87/0xb30
[  541.541050]        kthread+0x29d/0x340
[  541.546235]        ret_from_fork+0x22/0x30
[  541.551807]
               other info that might help us debug this:

[  541.563694] Chain exists of:
                 (wq_completion)events --> &id_priv->handler_mutex -->
&id_priv->handler_mutex/1

[  541.581095]  Possible unsafe locking scenario:

[  541.589747]        CPU0                    CPU1
[  541.595828]        ----                    ----
[  541.601891]   lock(&id_priv->handler_mutex/1);
[  541.607873]                                lock(&id_priv->handler_mutex);
[  541.616508]                                lock(&id_priv->handler_mutex/1);
[  541.625321]   lock((wq_completion)events);
[  541.630935]
                *** DEADLOCK ***

[  541.640567] 4 locks held by kworker/10:3/1152:
[  541.646535]  #0: ffff8891339a0548
((wq_completion)ib_cm){+.+.}-{0:0}, at: process_one_work+0x857/0x1700
[  541.658114]  #1: ffff88832ebcfe08
((work_completion)(&(&work->work)->work)){+.+.}-{0:0}, at:
process_one_work+0x88b/0x1700
[  541.671586]  #2: ffff8884081a53e0
(&id_priv->handler_mutex){+.+.}-{3:3}, at:
cma_ib_req_handler+0xf86/0x4a60 [rdma_cm]
[  541.684712]  #3: ffff8883914483e0
(&id_priv->handler_mutex/1){+.+.}-{3:3}, at:
cma_ib_req_handler+0x1709/0x4a60 [rdma_cm]
[  541.698155]
               stack backtrace:
[  541.705358] CPU: 10 PID: 1152 Comm: kworker/10:3 Tainted: G S
         5.17.0-rc3.rc3.debug #3
[  541.716799] Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS
1.6.2 01/08/2016
[  541.726409] Workqueue: ib_cm cm_work_handler [ib_cm]
[  541.733209] Call Trace:
[  541.737175]  <TASK>
[  541.740741]  dump_stack_lvl+0x44/0x57
[  541.746073]  check_noncircular+0x280/0x320
[  541.751889]  ? lock_chain_count+0x20/0x20
[  541.757611]  ? print_circular_bug.isra.47+0x430/0x430
[  541.764505]  ? mark_lock.part.52+0x107/0x1210
[  541.770616]  ? mark_lock.part.52+0x107/0x1210
[  541.776715]  ? lock_chain_count+0x20/0x20
[  541.782423]  ? lock_chain_count+0x20/0x20
[  541.788118]  check_prevs_add+0x3fd/0x2480
[  541.793800]  ? sched_clock_cpu+0x15/0x200
[  541.799470]  ? check_irq_usage+0xb50/0xb50
[  541.805226]  ? lockdep_lock+0xcb/0x1c0
[  541.810587]  ? static_obj+0xc0/0xc0
[  541.815649]  ? sched_clock_cpu+0x15/0x200
[  541.821295]  __lock_acquire+0x2402/0x2fa0
[  541.826930]  ? rcu_read_lock_bh_held+0xc0/0xc0
[  541.833061]  lock_acquire+0x1d2/0x5a0
[  541.838316]  ? flush_workqueue+0xe6/0x1400
[  541.844066]  ? rcu_read_unlock+0x50/0x50
[  541.849618]  ? lockdep_init_map_type+0x2f8/0x7f0
[  541.855950]  ? lockdep_init_map_type+0x2f8/0x7f0
[  541.862267]  flush_workqueue+0x109/0x1400
[  541.867898]  ? flush_workqueue+0xe6/0x1400
[  541.873610]  ? rdma_create_qp+0x423/0x6d0 [rdma_cm]
[  541.880188]  ? nvmet_rdma_create_queue_ib+0x7e1/0xa90 [nvmet_rdma]
[  541.888236]  ? check_flush_dependency+0x410/0x410
[  541.894638]  ? _raw_spin_unlock_irqrestore+0x3b/0x50
[  541.901348]  ? nvmet_rdma_queue_connect+0x1c79/0x2610 [nvmet_rdma]
[  541.909442]  nvmet_rdma_queue_connect+0x1c79/0x2610 [nvmet_rdma]
[  541.917357]  ? nvmet_rdma_alloc_cmds+0xd80/0xd80 [nvmet_rdma]
[  541.924970]  ? sched_clock_cpu+0x15/0x200
[  541.930652]  ? find_held_lock+0x3a/0x1c0
[  541.936219]  ? lock_release+0x42f/0xc90
[  541.941685]  ? lock_downgrade+0x6b0/0x6b0
[  541.947350]  ? lock_is_held_type+0xd9/0x130
[  541.953219]  ? rcu_read_lock_sched_held+0xaf/0xe0
[  541.959673]  ? rdma_find_gid+0x3d0/0x3d0 [ib_core]
[  541.966219]  ? rcu_read_lock_bh_held+0xc0/0xc0
[  541.972318]  ? lock_is_held_type+0xd9/0x130
[  541.978088]  cma_cm_event_handler+0xf2/0x530 [rdma_cm]
[  541.984922]  cma_ib_req_handler+0x1a76/0x4a60 [rdma_cm]
[  541.991815]  ? stack_trace_save+0x8a/0xb0
[  541.997355]  ? addr_handler+0x2a0/0x2a0 [rdma_cm]
[  542.003658]  ? alloc_list_entry+0x156/0x2c0
[  542.009343]  ? mark_lock.part.52+0x107/0x1210
[  542.015202]  ? lock_is_held_type+0xd9/0x130
[  542.020871]  ? cm_process_work+0x47/0x190 [ib_cm]
[  542.027130]  cm_process_work+0x47/0x190 [ib_cm]
[  542.033200]  ? _raw_spin_unlock+0x29/0x40
[  542.038683]  cm_req_handler+0x2235/0x6fd0 [ib_cm]
[  542.044947]  ? check_irq_usage+0xb50/0xb50
[  542.050528]  ? lockdep_lock+0xcb/0x1c0
[  542.055716]  ? cm_rep_handler+0x2440/0x2440 [ib_cm]
[  542.062199]  cm_work_handler+0x1acf/0x4a30 [ib_cm]
[  542.068590]  ? lock_is_held_type+0xd9/0x130
[  542.074307]  ? cm_req_handler+0x6fd0/0x6fd0 [ib_cm]
[  542.080815]  ? rcu_read_lock_sched_held+0xaf/0xe0
[  542.087126]  ? rcu_read_lock_bh_held+0xc0/0xc0
[  542.093144]  process_one_work+0x97e/0x1700
[  542.098777]  ? pwq_dec_nr_in_flight+0x270/0x270
[  542.104902]  worker_thread+0x87/0xb30
[  542.110056]  ? __kthread_parkme+0xc3/0x1d0
[  542.115698]  ? process_one_work+0x1700/0x1700
[  542.121627]  kthread+0x29d/0x340
[  542.126279]  ? kthread_complete_and_exit+0x20/0x20
[  542.132702]  ret_from_fork+0x22/0x30
[  542.137771]  </TASK>
[  542.192405] nvmet: creating nvm controller 1 for subsystem testnqn
for NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
[  546.991610] DMA-API: dma_debug_entry pool grown to 2162688 (3300%)

-- 
Best Regards,
  Yi Zhang


