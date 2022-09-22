Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A772C6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 08:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kZLOSIImAiM0987OU3biBSTbMdUB/jF31vl/o2P1cc4=; b=Gr/aFflAb08y29u7koEaP+ggh6
	njHHZkaM7Xo84GhJ6rjDumI9FZc4Jju6asvjCwegjELFuvUvIBybg1sWrYRv4aebQV2wMGbU7y0HT
	V4XK2P3N7LcDdjDnQn6U8wo7pARe1pngyYBlt94dyULGK3BamuqKEopwdvx9iK5L/TaTQlB95XF5g
	P5txV51EkyzYz9lsLmKuvclSTOI32kFn++UyxG5iGBrIyIGRvc67DIwzcQ7AUc5I/1EQhxXQay8dl
	AxqipiIbH+Y/ltCjmDta86P0vVKwD3jqeL50OElN1xxbahFmk/IjpyegiIAkjnu7o2C46yR3Pq60u
	hyxdtFdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHi4-00ECed-HI; Thu, 22 Sep 2022 08:37:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHhi-00ECVg-M8
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 08:37:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663835825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kZLOSIImAiM0987OU3biBSTbMdUB/jF31vl/o2P1cc4=;
	b=WeM4oKIusHZqHt3ZK7sVzMTZ1DwAWSK+rW0jBSeyynGCy9Lz2W9r/U3H2g6oiRvvSHKlRg
	ROd1J124ymvS1rOhFZ7B9hIkwvcXgT6k4fHtKjqeJ0uT4+Cjfvcaf6NpZ7FSwfHUtU4HP5
	F5KpGTDI1ZnzvVCYLliVaj8ebSenes8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-rD7EoO0ONOaRDYGIPrnqtg-1; Thu, 22 Sep 2022 04:37:04 -0400
X-MC-Unique: rD7EoO0ONOaRDYGIPrnqtg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A119803481;
	Thu, 22 Sep 2022 08:37:03 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D54FE2166B26;
	Thu, 22 Sep 2022 08:36:57 +0000 (UTC)
Date: Thu, 22 Sep 2022 16:36:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, Chao Leng <lengchao@huawei.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: don't wait freeze during resetting
Message-ID: <YyweoxKabKafs/K+@T590>
References: <20220920015719.1840164-1-ming.lei@redhat.com>
 <c04a263f-31cb-0cb8-c2f0-a3d318093b6c@grimberg.me>
 <YypoGKWiZBFAx6xX@T590>
 <8aed1d8f-3bd7-e86a-837a-b2fc6d316d8b@grimberg.me>
MIME-Version: 1.0
In-Reply-To: <8aed1d8f-3bd7-e86a-837a-b2fc6d316d8b@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_013706_894206_85C0F55B 
X-CRM114-Status: GOOD (  45.67  )
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

On Wed, Sep 21, 2022 at 11:19:21AM +0300, Sagi Grimberg wrote:
> 
> 
> On 9/21/22 04:25, Ming Lei wrote:
> > On Tue, Sep 20, 2022 at 11:18:33AM +0300, Sagi Grimberg wrote:
> > > 
> > > > First it isn't necessary to call nvme_wait_freeze during reset.
> > > > For nvme-pci, if tagset isn't allocated, there can't be any inflight
> > > > IOs; otherwise blk_mq_update_nr_hw_queues can freeze & wait queues.
> > > > 
> > > > Second, since commit bdd6316094e0 ("block: Allow unfreezing of a queue
> > > > while requests are in progress"), it is fine to unfreeze queue without
> > > > draining inflight IOs.
> > > > 
> > > > Also both nvme-rdma and nvme-tcp's timeout handler provides forward
> > > > progress if the controller state isn't LIVE, so it is fine to drop
> > > > the timeout function of nvme_wait_freeze_timeout().
> > > 
> > > The rdma/tcp should probably be split to separate patches.
> > > 
> > > > 
> > > > Cc: Sagi Grimberg <sagi@grimberg.me>
> > > > Cc: Chao Leng <lengchao@huawei.com>
> > > > Cc: Keith Busch <kbusch@kernel.org>
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >    drivers/nvme/host/apple.c |  1 -
> > > >    drivers/nvme/host/pci.c   |  1 -
> > > >    drivers/nvme/host/rdma.c  | 13 -------------
> > > >    drivers/nvme/host/tcp.c   | 13 -------------
> > > >    4 files changed, 28 deletions(-)
> > > > 
> > > > diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> > > > index 5fc5ea196b40..9cd02b57fc85 100644
> > > > --- a/drivers/nvme/host/apple.c
> > > > +++ b/drivers/nvme/host/apple.c
> > > > @@ -1126,7 +1126,6 @@ static void apple_nvme_reset_work(struct work_struct *work)
> > > >    	anv->ctrl.queue_count = nr_io_queues + 1;
> > > >    	nvme_start_queues(&anv->ctrl);
> > > > -	nvme_wait_freeze(&anv->ctrl);
> > > >    	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
> > > >    	nvme_unfreeze(&anv->ctrl);
> > > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > > index 98864b853eef..985b216907fc 100644
> > > > --- a/drivers/nvme/host/pci.c
> > > > +++ b/drivers/nvme/host/pci.c
> > > > @@ -2910,7 +2910,6 @@ static void nvme_reset_work(struct work_struct *work)
> > > >    		nvme_free_tagset(dev);
> > > >    	} else {
> > > >    		nvme_start_queues(&dev->ctrl);
> > > > -		nvme_wait_freeze(&dev->ctrl);
> > > >    		if (!dev->ctrl.tagset)
> > > >    			nvme_pci_alloc_tag_set(dev);
> > > >    		else
> > > > diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> > > > index 3100643be299..beb0d1a6a84d 100644
> > > > --- a/drivers/nvme/host/rdma.c
> > > > +++ b/drivers/nvme/host/rdma.c
> > > > @@ -986,15 +986,6 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
> > > >    	if (!new) {
> > > >    		nvme_start_queues(&ctrl->ctrl);
> > > > -		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
> > > > -			/*
> > > > -			 * If we timed out waiting for freeze we are likely to
> > > > -			 * be stuck.  Fail the controller initialization just
> > > > -			 * to be safe.
> > > > -			 */
> > > > -			ret = -ENODEV;
> > > > -			goto out_wait_freeze_timed_out;
> > > > -		}
> > > 
> > > So here is the description from the patch that introduced this:
> > > --
> > > nvme-rdma: fix reset hang if controller died in the middle of a reset
> > > 
> > > If the controller becomes unresponsive in the middle of a reset, we
> > > will hang because we are waiting for the freeze to complete, but that
> > > cannot happen since we have commands that are inflight holding the
> > > q_usage_counter, and we can't blindly fail requests that times out.
> > > 
> > > So give a timeout and if we cannot wait for queue freeze before
> > > unfreezing, fail and have the error handling take care how to
> > > proceed (either schedule a reconnect of remove the controller).
> > > --
> > > 
> > > So if between nvme_start_queues() and the freeze (with a full wait)
> > > that is done in blk_mq_update_nr_hw_queues() the controller becomes
> > > non responsive, in this case we may hang blocking on I/O that was
> > > pending and requeued after nvme_start_queues().
> > > 
> > > The problem is, that we cannot do any error recovery because the
> > > controller is in the middle of a reset/reconnect...
> > > So the code that you deleted was designed to detect this state, and
> > > reschedule another reconnect if the controller became non responsive.
> > > 
> > > What is preventing this from happening now?
> > 
> > Please see nvme_rdma_timeout() & nvme_tcp_timeout(), if controller state
> > isn't live, request will be aborted.
> 
> I agree with you. However non-mpath devices will most likely retry the
> command and not fail it like in the multipath case (see
> nvme_decide_disposition) and will cause the I/O to block.
> 
> While it is arguable if non-mpath fabrics devices are important in any
> capacity, the design was that IO is not completed until the controller
> either successfully reconnects (and retried), or it disconnects
> (failed), or fast_io_fail_tmo expires.
> 
> Hence for non-mpath controllers, the request(s) will timeout, and
> aborted, but nvme will opt to retry them instead of completing them
> with a failure (at least until fast_io_fail_tmo expires, but that can
> be arbitrarily long).

OK, I think it is better to change the behavior for non-mpath rdma/tcp, will
remove it in next version.


thanks,
Ming


