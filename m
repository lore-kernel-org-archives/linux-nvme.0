Return-Path: <SRS0=Nmzz=DV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF32BC433E7
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 02:03:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642C521775
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 02:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="swpOzkaD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cA1pPt3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642C521775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1Q7TC8UyrNZF6tbRLzC5GEMwH6z7ulUA4dvN66wvSyw=; b=swpOzkaDljyUb1bChX1ujBaZl
	ZO9PmrC9711PUk/M2vzcrJMxS7Ukpn7mVz2cyw8xvDYj0c5MFxmLonCCO6Q9w1f42dKJSXbNnpZyA
	rXlFZqV+BMlr/IrBsGDOLGBhDGyxNTQkn9OzDgTqgZ2hR0OCqWyAFpifcofozffI7R++vacJSKnsh
	nmE+QBUfoErGp+WWqdNBqEW26fJnTwzG8sn8pLUDHZdGW9pXsjOoMOxdfji36N69UJsobOCM/Gzsl
	nO4zj82XZX8WR1PN64/Lgs31qZoOZPSQlOi69qIQigs532pPpf4agDjDFFdWFTtsu7Js420M6Nlea
	s7TW/WNtA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSW8a-0000r5-DF; Wed, 14 Oct 2020 02:03:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSW8W-0000qf-TP
 for linux-nvme@lists.infradead.org; Wed, 14 Oct 2020 02:03:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602641007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZnBS0lxFc4aRI5IPnBKqaaP5VKiZUfUv2cEuSMjVCR4=;
 b=cA1pPt3ehDDr8M/MPSbV4bKxgn5G3lBZq1o3P+GQ8YhHFhwZJMUUuCxFQ9XMURi5KwW3Et
 I3d1kuDYxufdmgw/xhVsMb/dLkib5oVbsWOeS+V/6yUH2J7XET8H9KBb5cZtfxcjZH1HMs
 +T/MAcc2XGsGZiOqRQcMI+sb/Y1+JxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-SlNewCraPw2HPxMnv_OmPQ-1; Tue, 13 Oct 2020 22:03:22 -0400
X-MC-Unique: SlNewCraPw2HPxMnv_OmPQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2785E879535;
 Wed, 14 Oct 2020 02:03:21 +0000 (UTC)
Received: from T590 (ovpn-12-36.pek2.redhat.com [10.72.12.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE29B5DA8C;
 Wed, 14 Oct 2020 02:03:06 +0000 (UTC)
Date: Wed, 14 Oct 2020 10:02:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
Message-ID: <20201014020257.GB775684@T590>
References: <e39b711e-ebbd-8955-ca19-07c1dad26fa2@grimberg.me>
 <23f19725-f46b-7de7-915d-b97fd6d69cdc@redhat.com>
 <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
 <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
 <20201012081306.GB556731@T590>
 <5e05fc3b-ad81-aacc-1f8e-7ff0d1ad58fe@huawei.com>
 <e19073e4-06da-ce3c-519c-ece2c4d942fa@grimberg.me>
 <20201014010813.GA775684@T590>
 <a1221820-55db-e550-0a9c-684ab96608e3@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a1221820-55db-e550-0a9c-684ab96608e3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201013_220329_267135_C63FD0E0 
X-CRM114-Status: GOOD (  31.88  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 14, 2020 at 09:37:07AM +0800, Chao Leng wrote:
> rdma also need do this patch.
> We do test this patch with nvme over roce a few days, now work well.
> 
> On 2020/10/14 9:08, Ming Lei wrote:
> > On Tue, Oct 13, 2020 at 03:36:08PM -0700, Sagi Grimberg wrote:
> > > 
> > > > > > This may just reduce the probability. The concurrency of timeout
> > > > > > and teardown will cause the same request
> > > > > > be treated repeatly, this is not we expected.
> > > > > 
> > > > > That is right, not like SCSI, NVME doesn't apply atomic request
> > > > > completion, so
> > > > > request may be completed/freed from both timeout & nvme_cancel_request().
> > > > > 
> > > > > .teardown_lock still may cover the race with Sagi's patch because
> > > > > teardown
> > > > > actually cancels requests in sync style.
> > > > In extreme scenarios, the request may be already retry success(rq state
> > > > change to inflight).
> > > > Timeout processing may wrongly stop the queue and abort the request.
> > > > teardown_lock serialize the process of timeout and teardown, but do not
> > > > avoid the race.
> > > > It might not be safe.
> > > 
> > > Not sure I understand the scenario you are describing.
> > > 
> > > what do you mean by "In extreme scenarios, the request may be already retry
> > > success(rq state change to inflight)"?
> > > 
> > > What will retry the request? only when the host will reconnect
> > > the request will be retried.
> > > 
> > > We can call nvme_sync_queues in the last part of the teardown, but
> > > I still don't understand the race here.
> > 
> > Not like SCSI, NVME doesn't complete request atomically, so double
> > completion/free can be done from both timeout & nvme_cancel_request()(via teardown).
> > 
> > Given request is completed remotely or asynchronously in the two code paths,
> > the teardown_lock can't protect the case.
> > 
> > One solution is to apply the introduced blk_mq_complete_request_sync()
> > in both two code paths.
> > 
> > Another candidate is to use nvme_sync_queues() before teardown, such as
> > the following change:
> > 
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index d6a3e1487354..dc3561ca0074 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -1909,6 +1909,7 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
> >   	blk_mq_quiesce_queue(ctrl->admin_q);
> >   	nvme_start_freeze(ctrl);
> >   	nvme_stop_queues(ctrl);
> > +	nvme_sync_queues(ctrl);
> nvme_sync_queues now sync io queues and admin queues, so we may need like this:
> nvme_sync_io_queues(struct nvme_ctrl *ctrl)
> {
> 	down_read(&ctrl->namespaces_rwsem);
> 	list_for_each_entry(ns, &ctrl->namespaces, list)
> 		blk_sync_queue(ns->queue);
> 	up_read(&ctrl->namespaces_rwsem);
> }

Looks not necessary to do that, because admin queue is quiesced in
nvme_tcp_teardown_io_queues(), so it is safe to sync admin queue here too.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
