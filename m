Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04052C18E7C
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 15:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eswWLfkEnQpdtu+isG+K14u+ZfJSvAbvqWCgztSMnzs=; b=1+f0y8dd9kbM/Go3fVmla6XM8w
	rkhbkIVOXXGFnFERwN37CAxYQQ5RcAvqXH/Aad339RgQ2ntfQr451MpjTRxmEa0ZrXOcs3QVTTpIf
	OzMpCdgAQ05+/Gno9S07ojKojmjlJRYqErEC50eFkN12X8K6quj0/0MMSCcL2gDqgbHGYVbM84oU0
	FsavzuOHfRqAX1YvSDo+0HJFHvShYx0hGTuLM341q68Nlk+23JJP1JBirkrmtAtwWwNOw/rb7nNy7
	m+DvafjiyXU9HILbEfizFESlhBJxCTRpQ5VPhFw7B3dDwUlnnVxeu7tkqG8kXHvwB23f4nRUuHHyR
	f3ZsQuAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnJif-00000004PTL-1T8X;
	Wed, 26 Feb 2025 15:53:09 +0000
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnIRI-000000045rl-0G2D
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 14:31:09 +0000
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-30a2f240156so72204771fa.3
        for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 06:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740580266; x=1741185066; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eswWLfkEnQpdtu+isG+K14u+ZfJSvAbvqWCgztSMnzs=;
        b=BLTg8PpVThnATFAZe6yqsUx3WAlSEHyowniF7eke/ajLWAxC5R0SwI1Dzt1iQ+PjnN
         XaXj5F7F/L2e5mugFyT0LOzyQrgOljHc2YfUMKIu0EW/ER2I6Qup0t2Ft1ON808zPgPs
         xnfmR8XKB8cwrRv7M9l7VzGWw3WJH0cfxRRIBe1fbEBiNR8e3+JhQBC7LG/7FsqPs3Ur
         BRCkbw7N6CsnnIBoMuj1m0dF3mtd2bFpepTb31IG/VrB5QccdQ7sjO+R78nXZOJ+0xAR
         fA4roVtKm7qYHsSFJvnQ9KC+NyhHgFI4rRHgtZopGRQXHh0LMVfrvdyGdOif38kpRod7
         Q99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740580266; x=1741185066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eswWLfkEnQpdtu+isG+K14u+ZfJSvAbvqWCgztSMnzs=;
        b=veLJVhHFQ8g7CFJVjpxgvtIUhUiBOIfbqTolGAn3TKqO3xArFOp2LPQRDsJu5NykIL
         +gZOdU2qFYx9HMnbfW9/TL4CxFKNBe9iov2fik+YHyRfIW2jGxvuYek5mmhaSWKhtDLS
         nASx6rYWPzFgAozLk2aNlNDcM7SngZcsRuTFOys/qrEIyfvc9XCeAq4UX7VkOndVNXCx
         G+dI6nfs5UP1fDztrk2CJJkCLInzqXZAf/40+Nm+ZjY9UTkl3PtxZJvl+3p2gx1/6IBa
         BHzfeVNOHbqMFOeTeO2z2toec5xGuNlAdE2U6gRwXoVKYVZdd7fdc22xSOHra16rrQ4w
         TOKg==
X-Forwarded-Encrypted: i=1; AJvYcCWKxzSg/8EjECoMXjjV0EJ59op0/Mk7xtig5T/hviO/EF9reiMF6jhKdDz+dSrZjf4ZU+b0Ym9Z+mut@lists.infradead.org
X-Gm-Message-State: AOJu0YxG6TSu5UhM3a7hVUyIq7OpB5NOeFsRKMsLl5QJWs29HvzAe1+5
	KqmMB25E1epX5R1j3EziajoDBP0H5buKHgQSRnG2pfr3lw/jLQq1
X-Gm-Gg: ASbGnctZniZsv/zduCWoLAMkOuYXArAXv+dvZjvjsCm/iXF54UdiXtrXyMaZg4Eu0MN
	R/60Yfrk3HXRZPgsZ9TJfl1VGdRvlE7jMnyOi4aTUzdtZgIlX2/z9dk6syZtZZDC50Wwf/66whU
	51WQ/wgjrjpmL5FVKRIiFTBHBJEOiDW9R3vBo8Xks4yuaKyNGxZp8eIE/OWF689BlqHrvVgK8ed
	afXnmSLfH2NniDBoqfACgiFUnpsvnf+fPrfda3ElDVk2sVPpp02JhfeJz7OHYVpejE7dvdDbOur
	0q5JvMHGBUWfjSiCsmZScBaOwf3osXDmTdBtKGlyPMmIUSlr
X-Google-Smtp-Source: AGHT+IGJW1NAlywvROVKX3Fy47FV/keZ7CVdQO/S4ffINoO6dO3Lou+LoCLXMQL+bGSH5kPPCn5/wg==
X-Received: by 2002:a2e:9a98:0:b0:307:5879:e7d8 with SMTP id 38308e7fff4ca-30b792cb29cmr26025521fa.30.1740580265244;
        Wed, 26 Feb 2025 06:31:05 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819f5e4asm5422341fa.63.2025.02.26.06.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:31:04 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 26 Feb 2025 15:31:01 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Keith Busch <keith.busch@gmail.com>,
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
Message-ID: <Z78lpfLFvNxjoTNf@pc636>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp>
 <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
 <Z7xbrnP8kTQKYO6T@pc636>
 <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
 <Z73p2lRwKagaoUnP@kbusch-mbp>
 <CAOSXXT6-oWjKPV1hzXa5Ra4SPQg0L_FvxCPM0Sh0Yk6X90h0Sw@mail.gmail.com>
 <Z74Av6tlSOqcfb-q@pc636>
 <Z74KHyGGMzkhx5f-@pc636>
 <8d7aabb2-2836-4c09-9fc7-8bde271e7f23@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d7aabb2-2836-4c09-9fc7-8bde271e7f23@suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_063108_099427_DD1219A8 
X-CRM114-Status: GOOD (  23.91  )
X-Mailman-Approved-At: Wed, 26 Feb 2025 07:53:07 -0800
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

On Wed, Feb 26, 2025 at 11:59:53AM +0100, Vlastimil Babka wrote:
> On 2/25/25 7:21 PM, Uladzislau Rezki wrote:
> >>
> > WQ_MEM_RECLAIM-patch fixes this for me:
> 
> Sounds good, can you send a formal patch then?
>
Do you mean both? Test case and fix? I can :)

> Some nits below:
> 
> > <snip>
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 4030907b6b7d..1b5ed5512782 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1304,6 +1304,8 @@ module_param(rcu_min_cached_objs, int, 0444);
> >  static int rcu_delay_page_cache_fill_msec = 5000;
> >  module_param(rcu_delay_page_cache_fill_msec, int, 0444);
> > 
> > +static struct workqueue_struct *rcu_reclaim_wq;
> > +
> >  /* Maximum number of jiffies to wait before draining a batch. */
> >  #define KFREE_DRAIN_JIFFIES (5 * HZ)
> >  #define KFREE_N_BATCHES 2
> > @@ -1632,10 +1634,10 @@ __schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
> >         if (delayed_work_pending(&krcp->monitor_work)) {
> >                 delay_left = krcp->monitor_work.timer.expires - jiffies;
> >                 if (delay < delay_left)
> > -                       mod_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
> > +                       mod_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
> >                 return;
> >         }
> > -       queue_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
> > +       queue_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
> >  }
> > 
> >  static void
> > @@ -1733,7 +1735,7 @@ kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
> >                         // "free channels", the batch can handle. Break
> >                         // the loop since it is done with this CPU thus
> >                         // queuing an RCU work is _always_ success here.
> > -                       queued = queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
> > +                       queued = queue_rcu_work(rcu_reclaim_wq, &krwp->rcu_work);
> >                         WARN_ON_ONCE(!queued);
> >                         break;
> >                 }
> > @@ -1883,7 +1885,7 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
> >         if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> >                         !atomic_xchg(&krcp->work_in_progress, 1)) {
> >                 if (atomic_read(&krcp->backoff_page_cache_fill)) {
> > -                       queue_delayed_work(system_unbound_wq,
> > +                       queue_delayed_work(rcu_reclaim_wq,
> >                                 &krcp->page_cache_work,
> >                                         msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
> >                 } else {
> > @@ -2120,6 +2122,10 @@ void __init kvfree_rcu_init(void)
> >         int i, j;
> >         struct shrinker *kfree_rcu_shrinker;
> > 
> > +       rcu_reclaim_wq = alloc_workqueue("rcu_reclaim",
> 
> Should we name it "kvfree_rcu_reclaim"? rcu_reclaim sounds too generic
> as if it's part of rcu itself?
> 
> > +               WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
> 
> Do we want WQ_SYSFS? Or maybe only when someone asks, with a use case?
> 
If someone asks, IMO.

--
Uladzislau Rezki

