Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB50C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 00:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JZvtms7pIknR/E/OjT1THTSkCWU334H5w7OLjmBgWow=; b=d8ta6omwAR9gsUqbpvg7jGf+n9
	4OHgSPmJ/D5b0SxaOmTEIt+ey5I7Kn3jfBEJL2sVY000PMuwlJglqsoEqindbY7T5YC0rCYGK9laT
	xgBbc6GX03nOFEiGcGaPghyWlyt9k/XojTRNHu93n3R/Ih5lB90oVPB/jmab6J7ueAHWtaKWrCFuD
	1e/XRi1TMzo/CCLI/XALpkwLamHwB4jtKfb5pvBeHAXKS5L4W+U49ueHIgx7zxset75TMsKvHSsQ6
	OGt0MkDOXMgKiQoAboNu5NiXeHKdKZS3T01wE4qK9jLKv4sNX+GBFimDNJmyI58Dani/gMnnZSNk0
	3JSCQPMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpJRk-000VqS-T1; Tue, 23 Nov 2021 00:14:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpJRh-000VpW-ST
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 00:14:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637626439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZvtms7pIknR/E/OjT1THTSkCWU334H5w7OLjmBgWow=;
 b=iIp4iyETP5dbviUNYz4/uQ5ljgL/gRfx/gKVrq1PPdXUq4mPCiny3TLk1JlDs8JZimW5/b
 9HmC6plIMqidhPxWtp/1QwbwOjmmtcVDdYzoK8THzZ/0rrjKGo4eulTSMO7aq1lNwmefCL
 pL4Qw4Z3TXLkZz8HZRsEHOky60Z1K3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-c8SRk3RGPVGc_5sOf5nBDQ-1; Mon, 22 Nov 2021 19:13:58 -0500
X-MC-Unique: c8SRk3RGPVGc_5sOf5nBDQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 018E21018720;
 Tue, 23 Nov 2021 00:13:57 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2411D18428;
 Tue, 23 Nov 2021 00:13:45 +0000 (UTC)
Date: Tue, 23 Nov 2021 08:13:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH 4/5] nvme: quiesce namespace queue in parallel
Message-ID: <YZwyNQWIh56hbgnq@T590>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-5-ming.lei@redhat.com>
 <37036ab3-da87-898e-5af6-1abf228b4390@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37036ab3-da87-898e-5af6-1abf228b4390@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_161402_024171_306F0940 
X-CRM114-Status: GOOD (  26.03  )
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

On Mon, Nov 22, 2021 at 10:07:24AM +0200, Sagi Grimberg wrote:
> 
> 
> On 11/19/21 4:18 AM, Ming Lei wrote:
> > Chao Leng reported that in case of lots of namespaces, it may take quite a
> > while for nvme_stop_queues() to quiesce all namespace queues.
> > 
> > Improve nvme_stop_queues() by running quiesce in parallel, and just wait
> > once if global quiesce wait is allowed.
> > 
> > Link: https://lore.kernel.org/linux-block/cc732195-c053-9ce4-e1a7-e7f6dcf762ac@huawei.com/
> > Reported-by: Chao Leng <lengchao@huawei.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   drivers/nvme/host/core.c | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 4b5de8f5435a..06741d3ed72b 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -4517,9 +4517,7 @@ static void nvme_start_ns_queue(struct nvme_ns *ns)
> >   static void nvme_stop_ns_queue(struct nvme_ns *ns)
> >   {
> >   	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
> > -		blk_mq_quiesce_queue(ns->queue);
> > -	else
> > -		blk_mq_wait_quiesce_done(ns->queue);
> > +		blk_mq_quiesce_queue_nowait(ns->queue);
> >   }
> >   /*
> > @@ -4620,6 +4618,11 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
> >   	down_read(&ctrl->namespaces_rwsem);
> >   	list_for_each_entry(ns, &ctrl->namespaces, list)
> >   		nvme_stop_ns_queue(ns);
> > +	list_for_each_entry(ns, &ctrl->namespaces, list) {
> > +		blk_mq_wait_quiesce_done(ns->queue);
> > +		if (blk_mq_global_quiesce_wait(ns->queue))
> > +			break;
> > +	}
> >   	up_read(&ctrl->namespaces_rwsem);
> 
> 
> Can you quantify how much of a difference it is to do rcu_read_unlock()
> for every queue? The big improvement here is that it is done in parallel
> instead of serially. Just wandering if it is worth the less than elegant
> interface...

The biggest improvement is N * synchronize_rcu() -> 1 * synchronize_rcu()
in case of non blocking, that is what Chao Leng complained before.

Even for blocking case, the parallel quiesce is still good, such as, when
one synchronize_srcu() is done, other srcu syncs should be done usually too.


thanks, 
Ming


