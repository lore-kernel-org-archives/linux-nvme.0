Return-Path: <SRS0=Nmzz=DV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FEFC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 01:08:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5FD20EDD
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 01:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xwpvxosf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boykALr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5FD20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9vE43YmQWnVdO4pWMLTuWOxp4n4Xd3OKpXbztnEwSsc=; b=Xwpvxosftht8U5ycMVnJprFTf
	MnZc/Q5zjwuOKW7C5CV7zaJrOrpV2bGtG/e+g3TQOU6UXpE0kYjI6g2EqjFx8GuEeKZKZgyp8zDOG
	dqGpN1huconBgu25cgw6UJ7MZH3rCpatDezm6Q4AiJHbnJ8rtMKFxTghydDrUiViUHJN2ZGOKfFYl
	JF923bL6QvvmJCjMY3py+2rZEqzzITR2L36QTTcz+qbWs1J9V98DdJ5KN898N04CQ/V1D96reN669
	qvwE2g/FPI62OvhSwTCcuSiR3YRRPvwGRvp9j1U3fb+GBOubE6rgFmlfCZeAPNyIW22s6IMvmD7P3
	ocK+p5FuQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSVHX-0004go-Bm; Wed, 14 Oct 2020 01:08:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSVHR-0004fY-Rd
 for linux-nvme@lists.infradead.org; Wed, 14 Oct 2020 01:08:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602637715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E/69ONf8FQ290l0+b/tZ1c1YE/U0q1L4yCfmk70YYnc=;
 b=boykALr6NnkD6OAVkk7fhpux8PK2wO9zP/0aULQkTojfMzT1iTXYt2Msa39MW5KBqJKueQ
 jkUfbnbbvPO1sKsrSRqP1Uf5LPZ3D/yNuUO1BSIDQz3/fD1Rhb/PgY3YVdh2RjQKKx/Iro
 mQAmVos764ul0fIjfhIiEftZNi4QX/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-Ir_DaHO7OsmFzFbumOpCXw-1; Tue, 13 Oct 2020 21:08:30 -0400
X-MC-Unique: Ir_DaHO7OsmFzFbumOpCXw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A715456BE8;
 Wed, 14 Oct 2020 01:08:28 +0000 (UTC)
Received: from T590 (ovpn-12-36.pek2.redhat.com [10.72.12.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 641D16EF7D;
 Wed, 14 Oct 2020 01:08:17 +0000 (UTC)
Date: Wed, 14 Oct 2020 09:08:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
Message-ID: <20201014010813.GA775684@T590>
References: <20201009043938.GC27356@T590>
 <1711488120.3435389.1602219830518.JavaMail.zimbra@redhat.com>
 <e39b711e-ebbd-8955-ca19-07c1dad26fa2@grimberg.me>
 <23f19725-f46b-7de7-915d-b97fd6d69cdc@redhat.com>
 <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
 <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
 <20201012081306.GB556731@T590>
 <5e05fc3b-ad81-aacc-1f8e-7ff0d1ad58fe@huawei.com>
 <e19073e4-06da-ce3c-519c-ece2c4d942fa@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e19073e4-06da-ce3c-519c-ece2c4d942fa@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201013_210837_954174_8FACF0F9 
X-CRM114-Status: GOOD (  26.96  )
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
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 13, 2020 at 03:36:08PM -0700, Sagi Grimberg wrote:
> 
> > > > This may just reduce the probability. The concurrency of timeout
> > > > and teardown will cause the same request
> > > > be treated repeatly, this is not we expected.
> > > 
> > > That is right, not like SCSI, NVME doesn't apply atomic request
> > > completion, so
> > > request may be completed/freed from both timeout & nvme_cancel_request().
> > > 
> > > .teardown_lock still may cover the race with Sagi's patch because
> > > teardown
> > > actually cancels requests in sync style.
> > In extreme scenarios, the request may be already retry success(rq state
> > change to inflight).
> > Timeout processing may wrongly stop the queue and abort the request.
> > teardown_lock serialize the process of timeout and teardown, but do not
> > avoid the race.
> > It might not be safe.
> 
> Not sure I understand the scenario you are describing.
> 
> what do you mean by "In extreme scenarios, the request may be already retry
> success(rq state change to inflight)"?
> 
> What will retry the request? only when the host will reconnect
> the request will be retried.
> 
> We can call nvme_sync_queues in the last part of the teardown, but
> I still don't understand the race here.

Not like SCSI, NVME doesn't complete request atomically, so double
completion/free can be done from both timeout & nvme_cancel_request()(via teardown).

Given request is completed remotely or asynchronously in the two code paths,
the teardown_lock can't protect the case.

One solution is to apply the introduced blk_mq_complete_request_sync()
in both two code paths.

Another candidate is to use nvme_sync_queues() before teardown, such as
the following change:

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d6a3e1487354..dc3561ca0074 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1909,6 +1909,7 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	nvme_start_freeze(ctrl);
 	nvme_stop_queues(ctrl);
+	nvme_sync_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
 	if (ctrl->tagset) {
 		blk_mq_tagset_busy_iter(ctrl->tagset,
@@ -2171,14 +2172,11 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 
-	/* fence other contexts that may complete the command */
-	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
 	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
 	if (!blk_mq_request_completed(rq)) {
 		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
 		blk_mq_complete_request(rq);
 	}
-	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
 }
 
 static enum blk_eh_timer_return


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
