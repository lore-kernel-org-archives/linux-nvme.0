Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF6AC28D13
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Aug 2022 13:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vhe/KZ6MMAyEnAG1lY1lyHQnHZJ3vc5x4OnQdXMqjv0=; b=4isYnrmkgatrX39a6VS5tsBo9C
	ETVQXkPVl4gs32804X6U5Zy1eRb+IB8I+7jc3hRzmH2Yopz9y0nRuunJM5uH28/JY8UyxLrQgtMK5
	Iu2Q2B0YxZEZBxaCyxBQtcqf141UdF+jpZul02mC42rNp/c6C/FDbfigHFdzwG7B7C+wGCkPyAj0k
	/BWMMLsZQD3EH4CYRmIKliPI9S7CF8d+vuE//QpGCgqB9KHXxGNvpUhEhVZhV4XGKMiDO7yCGOEQg
	3lkiYFNC924NGWlwRHtB5MtidYyDL+qMtaspbbEe8f812YFNbE5NZ2zJ4QEOzZN7TE2MDysrZIa/o
	3y4DPz1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRD8I-00ExX5-Na; Thu, 25 Aug 2022 13:42:54 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRD8D-00ExSs-QW
	for linux-nvme@lists.infradead.org; Thu, 25 Aug 2022 13:42:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 3E961B8290E;
	Thu, 25 Aug 2022 13:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829AFC433C1;
	Thu, 25 Aug 2022 13:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661434967;
	bh=tEC6vU+mTx/Hiwl43/SNcKekimKee9HA0mCgdHaywnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hnyVaFCoCJ/olMkXM0e2HLQ7YfzkuuuegYAQKmUh4xdaPM0/kP305+TnzH754Rwws
	 7lpMA3a2uDYJRwg8hU2zeQfu8+9ZdElK9zZ0fmIbz21crVFzQYC5vEXNkD4G4ovbqs
	 gAhPGgpEVMjJWy3nP+M1SBc0OgjP9zlJ12un9tHFU+x0nyKi9pfDEtGvo8M5f2h3Jd
	 VOzw7y6rxb0w+DFKCI0IyhctMdMbfd0J8bazuW34WtoE0Xpj4g4WOrTYJPeMYi4vgb
	 XlsdKCUUK1h+ugLowThz+iA7UnTW4fYC4yNJ8OZ9tuz3BGXUuVGcZsPsB54qcoVjIc
	 8k6ioQakjoXBQ==
Date: Thu, 25 Aug 2022 07:42:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme-pci: don't wait freeze during resetting
Message-ID: <Ywd8VLKPmDS7QmBu@kbusch-mbp.dhcp.thefacebook.com>
References: <20220821084754.340585-1-ming.lei@redhat.com>
 <20220821084754.340585-3-ming.lei@redhat.com>
 <fcd5d4c6-b803-db9f-a00c-abfe7365f364@huawei.com>
 <YwdeRgU4YsZEGz8J@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwdeRgU4YsZEGz8J@T590>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_064250_050828_46B0DEDB 
X-CRM114-Status: GOOD (  26.02  )
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

On Thu, Aug 25, 2022 at 07:34:30PM +0800, Ming Lei wrote:
> On Thu, Aug 25, 2022 at 06:05:30PM +0800, Chao Leng wrote:
> > 
> > 
> > On 2022/8/21 16:47, Ming Lei wrote:
> > > First it isn't necessary to call nvme_wait_freeze in nvme_reset_work().
> > > If tagset isn't allocated, there can't be any inflight IOs; otherwise
> > > blk_mq_update_nr_hw_queues can freeze & wait queues.
> > > 
> > > Second, since commit bdd6316094e0 ("block: Allow unfreezing of a queue
> > > while requests are in progress"), it is fine to unfreeze queue without
> > > draining inflight IOs.
> > > 
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >   drivers/nvme/host/pci.c | 1 -
> > >   1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > index 3a1c37f32f30..91b2903fcc24 100644
> > > --- a/drivers/nvme/host/pci.c
> > > +++ b/drivers/nvme/host/pci.c
> > > @@ -2910,7 +2910,6 @@ static void nvme_reset_work(struct work_struct *work)
> > >   		nvme_free_tagset(dev);
> > >   	} else {
> > >   		nvme_start_queues(&dev->ctrl);
> > > -		nvme_wait_freeze(&dev->ctrl);
> > It is not safe.
> > nvme_dev_add may call blk_mq_update_nr_hw_queues, blk_mq_update_nr_hw_queues
> > require the state is frozen.
> 
> blk_mq_update_nr_hw_queues() calls blk_freeze_queue() for every queue in
> this tagset, so it needn't nvme's freeze wait.

Right, the blk-mq realloc should be fine, and it's really a very uncommon event
that nvme needs to realloc the tag set.

I'm trying to remember why I added the wait freeze here in the first place, and
I don't recall a good reason for it. I think I had a controller that always
timed out IO, and the resets would just continue indefinitely. Waiting for
freeze within a reset causes the next IO timeout to trigger a driver detach.
That doesn't sound like a good idea, though, since it tears down the admin
queue too.

Anyway, this looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

