Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC5FC47082
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 16:30:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC0261C5D
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 16:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC0261C5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=90c36V/L2JB4w3j+kIsi+aqG4QZNBpJW7SKEGplzmao=; b=AiWdogNFZNC9M2
	kaN4KZDh5h4glzgIEADEYHX13JCXzwcnItSN5vyK2uTGVMoNnQFjRKYrZbdpX6tIWxseD09tn/mKF
	6Wu9eYqONrh2IWPxaGIN4Zb86XAmDq0vk8XBmxjRtVJ/ys/ESFAUC+ZVNQo7Jqd/WauZU2JCwAG1g
	6dFvFjsaZa7HFZE76FB0GPOBmL+sAfXO3sFazXY/i7cRcABCrLVbArJdx6VcDj165p99+wxmFtSfK
	gj+Ym1yr8Rfi40y/NGKzV8/hFghetVN9jU5BpVwvfJmWdwvx3iARPq7bbW6T5i5Lnnu50EpRHJRvT
	9rVk8b/+aWUF9wy8Xjgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqI9K-004Wgi-LN; Mon, 07 Jun 2021 16:30:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqHuJ-004Py5-Uc
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 16:15:23 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9ECD26192B;
 Mon,  7 Jun 2021 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623082519;
 bh=6XxCmyoN0H5/AYd8uNXZEGj/OJd/VcSdJDpCprpvhLw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sByRQALyYsNwTbtIqc52Vevi1FBI3NypcTfdnvhPhbotIvqIbb4UVM5hyA6pmd4+S
 YYATZz11gocdVbdlmGqxpO/QPRDm2VEgvMIA6JpBA5nCon2WysnWREckp9MSiKC+Kq
 9nDCGEkZK9rtNZ30yoavuyNFsEzxwNazkGUri2naG6KYHvUX0W6dFvD3GtXyiZHfBS
 HU1J9LeHMkBhT+yBkkoilKqVuYHmWExAzUuSMSDHcPIM4+riULZLA3c5tCvtqI7N+G
 8gUA7yNshmsKHsE1UDtB8yn4K5FqjrTsGEPRgj6K7uY+IzDV0vX3rIYIwJliw4M5Wr
 5LJRhyEBhoekw==
Date: Tue, 8 Jun 2021 01:15:12 +0900
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv3 2/4] nvme: use blk_execute_rq() for passthrough commands
Message-ID: <20210607161512.GB21631@redsun51.ssa.fujisawa.hgst.com>
References: <20210521202145.3674904-1-kbusch@kernel.org>
 <20210521202145.3674904-3-kbusch@kernel.org>
 <CA+1E3rJM3sGLsOuPbYVH6kaTR8S9ogfe+wryuyWpqnA-pgDsEw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+1E3rJM3sGLsOuPbYVH6kaTR8S9ogfe+wryuyWpqnA-pgDsEw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_091520_046259_3CF0F946 
X-CRM114-Status: GOOD (  16.41  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 26, 2021 at 02:17:23PM +0530, Kanchan Joshi wrote:
> On Sat, May 22, 2021 at 2:05 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > The generic blk_execute_rq() knows how to handle polled completions. Use
> > that instead of implementing an nvme specific handler.
> >
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> > No changes since v2
> >
> >  drivers/nvme/host/core.c    | 38 +++++--------------------------------
> >  drivers/nvme/host/fabrics.c | 13 ++++++-------
> >  drivers/nvme/host/fabrics.h |  2 +-
> >  drivers/nvme/host/fc.c      |  2 +-
> >  drivers/nvme/host/nvme.h    |  2 +-
> >  drivers/nvme/host/rdma.c    |  3 +--
> >  drivers/nvme/host/tcp.c     |  2 +-
> >  drivers/nvme/target/loop.c  |  2 +-
> >  8 files changed, 17 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 762125f2905f..1a73eed61eee 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1012,31 +1012,6 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
> >  }
> >  EXPORT_SYMBOL_GPL(nvme_setup_cmd);
> >
> > -static void nvme_end_sync_rq(struct request *rq, blk_status_t error)
> > -{
> > -       struct completion *waiting = rq->end_io_data;
> > -
> > -       rq->end_io_data = NULL;
> > -       complete(waiting);
> > -}
> > -
> > -static void nvme_execute_rq_polled(struct request_queue *q,
> > -               struct gendisk *bd_disk, struct request *rq, int at_head)
> > -{
> > -       DECLARE_COMPLETION_ONSTACK(wait);
> > -
> > -       WARN_ON_ONCE(!test_bit(QUEUE_FLAG_POLL, &q->queue_flags));
> > -
> > -       rq->cmd_flags |= REQ_HIPRI;
> 
> The new code doesn't retain this flag.
> Looks good otherwise.

The flag is only used to select an apporpriate hctx. We've explicitly
selected a polling hctx in this path already, so the flag is
unnecessary.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
