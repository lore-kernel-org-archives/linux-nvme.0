Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC88C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 15:28:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445AB614C8
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 15:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 445AB614C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aq7J6MACLlZ/hmjzkYAR3syGLqvAAb5XmW5pa+e7J6M=; b=HqkY+3diP/B3nh
	nILIwDFAy7pFbPgP390qUeG4SidN8l0gwqR6wigSl812KB7lViCXAO1osUVGyiHutrDr4RyKUU09w
	z9TotuAMHRGj37Qi/cIbH59sC1ACT37+zuzh516vKFWHC0KyxdwsGiM1zRpsISX+d5w4Qm3zGww0E
	flvSdz9IN5ZcKv2eiWh7BL6Wf697xGvAnEen8fasgOEf+Xk9pvb5iwTg8jGU2Nw7BmDk+l09/+9UO
	1z3l/ztxp9uLo5H4vD0S7jXUwPuZTEH0E86HrIUWDvuu7p3p57gG84xftKBnh+lvYFkLH89l7A9ht
	phs//ITeqtun4GmZIvZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVbVK-00BYzx-OZ; Wed, 29 Sep 2021 15:28:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVbVI-00BYxo-IA
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 15:28:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632929294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T93jqqgqqFV2Mt29ptOHTmBc09wsel2Yq+k09RyZmL4=;
 b=iOOJh0GOCSVd1e2j+9WzdmdSTSbLuwFs5DoWTxDiXKvzEWakuMPd5FwXwMaaGTUnxTSg5r
 jLiHlflj6bkGmIjo3qwIF7ureo+RY58LmzHPC4tu4ih+sqNCCw27rPxqdzaW0UChx0dT1T
 2x7f3V7ywcs1i0dMwtkUFFhEpQXqmzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-mEyAJEfYOHOC89svWV9gJA-1; Wed, 29 Sep 2021 11:28:12 -0400
X-MC-Unique: mEyAJEfYOHOC89svWV9gJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4553336301;
 Wed, 29 Sep 2021 15:28:11 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE6DF19C59;
 Wed, 29 Sep 2021 15:28:06 +0000 (UTC)
Date: Wed, 29 Sep 2021 23:28:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 4/5] nvme: paring quiesce/unquiesce
Message-ID: <YVSGAQqzNTjohWkn@T590>
References: <20210929041559.701102-1-ming.lei@redhat.com>
 <20210929041559.701102-5-ming.lei@redhat.com>
 <dc9152dd-afb3-5902-004f-84fa27cee9ca@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dc9152dd-afb3-5902-004f-84fa27cee9ca@grimberg.me>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_082816_739457_85CD53AC 
X-CRM114-Status: GOOD (  30.96  )
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

On Wed, Sep 29, 2021 at 02:49:39PM +0300, Sagi Grimberg wrote:
> 
> 
> On 9/29/21 7:15 AM, Ming Lei wrote:
> > The current blk_mq_quiesce_queue() and blk_mq_unquiesce_queue() always
> > stops and starts the queue unconditionally. And there can be concurrent
> > quiesce/unquiesce coming from different unrelated code paths, so
> > unquiesce may come unexpectedly and start queue too early.
> > 
> > Prepare for supporting nested / concurrent quiesce/unquiesce, so that we
> > can address the above issue.
> > 
> > NVMe has very complicated quiesce/unquiesce use pattern, add one mutex
> > and queue stopped state in nvme_ctrl, so that we can make sure that
> > quiece/unquiesce is called in pair.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   drivers/nvme/host/core.c | 51 ++++++++++++++++++++++++++++++++++++----
> >   drivers/nvme/host/nvme.h |  4 ++++
> >   2 files changed, 50 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 23fb746a8970..5d0b2eb38e43 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -4375,6 +4375,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
> >   	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
> >   	spin_lock_init(&ctrl->lock);
> >   	mutex_init(&ctrl->scan_lock);
> > +	mutex_init(&ctrl->queues_stop_lock);
> >   	INIT_LIST_HEAD(&ctrl->namespaces);
> >   	xa_init(&ctrl->cels);
> >   	init_rwsem(&ctrl->namespaces_rwsem);
> > @@ -4450,14 +4451,44 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
> >   }
> >   EXPORT_SYMBOL_GPL(nvme_init_ctrl);
> > +static void __nvme_stop_admin_queue(struct nvme_ctrl *ctrl)
> > +{
> > +	lockdep_assert_held(&ctrl->queues_stop_lock);
> > +
> > +	if (!ctrl->admin_queue_stopped) {
> > +		blk_mq_quiesce_queue(ctrl->admin_q);
> > +		ctrl->admin_queue_stopped = true;
> > +	}
> > +}
> > +
> > +static void __nvme_start_admin_queue(struct nvme_ctrl *ctrl)
> > +{
> > +	lockdep_assert_held(&ctrl->queues_stop_lock);
> > +
> > +	if (ctrl->admin_queue_stopped) {
> > +		blk_mq_unquiesce_queue(ctrl->admin_q);
> > +		ctrl->admin_queue_stopped = false;
> > +	}
> > +}
> 
> I'd make this a bit we can flip atomically.
> 
> > +
> >   static void nvme_start_ns_queue(struct nvme_ns *ns)
> >   {
> > -	blk_mq_unquiesce_queue(ns->queue);
> > +	lockdep_assert_held(&ns->ctrl->queues_stop_lock);
> > +
> > +	if (test_bit(NVME_NS_STOPPED, &ns->flags)) {
> > +		blk_mq_unquiesce_queue(ns->queue);
> > +		clear_bit(NVME_NS_STOPPED, &ns->flags);
> > +	}
> >   }
> >   static void nvme_stop_ns_queue(struct nvme_ns *ns)
> >   {
> > -	blk_mq_quiesce_queue(ns->queue);
> > +	lockdep_assert_held(&ns->ctrl->queues_stop_lock);
> > +
> > +	if (!test_bit(NVME_NS_STOPPED, &ns->flags)) {
> > +		blk_mq_quiesce_queue(ns->queue);
> > +		set_bit(NVME_NS_STOPPED, &ns->flags);
> > +	}
> >   }
> 
> Why not use test_and_set_bit/test_and_clear_bit for serialization?
> 
> >   /*
> > @@ -4490,16 +4521,18 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
> >   {
> >   	struct nvme_ns *ns;
> > +	mutex_lock(&ctrl->queues_stop_lock);
> >   	down_read(&ctrl->namespaces_rwsem);
> >   	/* Forcibly unquiesce queues to avoid blocking dispatch */
> >   	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
> > -		nvme_start_admin_queue(ctrl);
> > +		__nvme_start_admin_queue(ctrl);
> >   	list_for_each_entry(ns, &ctrl->namespaces, list)
> >   		nvme_set_queue_dying(ns);
> >   	up_read(&ctrl->namespaces_rwsem);
> > +	mutex_unlock(&ctrl->queues_stop_lock);
> 
> This extra lock wrapping the namespaces_rwsem is scary. The
> ordering rules are not clear to me.

The rule is clear: queues_stop_lock has to be acquired before locking
->namespaces_rwsem.

Using test_and_set_bit/test_and_clear_bit could be enough for pairing
quiesce and unquiesce, I will try to remove the lock of
->queues_stop_lock in next version.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
