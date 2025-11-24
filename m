Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B9ACFA466
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 07:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jAseGI9mn5UNKgSzjgnBfcGubO6/frO9jzYSGsm8PCc=; b=OupRBMl4S0nS3Qg3CdsKa/t77K
	iRBcxQkECrtGNtHTa/f6lZ1A0La0+ieKE2DPrh00iTUMXOf8guhJQuKwMA0G0zjyq9DSVO5cCg4bD
	TAvaQK21efIWzMbIm2bpdLxPHtuMkdQUmqXHhSuUrtPfFB+8//hqn2Fi7iXgIuHxDIC0qMGrZ4WHH
	RIPen/anBtNVbQuoJTYinhD4SeYMw5OOjAdhZNls8ubf6r9DmzG3rKxaj4rvtwKDtDjjIC60dJMiV
	ha1OipOlFFW4q12dLe0dGdG9OUlg4tRL542wKlxnRvLeJiBsStDGMSlb0uOLKGHHVPIKSW+hzKoF2
	cdcSwBrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNQaE-0000000BC4I-0k46;
	Mon, 24 Nov 2025 07:01:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNQaC-0000000BC3h-00EU
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 07:01:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A767668D0A; Mon, 24 Nov 2025 08:01:45 +0100 (CET)
Date: Mon, 24 Nov 2025 08:01:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH BUG FIX 2/2] nvme-multipath: clear BIO_QOS flags on
 requeue
Message-ID: <20251124070142.GA17632@lst.de>
References: <20251123191858.69957-1-ckulkarnilinux@gmail.com> <20251123191858.69957-3-ckulkarnilinux@gmail.com> <20251124062552.GC16614@lst.de> <a3159403-7344-4627-a413-f289a313c12a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3159403-7344-4627-a413-f289a313c12a@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_230156_185301_5E301859 
X-CRM114-Status: GOOD (  26.54  )
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

On Mon, Nov 24, 2025 at 06:45:58AM +0000, Chaitanya Kulkarni wrote:
> >> Fix this by clearing both BIO_QOS_THROTTLED and BIO_QOS_MERGED flags
> >> when bios are redirected to the multipath head in nvme_failover_req().
> >> This is consistent with the existing code that clears REQ_POLLED and
> >> REQ_NOWAIT flags when the bio changes queues.
> >>
> >> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> >> ---
> >>   drivers/nvme/host/multipath.c | 10 ++++++++++
> >>   1 file changed, 10 insertions(+)
> >>
> >> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> >> index 3da980dc60d9..2535dba8ce1e 100644
> >> --- a/drivers/nvme/host/multipath.c
> >> +++ b/drivers/nvme/host/multipath.c
> >> @@ -168,6 +168,16 @@ void nvme_failover_req(struct request *req)
> >>   		 * the flag to avoid spurious EAGAIN I/O failures.
> >>   		 */
> >>   		bio->bi_opf &= ~REQ_NOWAIT;
> >> +		/*
> >> +		 * BIO_QOS_THROTTLED and BIO_QOS_MERGED were set when the bio
> >> +		 * went through the path's request queue rq_qos infrastructure.
> >> +		 * The bio is now being redirected to the multipath head's
> >> +		 * queue which may not have rq_qos enabled, so these flags are
> >> +		 * no longer valid and must be cleared to prevent
> >> +		 * rq_qos_done_bio() from dereferencing a NULL q->rq_qos.
> >> +		 */
> >> +		bio_clear_flag(bio, BIO_QOS_THROTTLED);
> >> +		bio_clear_flag(bio, BIO_QOS_MERGED);
> > This really should go into blk_steal_bios instead.  As should be the
> > existing nowait/polled fixups..
> >
> >
> even better, should I send a prep patch to move existing nowait/polled
> and second patch for QOS THROTTLED and MERGED that fixes the bug ?

Yes, we can probably move all of them including your new clear
in a separate patch (and wait until the next merge window).

