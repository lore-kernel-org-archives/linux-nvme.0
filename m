Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C687FCAC5A7
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Sep 2025 14:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I7hvLz+TcIXg4OLPntMFsnyJSZTjfnjcDcYESpkJZ7M=; b=ikVfwruS3VD4wK43iRq6myqLiF
	z4u6BkFBLkzJHHGpBGU09pLav20euIMZ9671EyeArCkGxhAj/Edf4TS0nI7YyCbox/aujEY9ha4/O
	PNUuTlVMU66iwCchmFC9OxrIehu+EOFSy7Ouuxk9/NNeT/JgvBbgHL0uQmcC0GcrFc994sXq9Ca0U
	Pg3Xv1E3hejcH+qIPGtIje4VsivlVgxQeTFFverL5pz9js2Er2YdO/u3dOM4FYOl2iwAJUStpqcn0
	wai3PNcgkaR7owRiF8LLzXIqAlMIxZG3riFPrEYehyY1zmMza0J/VChgUd7E9fVCGFk8KLKuLZei4
	0Vxl/aeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1nCH-0000000AClS-252p;
	Thu, 25 Sep 2025 14:43:49 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1nCG-0000000ACkV-0vi2
	for linux-nvme@lists.infradead.org;
	Thu, 25 Sep 2025 14:43:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 50E29605FF;
	Thu, 25 Sep 2025 14:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D11C4CEF0;
	Thu, 25 Sep 2025 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758811427;
	bh=N5JrG4ArvWG565dEhJ88rgU/kFQ1aVlRQbuV/+x6VtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNO7y+ydl7+LI3KzCsV8aPacVEZhWIePBPCoKdY1N1Lt5BIlBlxum2fIIFJY0Bi0Z
	 20OuFhCEGojQ2pjWwU6icXsBe77CzHL2hSm+8KbpBNsZrf4wtjKlydNvENlcAo7ZSx
	 bc6WyN57Av0RA0Wpg4XsxIDmggfnh86sjP6tLkKQFz938Rw/qBKb32GeII/i0xXsIz
	 2+uXkMLXtQ2hHyXYbcBrV3YpmSjwU9YXPnDsyPwghWfcYy6ZXsrqN6Cmi4TaFd8wKy
	 Azfb1gu2SYi7cTkYquVFer8dEmglYjUatbNzOGDj9xg+5VCCVNIG8f1B2lf8OXfaMv
	 sma10paLnqtRA==
Date: Thu, 25 Sep 2025 08:43:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Amit Chaudhary <achaudhary@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, randyj@purestorage.com,
	jmeneghi@redhat.com, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme-multipath: Skip nr_active increments in RETRY
 disposition
Message-ID: <aNVVIP3WE7POT498@kbusch-mbp>
References: <20250924224319.4557-1-achaudhary@purestorage.com>
 <aNR4m9wrO5cgFZIe@kbusch-mbp>
 <20250925011427.GC3269-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925011427.GC3269-mkhalfella@purestorage.com>
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

On Wed, Sep 24, 2025 at 06:14:27PM -0700, Mohamed Khalfella wrote:
> On 2025-09-24 17:02:51 -0600, Keith Busch wrote:
> > On Wed, Sep 24, 2025 at 03:43:18PM -0700, Amit Chaudhary wrote:
> > >  static inline void nvme_start_request(struct request *rq)
> > >  {
> > > -	if (rq->cmd_flags & REQ_NVME_MPATH)
> > > +	if ((rq->cmd_flags & REQ_NVME_MPATH) && (!nvme_req(rq)->retries))
> > >  		nvme_mpath_start_request(rq);
> > >  	blk_mq_start_request(rq);
> > >  }
> > 
> > Using "retries" is bit indirect as a proxy for multipath active counts.
> > Could this be moved to the mpath start instead, directly using the flag
> > that accounts for the path? This also helps to keep track if the command
> > gets retried across a user toggling the policy to "qd".
> > 
> > ---
> > diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> > index 3da980dc60d91..1c630967ddd40 100644
> > --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -182,7 +182,8 @@ void nvme_mpath_start_request(struct request *rq)
> >         struct nvme_ns *ns = rq->q->queuedata;
> >         struct gendisk *disk = ns->head->disk;
> > 
> > -       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
> > +       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD &&
> > +           !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
> >                 atomic_inc(&ns->ctrl->nr_active);
> >                 nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
> >         }
> > --
> 
> 193         nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
> 194         nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
> 195                                                       jiffies);
> 
> Doing it this way might messup with stats accounting because the two
> lines above will be executed on request retry. I do not think we need
> that, right?

Yeah, but we can use the other flag to know if it's already been
accounted:

--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -182,12 +182,14 @@ void nvme_mpath_start_request(struct request *rq)
        struct nvme_ns *ns = rq->q->queuedata;
        struct gendisk *disk = ns->head->disk;

-       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
+       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD &&
+           !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
                atomic_inc(&ns->ctrl->nr_active);
                nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
        }

-       if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
+       if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq) ||
+           nvme_req(rq)->flags & NVME_MPATH_IO_STATS)
                return;

        nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;

