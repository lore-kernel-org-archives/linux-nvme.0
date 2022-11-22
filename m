Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A8EC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 12:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fA7/motYxmklbAzxUPTcbUR9cW+apa3o9/EDlHlN3T4=; b=fCqMuDum4eA4fXLaWUfW/WDW3Q
	mSU1qdMAAfLvsbFZaYFz8oTq888yJ4aVXdtkJOrSYjPbNgEAux1How8TPUkYAZ72+Kg/IoElzzZif
	qzq9bQb448ybg680TQL6jYN7kMQ16wAetLL/3Je63w/jUETia/3pWEok0I+8RBIt/N4SqWeVAOqQL
	hX95uXZZ2DcnIvtQEd37evKFe4bLy2FXIsCYGIQu4vXZSBliwbTx5g/idxojitwjVBS6CsD6d6ZPF
	q1oyYleE0gi7SZ2OGy3Uukyx8qYy+WYuB9D+EwDo9dQ+tCs+i+08YEKPP10Q51AQHtF7OTBubKM5p
	RS7XROJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxSAy-008uC8-V1; Tue, 22 Nov 2022 12:14:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxSAw-008u98-U7
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 12:14:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F375B68D06; Tue, 22 Nov 2022 13:14:49 +0100 (CET)
Date: Tue, 22 Nov 2022 13:14:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander <csander@purestorage.com>, paulmck@kernel.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH] nvme: fix SRCU protection of nvme_ns_head list
Message-ID: <20221122121449.GA3888@lst.de>
References: <dfcd682c-126d-34ab-3858-a7a7fc0afcb3@grimberg.me> <20221121074039.GA24507@lst.de> <CADUfDZraHB6=i77i9Mivdf5cbUHpKxHofSZFnGhsywb=k-+y_w@mail.gmail.com> <20221121175932.GM4001@paulmck-ThinkPad-P17-Gen-1> <CADUfDZrVT2tCnUkorJ94Mzd20n-Ch-8cZaSeT0LbowH3dwQ=yw@mail.gmail.com> <b42a8825-a263-22fc-9f86-5c3dada173f1@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b42a8825-a263-22fc-9f86-5c3dada173f1@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_041455_168312_F7B2D4D6 
X-CRM114-Status: GOOD (  24.52  )
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

On Tue, Nov 22, 2022 at 12:06:57PM +0200, Sagi Grimberg wrote:
> I don't think rcu_mult is necessary.

It would also be really cumbersome to use.

> Lets look at nvme_ns_remove.
>
> 1. clears NVME_NS_READY + synchronize_srcu()
>    -> guarantees that nshead->current_path is not re-selecting this ns

Yes.

> 2. nvme_mpath_clear_current_path + synchronize_srcu()
>    -> if this ns happens to be the current_path -> clear it and fence
>       concurrent bio submissions

Yes.

> 3. removes ns from head sibling list + synchronize rcu
>    -> this should fence non-sleeping traversals (like revalidate_paths)

Well, non-sleeping would only matter if those non-sleeping travesals
are under rcu_read_lock(), but they are not.  They are either part of
a longer srcu critical section because other code can sleep, or in
case of revalidate_paths unprotected at all (which this patch fixes).

> Maybe it is OK to have it also srcu locked and just accept that
> nshead sibling list is srcu protected. In that case, your patch
> needs to extend the srcu also the clearing of current_head pointer.

I don't see how nvme_mpath_clear_current_path needs (S)RCU protection.
It never dereferences the current_path, it just checks is for pointer
equality and if they match clears it to NULL.  (I wonder if it should
use cmpxchg though).

> But looking again at your bug report, you mention that there are
> concurrent scans, one removing the ns and another accessing it.
> That cannot happen due to the scan_lock held around this section afaict.
>
> I guess it can be that in general ns removal can compete with a scan
> if due to some controller behavior that failed an identify command
> transiently in a prior scan, and a subsequent scan finds it? worth
> pinning down exactly what happened in the race you got because maybe we
> have a different issue that may manifest in other issues.

So scanning itself should be single threaded as it only happens from
the workqueue.  But nvme_ns_remove can be called from
nvme_remove_namespaces in in 6.1 and earlier from the passthrough
handler.

