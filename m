Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A44C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 15:20:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A54BD207DA
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 15:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yoZ5a75a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tBEGILFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54BD207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QXcYAufc04KfgcGMNY/OIuaVbKFEam92rB4CnPnGwd8=; b=yoZ5a75a6061BpXlecQ9X81hI
	0rvUdd+WFTIcko0db1BSEHOqHUtoUhYJ/2FU2YI+YkO99OGm/o72hw3pnc5QzWz9GqTFTueIyUus6
	MYe7jb5fULPUUQiVbUq/FyDNVZ6UQ5vMb+XAcR2tlyFOjw9ZWtkGXxmz0CZllSW+XcVQI4JwvMbCm
	RgEzT7p7Vh1fUoHb9g9g0K8qY7PtVUCAeRKO7WxA+c+6ss7PwSgeguoGvpHrV0hb1pUUUdU9lphrw
	caR9vm5n0UKpH0OoJVR386JHPC6HE51aEGPX5aazJD9sYsVhwnGLyBvT9EfpwxralqWM1k66Hy18I
	X7DuthlgQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6bUr-0005Tt-4g; Fri, 14 Aug 2020 15:19:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6bUp-0005Th-GH
 for linux-nvme@merlin.infradead.org; Fri, 14 Aug 2020 15:19:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=tim3PzhOZTtZ0Bzp0utUazdlgvWyBllX05yB6r7pryk=; b=tBEGILFcj4bgEEpwzn6woYDmW8
 qlwT2Ndw9JxQC1cSWlbrvwV2Znps0NMTs5oY6v93eE1JfuEdIDTTr6PzszfUT4jblq0tzK8Qb/L7n
 T0rE/0OWCqdxDJBT+tZT5472yMCPuyA+jRKkIvajQnYKT346XKNixOt/Z/t/H0Um+CRsLC++91RUK
 oWNd8e8GQkZstnROnfyCPaZ9m3ZltsCO04iVEYcLKCDC7YHMrucVieqF4mxx6uIA/MJwGytNEz0pE
 UwqYG2QD6Ru6Vom2skmT25gRfdKVKJcxntSZfm0vYMKt/35a+FbhhooGE5MpwSriDJKp8kYx9SE5C
 sOp7NXhA==;
Received: from 213-225-37-56.nat.highway.a1.net ([213.225.37.56]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6bUn-0002YR-TV; Fri, 14 Aug 2020 15:19:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] nvme: rename and document nvme_end_request
Date: Fri, 14 Aug 2020 17:15:26 +0200
Message-Id: <20200814151528.277465-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200814151528.277465-1-hch@lst.de>
References: <20200814151528.277465-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_end_request is a bit misnamed, as it wraps around the
blk_mq_complete_* API.  It's semantics also are non-trivial, so give it
a more descriptive name and add a comment explaining the semantics.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/fault-injection/nvme-fault-injection.rst | 2 +-
 drivers/nvme/host/fc.c                                 | 2 +-
 drivers/nvme/host/nvme.h                               | 8 +++++++-
 drivers/nvme/host/pci.c                                | 2 +-
 drivers/nvme/host/rdma.c                               | 2 +-
 drivers/nvme/host/tcp.c                                | 4 ++--
 drivers/nvme/target/loop.c                             | 2 +-
 7 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/fault-injection/nvme-fault-injection.rst b/Documentation/fault-injection/nvme-fault-injection.rst
index cdb2e829228e3e..1d4427890d7591 100644
--- a/Documentation/fault-injection/nvme-fault-injection.rst
+++ b/Documentation/fault-injection/nvme-fault-injection.rst
@@ -3,7 +3,7 @@ NVMe Fault Injection
 Linux's fault injection framework provides a systematic way to support
 error injection via debugfs in the /sys/kernel/debug directory. When
 enabled, the default NVME_SC_INVALID_OPCODE with no retry will be
-injected into the nvme_end_request. Users can change the default status
+injected into the nvme_try_complete_req. Users can change the default status
 code and no retry flag via the debugfs. The list of Generic Command
 Status can be found in include/linux/nvme.h
 
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index eae43bb444e038..ba4f10144274db 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2035,7 +2035,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	}
 
 	__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
-	if (!nvme_end_request(rq, status, result))
+	if (!nvme_try_complete_req(rq, status, result))
 		nvme_fc_complete_rq(rq);
 
 check_error:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ebb8c3ed388554..6d69cc7306d034 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -523,7 +523,13 @@ static inline u32 nvme_bytes_to_numd(size_t len)
 	return (len >> 2) - 1;
 }
 
-static inline bool nvme_end_request(struct request *req, __le16 status,
+/*
+ * Fill in the status and result information from the CQE, and then figure
+ * out if we blk-mq will need to use IPI magic to complete the request, and
+ * if yes do so.  If not let the caller complete the request without an
+ * indirect function call.
+ */
+static inline bool nvme_try_complete_req(struct request *req, __le16 status,
 		union nvme_result result)
 {
 	struct nvme_request *rq = nvme_req(req);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ba725ae47305ef..f96a69bbda70da 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -961,7 +961,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 
 	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
-	if (!nvme_end_request(req, cqe->status, cqe->result))
+	if (!nvme_try_complete_req(req, cqe->status, cqe->result))
 		nvme_pci_complete_rq(req);
 }
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 44c76ffbb264cd..4c5660201009c5 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1189,7 +1189,7 @@ static void nvme_rdma_end_request(struct nvme_rdma_request *req)
 
 	if (!refcount_dec_and_test(&req->ref))
 		return;
-	if (!nvme_end_request(rq, req->status, req->result))
+	if (!nvme_try_complete_req(rq, req->status, req->result))
 		nvme_rdma_complete_rq(rq);
 }
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 62fbaecdc960c3..3be4749dbf1127 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -481,7 +481,7 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		return -EINVAL;
 	}
 
-	if (!nvme_end_request(rq, cqe->status, cqe->result))
+	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
 		nvme_complete_rq(rq);
 	queue->nr_cqe++;
 
@@ -672,7 +672,7 @@ static inline void nvme_tcp_end_request(struct request *rq, u16 status)
 {
 	union nvme_result res = {};
 
-	if (!nvme_end_request(rq, cpu_to_le16(status << 1), res))
+	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
 		nvme_complete_rq(rq);
 }
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 4884ef1e46a281..0d6008cf66a2ad 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -115,7 +115,7 @@ static void nvme_loop_queue_response(struct nvmet_req *req)
 			return;
 		}
 
-		if (!nvme_end_request(rq, cqe->status, cqe->result))
+		if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
 			nvme_loop_complete_rq(rq);
 	}
 }
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
