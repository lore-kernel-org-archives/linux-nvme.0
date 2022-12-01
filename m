Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4178C4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Dec 2022 23:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h62Eg5+xRWiyEDjM73Pf1iIAnpvrOthuqsfnAO6gArI=; b=CQyYyA4hYiKaU2JOAxU/wzZk1X
	srvbuN/RzY/dWL0NK9G3QKlY8o7pAz7v+gjL3eHo02RQ09XvMrGXnfexh0wc/ZbTacJe+xw0R5Srf
	KAOfcirtuJhq7gUvAM88oNhjPnvrHoRTPuZw5bE0cAOBkzs8M7mCbVTsA4HxOulOpOllOE3gdaWGG
	OzaYMyRmWyHMSS5Sl2714tvq4u0PrAKvWhOcVW9jaklOWGuQWn3w8g02tbAD9lmEBOcLJv7ERQmqR
	UfIVRKfOfcL+yXEYXjqAzALh4tPwEa4HfYSRgRCcowiz+r6tetFGOrIidR0H2UKLcOBiVxY1GM4CL
	jzTrT3hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0tH3-00BpvC-Nu; Thu, 01 Dec 2022 23:47:25 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0soi-00BbuU-5t
	for linux-nvme@lists.infradead.org; Thu, 01 Dec 2022 23:18:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 15287B82058;
	Thu,  1 Dec 2022 23:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DE2C433D6;
	Thu,  1 Dec 2022 23:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669936684;
	bh=HPjuDcoGOmgh64WlVskn+MlvQS1nmvP9AirKsLWBS48=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=tANRy90HpljUPJ6u4h1U7xDSziOp3zQCcu05tMafVvixF34GFWd2Dpe6QvuST37RQ
	 TE2e/ag5O18bt39kQpYEtOg4PHd+wbolFWaRAzdeYKrpyZ0TgBtARq8KSczlF611KC
	 tWuU5dHbtUH2v33N2B9bVTxhNejPbCVhRqz9o5/O+EOFCb7+DxVBNgJfizlxGFhwOV
	 TLwhhwEm4JqN+T5d4zB9bvPQS3KQuF5l9T3qa+opWourDQDR3n10KaY//N9V8o3wfE
	 1hdF2Yfyu4JgoH0G+2Od40O9cvWrOgs2Ui/Tf7yhpc0oNNEDwRukHm96vCWTSXgf1O
	 yGFwyW+cnet8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5206B5C05F8; Thu,  1 Dec 2022 15:18:04 -0800 (PST)
Date: Thu, 1 Dec 2022 15:18:04 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Caleb Sander <csander@purestorage.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	linux-nvme@lists.infradead.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH] nvme: fix SRCU protection of nvme_ns_head list
Message-ID: <20221201231804.GL4001@paulmck-ThinkPad-P17-Gen-1>
References: <dfcd682c-126d-34ab-3858-a7a7fc0afcb3@grimberg.me>
 <20221121074039.GA24507@lst.de>
 <CADUfDZraHB6=i77i9Mivdf5cbUHpKxHofSZFnGhsywb=k-+y_w@mail.gmail.com>
 <20221121175932.GM4001@paulmck-ThinkPad-P17-Gen-1>
 <CADUfDZrVT2tCnUkorJ94Mzd20n-Ch-8cZaSeT0LbowH3dwQ=yw@mail.gmail.com>
 <b42a8825-a263-22fc-9f86-5c3dada173f1@grimberg.me>
 <20221122121449.GA3888@lst.de>
 <6a72cb78-8f23-a612-adab-10f4fe2a2174@grimberg.me>
 <CADUfDZpkw3iyiAqJ4X=rypJvLbO7dD2r9yegkYWyXOko-qcpNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUfDZpkw3iyiAqJ4X=rypJvLbO7dD2r9yegkYWyXOko-qcpNA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_151808_544632_12CBB3A6 
X-CRM114-Status: GOOD (  27.30  )
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

On Thu, Dec 01, 2022 at 01:27:16PM -0800, Caleb Sander wrote:
> On Tue, Nov 22, 2022 at 7:08 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> > ...
> > The original patch report did not include any sequence that removes all
> > namespaces, and given that it came from RockyLinux 8.6 kernel, it is not
> > 6.1... Hence I think that we need to understand how a namespace removal
> > happened at the same time that the namespace is being scanned. Maybe
> > something else is broken.
> 
> After some more debugging, I found the main cause:
> ns->disk isn't set until after ns is linked into the ns_head list.
> The ns is linked in nvme_init_ns_head(),
> which nvme_alloc_ns() calls before creating the disk:
> static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
> struct nvme_ns_ids *ids)
> {
> // ...
> if (nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED))
> goto out_free_queue;
> 
> disk = alloc_disk_node(0, node);
> if (!disk)
> goto out_unlink_ns;
> // ...
> ns->disk = disk;
> // ...
> }
> 
> It looks like this has never been a problem upstream:
> 5f432cceb3e9 ("nvme: use blk_mq_alloc_disk") fixed the order before
> e7d65803e2bb ("nvme-multipath: revalidate paths during rescan") was committed.
> Strange that the Red Hat 8.6 kernel has pulled in only the later commit.

Sadly, not strange at all.  Keeping upstream sane is hard enough, and
also keeping N -stable releases sane is not any easier.  ;-)

> The list traversal here still needs to be protected by (S)RCU,
> so I would still push for this patch.
> Sagi had suggested using RCU here instead, but discussing with Chris,
> it sounds like we reached a consensus to consistently protect this list
> with SRCU. We can evaluate switching to RCU later if needed,
> but since this is not in the I/O path, I don't see a big performance concern.

For whatever it is worth, makes sense to me!

							Thanx, Paul

