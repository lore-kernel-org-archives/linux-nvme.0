Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5207CC021B3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Feb 2025 16:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u1rJcr0E4srTcqTLbk7vYO/8bEZ4/iAouOB6dwNH0mc=; b=AGlwPA8rz6Fz1b6u5TmJ8dT1x6
	7Fl0YNznIfCnhWgXRfHXXM7CoR/vY+7zpKaGuQvDPVUPTezjzdKljqiZVVrzrmeCaUQXvRZzHR7z3
	KbLXulgA9jXblixL9+cDg+N0BedVGZUCNVTR3KkW38YTqxhGcb5NEnaUPvZ4BfnZ9An23yFk7MwLS
	zYS4MYnb0wwt2xGIl4Uo6r90/aipMWWZQLhYb0Evx8ML9tPe5o5UdlRh0Ji5G9Ed/DHkDDUc5Eqk1
	JVsXiCw5M27TTLrulctQTd68So1xHvXh4HiawxXr9BufRc0TV30LVzCjqj0EWSnEj1Lp4De3sjwLs
	Abe6+PmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlVxs-00000006CHI-3TYv;
	Fri, 21 Feb 2025 16:33:24 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlVvA-00000006Bhd-2VY1
	for linux-nvme@lists.infradead.org;
	Fri, 21 Feb 2025 16:30:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3D6845C69C7;
	Fri, 21 Feb 2025 16:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1702AC4CED6;
	Fri, 21 Feb 2025 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740155435;
	bh=peJoIjn/lcRBU6pV4UiXQxxm+ZfErwKhGJ/8tg/aPdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBrZU0d8BAYwdl1hhWZIz2ADAu1Bb4i21ZBFgizW6LukDfTPfF2IEFSzn70jG1+Lq
	 H3y8mbF6U2kySYBGPxfok4RIbRSiVorznbcfL4hoC38izjBtQfHHq9RxR5fSDY6rAb
	 N0gvdlVliwjj+dMS5uLu3EsFhxm38xL0FZCLkUAJVe/9sXZdrRR8Yno0Jp4QS1VezO
	 cMz2BJl/kJMu3OUZIStoQNmEKo8mnkyc+BA46GqyZL2wTUkobyU+OalyQtS4oVg9yH
	 IRcz68b5DjF6QDcPaBaJRzBqcLHK8rI3p3LsFDTijbNkZP37TGrHlp07eiMcmHHI0e
	 uWw0ojmIpRufg==
Date: Fri, 21 Feb 2025 09:30:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
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
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
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
Message-ID: <Z7iqJtCjHKfo8Kho@kbusch-mbp>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250221_083036_758511_B2E616C0 
X-CRM114-Status: GOOD (  31.55  )
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

On Wed, Aug 07, 2024 at 12:31:19PM +0200, Vlastimil Babka wrote:
> We would like to replace call_rcu() users with kfree_rcu() where the
> existing callback is just a kmem_cache_free(). However this causes
> issues when the cache can be destroyed (such as due to module unload).
> 
> Currently such modules should be issuing rcu_barrier() before
> kmem_cache_destroy() to have their call_rcu() callbacks processed first.
> This barrier is however not sufficient for kfree_rcu() in flight due
> to the batching introduced by a35d16905efc ("rcu: Add basic support for
> kfree_rcu() batching").
> 
> This is not a problem for kmalloc caches which are never destroyed, but
> since removing SLOB, kfree_rcu() is allowed also for any other cache,
> that might be destroyed.
> 
> In order not to complicate the API, put the responsibility for handling
> outstanding kfree_rcu() in kmem_cache_destroy() itself. Use the newly
> introduced kvfree_rcu_barrier() to wait before destroying the cache.
> This is similar to how we issue rcu_barrier() for SLAB_TYPESAFE_BY_RCU
> caches, but has to be done earlier, as the latter only needs to wait for
> the empty slab pages to finish freeing, and not objects from the slab.
> 
> Users of call_rcu() with arbitrary callbacks should still issue
> rcu_barrier() before destroying the cache and unloading the module, as
> kvfree_rcu_barrier() is not a superset of rcu_barrier() and the
> callbacks may be invoking module code or performing other actions that
> are necessary for a successful unload.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab_common.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index c40227d5fa07..1a2873293f5d 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -508,6 +508,9 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  	if (unlikely(!s) || !kasan_check_byte(s))
>  		return;
>  
> +	/* in-flight kfree_rcu()'s may include objects from our cache */
> +	kvfree_rcu_barrier();
> +
>  	cpus_read_lock();
>  	mutex_lock(&slab_mutex);

This patch appears to be triggering a new warning in certain conditions
when tearing down an nvme namespace's block device. Stack trace is at
the end.

The warning indicates that this shouldn't be called from a
WQ_MEM_RECLAIM workqueue. This workqueue is responsible for bringing up
and tearing down block devices, so this is a memory reclaim use AIUI.
I'm a bit confused why we can't tear down a disk from within a memory
reclaim workqueue. Is the recommended solution to simply remove the WQ
flag when creating the workqueue?

  ------------[ cut here ]------------
  workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_scan_work is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
  WARNING: CPU: 21 PID: 330 at kernel/workqueue.c:3719 check_flush_dependency+0x112/0x120
  Modules linked in: intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) skx_edac_common(E) nfit(E) libnvdimm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) iTCO_wdt(E) xhci_pci(E) mlx5_ib(E) ipmi_si(E) iTCO_vendor_support(E) i2c_i801(E) ipmi_devintf(E) evdev(E) kvm(E) xhci_hcd(E) ib_uverbs(E) acpi_cpufreq(E) wmi(E) i2c_smbus(E) ipmi_msghandler(E) button(E) efivarfs(E) autofs4(E)
  CPU: 21 UID: 0 PID: 330 Comm: kworker/u144:6 Tainted: G            E      6.13.2-0_g925d379822da #1
  Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive MP, BIOS YMM20 02/01/2023
  Workqueue: nvme-wq nvme_scan_work
  RIP: 0010:check_flush_dependency+0x112/0x120
  Code: 05 9a 40 14 02 01 48 81 c6 c0 00 00 00 48 8b 50 18 48 81 c7 c0 00 00 00 48 89 f9 48 c7 c7 90 64 5a 82 49 89 d8 e8 7e 4f 88 ff <0f> 0b eb 8c cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00 41 57 41
  RSP: 0018:ffffc90000df7bd8 EFLAGS: 00010082
  RAX: 000000000000006a RBX: ffffffff81622390 RCX: 0000000000000027
  RDX: 00000000fffeffff RSI: 000000000057ffa8 RDI: ffff88907f960c88
  RBP: 0000000000000000 R08: ffffffff83068e50 R09: 000000000002fffd
  R10: 0000000000000004 R11: 0000000000000000 R12: ffff8881001a4400
  R13: 0000000000000000 R14: ffff88907f420fb8 R15: 0000000000000000
  FS:  0000000000000000(0000) GS:ffff88907f940000(0000) knlGS:0000000000000000
  CR2: 00007f60c3001000 CR3: 000000107d010005 CR4: 00000000007726f0
  PKRU: 55555554
  Call Trace:
   <TASK>
   ? __warn+0xa4/0x140
   ? check_flush_dependency+0x112/0x120
   ? report_bug+0xe1/0x140
   ? check_flush_dependency+0x112/0x120
   ? handle_bug+0x5e/0x90
   ? exc_invalid_op+0x16/0x40
   ? asm_exc_invalid_op+0x16/0x20
   ? timer_recalc_next_expiry+0x190/0x190
   ? check_flush_dependency+0x112/0x120
   ? check_flush_dependency+0x112/0x120
   __flush_work.llvm.1643880146586177030+0x174/0x2c0
   flush_rcu_work+0x28/0x30
   kvfree_rcu_barrier+0x12f/0x160
   kmem_cache_destroy+0x18/0x120
   bioset_exit+0x10c/0x150
   disk_release.llvm.6740012984264378178+0x61/0xd0
   device_release+0x4f/0x90
   kobject_put+0x95/0x180
   nvme_put_ns+0x23/0xc0
   nvme_remove_invalid_namespaces+0xb3/0xd0
   nvme_scan_work+0x342/0x490
   process_scheduled_works+0x1a2/0x370
   worker_thread+0x2ff/0x390
   ? pwq_release_workfn+0x1e0/0x1e0
   kthread+0xb1/0xe0
   ? __kthread_parkme+0x70/0x70
   ret_from_fork+0x30/0x40
   ? __kthread_parkme+0x70/0x70
   ret_from_fork_asm+0x11/0x20
   </TASK>
  ---[ end trace 0000000000000000 ]---

