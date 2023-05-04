Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4E0C7EE21
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 08:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jgRUABmwC9cB+38dbaX2NRXIr1+ErwV4GjrBR5f6Axg=; b=sl327/ilUM88jYZjG99+4fMWXP
	7KSxVdRA2w6DS2g4gSwzj2/lMu5Ep940+VfCLBdRDPucUruDUQvmv46mT5x7azro/YbDOYF+NtgWu
	AoDy8cs2YwJ0KI1qI7Dl+HzEmo3GTPE1GhFy5Dbr/0wNUL/k7WLjNQIaCmP1CPOhZxCinNNdno8Q3
	Pyq9iBHtfrhuP48e0nLGjmXLtVpSm0DhjNITeQwuliReG4aUTqbWq2nEBA1dPuiJdgcIeea4kbJ7c
	xu7D31v6NYsEv5u4lCJMDa/Fge5eJQF8gmGphV8uc08/KGnfEytbBzY3ESEh5vuoJMtKxvohgW+6n
	ryUMr2GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puUOJ-00786w-1a;
	Thu, 04 May 2023 08:32:43 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puUOF-007859-1t
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 08:32:41 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3065f1a873fso15246f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 04 May 2023 01:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683189157; x=1685781157;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgRUABmwC9cB+38dbaX2NRXIr1+ErwV4GjrBR5f6Axg=;
        b=i+FtbzvPsKMKLDVabmLSTJtiO6E7G2S2EFhA9c37ov6/lgCx5sVZbbho33CnQVMMMy
         SIQWDZ/MNzUkf7LqixH2es8RMZIIM++Fm5Iyw8mIJAJ9glSTq1AcT00VSFjKYLl5NR++
         DRPCU7K3aHEDWQwh/MWz7EVi8cKOhUULNP633LB0qKO77a9+TLDKwKfxq+57oswimO0M
         yQ3/zPxdrTbW47i6GT6Ce4NxWxVr6Ta59MOOlVDlInKuOih/+wsbUSJBcXSprZvTTaqJ
         r0pN9RmiYOcIxbKE/eueTypuvyvZOiOpJW0mnf6+AavtsIrGgmpT+MFdCaJKLmRlK69W
         Wb7A==
X-Gm-Message-State: AC+VfDzgolRpwH4GvxkoY4jFhdVCeMJm0txEiHRvEeiOVoUmSt3in2OF
	WHs79LJYXUrQLbp5oUU0MSCaB5oswe8=
X-Google-Smtp-Source: ACHHUZ4/YrzBZSNnYS0STEy/7adp21yZktwqOuSupGXQ4ameJixbmHgApoTnDsTed5sHb2UCm6Zz5g==
X-Received: by 2002:adf:f185:0:b0:2c7:660:9284 with SMTP id h5-20020adff185000000b002c706609284mr5374085wro.0.1683189157422;
        Thu, 04 May 2023 01:32:37 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d4492000000b0030632833e74sm8596483wrq.11.2023.05.04.01.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 01:32:37 -0700 (PDT)
Message-ID: <bca0fb81-38ae-f022-1270-70c7e415ac41@grimberg.me>
Date: Thu, 4 May 2023 11:32:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: slab-use-after-free in __ib_process_cq
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <d9da387d-b497-5120-5251-0c5d6a4adb71@acm.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d9da387d-b497-5120-5251-0c5d6a4adb71@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_013239_629608_23202DCD 
X-CRM114-Status: GOOD (  15.06  )
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


> Hi,
> 
> While testing Jens' for-next branch I encountered a use-after-free
> issue, triggered by test nvmeof-mp/002. This is not the first time I see
> this issue - I had already observed this several weeks ago but I had not
> yet had the time to report this.

That is surprising because this area did not change for quite a while now.

CCing linux-rdma as well, I'm assuming that this is with rxe?
Does this happen with siw as well?
> 
> Thanks,
> 
> Bart.
> 
> [ 1377.113215] 
> ==================================================================
> [ 1377.119731] BUG: KASAN: slab-use-after-free in 
> __ib_process_cq+0x11c/0x300 [ib_core]
> [ 1377.120242] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: 
> disconnected (10): status 0 id 00000000bcabdd1c
> [ 1377.123791] Read of size 8 at addr ffff88813e60e000 by task 
> ksoftirqd/24/140
> [ 1377.123799]
> [ 1377.123803] CPU: 24 PID: 140 Comm: ksoftirqd/24 Tainted: G        W   
> E      6.3.0-dbg #36
> [ 1377.123808] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
> 1.16.0-debian-1.16.0-5 04/01/2014
> [ 1377.123812] Call Trace:
> [ 1377.123815]  <TASK>
> [ 1377.123819]  dump_stack_lvl+0x4a/0x80
> [ 1377.123832]  print_address_description.constprop.0+0x33/0x3c0
> [ 1377.123841]  ? preempt_count_sub+0x18/0xc0
> [ 1377.129660] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing 
> queue 64
> [ 1377.132413]  print_report+0xb6/0x260
> [ 1377.133455] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma: 
> cm_id= 00000000bcabdd1c queue->state= 1
> [ 1377.135496]  ? kasan_complete_mode_report_info+0x5c/0x190
> [ 1377.138029] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing 
> queue 65
> [ 1377.138700]  kasan_report+0xc2/0xf0
> [ 1377.139328] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: 
> disconnected (10): status 0 id 000000005baa5f8f
> [ 1377.140304]  ? __ib_process_cq+0x11c/0x300 [ib_core]
> [ 1377.141857] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma: 
> cm_id= 000000005baa5f8f queue->state= 1
> [ 1377.142982]  ? __ib_process_cq+0x11c/0x300 [ib_core]
> [ 1377.144873] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing 
> queue 66
> [ 1377.145854]  __asan_load8+0x69/0x90
> [ 1377.150901] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: 
> disconnected (10): status 0 id 000000007181ad76
> [ 1377.152350]  __ib_process_cq+0x11c/0x300 [ib_core]
> [ 1377.154247] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma: 
> cm_id= 000000007181ad76 queue->state= 1
> [ 1377.155204]  ib_poll_handler+0x46/0x1b0 [ib_core]
> [ 1377.158327] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: 
> disconnected (10): status 0 id 000000005378c1fe
> [ 1377.159140]  irq_poll_softirq+0x1cb/0x2c0
> [ 1377.161765] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing 
> queue 67
> [ 1377.163108]  __do_softirq+0x115/0x645
> [ 1377.163119]  run_ksoftirqd+0x37/0x60
> [ 1377.163305] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma: 
> cm_id= 000000005378c1fe queue->state= 1
> [ 1377.163361] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing 
> queue 68
> [ 1377.163476] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: 
> disconnected (10): status 0 id 00000000a8044607
> [ 1377.163490] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma: 
> cm_id= 00000000a8044607 queue->state= 1
> [ 1377.163527] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing 
> queue 69
> [ 1377.163602] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: 
> disconnected (10): status 0 id 00000000cb366712
> [ 1377.163615] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma: 
> cm_id= 00000000cb366712 queue->state= 1
> [ 1377.163739] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: 
> disconnected (10): status 0 id 00000000f3c4860c
> [ 1377.163752] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma: 
> cm_id= 00000000f3c4860c queue->state= 1
> [ 1377.163818] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: 
> disconnected (10): status 0 id 00000000e4bc69e3
> [ 1377.163829] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma: 
> cm_id= 00000000e4bc69e3 queue->state= 1
> [ 1377.164168] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing 
> queue 70
> [ 1377.164644] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing 
> queue 71
> [ 1377.165068] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing 
> queue 72
> [ 1377.165961]  smpboot_thread_fn+0x2ef/0x400
> [ 1377.165967]  ? _local_bh_enable+0x80/0x80
> [ 1377.339612]  ? sort_range+0x30/0x30
> [ 1377.343292]  kthread+0x185/0x1c0
> [ 1377.347334]  ? kthread_complete_and_exit+0x30/0x30
> [ 1377.351696]  ret_from_fork+0x1f/0x30
> [ 1377.355575]  </TASK>
> [ 1377.359060]
> [ 1377.391814] Allocated by task 15493:
> [ 1377.401149]  kasan_save_stack+0x26/0x50
> [ 1377.408029]  kasan_set_track+0x25/0x30
> [ 1377.412759]  kasan_save_alloc_info+0x1e/0x30
> [ 1377.417555]  __kasan_kmalloc+0x90/0xa0
> [ 1377.421267]  __kmalloc+0x62/0x120
> [ 1377.424637]  nvme_rdma_create_queue_ib+0x1a7/0x710 [nvme_rdma]
> [ 1377.428692]  nvme_rdma_cm_handler+0x4fa/0x6b0 [nvme_rdma]
> [ 1377.432600]  cma_cm_event_handler+0x92/0x290 [rdma_cm]
> [ 1377.436409]  addr_handler+0x16f/0x280 [rdma_cm]
> [ 1377.440030]  process_one_req+0x91/0x290 [ib_core]
> [ 1377.443707]  process_one_work+0x552/0xa30
> [ 1377.447081]  worker_thread+0x90/0x650
> [ 1377.450319]  kthread+0x185/0x1c0
> [ 1377.453412]  ret_from_fork+0x1f/0x30
> [ 1377.456543]
> [ 1377.459034] Freed by task 16086:
> [ 1377.461988]  kasan_save_stack+0x26/0x50
> [ 1377.465075]  kasan_set_track+0x25/0x30
> [ 1377.468085]  kasan_save_free_info+0x2e/0x50
> [ 1377.471143]  ____kasan_slab_free+0x14f/0x1b0
> [ 1377.474226]  __kasan_slab_free+0x12/0x20
> [ 1377.477137]  __kmem_cache_free+0x1b6/0x2d0
> [ 1377.480045]  kfree+0x99/0x160
> [ 1377.482601]  nvme_rdma_destroy_queue_ib+0x1b8/0x250 [nvme_rdma]
> [ 1377.485962]  nvme_rdma_free_queue+0x3e/0x50 [nvme_rdma]
> [ 1377.489117]  nvme_rdma_configure_io_queues+0x138/0x390 [nvme_rdma]
> [ 1377.492549]  nvme_rdma_setup_ctrl+0x137/0x4a0 [nvme_rdma]
> [ 1377.495733]  nvme_rdma_create_ctrl+0x4bd/0x6c0 [nvme_rdma]
> [ 1377.498900]  nvmf_create_ctrl+0x1c8/0x4c0 [nvme_fabrics]
> [ 1377.502024]  nvmf_dev_write+0xb6/0x120 [nvme_fabrics]
> [ 1377.505228]  vfs_write+0x1b7/0x7b0
> [ 1377.507779]  ksys_write+0xbb/0x140
> [ 1377.510274]  __x64_sys_write+0x42/0x50
> [ 1377.512833]  do_syscall_64+0x34/0x80
> [ 1377.515301]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [ 1377.518157]
> [ 1377.520010] The buggy address belongs to the object at ffff88813e60e000
> [ 1377.520010]  which belongs to the cache kmalloc-4k of size 4096
> [ 1377.526186] The buggy address is located 0 bytes inside of
> [ 1377.526186]  freed 4096-byte region [ffff88813e60e000, ffff88813e60f000)
> [ 1377.532364]
> [ 1377.534252] The buggy address belongs to the physical page:
> [ 1377.537272] page:0000000098da500d refcount:1 mapcount:0 
> mapping:0000000000000000 index:0x0 pfn:0x13e608
> [ 1377.541367] head:0000000098da500d order:3 entire_mapcount:0 
> nr_pages_mapped:0 pincount:0
> [ 1377.545159] flags: 0x4000000000010200(slab|head|zone=2)
> [ 1377.548197] raw: 4000000000010200 ffff88810004d040 dead000000000122 
> 0000000000000000
> [ 1377.551942] raw: 0000000000000000 0000000000040004 00000001ffffffff 
> 0000000000000000
> [ 1377.555683] page dumped because: kasan: bad access detected
> [ 1377.558864]
> [ 1377.560967] Memory state around the buggy address:
> [ 1377.564075]  ffff88813e60df00: fc fc fc fc fc fc fc fc fc fc fc fc fc 
> fc fc fc
> [ 1377.567783]  ffff88813e60df80: fc fc fc fc fc fc fc fc fc fc fc fc fc 
> fc fc fc
> [ 1377.571461] >ffff88813e60e000: fa fb fb fb fb fb fb fb fb fb fb fb fb 
> fb fb fb
> [ 1377.575138]                    ^
> [ 1377.577761]  ffff88813e60e080: fb fb fb fb fb fb fb fb fb fb fb fb fb 
> fb fb fb
> [ 1377.581487]  ffff88813e60e100: fb fb fb fb fb fb fb fb fb fb fb fb fb 
> fb fb fb
> [ 1377.585194] 
> ==================================================================
> 

