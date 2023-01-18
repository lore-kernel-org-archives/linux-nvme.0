Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A59BC38147
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jan 2023 16:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BNBksYynfe1wWPltNlb/eLymmdmPnjnnHQxh9heH/tk=; b=p7PIpTXn6cgesdQd5W5Qb+gsLG
	ZoKRfZJ02LoFMaKiWo6K/9hdXu5h2i65IISaewVpzTjQoaBZ2ZQ2w2SBgzTKJMehEXt9NnsLrKBPQ
	Z3gS+IrZZl5TN97WB/dTVeLUlumucvkFmHUvt/SXyXoGxlnmLqxVyQOwovIF+AQ0UeYfNtuCFeY8s
	iGjNediqAr1XFDhx5883gwUCwAAOk5DN8MkYZxotI/uQsCezENSadrxFVhO8CtRLftMvuFovCB9nc
	MOz7LPXIgz7dCAcLvUE219/QoICtCY9E2PfmPEw3i592BO5LYHTh1LezyJ3smjWco0R42z9TsSCxf
	+Jm3QZDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIBPs-001rIr-Ib; Wed, 18 Jan 2023 16:36:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIBPo-001rFY-76
	for linux-nvme@lists.infradead.org; Wed, 18 Jan 2023 16:35:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3131767373; Wed, 18 Jan 2023 17:35:45 +0100 (CET)
Date: Wed, 18 Jan 2023 17:35:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, sagi@grimberg.me,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHv2] nvme-pci: fix timeout request state check
Message-ID: <20230118163545.GA7411@lst.de>
References: <20230118052244.741505-1-kbusch@meta.com> <20230118053306.GA24817@lst.de> <Y8eJJ/9qo9c7jzLT@kbusch-mbp> <20230118073330.GA27048@lst.de> <Y8gOlnKNsOTPq1Yj@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8gOlnKNsOTPq1Yj@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230118_083556_421975_9BD7F793 
X-CRM114-Status: GOOD (  18.09  )
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

On Wed, Jan 18, 2023 at 08:21:58AM -0700, Keith Busch wrote:
> > The point is still that "started" is the wrong check here and relies
> > on an implementation detail.  I think we're better off with an explicit
> > IDLE check and a big fat comment.
> 
> So you want the check to look like this instead?
> 
> ---
> @@ -1362,7 +1362,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
>         else
>                 nvme_poll_irqdisable(nvmeq);
> 
> -       if (blk_mq_request_completed(req)) {
> +       if (blk_mq_request_completed(req) ||
> +           blk_mq_rq_state(req) == MQ_RQ_IDLE) {
>                 dev_warn(dev->ctrl.device,
>                          "I/O %d QID %d timeout, completion polled\n",
>                          req->tag, nvmeq->qid);
> --

Or maybe just:

	if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT) {
		..

> Alternatively, I also considered moving the IDLE state setting to when
> the request is actually freed, which might make more sense and works
> without changing the nvme driver:

I like that idea, but this touches gnarly code, so it'll need good
testing.

