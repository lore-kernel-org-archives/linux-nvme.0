Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05F6606A31A
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Nov 2026 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kZC6bUXu;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ak3UuOn9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=NL5ZaXPsEIy9ykVvGh3vR/rF7q7QothrL3/sWH6u9qQ=; b=kZC6bUXuv1kxYu7S1lm/YJHUdF
	afuz3LXex0ksra775TIOWVlyI2GtneQD4IIaaOWoQZ4OeNtZUNm1Z9u8qg5Ie+9Vm/poedxAoP2IN
	coXNiWss5SGG9Vwgy7zWTe05itiSs0SqEfShUBLU8JnQd+lusTZk/PSL1Dl8f94CSnyCF5KXV/eOG
	5MAxACFkcKwVVPn/ZAjFUbQ7TFGC8zXtnlJO09ahrpjnS5g5um/EpmhG8FcNT69EZsnBAxIvonccM
	BzTc3d98EgTwRNO08ghrPAlem4Gcr0lLp2hzyOGH/MYvxrg/wErEqKivdIYUK2ANSmu9S4GgkdUZu
	/DIWD0WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVHAB-00000001u2k-07LW;
	Sun, 22 Nov 2026 23:40:03 +0000
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVHA7-00000001u21-3S3a
	for linux-nvme@lists.infradead.org;
	Sun, 22 Nov 2026 23:40:02 +0000
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-5364042eecfso37788581cf.2
        for <linux-nvme@lists.infradead.org>; Sun, 22 Nov 2026 15:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795390798; x=1795995598; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NL5ZaXPsEIy9ykVvGh3vR/rF7q7QothrL3/sWH6u9qQ=;
        b=ak3UuOn9gQPtYZsGq3NwVmOtGd1namrLzUEBuQWDZCpbA/VETq5KFiGwG3OYFSAKsn
         /ZLcA2NhLVzR/zF5fBdFqVoIbI/Z7BdPLXnJQOhI/686xuZZ5x8VtRq3OsTHOrCoouac
         0egb6UwiW31R2Nd67pVCAGLeygeAChbNX4GFLAvjQSQQh3Kes24pTmbgvthP0RtO4KfD
         e5A1r0ZHtzqmhKNcVlEvj07eJxQwAQYr4Kj2asG/wRRCwhgIvpCjeHKhU9DpDWe+6ynM
         KtePq/yuclAc043lQaeywSbCeTbLMPFVHoklXxF60sL7alR/7OQQvwYnpZm4yMv3AUtM
         Ovkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795390798; x=1795995598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NL5ZaXPsEIy9ykVvGh3vR/rF7q7QothrL3/sWH6u9qQ=;
        b=G8RPvxKsrGsODDZo/pZ2Vxf/sGYeyb8UWBO46QBJRvwYIJ0q7abEXzFssp5smfL6Ue
         MpELKzOfKKoBx2n7Teh/WlHdZs5V42Wg20ldPArKAQiUgDgCzJ6263Y9Bdr2KHwDlIoc
         XQZ3d+0DyEBZqdcoS65BykOjLWEt4KzrbjowgQ3lVhYoeEsV8ymeLHV1VpTVNkNJB/le
         Z7P4Guba80U5oHMqYysA/kBZVbSkdR/MTodTjWwmlETUIFT31L5L0u7ehzx+IWsNWx0b
         dehDSv+/xnl0vWbVwB0ARqmBNrz5V8PRkFgpLkZwT40zzGt8UCGUasLa32NPztfCpkEJ
         XhMQ==
X-Forwarded-Encrypted: i=1; AL+hErHDOh9wHiwHqk0dXYr4eBbJntDoH64bqJa84pf7daXTbJidTK6ixloxrY53mqRRJAa+vvyC9OwqBaDr@lists.infradead.org
X-Gm-Message-State: APuU4Z+0MYNobEWn9I/2W526WHyNwWnE57X6vRwDiwbX0ivNeGz/NW/t
	prcDdlt3z0uZy8CRqgEN8IzxMzST06LiSmLrcB6YA3b0olWgGE6OEKWvBiyya+dlOhE=
X-Gm-Gg: AZFdTZddlPzgmdFvCHUS6ONsng09loqM7CPaEKBMGlNJE203ow6/m3+xSpR9/GrGAOq
	LMh1sb+hR+Jcq27PGYAYlDy3OjTFvHApZ8LrCJd/qNkv6KprjAjw0Eog3XymBmQ+RqOrQlrLxcx
	s0ZvsmxfGM+mSkSjO9JVW9Rn2mMfwkeJwBU/QIzrcHsE+HdEZcWTaFyPX2wkQrNbBDkKuzZepg6
	FhoFSQzwCEP+4QvpYnyUv9UWMtrowMMDBZEIlFeaoikkD//ezEHtaN7tu12qZnWQzryQSq2+HoZ
	iALOPp6FaCb3Y/W1sdgSJobN3fSbnLJCc3We/iiPItw6B7D1+YlxlBPLq35jV/RIPvhgF11f/jS
	kTuMq9gAS9rjDhL8Hqvi4nRU+TSZAErJ4fz9NQEGY3MrpNkfKb/+JHghFqmAyRq/xWsUKp9X4ib
	E8CMrvbVbGkmiLV/mtchSsjNJCjzePYjMBy1qqzKWraPvKBfZAhYkodXIIfROwxK3Kv2VlhVawG
	NjxjOubWIZOYQZJoO+hsp+xHaJXfqLnWevCnAg7uZfxQowLmrLTfTkDeeQxR1gsHm0V5Sjqu+H1
	QnCdnCNOyEOcHLX+y1dTrvhMhzknQ/Uby6rbgnGaFHNoCRqwz3xv5O9rvPPMnP8B0xbYwY9sUJh
	anZd7zjjkmbzbyydNC1ApLHWwMTromNRHd41sOtPVcQgzcqoP2AQvCtJkHeF+KgJRf5zvVD3fCB
	7Bb+Umea3aVJOgm3TpTFUtcBU59g==
X-Received: by 2002:a05:622a:178f:b0:539:c527:259 with SMTP id d75a77b69052e-55d76aaa0fbmr183012301cf.76.1795390797859;
        Sun, 22 Nov 2026 15:39:57 -0800 (PST)
Received: from Mac.mynetworksettings.com ([2600:4041:5c28:200:c8ee:a73:9097:862f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7889ea4csm84189161cf.26.2026.11.22.15.39.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 15:39:57 -0800 (PST)
From: Andrew Stellman <astellman@stellman-greene.com>
To: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>,
	Steve Wise <larrystevenwise@gmail.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrew Stellman <astellman@stellman-greene.com>
Subject: [PATCH] nvme-fabrics: limit nr_write_queues and nr_poll_queues when parsing
Date: Sun, 22 Nov 2026 18:39:51 -0500
Message-ID: <20261122233951.8912-1-astellman@stellman-greene.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261122_153959_895845_44854C6F 
X-CRM114-Status: GOOD (  15.06  )
X-Spam-Score: -1.7 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nr_io_queues is limited to num_online_cpus() when the options are
parsed, but nr_write_queues and nr_poll_queues are stored as given.
nvme-tcp and nvme-rdma size the queue array with the unsigned int sum
nr_io_queues + nr_write_queues + nr_poll_queues + 1, which wraps for
large values, while nvmf_nr_io_queues() limits each term to the online
CPUs and so asks for more I/O queues than were allocated.

With 4 CPUs and nr_write_queues=2147483647 nr_poll_queues=2147483647 on
nvme-tcp, the sum wraps to 3, three queues are allocated and 12 I/O
queues are created:

  nvme nvme0: creating 12 I/O queues.
  BUG: KASAN: slab-out-of-bounds in nvme_tcp_init_request+0x262/0x2f0
  Read of size 1 at addr ff11000005b344b9 by task nvme/123
  Call Trace:
   <TASK>
   dump_stack_lvl+0x53/0x70
   print_report+0xd0/0x630
   kasan_report+0xce/0x100
   nvme_tcp_init_request+0x262/0x2f0
   blk_mq_alloc_map_and_rqs+0x4db/0x9e0
   blk_mq_alloc_tag_set+0x661/0x10b0
   nvme_alloc_io_tag_set+0x37e/0x690
   nvme_tcp_setup_ctrl+0x502/0x1070
   nvme_tcp_create_ctrl+0xb0b/0x1420
   nvmf_dev_write+0x3f2/0x850
   vfs_write+0x227/0xcd0
   ksys_write+0xf7/0x1c0
   do_syscall_64+0xdf/0x4c0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

Limit both options to num_possible_cpus(). The sum can no longer wrap,
and the queue counts still follow CPU hotplug on reconnect, since
nvmf_nr_io_queues() and nvmf_set_io_queues() apply the online CPU
limit.

Reproduced on mainline (2dc60bd9975f) under QEMU with KASAN, connecting
nvme-tcp to an nvmet tcp target on the same guest. With this patch the
same connect creates 12 I/O queues mapped 4/4/4, and I/O and disconnect
work. Connecting with nr_write_queues=1 nr_poll_queues=1 behaves the
same with and without the patch.

The issue was found by Claude Sonnet 5.5 and Claude Opus 5.5 running
Quality Playbook, an LLM-driven code review tool:
https://github.com/andrewstellman/quality-playbook
The fix and this changelog were drafted with Claude Opus 5.5 and
reviewed by me.

Fixes: 330f6b8a7077 ("nvme-fabrics: allow user to set nr_write_queues for separate queue maps")
Fixes: 89d43802b0e7 ("nvme-fabrics: allow user to pass in nr_poll_queues")
Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
---
A reproducer is available on request.

Full KASAN report from the unpatched run (timestamps removed):

  BUG: KASAN: slab-out-of-bounds in nvme_tcp_init_request+0x262/0x2f0
  Read of size 1 at addr ff11000005b344b9 by task nvme/123

  CPU: 1 UID: 0 PID: 123 Comm: nvme Not tainted 7.4.0-rc3-01047-g2dc60bd9975f #1 PREEMPT(lazy) 
  Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x53/0x70
   print_report+0xd0/0x630
   ? __pfx__raw_spin_lock_irqsave+0x10/0x10
   ? nvme_tcp_init_request+0x262/0x2f0
   kasan_report+0xce/0x100
   ? nvme_tcp_init_request+0x262/0x2f0
   nvme_tcp_init_request+0x262/0x2f0
   blk_mq_alloc_map_and_rqs+0x4db/0x9e0
   blk_mq_alloc_tag_set+0x661/0x10b0
   nvme_alloc_io_tag_set+0x37e/0x690
   ? __pfx_nvme_alloc_io_tag_set+0x10/0x10
   ? blk_queue_exit+0x74/0xf0
   ? nvme_set_queue_count+0x161/0x260
   ? _dev_info+0xd5/0x110
   ? __pfx__dev_info+0x10/0x10
   ? __pfx_nvme_enable_ctrl+0x10/0x10
   ? nvme_tcp_start_queue+0x795/0xc00
   ? __asan_memset+0x23/0x50
   nvme_tcp_setup_ctrl+0x502/0x1070
   ? __pfx_nvme_tcp_setup_ctrl+0x10/0x10
   ? __wake_up+0x3f/0x60
   ? nvme_change_ctrl_state+0x183/0x340
   nvme_tcp_create_ctrl+0xb0b/0x1420
   nvmf_dev_write+0x3f2/0x850
   vfs_write+0x227/0xcd0
   ? do_sys_openat2+0xd1/0x170
   ? kmem_cache_free+0x1b8/0x380
   ? __pfx_vfs_write+0x10/0x10
   ? do_sys_openat2+0xd1/0x170
   ? __pfx_do_sys_openat2+0x10/0x10
   ? lapic_next_event+0x10/0x20
   ? clockevents_program_event+0x2ba/0x860
   ? fdget_pos+0x53/0x4b0
   ksys_write+0xf7/0x1c0
   ? __pfx_ksys_write+0x10/0x10
   ? __pfx_handle_softirqs+0x10/0x10
   do_syscall_64+0xdf/0x4c0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7fbf016af574
  Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d d5 ea 0e 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
  RSP: 002b:00007ffd975d7d38 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
  RAX: ffffffffffffffda RBX: 0000561235ee6b90 RCX: 00007fbf016af574
  RDX: 00000000000000f6 RSI: 0000561235ee6b90 RDI: 0000000000000003
  RBP: 00007ffd975d8da0 R08: 00000000000000f6 R09: 0000561235ee6b90
  R10: 00007fbf015ada40 R11: 0000000000000202 R12: 0000000000000003
  R13: 0000561235ee62a0 R14: 00000000000000f6 R15: 00007fbf017e6500
   </TASK>

  Allocated by task 123:
   kasan_save_stack+0x33/0x60
   kasan_save_track+0x14/0x40
   __kasan_kmalloc+0x8f/0xa0
   __kmalloc_noprof+0x1b1/0x460
   nvme_tcp_create_ctrl+0x714/0x1420
   nvmf_dev_write+0x3f2/0x850
   vfs_write+0x227/0xcd0
   ksys_write+0xf7/0x1c0
   do_syscall_64+0xdf/0x4c0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Last potentially related work creation:
   kasan_save_stack+0x33/0x60
   __kasan_record_aux_stack+0x9b/0xb0
   insert_work+0x24/0x250
   __queue_work+0x64e/0x1190
   queue_work_on+0x5d/0x70
   nvme_tcp_data_ready+0x1bd/0x240
   tcp_rcv_established+0x1ef3/0x39b0
   tcp_v4_do_rcv+0x45b/0x970
   tcp_v4_rcv+0x2241/0x3b90
   ip_protocol_deliver_rcu+0x61/0x3a0
   ip_local_deliver_finish+0x329/0x4b0
   ip_local_deliver+0x18f/0x2d0
   ip_rcv+0x21a/0x270
   __netif_receive_skb_one_core+0x161/0x1b0
   process_backlog+0x1e5/0x5e0
   __napi_poll+0x9c/0x520
   net_rx_action+0x8d0/0xe70
   handle_softirqs+0x1b3/0x600
   do_softirq+0x3d/0x60
   __local_bh_enable_ip+0x6a/0x70
   __dev_queue_xmit+0x8a3/0x3180
   ip_finish_output2+0x765/0x1bc0
   __ip_finish_output.part.0+0x46e/0x950
   ip_output+0x260/0x4c0
   __ip_queue_xmit+0x6f8/0x1dd0
   __tcp_transmit_skb+0x2ec9/0x4720
   tcp_write_xmit+0x11c9/0x78d0
   __tcp_push_pending_frames+0x8f/0x330
   tcp_sendmsg_locked+0x1741/0x3fc0
   tcp_sendmsg+0x26/0x40
   sock_sendmsg+0x298/0x330
   nvmet_try_send_response+0x270/0x6b0
   nvmet_tcp_io_work+0x6a0/0x2540
   process_one_work+0x6fc/0x1180
   worker_thread+0x45b/0xd10
   kthread+0x2c8/0x3b0
   ret_from_fork+0x36e/0x5a0
   ret_from_fork_asm+0x1a/0x30

  Second to last potentially related work creation:
   kasan_save_stack+0x33/0x60
   __kasan_record_aux_stack+0x9b/0xb0
   insert_work+0x24/0x250
   __queue_work+0x64e/0x1190
   queue_work_on+0x5d/0x70
   nvme_tcp_queue_rq+0xcf3/0x1a50
   blk_mq_dispatch_rq_list+0x3bc/0x2150
   __blk_mq_sched_dispatch_requests+0x1da/0x1520
   blk_mq_sched_dispatch_requests+0xa7/0x140
   blk_mq_run_hw_queue+0x53c/0x8a0
   blk_execute_rq+0x192/0x320
   __nvme_submit_sync_cmd+0x109/0x320
   nvme_set_queue_count+0x10d/0x260
   nvme_tcp_setup_ctrl+0x3d4/0x1070
   nvme_tcp_create_ctrl+0xb0b/0x1420
   nvmf_dev_write+0x3f2/0x850
   vfs_write+0x227/0xcd0
   ksys_write+0xf7/0x1c0
   do_syscall_64+0xdf/0x4c0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  The buggy address belongs to the object at ff11000005b34000
   which belongs to the cache kmalloc-1k of size 1024
  The buggy address is located 225 bytes to the right of
   allocated 984-byte region [ff11000005b34000, ff11000005b343d8)

  The buggy address belongs to the physical page:
  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5b30
  head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
  flags: 0x100000000000040(head|node=0|zone=1)
  page_type: f5(slab)
  raw: 0100000000000040 ff11000001038dc0 dead000000000100 dead000000000122
  raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
  head: 0100000000000040 ff11000001038dc0 dead000000000100 dead000000000122
  head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
  head: 0100000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
  head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   ff11000005b34380: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
   ff11000005b34400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  >ff11000005b34480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                          ^
   ff11000005b34500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   ff11000005b34580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ==================================================================

 drivers/nvme/host/fabrics.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5ed91557f07..74bdad463b0 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -955,7 +955,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -EINVAL;
 				goto out;
 			}
-			opts->nr_write_queues = token;
+			opts->nr_write_queues = min_t(unsigned int, token,
+						      num_possible_cpus());
 			break;
 		case NVMF_OPT_NR_POLL_QUEUES:
 			if (match_int(args, &token)) {
@@ -967,7 +968,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -EINVAL;
 				goto out;
 			}
-			opts->nr_poll_queues = token;
+			opts->nr_poll_queues = min_t(unsigned int, token,
+						     num_possible_cpus());
 			break;
 		case NVMF_OPT_TOS:
 			if (match_int(args, &token)) {
-- 
2.43.0


