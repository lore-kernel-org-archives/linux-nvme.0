Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDEFC19778
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 16:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZA/z7q9kCF5Lt65d14NWTfWdgZTE+Al3KkUXcPo/sbk=; b=a/B34VnHW3oSgkUJSJYsii47c+
	owFarPJzmXj35VkxmGjG/DjDFAqOhN6OT23IBVBaSdYeMPMeB+uhuEe5Gc1UJOfKRmpvfrZz+ld9Q
	9k9Bk7HFaODaVHTDo/akhWW8ksFM8qte7x2fr22JCEH9H1dKCyUlc9LSrC9TSg47HQxIegyq1ZlXF
	3IAaZGQTLyx4udWHgKyI6OVj1PP8YMKtIxiaBYrdUa5nZIGsScTY+WCgIJPFb0YvytWeRypQDwdBy
	FqKvvahydF995FAM7Knm3ysdU0RpvkxTfRo56pwX3fb5OjqgnPhcWzL349i2v1FFf8Uv7qL90A713
	63pC+GSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmy3C-00000000Ozr-0tMD;
	Tue, 25 Feb 2025 16:44:54 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmxPL-000000009Ik-0oQ6
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 16:03:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 09EE85C5879;
	Tue, 25 Feb 2025 16:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482EFC4CEDD;
	Tue, 25 Feb 2025 16:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740499421;
	bh=PZRqScTDAfxk6yafOLzJqKVISoJHPiEo/RN9hzakm1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zg+BK2ZNe/cpHw1WeZ2txYRfdHFFu4cwTtPsLhtR2YZG+pHez6IBObAtYUO3a8jl9
	 XqVYAK7O88nFucQjxhvx1XvyC/u697CpGxKMhyDceAAs55fhBOibEjfRFvGdjfU3pm
	 p4fG6B3PlXiY2vcMlDEPmr3RX+5Dyx90XKldqih4pW1vWLBZq3qDlkddnlDQmRxytY
	 TQ7ef2jr9aL2aucgpewlGfgmH7xPzvTovaF+Jwobf5rqkLbDQk/RB03Nlw6wdv6ks6
	 r+S02CXubr5GroPFchEgPO//fzaDOgXanGLdP/VU0v5ycy1eM2aCGnAVfFGB4P/VkW
	 5MuWrP3TZR7YA==
Date: Tue, 25 Feb 2025 09:03:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-nvme@lists.infradead.org,
	leitao@debian.org
Subject: Re: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from
 kmem_cache_destroy()
Message-ID: <Z73p2lRwKagaoUnP@kbusch-mbp>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp>
 <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
 <Z7xbrnP8kTQKYO6T@pc636>
 <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_080343_339648_48F88CDD 
X-CRM114-Status: GOOD (  11.69  )
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

On Tue, Feb 25, 2025 at 10:57:38AM +0100, Vlastimil Babka wrote:
> I tried to create a kunit test for it, but it doesn't trigger anything. Maybe
> it's too simple, or racy, and thus we are not flushing any of the queues from
> kvfree_rcu_barrier()?

Thanks, your test readily triggers it for me, but only if I load
rcutorture at the same time.

[  142.223220] CPU: 11 UID: 0 PID: 186 Comm: kworker/u64:11 Tainted: G            E    N 6.13.0-04839-g5e7b40f0ddce-dirty #831
[  142.223222] Tainted: [E]=UNSIGNED_MODULE, [N]=TEST
[  142.223223] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[  142.223224] Workqueue: test_kfree_rcu_destroy_wq cache_destroy_workfn [slub_kunit]
[  142.223230] Call Trace:
[  142.223231]  <TASK>
[  142.223233]  dump_stack_lvl+0x64/0x90
[  142.223239]  print_circular_bug+0x2c5/0x400
[  142.223243]  check_noncircular+0x103/0x120
[  142.223246]  ? save_trace+0x3e/0x360
[  142.223249]  __lock_acquire+0x1481/0x24b0
[  142.223252]  lock_acquire+0xaa/0x2a0
[  142.223253]  ? console_lock_spinning_enable+0x3e/0x60
[  142.223255]  ? lock_release+0xb3/0x250
[  142.223257]  console_lock_spinning_enable+0x5a/0x60
[  142.223258]  ? console_lock_spinning_enable+0x3e/0x60
[  142.223260]  console_flush_all+0x2b1/0x490
[  142.223262]  ? console_flush_all+0x29/0x490
[  142.223264]  console_unlock+0x49/0xf0
[  142.223266]  vprintk_emit+0x12b/0x300
[  142.223269]  ? kfree_rcu_shrink_scan+0x120/0x120
[  142.223270]  _printk+0x48/0x50
[  142.223272]  ? kfree_rcu_shrink_scan+0x120/0x120
[  142.223273]  __warn_printk+0xb4/0xe0
[  142.223276]  ? 0xffffffffa05d6000
[  142.223278]  ? kfree_rcu_shrink_scan+0x120/0x120
[  142.223279]  check_flush_dependency.part.0+0xad/0x100
[  142.223282]  __flush_work+0x38a/0x4a0
[  142.223284]  ? find_held_lock+0x2b/0x80
[  142.223287]  ? flush_rcu_work+0x26/0x40
[  142.223289]  ? lock_release+0xb3/0x250
[  142.223290]  ? __mutex_unlock_slowpath+0x2c/0x270
[  142.223292]  flush_rcu_work+0x30/0x40
[  142.223294]  kvfree_rcu_barrier+0xe9/0x130
[  142.223296]  kmem_cache_destroy+0x2b/0x1f0
[  142.223297]  cache_destroy_workfn+0x20/0x40 [slub_kunit]
[  142.223299]  process_one_work+0x1cd/0x560
[  142.223302]  worker_thread+0x183/0x310
[  142.223304]  ? rescuer_thread+0x330/0x330
[  142.223306]  kthread+0xd8/0x1d0
[  142.223308]  ? ret_from_fork+0x17/0x50
[  142.223310]  ? lock_release+0xb3/0x250
[  142.223311]  ? kthreads_online_cpu+0xf0/0xf0
[  142.223313]  ret_from_fork+0x2d/0x50
[  142.223315]  ? kthreads_online_cpu+0xf0/0xf0
[  142.223317]  ret_from_fork_asm+0x11/0x20
[  142.223321]  </TASK>
[  142.371052] workqueue: WQ_MEM_RECLAIM test_kfree_rcu_destroy_wq:cache_destroy_workfn [slub_kunit] is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
[  142.371072] WARNING: CPU: 11 PID: 186 at kernel/workqueue.c:3715 check_flush_dependency.part.0+0xad/0x100
[  142.375748] Modules linked in: slub_kunit(E) rcutorture(E) torture(E) kunit(E) iTCO_wdt(E) iTCO_vendor_support(E) intel_uncore_frequency_common(E) skx_edac_common(E) nfit(E) libnvdimm(E) kvm_intel(E) kvm(E) evdev(E) bochs(E) serio_raw(E) drm_kms_helper(E) i2c_i801(E) e1000e(E) i2c_smbus(E) intel_agp(E) intel_gtt(E) lpc_ich(E) agpgart(E) mfd_core(E) drm_shm]

