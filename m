Return-Path: <SRS0=sW0/=5L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F84AC43331
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 06:24:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7127320719
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 06:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jQ2Tno3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7127320719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:To:Subject:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=v0JVLno+RHeRmoKyGg0pQCeWGWn2nSqd8DqAAkmwfNA=; b=jQ2Tno3UHBz33E
	Cy/nYH9Smb80xL8jweJL8BmRB1t9LTJKNRhf/i+q+cSkmp5Rfo/4lSRp57Ce3Scf6ipxsFtDKa9Sh
	laltaokzK6fWm4V+D3qLjuvBEak231qL6poKVPQKd+wIUtzhxH2vy9wDs1x0gjphp3ERR6ucu+Q1D
	4HYVzVYySVPEw7q9agBFObFWvBTFREj7j5frYU9t+uZIeQBWJvamt3R7HgsZkcKHuQ8bSyYjn5mJj
	0MU0CM6aXMjtLE+5IyBe9dqmr2BbwpeO4HKrFhmn3a0n/yao1m+05mFhFqAXtT+q8CMpgWhg7gJi3
	EaOylWQFIvLPqDRA2R3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHLvu-0006oL-IC; Thu, 26 Mar 2020 06:24:02 +0000
Received: from mail-pf1-f170.google.com ([209.85.210.170])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHLvm-0006nm-55
 for linux-nvme@lists.infradead.org; Thu, 26 Mar 2020 06:23:58 +0000
Received: by mail-pf1-f170.google.com with SMTP id 22so2269973pfa.9
 for <linux-nvme@lists.infradead.org>; Wed, 25 Mar 2020 23:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=epma1qZI43BOWPjgj7aLvXo4UiAtvd1AOG0fdL4sCwQ=;
 b=pHX5I9j5kskxm2mBXn8bMdWKcZ59TRFSJG1gJf56/KFAVjR7SWKvw/fKNdQw6SEO2H
 EPkWINs0ojxVvg6jlaEiacBmezvwnZVxk/iXOA40lRCblRC5FkGaSSvXSKlJMhScVQSW
 A/Oq4u7/dqSIvWVjzQSkrcEkhzMeIe3pXPwoKwSLVaH+Ckt8vkCFwxC0HQOtGZw8dkAZ
 TX7zTrQMCcqlUWeiNTzdgiAqw3V4tYoq6HyBzBp9FeVt2oRKGojOILl47Hw/oiFG3c3S
 p6fHW+EFLIBzKaEzX4tGcRVDaorRTTvh5f9dHOGMRe+V9MgMBRhm2qXsiW0ta4PvhNHw
 LMtw==
X-Gm-Message-State: ANhLgQ28yFSPSAJhBEh+r9rAGPBUfb2XBWKXk5GZhjE/PqPFqFaIooIV
 nFEJwDNtvxJf7W6/C9A55Zs=
X-Google-Smtp-Source: ADFU+vv0jrsOrF/5/qEnpzApYgP+qHfmlCZy7uWQvggVxoZxN9uxwA2wmLVQcYphejulIJIIh6vxRg==
X-Received: by 2002:a63:ce42:: with SMTP id r2mr7301738pgi.106.1585203832841; 
 Wed, 25 Mar 2020 23:23:52 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2c87:e6f8:1c11:1d73?
 ([2601:647:4802:9070:2c87:e6f8:1c11:1d73])
 by smtp.gmail.com with ESMTPSA id d7sm811172pfo.86.2020.03.25.23.23.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Mar 2020 23:23:52 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
Subject: nvme deadlock with ANA
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 Anton Eidelman <anton@lightbitslabs.com>, Hannes Reinecke <hare@suse.de>
Message-ID: <5e38c566-3f26-288d-1004-161d1084b468@grimberg.me>
Date: Wed, 25 Mar 2020 23:23:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200325_232354_196438_6B41FC6F 
X-CRM114-Status: GOOD (  13.45  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey,

I want to consult with you guys on a deadlock condition I'm able to
hit with a test that incorporate controller reconnect, ana updates
and live I/O with timeouts.

This is true for NVMe/TCP, but can also happen in rdma or pci drivers as
well.

The deadlock combines 4 flows in parallel:
- ns scanning (triggered from reconnect)
- request timeout
- ANA update (triggered from reconnect)
- FS I/O coming into the mpath device

(1) ns scanning triggers disk revalidation -> update disk info ->
     freeze queue -> but blocked, why?

(2) timeout handler reference the g_usage_counter - > but blocks in
     the timeout handler, why?

(3) the timeout handler (indirectly) calls nvme_stop_queue() -> which
     takes the namespaces_rwsem - > but blocks, why?

(4) ANA update takes the namespaces_rwsem -> calls nvme_mpath_set_live()
     -> which synchronize the ns_head srcu (see commit 504db087aacc) ->
     but it blocks, why?

(5) FS I/O came into nvme_mpath_make_request -> took srcu_read_lock ->
     direct_make_request > blk_queue_enter -> but blocked, why?

==> because of (1), the request queue is under freeze -> deadlock.

Now as I said, this reproduced with nvme-tcp, rdma does pretty much the
same thing, and if we look at pci, it also calls nvme_dev_disable which
also calls nvme_stop_queues, and will also block in nvme_set_live (not
specific to ANA).

I'm trying to think about what is the proper solution for that, so I
thought I'd send it for some brainstorming...

Any thoughts on this?


See some traces for visualization:
=================================
- ns_scanning
--
Call Trace:
  __schedule+0x2b9/0x6c0
  schedule+0x42/0xb0
  blk_mq_freeze_queue_wait+0x4b/0xb0
  ? wait_woken+0x80/0x80
  blk_mq_freeze_queue+0x1b/0x20
  nvme_update_disk_info+0x62/0x3a0 [nvme_core]
  __nvme_revalidate_disk+0xb8/0x110 [nvme_core]
  nvme_revalidate_disk+0xa2/0x110 [nvme_core]
  revalidate_disk+0x2b/0xa0
  nvme_validate_ns+0x49/0x900 [nvme_core]
  ? blk_mq_free_request+0xd2/0x100
  ? __nvme_submit_sync_cmd+0xbe/0x1e0 [nvme_core]
  ? __switch_to_asm+0x40/0x70
  ? _cond_resched+0x19/0x30
  ? down_read+0x13/0xa0
  nvme_scan_work+0x24f/0x380 [nvme_core]
  process_one_work+0x1db/0x380
  worker_thread+0x4d/0x400
--

- request timeout
--
Call Trace:
  __schedule+0x2b9/0x6c0
  schedule+0x42/0xb0
  schedule_timeout+0x203/0x2f0
  ? ttwu_do_activate+0x5b/0x70
  wait_for_completion+0xb1/0x120
  ? wake_up_q+0x70/0x70
  __flush_work+0x123/0x1d0
  ? worker_detach_from_pool+0xb0/0xb0
  flush_work+0x10/0x20
  nvme_tcp_timeout+0x69/0xb0 [nvme_tcp]
  blk_mq_check_expired+0x13d/0x160
  bt_iter+0x52/0x60
  blk_mq_queue_tag_busy_iter+0x1a4/0x2f0
  ? blk_poll+0x350/0x350
  ? blk_poll+0x350/0x350
  ? syscall_return_via_sysret+0xf/0x7f
  blk_mq_timeout_work+0x59/0x110
  process_one_work+0x1db/0x380
  worker_thread+0x4d/0x400
  kthread+0x104/0x140
  ? process_one_work+0x380/0x380
  ? kthread_park+0x80/0x80
  ret_from_fork+0x35/0x40

...

Call Trace:
  __schedule+0x2b9/0x6c0
  schedule+0x42/0xb0
  rwsem_down_read_slowpath+0x16c/0x4a0
  down_read+0x85/0xa0
  nvme_stop_queues+0x21/0x50 [nvme_core]
  nvme_tcp_teardown_io_queues.part.21+0x19/0x80 [nvme_tcp]
  nvme_tcp_error_recovery_work+0x33/0x80 [nvme_tcp]
  process_one_work+0x1db/0x380
  worker_thread+0x4d/0x400
  kthread+0x104/0x140
  ? process_one_work+0x380/0x380
  ? kthread_park+0x80/0x80
  ret_from_fork+0x35/0x40
--

- ANA update
--
Call Trace:
  __schedule+0x2b9/0x6c0
  schedule+0x42/0xb0
  schedule_timeout+0x203/0x2f0
  ? __queue_work+0x117/0x3f0
  wait_for_completion+0xb1/0x120
  ? wake_up_q+0x70/0x70
  __synchronize_srcu.part.0+0x81/0xb0
  ? __bpf_trace_rcu_utilization+0x10/0x10
  ? ktime_get_mono_fast_ns+0x4e/0xa0
  synchronize_srcu_expedited+0x28/0x30
  synchronize_srcu+0x57/0xe0
  nvme_mpath_set_live+0x4f/0x140 [nvme_core]
  nvme_update_ns_ana_state+0x5c/0x60 [nvme_core]
  nvme_update_ana_state+0xca/0xe0 [nvme_core]
  nvme_parse_ana_log+0xa1/0x180 [nvme_core]
  ? nvme_ana_work+0x20/0x20 [nvme_core]
  nvme_read_ana_log+0x76/0x100 [nvme_core]
  nvme_ana_work+0x15/0x20 [nvme_core]
  process_one_work+0x1db/0x380
--

FS I/O
--
Call Trace:
  __schedule+0x2b9/0x6c0
  schedule+0x42/0xb0
  blk_queue_enter+0x169/0x210
  ? wait_woken+0x80/0x80
  direct_make_request+0x49/0xd0
  nvme_ns_head_make_request+0xbc/0x3e0 [nvme_core]
  ? get_user_pages_fast+0xa5/0x190
  generic_make_request+0xcf/0x320
  submit_bio+0x42/0x170
  ? set_page_dirty_lock+0x40/0x60
  iomap_dio_submit_bio.isra.0+0x55/0x60
  iomap_dio_bio_actor+0x1c9/0x3d0
  iomap_dio_actor+0x58/0x1c0
  iomap_apply+0xd5/0x140
  ? iomap_dio_bio_actor+0x3d0/0x3d0
  iomap_dio_rw+0x2c2/0x440
  ? iomap_dio_bio_actor+0x3d0/0x3d0
  ? __x64_sys_io_cancel+0x150/0x150
  xfs_file_dio_aio_read+0x66/0xf0 [xfs]
  ? xfs_file_dio_aio_read+0x66/0xf0 [xfs]
  xfs_file_read_iter+0xbf/0xe0 [xfs]
  aio_read+0xc8/0x160
--

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
