Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3308DC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 17:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oDKWHOt0h8RESMzECS3QhUYXD1YhLjc1p6okMVqFby8=; b=y9s3JEnqeqc6L8VzvMrIPeAmJb
	hYZCoaM57HkpG4RzlSRBm3sbx7HI48OC2q+90booNMhZ6cJWEakc1aP+ucEyKSYyrdxX6URaZSO6L
	el+bQ8i0D721BDLUWu8SJSICsF7NSJgAnkn5oY85MUFhzR05OQOVBa+ED8lx4PvHQkb5fpInWFSZ8
	n1aVepB7QnfRi2G/iamRXI8h2WnaoIWUgsN6S/AsDCktSZRX6RlUTTmsxsOhkHu+3vKwBrkNF2z5Y
	0pEcQK7V/cbvB/OkADRANizpwJOTmKVA6HdzKY0VLAfOlYj5zAiNS1zTbOvIK+S+bY/HKseLcb5Mb
	VJlcypKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxB4y-00Ga27-Jk; Mon, 21 Nov 2022 17:59:36 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxB4w-00Ga0C-E5
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 17:59:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 139206138B;
	Mon, 21 Nov 2022 17:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F123C433C1;
	Mon, 21 Nov 2022 17:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669053572;
	bh=5xqAHswpdWh2fNAZmL5xasNZdDF2In5BryUI5qvvUMw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=eYUuXliKTGI+9Az48G2adTTzqkI2gwOa08e1kONnMt/x8xWCE7u1MxGq0kNbda88Y
	 WS2ICCmypn1Ijm4xxqheatIkCnlb3oQ6EmI44sVpTkTsqt+lfEKHrXsxJ4akJnHlwr
	 r6R2a4y+PSkcNgsXHc4fodnbhWkhl0Wfsj61mUM4I0a5qyBBxOfw50mdVjZyJBE4tF
	 EDQ8EUZzC/cINZlyQ/emXTU/Po3opk+FDlmUvDn3d5rvsH3asCQK0xtYBR1jtpzzZb
	 6bquosibnu8WczKutFCePVd15gmT1c1LUwVpqp5Ce0Eybewzra3E8aB9T6RdpZPfhV
	 F3N+NNUUwGEvQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0F8965C09CB; Mon, 21 Nov 2022 09:59:32 -0800 (PST)
Date: Mon, 21 Nov 2022 09:59:32 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Caleb Sander <csander@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	linux-nvme@lists.infradead.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH] nvme: fix SRCU protection of nvme_ns_head list
Message-ID: <20221121175932.GM4001@paulmck-ThinkPad-P17-Gen-1>
References: <dfcd682c-126d-34ab-3858-a7a7fc0afcb3@grimberg.me>
 <20221121074039.GA24507@lst.de>
 <CADUfDZraHB6=i77i9Mivdf5cbUHpKxHofSZFnGhsywb=k-+y_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUfDZraHB6=i77i9Mivdf5cbUHpKxHofSZFnGhsywb=k-+y_w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_095934_574846_CD0CEB88 
X-CRM114-Status: GOOD (  26.19  )
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
Reply-To: paulmck@kernel.org
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 21, 2022 at 09:48:31AM -0800, Caleb Sander wrote:
> On Sun, Nov 20, 2022 at 11:40 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Sun, Nov 20, 2022 at 01:24:51PM +0200, Sagi Grimberg wrote:
> > >>      sector_t capacity = get_capacity(head->disk);
> > >>      int node;
> > >> +    int srcu_idx;
> > >>   +  srcu_idx = srcu_read_lock(&head->srcu);
> > >>      list_for_each_entry_rcu(ns, &head->list, siblings) {
> > >>              if (capacity != get_capacity(ns->disk))
> > >>                      clear_bit(NVME_NS_READY, &ns->flags);
> > >>      }
> > >> +    srcu_read_unlock(&head->srcu, srcu_idx);
> > >
> > > I don't think you need srcu here, rcu_read_lock/unlock is sufficient.
> >
> > So the code obviously does not sleep.  But I wonder if anything speaks
> > against mixing SRCU and RCU protection for the same list?
> 
> As I understand, synchronize_rcu() only synchronizes with RCU critical sections,
> and likewise synchronize_srcu() only synchronizes with SRCU critical sections.
> Currently nvme_ns_head_submit_bio() is using srcu_read_lock()
> but nvme_ns_remove() is using synchronize_rcu(),
> so there is no synchronization at all.
> Since nvme_ns_head_submit_bio() sleeps during the critical section,
> we definitely need to keep using SRCU there,
> and therefore nvme_ns_remove() needs to use synchronize_srcu().
> I agree RCU would work in nvme_mpath_revalidate_paths(), but as Paul points out,
> nvme_ns_remove() would then need to synchronize with both SRCU and RCU.
> This seems like it would complicate nvme_ns_remove()
> and require waiting on readers of unrelated RCU-protected structures.
> Is there some cost to using SRCU over RCU that I am missing?

The cost is that srcu_read_lock() and srcu_read_unlock() both invoke
smp_mb().  This might or might not be a problem for you, depending on
how fast your fastpaths need to be.  Another cost is the need to pass
the return value of srcu_read_lock() to srcu_read_unlock(), which is
usually more of a software-engineering cost than it is a performance cost.

Of course, the easiest thing is to try it both ways and see if you can
measure the difference.  If you are unsure whether or not it is safe
to replace rcu_read_lock() with srcu_read_lock(), you can just add
smp_mb() after each rcu_read_lock() and before each rcu_read_unlock().
That won't be exactly, but it will get you quite close to the cost of
srcu_read_lock() and srcu_read_unlock().

							Thanx, Paul

