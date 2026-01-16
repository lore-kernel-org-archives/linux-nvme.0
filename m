Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C95D4A60A
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jan 2026 07:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q8X1E3UYPtNmvX23q+Lx4/Evy7h2o/ZPpablc61QY0k=; b=R/y3gJ9hMp5F2GSG9p+pe9Mo/G
	EYOi+6mpFjwm0F4eqO6I6CQxHYRHDjikLjbW5GvcIaUioRb/iweJFBzjfKxxzYFymT0iq6LVVK0Rg
	MxQa9OuHOCMN2vb48sFn7YnPFvFHp1H74slj+eEaxObVjy25RQ2fNDQiH52iy+KRpiwkLXeurbJ3v
	7YUirJBHNG59gC3x/B+RZGT8oXLiiUQAB+QPtdxWQ1in2fFNUJSN83CotVU/fNfx1mSVDTjsGQldl
	qU0R9RXX18zSMOr3hgxRvfnpaC4epZNF1Ti3X77hOco5hbHhvcDducnehG0fPmgBIgrt4wOBHG6B/
	0O0XbFWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgeXy-0000000DiD1-49eu;
	Fri, 16 Jan 2026 07:47:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgeXx-0000000DiCH-0VpB
	for linux-nvme@lists.infradead.org;
	Fri, 16 Jan 2026 07:47:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768549623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8X1E3UYPtNmvX23q+Lx4/Evy7h2o/ZPpablc61QY0k=;
	b=atcBNeCH3pFDd0leuTaf1vtHT1W+MSHNvpeI4793vd0Ry01J9MMaYraJ0sYwMuOHJ7PEYz
	h4HuYxcDNvP0hlXxH48eK66lLgG2hJk4vneBtMa0ZsQOht7d34hXFA2w3a1VrCmAwOE31+
	k2HlVYpAXbX8t1wugufJvnnc05G+99w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-_KNBCSLFNt6k-E4IvZMDtA-1; Fri,
 16 Jan 2026 02:46:59 -0500
X-MC-Unique: _KNBCSLFNt6k-E4IvZMDtA-1
X-Mimecast-MFC-AGG-ID: _KNBCSLFNt6k-E4IvZMDtA_1768549618
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89C9819560A7;
	Fri, 16 Jan 2026 07:46:57 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 91B551800994;
	Fri, 16 Jan 2026 07:46:56 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/2] nvme/io_uring: optimize IOPOLL completions for local ring context
Date: Fri, 16 Jan 2026 15:46:38 +0800
Message-ID: <20260116074641.665422-3-ming.lei@redhat.com>
In-Reply-To: <20260116074641.665422-1-ming.lei@redhat.com>
References: <20260116074641.665422-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260115_234705_238882_90465DF0 
X-CRM114-Status: GOOD (  19.02  )
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

When multiple io_uring rings poll on the same NVMe queue, one ring can
find completions belonging to another ring. The current code always
uses task_work to handle this, but this adds overhead for the common
single-ring case.

This patch passes the polling io_ring_ctx through io_comp_batch's new
poll_ctx field. In io_do_iopoll(), the polling ring's context is stored
in iob.poll_ctx before calling the iopoll callbacks.

In nvme_uring_cmd_end_io(), we now compare iob->poll_ctx with the
request's owning io_ring_ctx (via io_uring_cmd_ctx_handle()). If they
match (local context), we complete inline with io_uring_cmd_done32().
If they differ (remote context) or iob is NULL (non-iopoll path), we
use task_work as before.

This optimization eliminates task_work scheduling overhead for the
common case where a ring polls and finds its own completions.

~10% IOPS improvement is observed in the following benchmark:

fio/t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -O0 -P1 -u1 -n1 /dev/ng0n1

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/ioctl.c | 20 +++++++++++++-------
 include/linux/blkdev.h    |  1 +
 io_uring/rw.c             |  6 ++++++
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index e45ac0ca174e..fb62633ccbb0 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -426,14 +426,20 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	pdu->result = le64_to_cpu(nvme_req(req)->result.u64);
 
 	/*
-	 * IOPOLL could potentially complete this request directly, but
-	 * if multiple rings are polling on the same queue, then it's possible
-	 * for one ring to find completions for another ring. Punting the
-	 * completion via task_work will always direct it to the right
-	 * location, rather than potentially complete requests for ringA
-	 * under iopoll invocations from ringB.
+	 * For IOPOLL, check if this completion is happening in the context
+	 * of the same io_ring that owns the request (local context). If so,
+	 * we can complete inline without task_work overhead. Otherwise, we
+	 * must punt to task_work to ensure completion happens in the correct
+	 * ring's context.
 	 */
-	io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
+	if (blk_rq_is_poll(req) && iob &&
+	    iob->poll_ctx == io_uring_cmd_ctx_handle(ioucmd)) {
+		if (pdu->bio)
+			blk_rq_unmap_user(pdu->bio);
+		io_uring_cmd_done32(ioucmd, pdu->status, pdu->result, 0);
+	} else {
+		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
+	}
 	return RQ_END_IO_FREE;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 438c4946b6e5..251e0f538c4c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1822,6 +1822,7 @@ struct io_comp_batch {
 	struct rq_list req_list;
 	bool need_ts;
 	void (*complete)(struct io_comp_batch *);
+	void *poll_ctx;
 };
 
 static inline bool blk_atomic_write_start_sect_aligned(sector_t sector,
diff --git a/io_uring/rw.c b/io_uring/rw.c
index c33c533a267e..4c81a5a89089 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -1321,6 +1321,12 @@ int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin)
 	struct io_kiocb *req, *tmp;
 	int nr_events = 0;
 
+	/*
+	 * Store the polling io_ring_ctx so drivers can detect if they're
+	 * completing a request in the same ring context that's polling.
+	 */
+	iob.poll_ctx = ctx;
+
 	/*
 	 * Only spin for completions if we don't have multiple devices hanging
 	 * off our complete list.
-- 
2.47.0


