Return-Path: <SRS0=hdrt=2A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAEEC43603
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 06:26:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936FE20663
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 06:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vtu7BvuO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G6WQ5kyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936FE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n5G7T/w89sH7pfDmElU9l3R4jaRYom2u5zqnY/rOTmY=; b=Vtu7BvuOc0GivV
	6KmqoYw7lGudU6ML63TV5JE6oaO+9aZLjnqXahqzTy/xX+//LIIdISnHR0qa4vWuyvq8BgWSXyUhi
	GOyWaFSHeJri/WYDI3vmXUhmCinKfC3mKmKxIiEsRliocQoxfz4gYro2qpo6WDhIuDcK+zVJhAFJY
	foP/tj892UNfprLTquYMXI0Tu//frMwQ7wLm/9KFClZpp68T00IshG30ZJBqvsiXLgE0G1xEidxoz
	PvGjnNJj6d/5DKaL5eVwACxtpPkZJOevSJklFTDMlnGuFso45svUdoe6F7iV0cNzjhPqx/PIsP7E/
	1QB4U32DI5JX/ULQgqCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ieYyS-0000md-78; Tue, 10 Dec 2019 06:26:20 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieYyF-0000YU-MC
 for linux-nvme@lists.infradead.org; Tue, 10 Dec 2019 06:26:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575959168; x=1607495168;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zH5tRDhEXu8afhVpYOsTDOgofQdf8sS1VxYq+LREIiU=;
 b=G6WQ5kyVpzo0JOi58t8CJl/yv/M/a9ethEy0nYtw6CjfI1yjRbvpDUFj
 3XbS1Gwcn9AFHdgEOs66Api+GaQtxZDZDG4gVKE+VYoel1Xca45h2/pER
 0H5psDBpa+rrGZSBJfQKry8kgpNMLvirZXd8e0z7AYbuckx4y4f4IdvXL
 KyZmMxWtqkQ3i5lJelZ0GvFgXj65wRmtNsAuLZY6u/vILnhg3/d2gPoox
 RJ3c6FU0pueCZFjyHtDoPs8yVFFGjpZ1W8X/dOuL/qIsJVh4lptTSqMOw
 1AW5mT3VPYyjIfhRm0HojVGKZ9Co3ubjGCHTexzzxpJpVcUo64zMZiBmW Q==;
IronPort-SDR: G3oViWrNqe5E3iYm64zZyOkHpR1RHcRxFaziK0B01zJvTtB8kvgcBwKezzzFohY+JWNQdFEtWQ
 a7oUmmyRTlWYoHw+0XBCH3NDfgPVGijK71Xx6z4URDlCwKosEO1aeSqpCh4WgArfTtr3sNGq9C
 YUJCag/FCbSfuLv85ufllRoRIyODlCmGVf2zO0zX4vIN4A3FhthObeofQJrzZnSp6w1CHGdSKw
 3MPzgVUMyMsIwfiFKj9efZRmTuRN4qfi1AL/bTPJd2g7Ow47sLWaHnjJyOkHAmwi39CW/HivGe
 Tn4=
X-IronPort-AV: E=Sophos;i="5.69,298,1571673600"; d="scan'208";a="125754003"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 14:26:07 +0800
IronPort-SDR: WwtUiNo94NUZsUmGU3X7BRDVTf0erjNLjhL2DVMROhuFbZ2HyEIH+GbMnnqsPgHsnhAIlgcWTB
 EWvrRnKUd756k+N4FV+nxZhumqXY2+gXFCyuBTNZh9RuXdqaPf4JiJpyJloSHKCP34sFJfvDuB
 EqamMQhCoDs8RPiMsOTPoxuSyfoXwvguNnw6CWBJ/oiNq5y+aPkxUFalwYB1+VYWe0v4de8/bC
 NNDzm4VDNRqbsuwftlQHqpbmZyndomV+7R4AoPGt5IhocLnmAn7hwZm6xApDRWNdZkbfkUhz88
 3FMo00Q+7Yq71OYEWwK/tuNG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 22:20:22 -0800
IronPort-SDR: mwre6UlW9iY574TyzCoug+xSA2n/Jr1JlMFH+NLX59AtAnaTl9NfkhcceNhgOJ/k7n+zWBI7DB
 YD8bd4qP6w2B/IsQbLD/ncFTwThVtbcNJvcipNoZCiQIqkaLV6r9DaEtYssWxr+1PuaiQ4ggDR
 6YbkewoQhyxpRwbEI3hkUmG2f38jNEZqMP34bMAIaD3+VkGJvQNVglon/vZWk7AxNWH38IcLdZ
 txrD7fvt/tBQRcrbxIxJO5xoxycO0RAx/go6HYkslw2Hb7PrRhC8sg/m5phr7FW7KxlC/l6bqw
 ybQ=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2019 22:26:07 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: sagi@grimberg.me,
	hch@lst.de
Subject: [RFC PATCH 2/2] nvmet: add file-ns polling support
Date: Mon,  9 Dec 2019 22:25:57 -0800
Message-Id: <20191210062557.5171-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191210062557.5171-1-chaitanya.kulkarni@wdc.com>
References: <20191210062557.5171-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191209_222607_730519_A2EB0F93 
X-CRM114-Status: GOOD (  16.83  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch adds polling support for file-ns. We only enable polling
based on underlying fs support and use_poll attr. By default we don't
poll on any operation we poll on the request with Reqd/write when we
receive -EIOCBQUEUED i.e. for direct I/O.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/core.c        |  4 +++
 drivers/nvme/target/io-cmd-file.c | 60 +++++++++++++++++++++++++++----
 drivers/nvme/target/nvmet.h       |  9 +++--
 3 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d8f9130d1cd1..cd2f5c6f896e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -514,12 +514,16 @@ inline void nvmet_req_done(struct nvmet_req *req)
 {
 	if (req->ns->bdev)
 		nvmet_bdev_req_complete(req);
+	if (req->ns->file)
+		nvmet_file_req_complete(req);
 }
 
 inline void nvmet_req_poll_complete(struct nvmet_req *req)
 {
 	if (req->ns->bdev)
 		nvmet_bdev_poll_complete(req);
+	if (req->ns->file)
+		nvmet_file_poll_complete(req);
 }
 
 int nvmet_ns_enable(struct nvmet_ns *ns)
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index caebfce06605..1f49a02fd437 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -16,6 +16,7 @@
 void nvmet_file_ns_disable(struct nvmet_ns *ns)
 {
 	if (ns->file) {
+		ns->poll ? nvmet_ns_stop_poll(ns) : 0;
 		if (ns->buffered_io)
 			flush_workqueue(buffered_io_wq);
 		mempool_destroy(ns->bvec_pool);
@@ -72,6 +73,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 		goto err;
 	}
 
+	ns->poll = ns->use_poll && ns->file->f_op->iopoll;
+	ret = ns->poll ? nvmet_ns_start_poll(ns) : 0;
+	if (ret)
+		goto err;
+
 	return ret;
 err:
 	ns->size = 0;
@@ -114,9 +120,8 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 	return call_iter(iocb, &iter);
 }
 
-static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
+void nvmet_file_req_complete(struct nvmet_req *req)
 {
-	struct nvmet_req *req = container_of(iocb, struct nvmet_req, f.iocb);
 	u16 status = NVME_SC_SUCCESS;
 
 	if (req->f.bvec != req->inline_bvec) {
@@ -126,13 +131,39 @@ static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
 			mempool_free(req->f.bvec, req->ns->bvec_pool);
 	}
 
-	if (unlikely(ret != req->transfer_len))
-		status = errno_to_nvme_status(req, ret);
+	if (unlikely(req->f.iosize != req->transfer_len))
+		status = errno_to_nvme_status(req, req->f.iosize);
 	nvmet_req_complete(req, status);
 }
 
+static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
+{
+	struct nvmet_req *req = container_of(iocb, struct nvmet_req, f.iocb);
+
+	req->f.iosize = ret;
+	req->poll ? complete(&req->wait) : nvmet_file_req_complete(req);
+}
+
+void nvmet_file_poll_complete(struct nvmet_req *req)
+{
+	while (!completion_done(&req->wait)) {
+		int ret = req->f.iocb.ki_filp->f_op->iopoll(&req->f.iocb, true);
+
+		if (ret < 0)
+			pr_err("tid %d poll error %d", req->t->id, ret);
+	}
+	/*
+	 * We are out of the lock anyway, by completing the polled request here
+	 * we reduce lock contention and decrease the size of done list which
+	 * reduces the size of list_lock. This allows nvmet_file_execute_rw()
+	 * to make progress as and when we scheduled out.
+	 */
+	nvmet_file_req_complete(req);
+}
+
 static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 {
+	struct kiocb *iocb = &req->f.iocb;
 	ssize_t nr_bvec = req->sg_cnt;
 	unsigned long bv_cnt = 0;
 	bool is_sync = false;
@@ -151,7 +182,7 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 		return true;
 	}
 
-	memset(&req->f.iocb, 0, sizeof(struct kiocb));
+	memset(iocb, 0, sizeof(struct kiocb));
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		nvmet_file_init_bvec(&req->f.bvec[bv_cnt], sg);
 		len += req->f.bvec[bv_cnt].bv_len;
@@ -187,13 +218,20 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 	 * A NULL ki_complete ask for synchronous execution, which we want
 	 * for the IOCB_NOWAIT case.
 	 */
-	if (!(ki_flags & IOCB_NOWAIT))
-		req->f.iocb.ki_complete = nvmet_file_io_done;
+	if (!(ki_flags & IOCB_NOWAIT)) {
+		iocb->ki_complete = nvmet_file_io_done;
+		ki_flags |= req->ns->poll ? IOCB_HIPRI : 0;
+	}
 
 	ret = nvmet_file_submit_bvec(req, pos, bv_cnt, total_len, ki_flags);
 
 	switch (ret) {
 	case -EIOCBQUEUED:
+		if (req->ns->poll) {
+			req->poll = true;
+			nvmet_req_prep_poll(req);
+			nvmet_req_issue_poll(req);
+		}
 		return true;
 	case -EAGAIN:
 		if (WARN_ON_ONCE(!(ki_flags & IOCB_NOWAIT)))
@@ -211,6 +249,10 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 	}
 
 complete:
+	/*
+	 * If we are here, then I/O is synchronously completed and ret holds
+	 * number of bytes transferred.
+	 */
 	nvmet_file_io_done(&req->f.iocb, ret, 0);
 	return true;
 }
@@ -379,15 +421,19 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 	switch (cmd->common.opcode) {
 	case nvme_cmd_read:
 	case nvme_cmd_write:
+		req->poll = false;
 		req->execute = nvmet_file_execute_rw;
 		return 0;
 	case nvme_cmd_flush:
+		req->poll = false;
 		req->execute = nvmet_file_execute_flush;
 		return 0;
 	case nvme_cmd_dsm:
+		req->poll = false;
 		req->execute = nvmet_file_execute_dsm;
 		return 0;
 	case nvme_cmd_write_zeroes:
+		req->poll = false;
 		req->execute = nvmet_file_execute_write_zeroes;
 		return 0;
 	default:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index ef2919e23e0b..e7e0e0de705e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -317,9 +317,10 @@ struct nvmet_req {
 		} b;
 		struct {
 			bool			mpool_alloc;
-			struct kiocb            iocb;
-			struct bio_vec          *bvec;
-			struct work_struct      work;
+			struct kiocb		iocb;
+			struct bio_vec		*bvec;
+			struct work_struct	work;
+			long			iosize;
 		} f;
 	};
 	int			sg_cnt;
@@ -469,6 +470,8 @@ void nvmet_req_issue_poll(struct nvmet_req *req);
 void nvmet_req_poll_complete(struct nvmet_req *req);
 void nvmet_bdev_poll_complete(struct nvmet_req *req);
 void nvmet_bdev_req_complete(struct nvmet_req *req);
+void nvmet_file_poll_complete(struct nvmet_req *req);
+void nvmet_file_req_complete(struct nvmet_req *req);
 void nvmet_req_done(struct nvmet_req *req);
 
 #define NVMET_QUEUE_SIZE	1024
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
