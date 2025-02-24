Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6AAC021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 15:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KDaVhUlblnEguLdPYS8Pr9ZzC8T1XM3TdpsKGFZcVtw=; b=NPhCXWy3uHTqFI2/2+ugUfulfk
	XnlnG4dLK7EX3aFJ9GA8Q6XZzhyHGUXjp0aKeDIpkz677TGiz4x2avNT7ImRnvJu0ukENl1gA8b1g
	4O2UpkIUl4UT5zEYejo7+MsYq669tGeU+VwlWV5mRuBcsCmfCQu9cOEG2SzR8Smhxh8xiiJY+MEIh
	D+Coo9W+4dczxKeXkVFMhkFsOlYKWQWh2WtQ9b/Irz1aqsp88rzfByjGkNqS4EOLXffjW+xuRRaGP
	vSdNe7GvXTQ7o3VUZ7LxG1Ww3jPtNpsJAvb1ksJ3DmhBem35Fs7mNnw48AMnQN8dHoG4ZlwkfktSF
	gmUVJ9Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmaYS-0000000EJKf-2y2H;
	Mon, 24 Feb 2025 15:39:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmaWY-0000000EIwE-1Vnw
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 15:37:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 41A945C4888;
	Mon, 24 Feb 2025 15:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E79C4CED6;
	Mon, 24 Feb 2025 15:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740411456;
	bh=u5QAJ42DRy8ZnhVq2mJsa+QiTU0Mr4iCvNVvkjkRrkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n26tiAiPA/EnLuWwHHXxJQo0XxQ6+FBmRROtzKyw8CLdXwa+DUo1mj9Y81reXwfVZ
	 WsGSbBt/XxZBtCP3SjbQaQV0jXl0wUunnuQV+Tav5kL71Bkz4hcCFGRPIIBsNAAAAN
	 P9zs048qa1Mg83YtIgXR9odTHlLhs6p02flIpiTIRkQdZCL3+tOzQqkkDTI34AlpXZ
	 gwj7c3LauJTxkhK0uaxhrDDqPFNrPT+XjxpKm/a/R/3PIVSX+/OXHaDyJuxtlDNckI
	 Zu+f8gLBnxvo1ONE8vsDhNDYeSbcQZfgqXZ4yLzM4l2GnAmsE1jZZVNAar2DCThAVf
	 zarhrfHExOnzw==
Date: Mon, 24 Feb 2025 08:37:32 -0700
From: Keith Busch <kbusch@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
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
Message-ID: <Z7ySPC32oKBccunx@kbusch-mbp>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp>
 <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
 <Z7xbrnP8kTQKYO6T@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7xbrnP8kTQKYO6T@pc636>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_073738_508499_CBEDBBCD 
X-CRM114-Status: GOOD (  27.76  )
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

On Mon, Feb 24, 2025 at 12:44:46PM +0100, Uladzislau Rezki wrote:
> On Fri, Feb 21, 2025 at 06:28:49PM +0100, Vlastimil Babka wrote:
> > > 
> > > The warning indicates that this shouldn't be called from a
> > > WQ_MEM_RECLAIM workqueue. This workqueue is responsible for bringing up
> > > and tearing down block devices, so this is a memory reclaim use AIUI.
> > > I'm a bit confused why we can't tear down a disk from within a memory
> > > reclaim workqueue. Is the recommended solution to simply remove the WQ
> > > flag when creating the workqueue?
> > 
> > I think it's reasonable to expect a memory reclaim related action would
> > destroy a kmem cache. Mateusz's suggestion would work around the issue, but
> > then we could get another surprising warning elsewhere. Also making the
> > kmem_cache destroys async can be tricky when a recreation happens
> > immediately under the same name (implications with sysfs/debugfs etc). We
> > managed to make the destroying synchronous as part of this series and it
> > would be great to keep it that way.
> > 
> > >   ------------[ cut here ]------------
> > >   workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_scan_work is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
> > 
> > Maybe instead kfree_rcu_work should be using a WQ_MEM_RECLAIM workqueue? It
> > is after all freeing memory. Ulad, what do you think?
> > 
> We reclaim memory, therefore WQ_MEM_RECLAIM seems what we need.
> AFAIR, there is an extra rescue worker, which can really help
> under a low memory condition in a way that we do a progress.
> 
> Do we have a reproducer of mentioned splat?

We're observing this happen in production, and I'm trying to get more
details on what is going on there. The stack trace says that the nvme
controller deleted a namespace, and it happens to also be the last disk
that drops the slab's final ref, which deletes the kmem_cache. I think
this must be part of some automated reimaging process, as the disk is
immediately recreated followed by a kexec.

Trying to manually recreate this hasn't been successful so far because
it's never the last disk on my test machines, so I'm always seeing a
non-zero ref when deleting namespaces from this nvme workqueue.

