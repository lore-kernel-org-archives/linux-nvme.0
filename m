Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B27EEE6457
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 07:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dumIc5tL57L7nL7QbyVcu7UK81Hrr11fTIeTJKvc0xk=; b=QOw2AD3pyVspA9BRkiIRvJwrAY
	IDjqhQTZwk74JIulccC6gJ8SpZdxJBTHamiJmb5qQkXAuQmBt6cGwe/QKfAdw2ohO2ymvirsDQuBr
	DAQpkGM7m0U8w11+HhWca2I8O7tzkWZ1//SflrUpHJB0Kj08gSIygmPc+3QhbKd82s03nNV0NEPA3
	hppy+VdjJIjHesfzN+qyi3zC2IxahX0OgBNWDZCnxNmcKG5PeKT64tBtr5xFwC5DktNp5g7JBGMar
	b1F9Pw3Eye+D488tYrUbRvBVcCkmaPk1DwvEKRblRdABqBZH0y+gqfsj3Q/lbv0cyM/GBEx1dftOm
	c/pW3skg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soeT0-0000000CDgY-0ORX;
	Thu, 12 Sep 2024 07:42:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soeSw-0000000CDeJ-3hJq
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 07:42:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 45A16227AAF; Thu, 12 Sep 2024 09:42:06 +0200 (CEST)
Date: Thu, 12 Sep 2024 09:42:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 04/10] blk-integrity: consider entire bio list for
 merging
Message-ID: <20240912074205.GA8202@lst.de>
References: <20240911201240.3982856-1-kbusch@meta.com> <20240911201240.3982856-5-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911201240.3982856-5-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_004211_094492_3B28D64A 
X-CRM114-Status: GOOD (  17.40  )
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

On Wed, Sep 11, 2024 at 01:12:34PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> If a bio is merged to a request, the entire bio list is merged, so don't
> temporarily detach it from its list when counting segments. In most
> cases, bi_next will already be NULL, so detaching is usually a no-op.
> But if the bio does have a list, the current code is miscounting the
> segments for the resulting merge.

As far as I can tell we can never get here with bi_next set.  Rationale:

blk_integrity_merge_bio has two callers: ll_new_hw_segment and
blk_rq_merge_ok.

ll_new_hw_segment is called from ll_back_merge_fn and ll_front_merge_fn.

ll_back_merge_fn is called from blk_rq_append_bio and
bio_attempt_back_merge.

blk_rq_append_bio is always used for a single bio and in fact used
to build bio chains.

bio_attempt_back_merge is called from blk_attempt_bio_merge,
blk_mq_sched_try_merge and blk_zone_write_plug_init_request.

blk_attempt_bio_merge is called from blk_attempt_plug_merge and
blk_bio_list_merge.

blk_attempt_plug_merge is called from blk_mq_attempt_bio_merge,
which always operates on a single bio.

blk_bio_list_merge is called from blk_mq_sched_bio_merge,
kyber_bio_merge where the latter is just an indirect call from
the former, and blk_mq_sched_bio_merge is called from
blk_mq_attempt_bio_merge which was considered above.

blk_mq_sched_try_merge is called from bfq_bio_merge and dd_bio_merge,
both of which are implementation of the ->bio_merge elevator_mq_ops
method called from blk_mq_sched_bio_merge, which was considered above.

blk_zone_write_plug_init_request is called from blk_mq_submit_bio
and always operates on a single bio.

ll_front_merge_fn is called from bio_attempt_front_merge.

bio_attempt_front_merge is called from blk_attempt_bio_merge and
blk_mq_sched_try_merge, both of which were considered above.

blk_rq_merge_ok is called from blk_attempt_bio_merge,
blk_zone_write_plug_init_request and elv_bio_merge_ok.

blk_attempt_bio_merge and blk_zone_write_plug_init_request were
already considered above.

elv_bio_merge_ok is called from bfq_request_merge and dd_request_merge
and elv_merge.  The first two are implementations of the ->request_merge
elevator_mq_ops method called from elv_merge, which is called from
blk_mq_sched_try_merge, which was considered above.

Also it feels like the call in blk_rq_merge_ok is superflous from this.


