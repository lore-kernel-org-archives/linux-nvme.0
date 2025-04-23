Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9AAC369CB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 06:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AAZWdDzuKc/COwpjZ1U81E48gBLe7iMMZGFp81qW+zk=; b=DPdPM8VYn3xU4l/WA0MvjpNp3e
	sKz9G74lzS22WaGHebC6eQP4rDnp034PlbU1p7tJAQzl23n2xvEVJuq+HVDCXUXCQHUYaejE6PCCE
	TgtLJyYtlPSRiKcJUVEX1CEUKFuqA8zRuoFIW0le3KUWC4hw9iowuggj72UJlu+2bCFc2yoj1Yjb6
	h1Pms6Rn51hCptwmkAhbuEm+rAsMyMmMwqRa0qUbxKKyvcSSiSahDmJZ2yu2AltuXZwrXzN+Zl97g
	r+HXkOfy/1sQFbUyfE88JJmNC7/t9lS4kM4cp8JkvQ7c8FCqxDRkBHzLtEKT+yz7kBDnTvWD9M/Dg
	CpQ2vRcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7TpL-00000009Mzm-3dUb;
	Wed, 23 Apr 2025 06:43:23 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7TFn-00000009IW6-08zq
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 06:06:40 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-224171d6826so85533875ad.3
        for <linux-nvme@lists.infradead.org>; Tue, 22 Apr 2025 23:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745388398; x=1745993198; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AAZWdDzuKc/COwpjZ1U81E48gBLe7iMMZGFp81qW+zk=;
        b=LexqvYEsoPhynEZiL5liS5FKCvEL59sz/sT+90SCqNAq32EyYCXWgcTpQ2670LTPPk
         WcjNFI6Q77oF23e5gEz44BIHpGFa5YFfelpSCFtCHpUIguNWD+/PnYhkPv8S/Y02Fixb
         60azFCoS1txEkqBcPIdrX7364OrIlmt0RRlFhwt9XFFFJpTVhj5rbjtowgKstyDOxOkn
         dvS8myACsLdMJZqXW2EtlxpcTlX8NeIXedIclvrDN4Ntg7e5mhkiUSv1NaphKpPvan6H
         v9RLN5HhfcePeTJ2vji2G/zgc1yNIF/a4F8NeZsVIg/+hLh2UA9kuyJdNsmpWnlk8Keq
         wjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745388398; x=1745993198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AAZWdDzuKc/COwpjZ1U81E48gBLe7iMMZGFp81qW+zk=;
        b=HXZnZ0aXzcyuUzKQlFKVJ4pr7jRejs0n/l/chxs5welrvmfxf+mBmDPjeON4s7vB6f
         f0zhlCCiGPvU124FXy+7Ihf5arU7J8BjYQoybDhbbcH4qvDy7VOJ3Wnq+6QvtPPzzps6
         SwU5+12LpLS+EUz5RG5rEMPj/LwafT8lbGYYy9JiwwOGQ1ziMSbMgXy5/ywBLPmiCn3T
         ZrCz1xyPkWLnXgByOirF7mWFoxvlVfAMyIjqY+//l5eZaKFUM25MZk+TQT8KO8ZnzZDR
         3Vi3YJpvNJBK+tPl2FqujxW5wJW2IERlfs9dyrymkd3YzCxpR6ZfrjcVLM3/MX0obr2t
         VJjA==
X-Forwarded-Encrypted: i=1; AJvYcCXXngjNg8wWBiUNPHlmEL2OXw8OFrsuq/UW1XttmpmZHPbP0EVZ4QtuT+Ag2VxupbceNmDrZf3iK/db@lists.infradead.org
X-Gm-Message-State: AOJu0YxlFgdDPn5+Z8EgzS0w/d1Itj0x8FcRHzseRovrwHbRfW5S4tib
	lq0/5AHw/qc3PzLLQq7fhp5J1H82jIugW7gzlDw0V4hci/SD8l4q
X-Gm-Gg: ASbGnctuXPuG5iYnzt9+p/rHb9Zk/cUk/Epe1IPM499N4fBSkIh3lBsuD1EFdcZ/l1a
	MeYGodM0cSdxWZyZnG2Cw3qYkAQ01sXuKs2dCA2vw3eVARlJs9eoVhj7hnGoKNqlRevdrexcBdp
	/Gv2UthaWz4FoGI6H7FlW+dZhg4bBpqdxFRIJymwpIwWJv89Vtz5EReg+PHkKwpLBBNrfFt9QaD
	VLIDQJLupFEiowwWcNbbypAN5K0AVLs/o37LnfZOQUXqJtk3Gin5AQAw8/e+uOymHuQzIJQ89iU
	2GzU2hqaw74P8nWJGgW1psYl9ob7OzYiXe2elTFe/rPlolbqa/NMgV/647a20F5lk5mLrMPFXcJ
	YQfQS3GaOGoS2e+w9D7DBKwJP8uhUTdYnVBdRrzHALfOM4g==
X-Google-Smtp-Source: AGHT+IFyFvYrPdAYW+QQhryADoXcctBVGuou7eiAKfWHuTWvG8i+jOE48LEA1c2XeVwcW71I0CGihA==
X-Received: by 2002:a17:902:ce01:b0:21f:7082:1137 with SMTP id d9443c01a7336-22c5357d158mr318617875ad.22.1745388397530;
        Tue, 22 Apr 2025 23:06:37 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fe0976sm96227495ad.245.2025.04.22.23.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 23:06:36 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	csander@purestorage.com,
	shinichiro.kawasaki@wdc.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] nvmet-tcp: don't restore null sk_state_change
Date: Wed, 23 Apr 2025 16:06:21 +1000
Message-ID: <20250423060621.632581-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_230639_075567_50A55EB6 
X-CRM114-Status: GOOD (  12.28  )
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

queue->state_change is set as part of nvmet_tcp_set_queue_sock(), but if
the TCP connection isn't established when nvmet_tcp_set_queue_sock() is
called then queue->state_change isn't set and sock->sk->sk_state_change
isn't replaced.

As such we don't need to restore sock->sk->sk_state_change if
queue->state_change is NULL.

This avoids NULL pointer dereferences such as this:

[  286.462026][    C0] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  286.462814][    C0] #PF: supervisor instruction fetch in kernel mode
[  286.463796][    C0] #PF: error_code(0x0010) - not-present page
[  286.464392][    C0] PGD 8000000140620067 P4D 8000000140620067 PUD 114201067 PMD 0
[  286.465086][    C0] Oops: Oops: 0010 [#1] SMP KASAN PTI
[  286.465559][    C0] CPU: 0 UID: 0 PID: 1628 Comm: nvme Not tainted 6.15.0-rc2+ #11 PREEMPT(voluntary)
[  286.466393][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
[  286.467147][    C0] RIP: 0010:0x0
[  286.467420][    C0] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  286.467977][    C0] RSP: 0018:ffff8883ae008580 EFLAGS: 00010246
[  286.468425][    C0] RAX: 0000000000000000 RBX: ffff88813fd34100 RCX: ffffffffa386cc43
[  286.469019][    C0] RDX: 1ffff11027fa68b6 RSI: 0000000000000008 RDI: ffff88813fd34100
[  286.469545][    C0] RBP: ffff88813fd34160 R08: 0000000000000000 R09: ffffed1027fa682c
[  286.470072][    C0] R10: ffff88813fd34167 R11: 0000000000000000 R12: ffff88813fd344c3
[  286.470585][    C0] R13: ffff88813fd34112 R14: ffff88813fd34aec R15: ffff888132cdd268
[  286.471070][    C0] FS:  00007fe3c04c7d80(0000) GS:ffff88840743f000(0000) knlGS:0000000000000000
[  286.471644][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  286.472543][    C0] CR2: ffffffffffffffd6 CR3: 000000012daca000 CR4: 00000000000006f0
[  286.473500][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  286.474467][    C0] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[  286.475453][    C0] Call Trace:
[  286.476102][    C0]  <IRQ>
[  286.476719][    C0]  tcp_fin+0x2bb/0x440
[  286.477429][    C0]  tcp_data_queue+0x190f/0x4e60
[  286.478174][    C0]  ? __build_skb_around+0x234/0x330
[  286.478940][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.479659][    C0]  ? __pfx_tcp_data_queue+0x10/0x10
[  286.480431][    C0]  ? tcp_try_undo_loss+0x640/0x6c0
[  286.481196][    C0]  ? seqcount_lockdep_reader_access.constprop.0+0x82/0x90
[  286.482046][    C0]  ? kvm_clock_get_cycles+0x14/0x30
[  286.482769][    C0]  ? ktime_get+0x66/0x150
[  286.483433][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.484146][    C0]  tcp_rcv_established+0x6e4/0x2050
[  286.484857][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.485523][    C0]  ? ipv4_dst_check+0x160/0x2b0
[  286.486203][    C0]  ? __pfx_tcp_rcv_established+0x10/0x10
[  286.486917][    C0]  ? lock_release+0x217/0x2c0
[  286.487595][    C0]  tcp_v4_do_rcv+0x4d6/0x9b0
[  286.488279][    C0]  tcp_v4_rcv+0x2af8/0x3e30
[  286.488904][    C0]  ? raw_local_deliver+0x51b/0xad0
[  286.489551][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.490198][    C0]  ? __pfx_tcp_v4_rcv+0x10/0x10
[  286.490813][    C0]  ? __pfx_raw_local_deliver+0x10/0x10
[  286.491487][    C0]  ? __pfx_nf_confirm+0x10/0x10 [nf_conntrack]
[  286.492275][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.492900][    C0]  ip_protocol_deliver_rcu+0x8f/0x370
[  286.493579][    C0]  ip_local_deliver_finish+0x297/0x420
[  286.494268][    C0]  ip_local_deliver+0x168/0x430
[  286.494867][    C0]  ? __pfx_ip_local_deliver+0x10/0x10
[  286.495498][    C0]  ? __pfx_ip_local_deliver_finish+0x10/0x10
[  286.496204][    C0]  ? ip_rcv_finish_core+0x19a/0x1f20
[  286.496806][    C0]  ? lock_release+0x217/0x2c0
[  286.497414][    C0]  ip_rcv+0x455/0x6e0
[  286.497945][    C0]  ? __pfx_ip_rcv+0x10/0x10
[  286.498550][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.499137][    C0]  ? __pfx_ip_rcv_finish+0x10/0x10
[  286.499763][    C0]  ? lock_release+0x217/0x2c0
[  286.500327][    C0]  ? dl_scaled_delta_exec+0xd1/0x2c0
[  286.500922][    C0]  ? __pfx_ip_rcv+0x10/0x10
[  286.501480][    C0]  __netif_receive_skb_one_core+0x166/0x1b0
[  286.502173][    C0]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[  286.502903][    C0]  ? lock_acquire+0x2b2/0x310
[  286.503487][    C0]  ? process_backlog+0x372/0x1350
[  286.504087][    C0]  ? lock_release+0x217/0x2c0
[  286.504642][    C0]  process_backlog+0x3b9/0x1350
[  286.505214][    C0]  ? process_backlog+0x372/0x1350
[  286.505779][    C0]  __napi_poll.constprop.0+0xa6/0x490
[  286.506363][    C0]  net_rx_action+0x92e/0xe10
[  286.506889][    C0]  ? __pfx_net_rx_action+0x10/0x10
[  286.507437][    C0]  ? timerqueue_add+0x1f0/0x320
[  286.507977][    C0]  ? sched_clock_cpu+0x68/0x540
[  286.508492][    C0]  ? lock_acquire+0x2b2/0x310
[  286.509043][    C0]  ? kvm_sched_clock_read+0xd/0x20
[  286.509607][    C0]  ? handle_softirqs+0x1aa/0x7d0
[  286.510187][    C0]  handle_softirqs+0x1f2/0x7d0
[  286.510754][    C0]  ? __pfx_handle_softirqs+0x10/0x10
[  286.511348][    C0]  ? irqtime_account_irq+0x181/0x290
[  286.511937][    C0]  ? __dev_queue_xmit+0x85d/0x3450
[  286.512510][    C0]  do_softirq.part.0+0x89/0xc0
[  286.513100][    C0]  </IRQ>
[  286.513548][    C0]  <TASK>
[  286.513953][    C0]  __local_bh_enable_ip+0x112/0x140
[  286.514522][    C0]  ? __dev_queue_xmit+0x85d/0x3450
[  286.515072][    C0]  __dev_queue_xmit+0x872/0x3450
[  286.515619][    C0]  ? nft_do_chain+0xe16/0x15b0 [nf_tables]
[  286.516252][    C0]  ? __pfx___dev_queue_xmit+0x10/0x10
[  286.516817][    C0]  ? selinux_ip_postroute+0x43c/0xc50
[  286.517433][    C0]  ? __pfx_selinux_ip_postroute+0x10/0x10
[  286.518061][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.518606][    C0]  ? ip_output+0x164/0x4a0
[  286.519149][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.519671][    C0]  ? ip_finish_output2+0x17d5/0x1fb0
[  286.520258][    C0]  ip_finish_output2+0xb4b/0x1fb0
[  286.520787][    C0]  ? __pfx_ip_finish_output2+0x10/0x10
[  286.521355][    C0]  ? __ip_finish_output+0x15d/0x750
[  286.521890][    C0]  ip_output+0x164/0x4a0
[  286.522372][    C0]  ? __pfx_ip_output+0x10/0x10
[  286.522872][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.523402][    C0]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[  286.524031][    C0]  ? __pfx_ip_finish_output+0x10/0x10
[  286.524605][    C0]  ? __ip_queue_xmit+0x999/0x2260
[  286.525200][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.525744][    C0]  ? ipv4_dst_check+0x16a/0x2b0
[  286.526279][    C0]  ? lock_release+0x217/0x2c0
[  286.526793][    C0]  __ip_queue_xmit+0x1883/0x2260
[  286.527324][    C0]  ? __skb_clone+0x54c/0x730
[  286.527827][    C0]  __tcp_transmit_skb+0x209b/0x37a0
[  286.528374][    C0]  ? __pfx___tcp_transmit_skb+0x10/0x10
[  286.528952][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.529472][    C0]  ? seqcount_lockdep_reader_access.constprop.0+0x82/0x90
[  286.530152][    C0]  ? trace_hardirqs_on+0x12/0x120
[  286.530691][    C0]  tcp_write_xmit+0xb81/0x88b0
[  286.531224][    C0]  ? mod_memcg_state+0x4d/0x60
[  286.531736][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.532253][    C0]  __tcp_push_pending_frames+0x90/0x320
[  286.532826][    C0]  tcp_send_fin+0x141/0xb50
[  286.533352][    C0]  ? __pfx_tcp_send_fin+0x10/0x10
[  286.533908][    C0]  ? __local_bh_enable_ip+0xab/0x140
[  286.534495][    C0]  inet_shutdown+0x243/0x320
[  286.535077][    C0]  nvme_tcp_alloc_queue+0xb3b/0x2590 [nvme_tcp]
[  286.535709][    C0]  ? do_raw_spin_lock+0x129/0x260
[  286.536314][    C0]  ? __pfx_nvme_tcp_alloc_queue+0x10/0x10 [nvme_tcp]
[  286.536996][    C0]  ? do_raw_spin_unlock+0x54/0x1e0
[  286.537550][    C0]  ? _raw_spin_unlock+0x29/0x50
[  286.538127][    C0]  ? do_raw_spin_lock+0x129/0x260
[  286.538664][    C0]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  286.539249][    C0]  ? nvme_tcp_alloc_admin_queue+0xd5/0x340 [nvme_tcp]
[  286.539892][    C0]  ? __wake_up+0x40/0x60
[  286.540392][    C0]  nvme_tcp_alloc_admin_queue+0xd5/0x340 [nvme_tcp]
[  286.541047][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.541589][    C0]  nvme_tcp_setup_ctrl+0x8b/0x7a0 [nvme_tcp]
[  286.542254][    C0]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[  286.542887][    C0]  ? __pfx_nvme_tcp_setup_ctrl+0x10/0x10 [nvme_tcp]
[  286.543568][    C0]  ? trace_hardirqs_on+0x12/0x120
[  286.544166][    C0]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[  286.544792][    C0]  ? nvme_change_ctrl_state+0x196/0x2e0 [nvme_core]
[  286.545477][    C0]  nvme_tcp_create_ctrl+0x839/0xb90 [nvme_tcp]
[  286.546126][    C0]  nvmf_dev_write+0x3db/0x7e0 [nvme_fabrics]
[  286.546775][    C0]  ? rw_verify_area+0x69/0x520
[  286.547334][    C0]  vfs_write+0x218/0xe90
[  286.547854][    C0]  ? do_syscall_64+0x9f/0x190
[  286.548408][    C0]  ? trace_hardirqs_on_prepare+0xdb/0x120
[  286.549037][    C0]  ? syscall_exit_to_user_mode+0x93/0x280
[  286.549659][    C0]  ? __pfx_vfs_write+0x10/0x10
[  286.550259][    C0]  ? do_syscall_64+0x9f/0x190
[  286.550840][    C0]  ? syscall_exit_to_user_mode+0x8e/0x280
[  286.551516][    C0]  ? trace_hardirqs_on_prepare+0xdb/0x120
[  286.552180][    C0]  ? syscall_exit_to_user_mode+0x93/0x280
[  286.552834][    C0]  ? ksys_read+0xf5/0x1c0
[  286.553386][    C0]  ? __pfx_ksys_read+0x10/0x10
[  286.553964][    C0]  ksys_write+0xf5/0x1c0
[  286.554499][    C0]  ? __pfx_ksys_write+0x10/0x10
[  286.555072][    C0]  ? trace_hardirqs_on_prepare+0xdb/0x120
[  286.555698][    C0]  ? syscall_exit_to_user_mode+0x93/0x280
[  286.556319][    C0]  ? do_syscall_64+0x54/0x190
[  286.556866][    C0]  do_syscall_64+0x93/0x190
[  286.557420][    C0]  ? rcu_read_unlock+0x17/0x60
[  286.557986][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.558526][    C0]  ? lock_release+0x217/0x2c0
[  286.559087][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.559659][    C0]  ? count_memcg_events.constprop.0+0x4a/0x60
[  286.560476][    C0]  ? exc_page_fault+0x7a/0x110
[  286.561064][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.561647][    C0]  ? lock_release+0x217/0x2c0
[  286.562257][    C0]  ? do_user_addr_fault+0x171/0xa00
[  286.562839][    C0]  ? do_user_addr_fault+0x4a2/0xa00
[  286.563453][    C0]  ? irqentry_exit_to_user_mode+0x84/0x270
[  286.564112][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.564677][    C0]  ? irqentry_exit_to_user_mode+0x84/0x270
[  286.565317][    C0]  ? trace_hardirqs_on_prepare+0xdb/0x120
[  286.565922][    C0]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  286.566542][    C0] RIP: 0033:0x7fe3c05e6504
[  286.567102][    C0] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 8b 10 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
[  286.568931][    C0] RSP: 002b:00007fff76444f58 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[  286.569807][    C0] RAX: ffffffffffffffda RBX: 000000003b40d930 RCX: 00007fe3c05e6504
[  286.570621][    C0] RDX: 00000000000000cf RSI: 000000003b40d930 RDI: 0000000000000003
[  286.571443][    C0] RBP: 0000000000000003 R08: 00000000000000cf R09: 000000003b40d930
[  286.572246][    C0] R10: 0000000000000000 R11: 0000000000000202 R12: 000000003b40cd60
[  286.573069][    C0] R13: 00000000000000cf R14: 00007fe3c07417f8 R15: 00007fe3c073502e
[  286.573886][    C0]  </TASK>

Resolves: https://lore.kernel.org/linux-nvme/5hdonndzoqa265oq3bj6iarwtfk5dewxxjtbjvn5uqnwclpwt6@a2n6w3taxxex/
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
We could also remove the `sock->sk->sk_state != TCP_ESTABLISHED` check
in nvmet_tcp_set_queue_sock() if that's prefered.

 drivers/nvme/target/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index f2d0c920269b..12a5cb8641ca 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1560,6 +1560,9 @@ static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
 
+	if (!queue->state_change)
+		return;
+
 	write_lock_bh(&sock->sk->sk_callback_lock);
 	sock->sk->sk_data_ready =  queue->data_ready;
 	sock->sk->sk_state_change = queue->state_change;
-- 
2.49.0


