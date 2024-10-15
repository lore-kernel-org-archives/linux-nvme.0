Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC38CFC277
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 15:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EBdZXvbX8SX3h54zTZqIpjewi0BEiPjySKXOtQmGfXM=; b=3jbvGcgbQOKhj/J/1nJsD4rULc
	8fEh0T4sRs2Ja2LTTYtDhRsth1wFaenOUd7PkKTqt96yLruBRRElCfvN9P5suEKK+wTnr6b/ZyacK
	XOAY+rLpY6ry9BN0R6+yt7eJse5ivEvVVR5oiG0igO1WdZeL+zqDEYz8P7J3PFjdAH0kCj7eTOqyy
	PQ1dQDZ3rj+ssHO6QV6GwOgQooCcLO5SnLQct3TS+fCMl3ZIbGeWQIO6Ml2Hs5dWjplOvPDg53RJY
	R6+1Zyfv+7K/LsFc2cVvc6hlnftTDAlUvD8+DWLc1+dUF2ZAPX0Ip9zQG9C5UErXLtooso4NOVv82
	0Vf5peew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0jC2-00000008eTy-2hja;
	Tue, 15 Oct 2024 15:10:38 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0jAr-00000008eHe-2ytG
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 15:09:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id BFC09A42971;
	Tue, 15 Oct 2024 15:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE876C4CEC6;
	Tue, 15 Oct 2024 15:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729004964;
	bh=HrjQM8lcvtnIvBc0KLhp1g8XVVe9kH8v4PrPbcSFfpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3yRHmo00PbZ4Kkgix4TfSGcO+OO60xnq1qVIUelpWP11a8ggBa/65HbcXOBES0qv
	 ZP1arbfvD4UB70U1Qtao5PovoVng8ecBS8pBbyaCjJbUnEIJxwieDm2nYKEfyQbGLd
	 mqX6NlyaiiO3I/PfaRBapeaGHwNKZyBU7aKdRUBFYgF+3gsKQ1TGOoJa8hjHu5gjZE
	 VP4Gr+Ekk0rLz14GIbB2bre2RyPVvClC8ewDCmUIDLecbdTEhIvetGhyugIZes1r4N
	 MBMJC2VH7Qh69mguw3TTayT/byRUyvLhK+CVpgfTSD6wwzkAUvEcu84HlEE3JZfXSE
	 bw2w/CDIH0G6A==
Date: Tue, 15 Oct 2024 09:09:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hare@suse.de,
	sagi@grimberg.me, martin.petersen@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, bvanassche@acm.org,
	asml.silence@gmail.com, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <Zw6FoPCEJ0-rARGT@kbusch-mbp>
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com>
 <20241015055006.GA18759@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015055006.GA18759@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_080925_842172_A483E7FF 
X-CRM114-Status: GOOD (  26.73  )
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

On Tue, Oct 15, 2024 at 07:50:06AM +0200, Christoph Hellwig wrote:
> 1) While the current per-file temperature hints interface is not perfect
> it is okay and make sense to reuse until we need something more fancy.
> We make good use of it in f2fs and the upcoming zoned xfs code to help
> with data placement and have numbers to show that it helps.

So we're okay to proceed with patch 1?
 
> 2) A per-I/O interface to set these temperature hint conflicts badly
> with how placement works in file systems.  If we have an urgent need
> for it on the block device it needs to be opt-in by the file operations
> so it can be enabled on block device, but not on file systems by
> default.  This way you can implement it for block device, but not
> provide it on file systems by default.  If a given file system finds
> a way to implement it it can still opt into implementing it of course.

If we add a new fop_flag that only block fops enables, then it's okay?

> 3) Mapping from temperature hints to separate write streams needs to
> happen above the block layer, because file systems need to be in
> control of it to do intelligent placement.  That means if you want to
> map from temperature hints to stream separation it needs to be
> implemented at the file operation layer, not in the device driver.
> The mapping implemented in this series is probably only useful for
> block devices.  Maybe if dumb file systems want to adopt it, it could
> be split into library code for reuse, but as usual that's probably
> best done only when actually needed.

IMO, I don't even think the io_uring per-io hint needs to be limited to
the fcntl lifetime values. It could just be a u16 value opaque to the
block layer that just gets forwarded to the device.

> 4) To support this the block layer, that is bios and requests need
> to support a notion of stream separation.   Kanchan's previous series
> had most of the bits for that, it just needs to be iterated on.
> 
> All of this could have probably be easily done in the time spent on
> this discussion.

