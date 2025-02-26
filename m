Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B156C18E7C
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 15:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X3/aU7lmziMQt0GRz0RQ3LAAu7nNKTl6wiF2Hu6gTiY=; b=CLmRmLkWLl/XcWevy+JarJIaIs
	BXRBLchrA0ojSjzK3FgHUaticy5D8VXVTaLtytJjDcAB1cTS4ZMqBmqOOk11mzKpF0+xpjgzjbwHP
	H3GOb9bH1HCSUF/y4gGSw58quEU4egacW1RrHMpkqeFVYeS2GzIBgj7oKKv3RM8v9ufHCZtSTgBOB
	KagblUN+IWYy/a/WfBb19UKKuaC3Fr68Whd7DkaGX10uBLWYwEv1A0w37k/iMfodDjlZhGGEIGh2j
	/1PYI4s1G+Piq9wzwli3ggBJqmtiY37T4sw0R3qeiL/N3eI57HidYF8gPevc0C7p51tJImhUL/sfv
	Lkh2crKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnJiZ-00000004PQZ-1zeL;
	Wed, 26 Feb 2025 15:53:03 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnJhG-00000004P3A-20ka
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 15:51:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CCED35C5D9D;
	Wed, 26 Feb 2025 15:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B506C4CED6;
	Wed, 26 Feb 2025 15:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740585101;
	bh=dystgmSF/TCO8+uxX80prLd9mmlEKMg2wmXGUfrA378=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/wtZVHDOkcHb7Wj/XoTGhFH+jxWlVoY/3JmSc85XIsQBGuD3Gxmv325CJ64iW62I
	 sLn3ueeKUKKEkkKxXG1r3zuySs0GQNjC2xBBRb9EJlIYFWS6GbsPUfrvvmRV2a6dvf
	 XZAXHrOF0l30oLCks2wqUQnLjyU0cWBHUEWG6Y+ePaw0Mbm1ktvpkoGZBHjhBfKYwi
	 B7uFEabl3vRtrjctHeND1AeJpBZ72c+gaKOg/ZzNTibJxVnK7fN2grML69IQB6MsBH
	 BpVyRJswqscjYs7RJNdAbTx/Zlf0XO+ANH2X/3e4oTROLG/KcresZY91V6qxiCWYPA
	 BqIqJwDfWeC1Q==
Date: Wed, 26 Feb 2025 08:51:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Keith Busch <keith.busch@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
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
Message-ID: <Z784iRR13v6SkJv5@kbusch-mbp>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp>
 <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
 <Z7xbrnP8kTQKYO6T@pc636>
 <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
 <Z73p2lRwKagaoUnP@kbusch-mbp>
 <CAOSXXT6-oWjKPV1hzXa5Ra4SPQg0L_FvxCPM0Sh0Yk6X90h0Sw@mail.gmail.com>
 <Z74Av6tlSOqcfb-q@pc636>
 <Z74KHyGGMzkhx5f-@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z74KHyGGMzkhx5f-@pc636>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_075142_605364_FA8A52DB 
X-CRM114-Status: GOOD (  20.21  )
X-Mailman-Approved-At: Wed, 26 Feb 2025 07:53:02 -0800
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

On Tue, Feb 25, 2025 at 07:21:19PM +0100, Uladzislau Rezki wrote:
> WQ_MEM_RECLAIM-patch fixes this for me:

This is successful with the new kuint test for me as well. I can't
readily test this in production where I first learned of this issue (at
least not in the near term), but for what it's worth, this looks like a
good change to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>
 
> <snip>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 4030907b6b7d..1b5ed5512782 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1304,6 +1304,8 @@ module_param(rcu_min_cached_objs, int, 0444);
>  static int rcu_delay_page_cache_fill_msec = 5000;
>  module_param(rcu_delay_page_cache_fill_msec, int, 0444);
> 
> +static struct workqueue_struct *rcu_reclaim_wq;
> +
>  /* Maximum number of jiffies to wait before draining a batch. */
>  #define KFREE_DRAIN_JIFFIES (5 * HZ)
>  #define KFREE_N_BATCHES 2
> @@ -1632,10 +1634,10 @@ __schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
>         if (delayed_work_pending(&krcp->monitor_work)) {
>                 delay_left = krcp->monitor_work.timer.expires - jiffies;
>                 if (delay < delay_left)
> -                       mod_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
> +                       mod_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
>                 return;
>         }
> -       queue_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
> +       queue_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
>  }
> 
>  static void
> @@ -1733,7 +1735,7 @@ kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
>                         // "free channels", the batch can handle. Break
>                         // the loop since it is done with this CPU thus
>                         // queuing an RCU work is _always_ success here.
> -                       queued = queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
> +                       queued = queue_rcu_work(rcu_reclaim_wq, &krwp->rcu_work);
>                         WARN_ON_ONCE(!queued);
>                         break;
>                 }
> @@ -1883,7 +1885,7 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
>         if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
>                         !atomic_xchg(&krcp->work_in_progress, 1)) {
>                 if (atomic_read(&krcp->backoff_page_cache_fill)) {
> -                       queue_delayed_work(system_unbound_wq,
> +                       queue_delayed_work(rcu_reclaim_wq,
>                                 &krcp->page_cache_work,
>                                         msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
>                 } else {
> @@ -2120,6 +2122,10 @@ void __init kvfree_rcu_init(void)
>         int i, j;
>         struct shrinker *kfree_rcu_shrinker;
> 
> +       rcu_reclaim_wq = alloc_workqueue("rcu_reclaim",
> +               WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
> +       WARN_ON(!rcu_reclaim_wq);
> +
>         /* Clamp it to [0:100] seconds interval. */
>         if (rcu_delay_page_cache_fill_msec < 0 ||
>                 rcu_delay_page_cache_fill_msec > 100 * MSEC_PER_SEC) {
> <snip>

