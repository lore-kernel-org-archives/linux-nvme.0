Return-Path: <SRS0=KdjD=LS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AC2C49EA6
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 17:51:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B5B613C7
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 17:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B5B613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=a+8m1DL+1hmeaAQYyuuB1mCg2JMO05O5qZdj1QSx+Mc=; b=lKP9ej7dROc0JS
	FeeWIxUeUI/dZDRxpU/wba30jHPkVBClQO9qBHf+oFo0TKfDMGU14HNq5VP05nfc/zk+/voCk3XHM
	zLyy4A15by74OFIYevKwv0izWJSBADweloghrJwkUWgIVdsev4Bq+6z8ISY2yU1SEjPN5yPn/xKb0
	h5M9TpxI7CVOio9KjJO1+ICzhwOJydzjd1CpvYILsUioJ0X9BS1IdqodF5SGxf2dz8ZJkGElcWljo
	crdLFD/a4uDbeAgQh3KDpMaezR7McRtwiaihKiM40wnG0DHPGUb6f0wPnChS5gRpxsg0BjEol/Uvn
	VapBKjYQe4+Kh4su2UuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwTVC-00Fk1H-Aw; Thu, 24 Jun 2021 17:50:58 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwTCY-00Ff8o-9J
 for linux-nvme@lists.infradead.org; Thu, 24 Jun 2021 17:31:45 +0000
Received: by mail-pf1-x429.google.com with SMTP id g21so4085507pfc.11
 for <linux-nvme@lists.infradead.org>; Thu, 24 Jun 2021 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=xmipmZR09i0Ij/OpqIqcKio8xW4YT4WRGG6O4OoW61A=;
 b=TQLDMObX8SoMTca2HSrQ5Jwe9UKt0SBtSFDz06xGn3bTUibONiFfnwUxnvIgzY7q+e
 qv8Bv8mBFg20qFdwBMbyrzLugff9v4W2x3XGzMGISIJ9iqID9mCgFGKutfYO9qQlptDU
 2FaN58mwDGe8bdHVLZdhQb64Wt3PX2fLqXCJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=xmipmZR09i0Ij/OpqIqcKio8xW4YT4WRGG6O4OoW61A=;
 b=d9Rcvso5K0BsX3yQKyL70N/Tq9zqxx09Ptmz/NZIBgly3U2ch5Jz10nnusZxmWav3s
 QvMkChwm14Eb8VOsO+rSPJkyDkZR2WEtWAAD7DiUezbffcPSaQLI4PL3eZLeuhTsvGB5
 RNZXsOo+BEvG8dYsh4PJFd573KkXDx50yi2m9mFVkzshCRuH5mg8xq0zj57zaCJ3TSbr
 Xd1lznaldOOWW5yyfW0yeZoBqvIkVve9522TaLdiibMbfOGZHPVuwZp64mHc6UW7Ls9m
 yw/+KcxkijVc8ymKFgT6VwZ/vN3XVWQSmN65uS9Lkk6dcVwMAFdjYOSR5YlECnMkEQwn
 K6WQ==
X-Gm-Message-State: AOAM532BQ+dJp/cfhVZR6BGsHa7EQz7l7K7RT6zUbSpSaVO/Bds/O2zF
 uPHXgeL63nM3X6yxtyL/pBcE5iC9tAlMPCXuiyLWeP9arZcpbpL9NFSGFp8lXf/pZXVZtXJnocO
 luL1uvYEOawgUpTFTEfi+E1awNFicohc2Cw3OqJ3T9ghTZkH2L7AVsHBQgNLOKNkNXiqgc7wJ0g
 ja0XXWun0=
X-Google-Smtp-Source: ABdhPJyep+vXMKmgmqGnXdi6yudryxdK22kXUuCeKj7CGutJqQipSepCnsPAgIWwr8OtUQeTTTIeQw==
X-Received: by 2002:a63:66c7:: with SMTP id a190mr5740059pgc.123.1624555900292; 
 Thu, 24 Jun 2021 10:31:40 -0700 (PDT)
Received: from yoga.purestorage.com ([192.30.189.3])
 by smtp.googlemail.com with ESMTPSA id gg5sm8488537pjb.0.2021.06.24.10.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jun 2021 10:31:40 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-nvme@lists.infradead.org
Cc: yzhong@purestorage.com, ashishk@purestorage.com,
 Casey Chen <cachen@purestorage.com>
Subject: [PATCH 0/2] rr: nvme-pci: fix races and UAF
Date: Thu, 24 Jun 2021 10:31:23 -0700
Message-Id: <20210624173125.20376-1-cachen@purestorage.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210624_103142_479193_9025FA41 
X-CRM114-Status: GOOD (  10.33  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Found two bugs while power-cycling PCIe NVMe drive for hours:
- Races in nvme_setup_io_queues()
- UAF introduced by nvme_dev_remove_admin(), which is found
after fixing the races. Without fixing the races, the system
just crashes and cannot survive to reproduce the UAF.

The proposed fixes have been tested for several days for correctness.

0. Code baseline

Tag nvme-5.14-2021-06-08 of repo http://git.infradead.org/nvme.git

1. Testing method

while :; power off one drive;
    sleep $((RANDOM%3)).$((RANDOM%10));
    power on the same drive;
    sleep $((RANDOM%3)).$((RANDOM%10));
done

2. Sample crash trace due to races in nvme_setup_io_queues()
(task ID shown after the timestamps)

[11668.533431][  T716] pcieport 0000:87:08.0: pciehp: Slot(402): Card present
...
[11668.681298][T251231] nvme nvme12: pci function 0000:8c:00.0
[11668.681354][T26714] nvme 0000:8c:00.0: enabling device (0100 -> 0102)
[11669.046119][   C31] pcieport 0000:87:08.0: pciehp: pending interrupts 0x0108 from Slot Status
[11669.046142][  T716] pcieport 0000:87:08.0: pciehp: Slot(402): Link Down
[11669.046146][  T716] pcieport 0000:87:08.0: pciehp: Slot(402): Card not present
[11669.046149][  T716] pcieport 0000:87:08.0: pciehp: pciehp_unconfigure_device: domain:bus:dev = 0000:8c:00
[11669.077428][  T716] ------------[ cut here ]------------
[11669.077431][  T716] kernel BUG at drivers/pci/msi.c:348!
[11669.077555][  T716] invalid opcode: 0000 [#1] SMP KASAN
[11669.077658][  T716] CPU: 31 PID: 716 Comm: irq/127-pciehp Not tainted 5.13.0-rc3+
[11669.078022][  T716] RIP: 0010:free_msi_irqs+0x28a/0x2d0
...
[11669.093982][  T716] Call Trace:
[11669.096850][  T716]  pci_free_irq_vectors+0xe/0x20
[11669.099695][  T716]  nvme_dev_disable+0x140/0x760 [nvme]
[11669.102503][  T716]  ? _raw_spin_lock_irqsave+0x9c/0x100
[11669.105271][  T716]  ? trace_hardirqs_on+0x2c/0xe0
[11669.107994][  T716]  nvme_remove+0x191/0x1e0 [nvme]
[11669.110689][  T716]  pci_device_remove+0x6b/0x110
[11669.113316][  T716]  device_release_driver_internal+0x14f/0x280
[11669.115939][  T716]  pci_stop_bus_device+0xcb/0x100
[11669.118515][  T716]  pci_stop_and_remove_bus_device+0xe/0x20
[11669.121079][  T716]  pciehp_unconfigure_device+0xfa/0x200
[11669.123597][  T716]  ? pciehp_configure_device+0x1c0/0x1c0
[11669.126049][  T716]  ? trace_hardirqs_on+0x2c/0xe0
[11669.128444][  T716]  pciehp_disable_slot+0xc4/0x1a0
[11669.130771][  T716]  ? pciehp_runtime_suspend+0x40/0x40
[11669.133054][  T716]  ? __mutex_lock_slowpath+0x10/0x10
[11669.135289][  T716]  ? trace_hardirqs_on+0x2c/0xe0
[11669.137462][  T716]  pciehp_handle_presence_or_link_change+0x15c/0x4f0
[11669.139632][  T716]  ? down_read+0x11f/0x1a0
[11669.141731][  T716]  ? pciehp_handle_disable_request+0x80/0x80
[11669.143817][  T716]  ? rwsem_down_read_slowpath+0x600/0x600
[11669.145851][  T716]  ? __radix_tree_lookup+0xb2/0x130
[11669.147842][  T716]  pciehp_ist+0x19d/0x1a0
[11669.149790][  T716]  ? pciehp_set_indicators+0xe0/0xe0
[11669.151704][  T716]  ? irq_finalize_oneshot.part.46+0x1d0/0x1d0
[11669.153588][  T716]  irq_thread_fn+0x3f/0xa0
[11669.155407][  T716]  irq_thread+0x195/0x290
[11669.157147][  T716]  ? irq_thread_check_affinity.part.49+0xe0/0xe0
[11669.158883][  T716]  ? _raw_read_lock_irq+0x50/0x50
[11669.160611][  T716]  ? _raw_read_lock_irq+0x50/0x50
[11669.162320][  T716]  ? irq_forced_thread_fn+0xf0/0xf0
[11669.164032][  T716]  ? trace_hardirqs_on+0x2c/0xe0
[11669.165731][  T716]  ? irq_thread_check_affinity.part.49+0xe0/0xe0
[11669.167461][  T716]  kthread+0x1c8/0x1f0
[11669.169173][  T716]  ? kthread_parkme+0x40/0x40
[11669.170883][  T716]  ret_from_fork+0x22/0x30

3. KASAN report for the UAF introduced by nvme_dev_remove_admin()
(task ID is shown after the timestamp)

[18319.015748][T246989] nvme nvme13: pci function 0000:8c:00.0
[18319.015795][T215541] nvme 0000:8c:00.0: enabling device (0100 -> 0102)
[18319.369086][   C31] pcieport 0000:87:08.0: pciehp: pending interrupts 0x0108 from Slot Status
[18319.369107][  T716] pcieport 0000:87:08.0: pciehp: Slot(402): Link Down
[18319.369111][  T716] pcieport 0000:87:08.0: pciehp: Slot(402): Card not present
[18319.369116][  T716] pcieport 0000:87:08.0: pciehp: pciehp_unconfigure_device: domain:bus:dev = 0000:8c:00
[18320.452045][T215541] nvme nvme13: 88/0/0 default/read/poll queues
[18320.469475][T215541] nvme nvme13: failed to mark controller live state
[18320.469483][T215541] nvme nvme13: Removing after probe failure status: -19
[18320.551295][T215541] ==================================================================
[18320.551299][T215541] BUG: KASAN: use-after-free in __blk_mq_all_tag_iter+0x9c/0x3f0
[18320.551311][T215541] Read of size 4 at addr ffff888897904d04 by task kworker/u178:2/215541
[18320.551315][T215541] 
[18320.551318][T215541] CPU: 86 PID: 215541 Comm: kworker/u178:2 Not tainted 5.13.0-rc3+
[18320.551327][T215541] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
[18320.551339][T215541] Call Trace:
[18320.551343][T215541]  dump_stack+0xa4/0xdb
[18320.551354][T215541]  ? __blk_mq_all_tag_iter+0x9c/0x3f0
[18320.551359][T215541]  print_address_description.constprop.10+0x3a/0x60
[18320.551366][T215541]  ? __blk_mq_all_tag_iter+0x9c/0x3f0
[18320.551372][T215541]  ? __blk_mq_all_tag_iter+0x9c/0x3f0
[18320.551377][T215541]  ? blk_mq_update_nr_requests+0x2a0/0x2a0
[18320.551382][T215541]  kasan_report.cold.15+0x7c/0xd8
[18320.551390][T215541]  ? __blk_mq_all_tag_iter+0x9c/0x3f0
[18320.551395][T215541]  __blk_mq_all_tag_iter+0x9c/0x3f0
[18320.551401][T215541]  ? blk_mq_update_nr_requests+0x2a0/0x2a0
[18320.551407][T215541]  ? bt_iter+0xf0/0xf0
[18320.551412][T215541]  ? __blk_mq_all_tag_iter+0x2c9/0x3f0
[18320.551417][T215541]  ? blk_mq_update_nr_requests+0x2a0/0x2a0
[18320.551422][T215541]  ? bt_iter+0xf0/0xf0
[18320.551427][T215541]  ? dev_printk_emit+0x95/0xbb
[18320.551436][T215541]  blk_mq_tagset_busy_iter+0x75/0xa0
[18320.551441][T215541]  ? blk_mq_update_nr_requests+0x2a0/0x2a0
[18320.551446][T215541]  ? blk_mq_update_nr_requests+0x2a0/0x2a0
[18320.551451][T215541]  blk_mq_tagset_wait_completed_request+0x86/0xc0
[18320.551457][T215541]  ? blk_mq_tagset_busy_iter+0xa0/0xa0
[18320.551463][T215541]  ? blk_mq_tagset_busy_iter+0x80/0xa0
[18320.551469][T215541]  ? trace_event_raw_event_nvme_setup_cmd+0x2d0/0x2d0 [nvme_core]
[18320.551493][T215541]  nvme_dev_disable+0x4f6/0x760 [nvme]
[18320.551502][T215541]  ? trace_hardirqs_on+0x2c/0xe0
[18320.551510][T215541]  nvme_reset_work+0x226/0x2060 [nvme]
[18320.551520][T215541]  ? nvme_remove+0x1e0/0x1e0 [nvme]
[18320.551528][T215541]  ? __update_load_avg_cfs_rq+0x1d8/0x550
[18320.551537][T215541]  ? down_read+0x11f/0x1a0
[18320.551545][T215541]  ? newidle_balance+0x444/0x690
[18320.551552][T215541]  ? update_load_avg+0x626/0xbe0
[18320.551557][T215541]  ? update_cfs_group+0x1e/0x150
[18320.551562][T215541]  ? load_balance+0x11d0/0x11d0
[18320.551567][T215541]  ? dequeue_entity+0x150/0x730
[18320.551573][T215541]  ? nvme_irq_check+0x60/0x60 [nvme]
[18320.551581][T215541]  ? finish_task_switch+0x101/0x3d0
[18320.551588][T215541]  ? read_word_at_a_time+0xe/0x20
[18320.551594][T215541]  ? strscpy+0xc1/0x1d0
[18320.551598][T215541]  process_one_work+0x4b9/0x7b0
[18320.551604][T215541]  worker_thread+0x72/0x710
[18320.551610][T215541]  ? process_one_work+0x7b0/0x7b0
[18320.551614][T215541]  kthread+0x1c8/0x1f0
[18320.551618][T215541]  ? kthread_parkme+0x40/0x40
[18320.551622][T215541]  ret_from_fork+0x22/0x30
[18320.551630][T215541] 
[18320.551632][T215541] Allocated by task 215541:
[18320.551635][T215541]  kasan_save_stack+0x19/0x40
[18320.551639][T215541]  __kasan_kmalloc+0x7f/0xa0
[18320.551642][T215541]  kmem_cache_alloc_node_trace+0x187/0x2b0
[18320.551648][T215541]  blk_mq_init_tags+0x47/0x100
[18320.551651][T215541]  blk_mq_alloc_rq_map+0x44/0xf0
[18320.551656][T215541]  __blk_mq_alloc_map_and_request+0x7f/0x140
[18320.551661][T215541]  blk_mq_alloc_tag_set+0x25e/0x510
[18320.551666][T215541]  nvme_reset_work+0x14f9/0x2060 [nvme]
[18320.551674][T215541]  process_one_work+0x4b9/0x7b0
[18320.551678][T215541]  worker_thread+0x72/0x710
[18320.551682][T215541]  kthread+0x1c8/0x1f0
[18320.551685][T215541]  ret_from_fork+0x22/0x30
[18320.551689][T215541] 
[18320.551690][T215541] Freed by task 716:
[18320.551693][T215541]  kasan_save_stack+0x19/0x40
[18320.551696][T215541]  kasan_set_track+0x1c/0x30
[18320.551699][T215541]  kasan_set_free_info+0x20/0x30
[18320.551704][T215541]  __kasan_slab_free+0xec/0x130
[18320.551707][T215541]  kfree+0xa8/0x460
[18320.551712][T215541]  blk_mq_free_map_and_requests+0x8d/0xc0
[18320.551717][T215541]  blk_mq_free_tag_set+0x30/0xf0
[18320.551721][T215541]  nvme_remove+0x199/0x1e0 [nvme]
[18320.551729][T215541]  pci_device_remove+0x6b/0x110
[18320.551735][T215541]  device_release_driver_internal+0x14f/0x280
[18320.551744][T215541]  pci_stop_bus_device+0xcb/0x100
[18320.551750][T215541]  pci_stop_and_remove_bus_device+0xe/0x20
[18320.551754][T215541]  pciehp_unconfigure_device+0xfa/0x200
[18320.551761][T215541]  pciehp_disable_slot+0xc4/0x1a0
[18320.551765][T215541]  pciehp_handle_presence_or_link_change+0x15c/0x4f0
[18320.551770][T215541]  pciehp_ist+0x19d/0x1a0
[18320.551774][T215541]  irq_thread_fn+0x3f/0xa0
[18320.551780][T215541]  irq_thread+0x195/0x290
[18320.551783][T215541]  kthread+0x1c8/0x1f0
[18320.551786][T215541]  ret_from_fork+0x22/0x30
[18320.551791][T215541] 
[18320.551792][T215541] The buggy address belongs to the object at ffff888897904d00
[18320.551792][T215541]  which belongs to the cache kmalloc-192 of size 192
[18320.551795][T215541] The buggy address is located 4 bytes inside of
[18320.551795][T215541]  192-byte region [ffff888897904d00, ffff888897904dc0)
[18320.551800][T215541] The buggy address belongs to the page:
[18320.551802][T215541] page:000000002f3df664 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x897904
[18320.551807][T215541] head:000000002f3df664 order:1 compound_mapcount:0
[18320.551810][T215541] flags: 0x200000000010200(slab|head|node=0|zone=2)
[18320.551819][T215541] raw: 0200000000010200 dead000000000100 dead000000000122 ffff88810004ca00
[18320.551824][T215541] raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
[18320.551826][T215541] page dumped because: kasan: bad access detected
[18320.551828][T215541] 
[18320.551829][T215541] Memory state around the buggy address:
[18320.551832][T215541]  ffff888897904c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[18320.551835][T215541]  ffff888897904c80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[18320.551838][T215541] >ffff888897904d00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[18320.551841][T215541]                    ^
[18320.551843][T215541]  ffff888897904d80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[18320.551846][T215541]  ffff888897904e00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[18320.551848][T215541] ==================================================================
[18320.551850][T215541] Disabling lock debugging due to kernel taint

Casey Chen (2):
  nvme-pci: Fix multiple races in nvme_setup_io_queues()
  nvme-pci: Fix UAF introduced by nvme_dev_remove_admin()

 drivers/nvme/host/pci.c | 60 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 7 deletions(-)

-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
