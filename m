Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD59EC5AC67
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 20:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q2cmqbvAu79K9Kh5ZQbzK7San2QVikfsoxkJansBbyA=; b=OvsXav/oJn1Xe5hsrKGl3yLbzM
	sVumOZUWoeEen5jJxDUDZo1uC6XO8VMLQUiTLjGbf8+q5o3Is7r8u6uWlCHMH405+jYfVlD1PWgwJ
	xXGnN3XYuBzvWXpLJsLkm+v4D86HIugg/5cIhGsp01I9HL4PX+UdWSKrToFiouh4CVMIoJczDaCws
	GGNKRxHO54H82vJUfMUK+RFbZPN7LEK9omk4E8Wxy8B14x+Aq//n25GHD9+uVvl3VcbSkmJOTuyKt
	DX0i4w8v8vd52Hol2EAhRWW6Iul4/ImqRs0dJrhr5MvThJciUq7BGTDNCMXv70otP3WBTm0kvm2nj
	UYyiaaqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wttJL-0000000EwYk-0k5U;
	Tue, 11 Aug 2026 20:42:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wttJJ-0000000EwYd-1QDn
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 20:42:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CA934439BF;
	Tue, 11 Aug 2026 20:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567121F000E9;
	Tue, 11 Aug 2026 20:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786480976;
	bh=Q2cmqbvAu79K9Kh5ZQbzK7San2QVikfsoxkJansBbyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YFbw3h+9VF05FaKzac6jPhVAB835l5JVJCUXwTuCJl9eBG9OxW5fKgFOyQF10rSIs
	 Rgq6rp9K/wNatLZMxgnw+8SQTYxaj5qCHkPCVPj8jXdsouEZl9VaZRvXBw0dMIBa6x
	 La/Vnqz6TyhYtdIgig7ILqO+Anbl8J7EAPvQoslguHUfQToKMag/6mr36B/Z5d5EFQ
	 7Ei32ZvBOy+CXDbLKzIFn/cV4a89TQgxbRXxT4CmVrMwMNVTb22vZ5YVO7r7r+vSAM
	 fnC6ojfziByZLUBR3ARp7EA9Ev2hTaKW9tHtHKRzruJ4TgVas53yW+1Vy++v8vy+cX
	 1xJyovjvpNzyw==
Date: Tue, 11 Aug 2026 14:42:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chris S <coshi036@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Weidong Zhu <weizhu@fiu.edu>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] nvme: refuse an unsolicited format change on a
 namespace that is in use
Message-ID: <anuJTi4sZiCBuMzb@kbusch-mbp>
References: <20260811192111.2058140-1-coshi036@gmail.com>
 <ant4bioGLl4B35n_@kbusch-mbp>
 <CACd_6n1=oS_Jdq6s=u2jNmtP9n0Yc13BkKqJHSpsjbWHy=X5cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACd_6n1=oS_Jdq6s=u2jNmtP9n0Yc13BkKqJHSpsjbWHy=X5cA@mail.gmail.com>
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

On Tue, Aug 11, 2026 at 04:29:51PM -0400, Chris S wrote:
> On Tue, Aug 11, 2026 at 01:30:54PM -0600, Keith Busch wrote:
> > Refusing to acknowledge the new format doesn't mean you get to continue
> > using the old format. You're going to corrupt memory and data this way.
> 
> You're right - the teardown is the problem, not the refusal.
> 
> nvme_ns_remove() never sets GD_DEAD, so del_gendisk() takes the
> non-surprise path and asks the filesystem to write back.  Those bios
> go through nvme_setup_rw() with the stale lba_shift.  set_capacity(0)
> doesn't catch them on a partition, which keeps its own bd_nr_sectors.
> 
> So it should mark the disk dead first and drop the cache instead:
> 
>         blk_mark_disk_dead(ns->disk);
>         ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
> 
> Multipath needs more than that - the openers are on head->disk, and
> only the path gets removed.
> 
> Is that the direction, or is refuse-and-remove wrong here to begin
> with?

You need a nvme spec level change for this to work. There's nothing we
can do today to close every race where the driver attempts to use a
stale LBA shift when the format was changed externally.

What I proposed in the past was that the device has to return a new
error code for all new IO until the host queries the appropriate
Namespace identification to acknowledge the new LBA format. Kind of like
a SCSI "Check Condition Parameters Changed". An enlightend host could
trigger a queue freeze and namespace rescan after seeing this status,
clearing the device's latch and resume IO after setting up the new queue
limits.

