Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EBEC021BB
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 17:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GKmie4ql2EMQXkPV0dHeKHuPylk+abYCTsODvoG58iw=; b=Pge7YjmKSBL6N5XeZHOD5VSgPY
	5jtIT6Z7LGI1DN8EsoXQUT7VkO6x9WEtL0I8EVT8sBwGc3U/wpAkxDgr1zTBwBC/Wofvm7Pl7uzuH
	Ekq8pRAoAru+ZvM8MXa7RlZMIt8gnpMCmlAe0edxSLbiTux29cgCJoHl7u79uHPzKx+eOBFsSNIeH
	aYyX6m2EsnKx+cMCLBpS2evCoTf7nFydhtDQmbtgl/z02Rd70bHP1lXo1pecjHVklfTITqgrM4BqJ
	lUjskTCFb8425kohzD4KW8FtWKvlqz3UkFWyeo4LOdTn9n7i+53gWpOnsNM0rJ08DpwsRIcHIpphn
	ukWZLI4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmyLG-00000000WNJ-1Um1;
	Tue, 25 Feb 2025 17:03:34 +0000
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWtJ-0000000DTne-1kXg
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 11:44:54 +0000
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-30930b0b420so37795571fa.2
        for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 03:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740397491; x=1741002291; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GKmie4ql2EMQXkPV0dHeKHuPylk+abYCTsODvoG58iw=;
        b=m9vh2S9XveNrDCJDX0NMawqDu9HUYv1f5lYKcGq+pFyc9g/ahs7qKYDl8qfJT83seO
         hd2lPVsMvIaD2qp8Ql2Kba5wk3IPPhOZklzWU5BpTLLmSvOTxdrxiATj2rEmyXuIo1xe
         Bn0BZc2i3uPFCKHE/yBqQUyQ2WWpao3JHbcFBxOC5CadNXUgnfvzhuMJvXSmvtY6KgCG
         3T129YV0k5FiMB32Vu2xnjAs14iCrtbNYQGoCPqKXwkyS02Itvda7WSo51UpLfTy51zI
         1dxyU5R8A2DKCo1c+ffeYOnJoBxNXUKpK/aAfWzNNHPo4P7krQh3vjCZ9D3SqzpC/IXc
         9Z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740397491; x=1741002291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKmie4ql2EMQXkPV0dHeKHuPylk+abYCTsODvoG58iw=;
        b=WaDqq4Tu/TxFKcJVeX2UuiqFCjBc0313yF5DKG8WBpuwa3313Y5UnGWi3ZixiDmr2O
         RFmijc9kLg8xRylkJOErxLMc1oOwuKJBpittxZXmOKN/GWxd3nBHHtZGfayoLLdp981Z
         zXSWl/Obmo7LW0eYlz63JFqsJP8/TlkpKA4jMQwcT5Mr+vnUF4KNi83LzczeMaz4v6F2
         NDjvYvRz4WBB0BYFr1DvLM8lZXEut2ryBZxH5xliUZxCQy0J1PXV0Vn11W4N/8iCP07Q
         HuX6HPGf/K+d1Yh8slSX7w5dt49XI9K6uyxLawhlaQWTJUEzmJg3L2pJqHDtU8k7R5VR
         kzwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmZlyr796Hd0AheWAof066lfAsGYXMaX4ALT90ovThjfNCLf6t0qu9I+qd2jjD/1t50Q0tWjK5wlPF@lists.infradead.org
X-Gm-Message-State: AOJu0YwEqvCEjVPYjPZlwitMAZvk1kgrP4ykFOcyEQI0a9THmoZ54yAf
	wO1tJ/EWvD8qH2+fSJ2Dyu94FWltroGCmysBrM1vnL/wKcC7FbTs
X-Gm-Gg: ASbGncuVGsMP+EzgmQbFuEghxaDr0Wnrzh5pJHedHMHUoAMCUx4SKTXb8QK4PZH4Ui2
	6ltrZfmZmCi001MZOsjo1AsggkeStnV4bc9m4KASkiApf/LeKz5o92fHqTyr/v26X9UzX/A8Cke
	p5q3zSSGDQC1TUMgZwqCuFgNcf2wuTlgtruWSZwwg+OfP+RIzFCqDwtEdR5QzC33aHz39immifB
	9oT14+seUDvhgaqCZvK6BrPUu92XEMdbEPYr4Jg+hIBfGk5i611num2kB1olbE0IM6gRUfYwekJ
	GRE+xeq12Wsuq3QVBzhjLC/vD1cq9zcUa+LAcugvsdx9LR1W
X-Google-Smtp-Source: AGHT+IGjbXqoMdV+6yP1nHJ/PGwFmTUOZnYyR49KFY2a21Z1wZNQdeD93xJxOmEV3IxFMucNPB3mfQ==
X-Received: by 2002:a05:6512:1244:b0:545:1104:617d with SMTP id 2adb3069b0e04-54838eddea5mr5695115e87.11.1740397490753;
        Mon, 24 Feb 2025 03:44:50 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461f541653sm2376875e87.156.2025.02.24.03.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 03:44:50 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 24 Feb 2025 12:44:46 +0100
To: Vlastimil Babka <vbabka@suse.cz>, Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>,
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
Message-ID: <Z7xbrnP8kTQKYO6T@pc636>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp>
 <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_034453_460312_C3B68D87 
X-CRM114-Status: GOOD (  41.90  )
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

On Fri, Feb 21, 2025 at 06:28:49PM +0100, Vlastimil Babka wrote:
> On 2/21/25 17:30, Keith Busch wrote:
> > On Wed, Aug 07, 2024 at 12:31:19PM +0200, Vlastimil Babka wrote:
> >> We would like to replace call_rcu() users with kfree_rcu() where the
> >> existing callback is just a kmem_cache_free(). However this causes
> >> issues when the cache can be destroyed (such as due to module unload).
> >> 
> >> Currently such modules should be issuing rcu_barrier() before
> >> kmem_cache_destroy() to have their call_rcu() callbacks processed first.
> >> This barrier is however not sufficient for kfree_rcu() in flight due
> >> to the batching introduced by a35d16905efc ("rcu: Add basic support for
> >> kfree_rcu() batching").
> >> 
> >> This is not a problem for kmalloc caches which are never destroyed, but
> >> since removing SLOB, kfree_rcu() is allowed also for any other cache,
> >> that might be destroyed.
> >> 
> >> In order not to complicate the API, put the responsibility for handling
> >> outstanding kfree_rcu() in kmem_cache_destroy() itself. Use the newly
> >> introduced kvfree_rcu_barrier() to wait before destroying the cache.
> >> This is similar to how we issue rcu_barrier() for SLAB_TYPESAFE_BY_RCU
> >> caches, but has to be done earlier, as the latter only needs to wait for
> >> the empty slab pages to finish freeing, and not objects from the slab.
> >> 
> >> Users of call_rcu() with arbitrary callbacks should still issue
> >> rcu_barrier() before destroying the cache and unloading the module, as
> >> kvfree_rcu_barrier() is not a superset of rcu_barrier() and the
> >> callbacks may be invoking module code or performing other actions that
> >> are necessary for a successful unload.
> >> 
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >>  mm/slab_common.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >> 
> >> diff --git a/mm/slab_common.c b/mm/slab_common.c
> >> index c40227d5fa07..1a2873293f5d 100644
> >> --- a/mm/slab_common.c
> >> +++ b/mm/slab_common.c
> >> @@ -508,6 +508,9 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >>  	if (unlikely(!s) || !kasan_check_byte(s))
> >>  		return;
> >>  
> >> +	/* in-flight kfree_rcu()'s may include objects from our cache */
> >> +	kvfree_rcu_barrier();
> >> +
> >>  	cpus_read_lock();
> >>  	mutex_lock(&slab_mutex);
> > 
> > This patch appears to be triggering a new warning in certain conditions
> > when tearing down an nvme namespace's block device. Stack trace is at
> > the end.
> > 
> > The warning indicates that this shouldn't be called from a
> > WQ_MEM_RECLAIM workqueue. This workqueue is responsible for bringing up
> > and tearing down block devices, so this is a memory reclaim use AIUI.
> > I'm a bit confused why we can't tear down a disk from within a memory
> > reclaim workqueue. Is the recommended solution to simply remove the WQ
> > flag when creating the workqueue?
> 
> I think it's reasonable to expect a memory reclaim related action would
> destroy a kmem cache. Mateusz's suggestion would work around the issue, but
> then we could get another surprising warning elsewhere. Also making the
> kmem_cache destroys async can be tricky when a recreation happens
> immediately under the same name (implications with sysfs/debugfs etc). We
> managed to make the destroying synchronous as part of this series and it
> would be great to keep it that way.
> 
> >   ------------[ cut here ]------------
> >   workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_scan_work is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
> 
> Maybe instead kfree_rcu_work should be using a WQ_MEM_RECLAIM workqueue? It
> is after all freeing memory. Ulad, what do you think?
> 
We reclaim memory, therefore WQ_MEM_RECLAIM seems what we need.
AFAIR, there is an extra rescue worker, which can really help
under a low memory condition in a way that we do a progress.

Do we have a reproducer of mentioned splat?

--
Uladzislau Rezki

