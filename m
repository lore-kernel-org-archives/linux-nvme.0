Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C52C021B8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 17:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uT3CYG520Dq/1dijGlLbTlImqbVeMFyUskqf9mGklcY=; b=WSFmnon/yIXf8HAEy5AF7RK5ev
	0Kdk9FvpGwoxVE3g9Lod4Xpwwj6n/8QmceDmt1vmbB8QFxRwOKBJ5wSjKdFVSNTeQxt7WCNYQXJC4
	tGZxyh/XWv3eCDKXsIKE5PEAWQxasNvym9dcZa23sY9ETLtFQNl6RY60bRlZgKMqmkZkZBZNqpoA9
	Gv9AYIcP05CY4lbQfnvZAg7rUXtT41V8F3g39VMi1hO37zLh40aO9OFVFNNBNU7uJ1AT1RqAhwwzG
	D0Z0svPFla0+MRvNgB0lsQbP18o9iyb59+jcK9pl0t/YkAoHaLJat8U9/5AEeH0nKlD2bNoS2bLSZ
	T5mMD7tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmyLJ-00000000WPh-0SNt;
	Tue, 25 Feb 2025 17:03:37 +0000
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmv9f-0000000HP8e-2lkS
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 13:39:24 +0000
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-30a2f240156so57585621fa.3
        for <linux-nvme@lists.infradead.org>; Tue, 25 Feb 2025 05:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740490761; x=1741095561; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uT3CYG520Dq/1dijGlLbTlImqbVeMFyUskqf9mGklcY=;
        b=HB+3bOanpfxtKUfYqRIZ2TPXn61be/xH7jjsKXDqS0dmPZ4OGNOzSFWwtFqMTBz3wT
         QcaLx+55uGrt2dJ2m+SFipNbrSqufnHj08bjy3pQEWIPbJA5eKndWcC88mL7PIo+VVW/
         9XnFAZjOzkU4QJeVOZJIJq8psQ8gae6f+2DVSUtAVzV7WtsJTge8YaO6/TuUAqSrIARX
         fICDxMgXlKnJubqMdpOxe/BEPk5Cs9QkzXvb+QtJw2zs/baGRrW5uzp9I+WVj+DEB+0v
         YDnfcKNgncSmAmPDcPznekvpGOz3ZnUFH9nZQJgBrl1rDimwXlNZEOfG1fQOej9rhovt
         rz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740490761; x=1741095561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uT3CYG520Dq/1dijGlLbTlImqbVeMFyUskqf9mGklcY=;
        b=DXp3IQ6D9pf0ecOSi3Smw6VVvSOrMKpX2WpJmdfZ2hcq0VVdICntMypVoVwa1RLkIK
         nNoMWSVIpfm+sMTOqs+tMv6vWQYgSZjZFYEChVucrU6DRFhAfdFsouj4Lz77znLZ0bWA
         JV6KZ0qsqULWnH3ezrxD0rJHnCi+sMyfip6W7fHPhrfmJPP4X37aWHcE5kgXWgKwi+9U
         TSDQSGk95r917o1fFsFvTUn2OX3lFHr2b1Wj/Y/X1PqX901cyPSdiQgKm3EZRKdE2W2K
         358Qy9vmeCJLg7gjFPb458dPjQtEQHVxOMl0vnxNUT/dQNrY1a9WWp8LrTJdAlaJyeu/
         X/8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeQyO1A7E1JIZbwGgpnsxvbj3AXKUp67hsK37kfy+k92w7VFTs4u5CrQbSadvOvud2Oa87bTrNKo7d@lists.infradead.org
X-Gm-Message-State: AOJu0Yy+6Lv7GqJdMIh+rDXivCozmsJjxZyKk3+UoudSIopVSbP0N+Uu
	w+vKyEL6kvv8UQklzXtNZWZLTCcoXws87Kfa+x/BCeob3BIvXzX0
X-Gm-Gg: ASbGnctQM+iaJaKrTA/k4NcqeQqe8Cq/DNrM0lJI8EmFLDXtaJVZdIF4J1oxMa8QGwH
	teBnYdHuGi1g0k3F4vC5kjMtbHn6b3IOYvs3Kylbrq0/rHMNeHxFDvQEXsj3Vs67cNQ2q7anwvf
	XY+CtGlCpWpAYNnkTzPwMBCGjukmhKO/0boyMhh1pBWEvQQFXWX4bJczy8NVPgiRKRuiFKMwXy9
	zjCmq+PLm4Q30KXZ+hcb7cDRPndNnqbk1v8UPUkzyz/nmS3bKyrqHdMWfiowFTce0N1pJtzq4HW
	J2ZvYCOFXCOLb5pYETKhgqPNX9CNkYKL3fiXsHZP3gH/hn/7
X-Google-Smtp-Source: AGHT+IFNV2rx8abzKJFcJ2A+jBxuuw5RrwkFtqBmny0yVTTzAz0hhI1h/FhGU/in4snmWgKvHrdp0Q==
X-Received: by 2002:a05:651c:2227:b0:300:3307:389d with SMTP id 38308e7fff4ca-30a598e5c7cmr69996921fa.19.1740490760754;
        Tue, 25 Feb 2025 05:39:20 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819f4a4bsm2372111fa.49.2025.02.25.05.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:39:19 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 25 Feb 2025 14:39:16 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>, Keith Busch <kbusch@kernel.org>,
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
Message-ID: <Z73IBMdk5fnmYnN1@pc636>
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
X-CRM114-CacheID: sfid-20250225_053923_701407_CAE9EFD0 
X-CRM114-Status: GOOD (  59.64  )
X-Mailman-Approved-At: Tue, 25 Feb 2025 08:58:02 -0800
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
> On 2/24/25 12:44, Uladzislau Rezki wrote:
> > On Fri, Feb 21, 2025 at 06:28:49PM +0100, Vlastimil Babka wrote:
> >> On 2/21/25 17:30, Keith Busch wrote:
> >> > On Wed, Aug 07, 2024 at 12:31:19PM +0200, Vlastimil Babka wrote:
> >> >> We would like to replace call_rcu() users with kfree_rcu() where the
> >> >> existing callback is just a kmem_cache_free(). However this causes
> >> >> issues when the cache can be destroyed (such as due to module unload).
> >> >> 
> >> >> Currently such modules should be issuing rcu_barrier() before
> >> >> kmem_cache_destroy() to have their call_rcu() callbacks processed first.
> >> >> This barrier is however not sufficient for kfree_rcu() in flight due
> >> >> to the batching introduced by a35d16905efc ("rcu: Add basic support for
> >> >> kfree_rcu() batching").
> >> >> 
> >> >> This is not a problem for kmalloc caches which are never destroyed, but
> >> >> since removing SLOB, kfree_rcu() is allowed also for any other cache,
> >> >> that might be destroyed.
> >> >> 
> >> >> In order not to complicate the API, put the responsibility for handling
> >> >> outstanding kfree_rcu() in kmem_cache_destroy() itself. Use the newly
> >> >> introduced kvfree_rcu_barrier() to wait before destroying the cache.
> >> >> This is similar to how we issue rcu_barrier() for SLAB_TYPESAFE_BY_RCU
> >> >> caches, but has to be done earlier, as the latter only needs to wait for
> >> >> the empty slab pages to finish freeing, and not objects from the slab.
> >> >> 
> >> >> Users of call_rcu() with arbitrary callbacks should still issue
> >> >> rcu_barrier() before destroying the cache and unloading the module, as
> >> >> kvfree_rcu_barrier() is not a superset of rcu_barrier() and the
> >> >> callbacks may be invoking module code or performing other actions that
> >> >> are necessary for a successful unload.
> >> >> 
> >> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> >> ---
> >> >>  mm/slab_common.c | 3 +++
> >> >>  1 file changed, 3 insertions(+)
> >> >> 
> >> >> diff --git a/mm/slab_common.c b/mm/slab_common.c
> >> >> index c40227d5fa07..1a2873293f5d 100644
> >> >> --- a/mm/slab_common.c
> >> >> +++ b/mm/slab_common.c
> >> >> @@ -508,6 +508,9 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >> >>  	if (unlikely(!s) || !kasan_check_byte(s))
> >> >>  		return;
> >> >>  
> >> >> +	/* in-flight kfree_rcu()'s may include objects from our cache */
> >> >> +	kvfree_rcu_barrier();
> >> >> +
> >> >>  	cpus_read_lock();
> >> >>  	mutex_lock(&slab_mutex);
> >> > 
> >> > This patch appears to be triggering a new warning in certain conditions
> >> > when tearing down an nvme namespace's block device. Stack trace is at
> >> > the end.
> >> > 
> >> > The warning indicates that this shouldn't be called from a
> >> > WQ_MEM_RECLAIM workqueue. This workqueue is responsible for bringing up
> >> > and tearing down block devices, so this is a memory reclaim use AIUI.
> >> > I'm a bit confused why we can't tear down a disk from within a memory
> >> > reclaim workqueue. Is the recommended solution to simply remove the WQ
> >> > flag when creating the workqueue?
> >> 
> >> I think it's reasonable to expect a memory reclaim related action would
> >> destroy a kmem cache. Mateusz's suggestion would work around the issue, but
> >> then we could get another surprising warning elsewhere. Also making the
> >> kmem_cache destroys async can be tricky when a recreation happens
> >> immediately under the same name (implications with sysfs/debugfs etc). We
> >> managed to make the destroying synchronous as part of this series and it
> >> would be great to keep it that way.
> >> 
> >> >   ------------[ cut here ]------------
> >> >   workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_scan_work is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
> >> 
> >> Maybe instead kfree_rcu_work should be using a WQ_MEM_RECLAIM workqueue? It
> >> is after all freeing memory. Ulad, what do you think?
> >> 
> > We reclaim memory, therefore WQ_MEM_RECLAIM seems what we need.
> > AFAIR, there is an extra rescue worker, which can really help
> > under a low memory condition in a way that we do a progress.
> > 
> > Do we have a reproducer of mentioned splat?
> 
> I tried to create a kunit test for it, but it doesn't trigger anything. Maybe
> it's too simple, or racy, and thus we are not flushing any of the queues from
> kvfree_rcu_barrier()?
> 
See some comments below. I will try to reproduce it today. But from the
first glance it should trigger it.

> ----8<----
> From 1e19ea78e7fe254034970f75e3b7cb705be50163 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Tue, 25 Feb 2025 10:51:28 +0100
> Subject: [PATCH] add test for kmem_cache_destroy in a workqueue
> 
> ---
>  lib/slub_kunit.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index f11691315c2f..5fe9775fba05 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -6,6 +6,7 @@
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/rcupdate.h>
> +#include <linux/delay.h>
>  #include "../mm/slab.h"
>  
>  static struct kunit_resource resource;
> @@ -181,6 +182,52 @@ static void test_kfree_rcu(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, 0, slab_errors);
>  }
>  
> +struct cache_destroy_work {
> +        struct work_struct work;
> +        struct kmem_cache *s;
> +};
> +
> +static void cache_destroy_workfn(struct work_struct *w)
> +{
> +	struct cache_destroy_work *cdw;
> +
> +	cdw = container_of(w, struct cache_destroy_work, work);
> +
> +	kmem_cache_destroy(cdw->s);
> +}
> +
> +static void test_kfree_rcu_wq_destroy(struct kunit *test)
> +{
> +	struct test_kfree_rcu_struct *p;
> +	struct cache_destroy_work cdw;
> +	struct workqueue_struct *wq;
> +	struct kmem_cache *s;
> +
> +	if (IS_BUILTIN(CONFIG_SLUB_KUNIT_TEST))
> +		kunit_skip(test, "can't do kfree_rcu() when test is built-in");
> +
> +	INIT_WORK_ONSTACK(&cdw.work, cache_destroy_workfn);
> +	wq = alloc_workqueue("test_kfree_rcu_destroy_wq", WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
>
Maybe it is worth to add WQ_HIGHPRI also to be ahead?

> +	if (!wq)
> +		kunit_skip(test, "failed to alloc wq");
> +
> +	s = test_kmem_cache_create("TestSlub_kfree_rcu_wq_destroy",
> +				   sizeof(struct test_kfree_rcu_struct),
> +				   SLAB_NO_MERGE);
> +	p = kmem_cache_alloc(s, GFP_KERNEL);
> +
> +	kfree_rcu(p, rcu);
> +
> +	cdw.s = s;
> +	queue_work(wq, &cdw.work);
> +	msleep(1000);
I am not sure it is needed. From the other hand it does nothing if
i do not miss anything.

> +	flush_work(&cdw.work);
> +
> +	destroy_workqueue(wq);
> +
> +	KUNIT_EXPECT_EQ(test, 0, slab_errors);
> +}
> +
>  static void test_leak_destroy(struct kunit *test)
>  {
>  	struct kmem_cache *s = test_kmem_cache_create("TestSlub_leak_destroy",
> @@ -254,6 +301,7 @@ static struct kunit_case test_cases[] = {
>  	KUNIT_CASE(test_clobber_redzone_free),
>  	KUNIT_CASE(test_kmalloc_redzone_access),
>  	KUNIT_CASE(test_kfree_rcu),
> +	KUNIT_CASE(test_kfree_rcu_wq_destroy),
>  	KUNIT_CASE(test_leak_destroy),
>  	KUNIT_CASE(test_krealloc_redzone_zeroing),
>  	{}
> -- 
> 2.48.1
> 
> 

--
Uladzislau Rezki

