Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5C6C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 00:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qEzhlHNCSX3Ishxo5xNbRLk/2ycbHphVlkb2MkNB6ew=; b=ovkIjk6W9iULFwP/eQraS3VD7/
	emxGxTZc+cnoaYb+7PcR0O/r8jBTSuO+jRlpNL7vn785aGhxWfLtfPyf87L/sOV/b3PPTa1oPi8Xl
	Cd4gekPLoMmtjb1ZHZpsCHrSyb/NIVBRHBwjP4vdox0PJeLRtETAhLlvABk7K8oGPxJLT5TEsKbF5
	GRyQ65qufPsY04Am6gec46JBC2+NTgjBJBTPGSu4bB9kRb6134mvyHU0ZwnglOTK9sA8s9w+7eXrH
	dHmH78J/8Stueena7POUhukwwlpVQNjimuDVQVb02hESoyeeNHtfVr3bf7Z5aMZvE0mdAkEwYN8ud
	1N5pYAHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxH6f-001WCf-B2; Tue, 22 Nov 2022 00:25:45 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxH6b-001WCA-Nh
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 00:25:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 83C9EB818B9;
	Tue, 22 Nov 2022 00:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C649C433D6;
	Tue, 22 Nov 2022 00:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669076738;
	bh=gsLMzCoeoc9ux+uR73cth2X5CC/dIj7UE5fWsCukjjc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=AnRhbtK+MYQ+wbycKsrOkZRqt2qh4xWTTmBRXt4jCTZseeuFCabTu2VM4x/VLxHJx
	 XQlJuiUaJKa3NFKpXHmAHSanuIe9F7hL6+cmme6W0+4Dpgr5QWrw3ysL+DjDgnghg7
	 2wHvP28dFdWPPjihm8Lzi3J9D+WmE8yC4WMB+wuXrTCcU7Zl6l9Pc2g2VKkGQDV/fP
	 BgpVeOjAqhjwex2OSyrM4OpTs/SgvmzkZyEofVXUpo1xCS3J/MxyeWo5itDP7/9g2y
	 c8Xdxe6XWPJhIvL2fiDheHjYAHfrxucEWV68pDP1zuTm2cOd/MkPuqAhcuAhd8zT3w
	 bHOPGbmI8jBIA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C76AE5C116C; Mon, 21 Nov 2022 16:25:37 -0800 (PST)
Date: Mon, 21 Nov 2022 16:25:37 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Caleb Sander <csander@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	linux-nvme@lists.infradead.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH] nvme: fix SRCU protection of nvme_ns_head list
Message-ID: <20221122002537.GQ4001@paulmck-ThinkPad-P17-Gen-1>
References: <dfcd682c-126d-34ab-3858-a7a7fc0afcb3@grimberg.me>
 <20221121074039.GA24507@lst.de>
 <CADUfDZraHB6=i77i9Mivdf5cbUHpKxHofSZFnGhsywb=k-+y_w@mail.gmail.com>
 <20221121175932.GM4001@paulmck-ThinkPad-P17-Gen-1>
 <CADUfDZrVT2tCnUkorJ94Mzd20n-Ch-8cZaSeT0LbowH3dwQ=yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUfDZrVT2tCnUkorJ94Mzd20n-Ch-8cZaSeT0LbowH3dwQ=yw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_162542_096902_6D815E47 
X-CRM114-Status: GOOD (  38.31  )
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

On Mon, Nov 21, 2022 at 11:58:53AM -0800, Caleb Sander wrote:
> On Mon, Nov 21, 2022 at 9:59 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Nov 21, 2022 at 09:48:31AM -0800, Caleb Sander wrote:
> > > On Sun, Nov 20, 2022 at 11:40 PM Christoph Hellwig <hch@lst.de> wrote:
> > > >
> > > > On Sun, Nov 20, 2022 at 01:24:51PM +0200, Sagi Grimberg wrote:
> > > > >>      sector_t capacity = get_capacity(head->disk);
> > > > >>      int node;
> > > > >> +    int srcu_idx;
> > > > >>   +  srcu_idx = srcu_read_lock(&head->srcu);
> > > > >>      list_for_each_entry_rcu(ns, &head->list, siblings) {
> > > > >>              if (capacity != get_capacity(ns->disk))
> > > > >>                      clear_bit(NVME_NS_READY, &ns->flags);
> > > > >>      }
> > > > >> +    srcu_read_unlock(&head->srcu, srcu_idx);
> > > > >
> > > > > I don't think you need srcu here, rcu_read_lock/unlock is sufficient.
> > > >
> > > > So the code obviously does not sleep.  But I wonder if anything speaks
> > > > against mixing SRCU and RCU protection for the same list?
> > >
> > > As I understand, synchronize_rcu() only synchronizes with RCU critical sections,
> > > and likewise synchronize_srcu() only synchronizes with SRCU critical sections.
> > > Currently nvme_ns_head_submit_bio() is using srcu_read_lock()
> > > but nvme_ns_remove() is using synchronize_rcu(),
> > > so there is no synchronization at all.
> > > Since nvme_ns_head_submit_bio() sleeps during the critical section,
> > > we definitely need to keep using SRCU there,
> > > and therefore nvme_ns_remove() needs to use synchronize_srcu().
> > > I agree RCU would work in nvme_mpath_revalidate_paths(), but as Paul points out,
> > > nvme_ns_remove() would then need to synchronize with both SRCU and RCU.
> > > This seems like it would complicate nvme_ns_remove()
> > > and require waiting on readers of unrelated RCU-protected structures.
> > > Is there some cost to using SRCU over RCU that I am missing?
> >
> > The cost is that srcu_read_lock() and srcu_read_unlock() both invoke
> > smp_mb().  This might or might not be a problem for you, depending on
> > how fast your fastpaths need to be.  Another cost is the need to pass
> > the return value of srcu_read_lock() to srcu_read_unlock(), which is
> > usually more of a software-engineering cost than it is a performance cost.
> 
> Thanks, that's great to know! I think this is probably not performance-critical,
> since it's called only for changes in the connected NVMe namespaces.
> 
> > Of course, the easiest thing is to try it both ways and see if you can
> > measure the difference.  If you are unsure whether or not it is safe
> > to replace rcu_read_lock() with srcu_read_lock(), you can just add
> > smp_mb() after each rcu_read_lock() and before each rcu_read_unlock().
> > That won't be exactly, but it will get you quite close to the cost of
> > srcu_read_lock() and srcu_read_unlock().
> 
> Regarding your suggestion to use synchronize_rcu_mult() to wait concurrently,
> I'm not sure it's possible to write an equivalent to call_my_srrcu() here,
> since the srcu_struct is per-nvme_ns_head rather than global.
> I think we would probably need to synchronize with RCU and SRCU sequentially.

That might be a reason to use a global srcu_struct.  Though there might
be good reasons not to, for all I know.

							Thanx, Paul

