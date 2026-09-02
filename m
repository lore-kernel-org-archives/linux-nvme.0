Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EF6C624D4
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 22:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i/dqMqkRLXLgOf/iN7bfg+WtTxgpBe43DRYOg5f23zY=; b=FprdxRi6YlHWaEw01aTybG6rLI
	PQluzygIKJezkPLVNDbT6ES591VC1C9xj2oZkDa1n2X++iQpakk/w+ZEl3p/IJ5+g0zo5SvAH2mSy
	fj7S9mLKkfIokF65l+p3U2Wod+YvRd+kFd8GYgPTbhuMsjfOvRKQvSn4Q/zDZCYkkvM2V6iv5Zxp7
	ZM0n8mcazyiCn0rKRPIS/s1govK18icMNpHU3aVdAZEh82jZgZsQIlc4MQfIwRSqbuhe8dgW6KEat
	dfUGlzvCBN6bEcpdpH815o6xFzA9rkVRfSqUu4Rlf0uRJspev0AHBemUouQN8zZ63q/nAE0xEt4uK
	LCC2AnPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1ttO-0000000G45u-0EMR;
	Wed, 02 Sep 2026 22:57:18 +0000
Received: from mail-pg1-x563.google.com ([2607:f8b0:4864:20::563])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1ttL-0000000G44k-3nsP
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 22:57:17 +0000
Received: by mail-pg1-x563.google.com with SMTP id 41be03b00d2f7-cbe4c537ad6so219850a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 02 Sep 2026 15:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788389834; x=1788994634; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i/dqMqkRLXLgOf/iN7bfg+WtTxgpBe43DRYOg5f23zY=;
        b=Z6TBAnWiTpWDJuBPFoZjTLAyH2kkmxPMbNsc+GQT4+x38KmUoy2Fozk5FgtfZ9W0h2
         0u8KMW2GWI5+gr7rqwa2KwAzTAE6J+OM7kw4Aho3I5B3rGZsZGnK+hS8S8c8wvGJjXFz
         AqZMdQjX61PiIiZZ/QMFf0RbAExqJiuITZZDiX32ITwTIUVhzBsy+SzOyGVyYiAz75Ec
         Hac5BrqGAIdul5piqKhg3LcLKMsoP+HyuYZav+hy0vwswwRk7H0qkBHjTynTfmAQrrQw
         4DM+vQ6cvUE+cNQFu6bvXARA/rGmsRmv+8cIsNOzFU+GUdBF+YnuLN3vwqZVOHzQfPdS
         0BLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788389834; x=1788994634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i/dqMqkRLXLgOf/iN7bfg+WtTxgpBe43DRYOg5f23zY=;
        b=Zf7lPgdYWl0comrC3dzxNfKXQj2cDpc2hki5yvYimutAWxigiSlQ4bCieoRwuUfD63
         +pmbNtF/xNMB+9hl+KyhRQGonq14ZPjZ38ZNWNrUDaBHwPvKoTq4j5uj7pc2oTwqRKnF
         LpVXtSxW/Lsyh/JXy65JCsWMZSWcBMcToG8KUUbQLwdetrHDufXL+wac8NbaegjolBf8
         +O8Cp8BMaEIOp1dhXHWxi4h+Xn1fEG/2dRpeNERLQsmdnJQCM4+MX/sMb6ToJG+VnayD
         Yw7hBUQ3dYjhRfLNDmw3ffNC0KHPSA+f6vh3aLdahZhJJz4/dppaQoUl1Gmz4gdzQFWG
         nOlw==
X-Forwarded-Encrypted: i=1; AKwUvByBI7XZ6KXMXRVucVEIVd09DrRqglAZhTNCpH3Lvvj3VG+n7VtXo5ZdfjobtxSQi/sQVS+AZOsLqLIC@lists.infradead.org
X-Gm-Message-State: AFuF++m57WaAczODHXyBIquqSXp5lI0qbMFO3EpoSYXg8Xq2QnOJ+CS0
	WMz0QG9gtKn4vsS6OVeeQehU2iPZUNbhhn3p7h5QmJUkGc08wXiU0LJWrM/8/nyfdIgLXRqCsFD
	UFngVuFjMLIT32/nz/dx8MD/TvpwaZzCOZPJe9inzsXV5nhv3RSjr
X-Gm-Gg: AYBFou1LNAUArU07Cz1+SB7I60Wtxv7L0GfoFoWAHqAY8uCWEJBNehtiriNAM5tgvJm
	IyeCuZD1cxPdznoXhe7fab20ab44jo+7+5/Z6vfrniiYgYsH3B17uYTsIKMd6DHbMeyjPcIz7rn
	g3f3CShidQgcItn1J6mzEXDGD08U/xL/hbTt9FoBIEgVz72sIDq5P8xMeZSOGsuEamBZvIlCVdT
	JXMp4tRke6xa+xHaTaXr6+MBE91gp7EQpGfN/bxez1DkoQvWo9J1AYlF/VFpI1NT6YKLIV0kUTD
	ZdsWcY+aXyVk0hA728HsVsUUVqaqtHJG3C3PZz/LvZLuboEvLjgvR5AXn/+AOwYLHgorjp/Edgt
	j9yQw/tv1Jw3B+0gk
X-Received: by 2002:a17:90a:e7d1:b0:38e:6d4c:14df with SMTP id 98e67ed59e1d1-39aedec8443mr7525746a91.1.1788389834532;
        Wed, 02 Sep 2026 15:57:14 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-3325680a589sm24784eec.3.2026.09.02.15.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 15:57:14 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id A7B4540423;
	Wed,  2 Sep 2026 16:57:13 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A1AC3E40404; Wed,  2 Sep 2026 16:57:13 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 2/2] nvme/ioctl: call io_uring_cmd_set_res32() in ->end_io()
Date: Wed,  2 Sep 2026 16:57:08 -0600
Message-ID: <20260902225708.2379840-3-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902225708.2379840-1-csander@purestorage.com>
References: <20260902225708.2379840-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_155716_029634_939581D8 
X-CRM114-Status: GOOD (  17.21  )
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

io_uring_cmd_set_res32() only performs loads and stores to the io_uring
request state, so it's safe to call in interrupt context. Move the call
from the nvme_uring_task_cb() task work to nvme_uring_cmd_end_io(). This
unifies the 2 places setting the NVMe status and result on the uring_cmd
and removes the need to pass them through struct nvme_uring_cmd_pdu,
saving 16 bytes and a couple memory accesses.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/ioctl.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 6539d4750098..3aa5d2f2dfbb 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -421,12 +421,10 @@ struct nvme_uring_data {
  * Expect build errors if this grows larger than that.
  */
 struct nvme_uring_cmd_pdu {
 	struct request *req;
 	struct bio *bio;
-	u64 result;
-	int status;
 };
 
 static inline struct nvme_uring_cmd_pdu *nvme_uring_cmd_pdu(
 		struct io_uring_cmd *ioucmd)
 {
@@ -438,29 +436,30 @@ static void nvme_uring_task_cb(struct io_tw_req tw_req, io_tw_token_t tw)
 	struct io_uring_cmd *ioucmd = io_uring_cmd_from_tw(tw_req);
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
 
 	if (pdu->bio)
 		blk_rq_unmap_user(pdu->bio);
-	io_uring_cmd_done32(ioucmd, pdu->status, pdu->result,
-			    IO_URING_CMD_TASK_WORK_ISSUE_FLAGS);
+	__io_uring_cmd_done(ioucmd, IO_URING_CMD_TASK_WORK_ISSUE_FLAGS);
 }
 
 static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 						blk_status_t err,
 						const struct io_comp_batch *iob)
 {
 	struct io_uring_cmd *ioucmd = req->end_io_data;
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
+	u64 result = le64_to_cpu(nvme_req(req)->result.u64);
+	int status;
 
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED) {
-		pdu->status = -EINTR;
+		status = -EINTR;
 	} else {
-		pdu->status = nvme_req(req)->status;
-		if (!pdu->status)
-			pdu->status = blk_status_to_errno(err);
+		status = nvme_req(req)->status;
+		if (!status)
+			status = blk_status_to_errno(err);
 	}
-	pdu->result = le64_to_cpu(nvme_req(req)->result.u64);
+	io_uring_cmd_set_res32(ioucmd, status, result);
 
 	/*
 	 * For IOPOLL, check if this completion is happening in the context
 	 * of the same io_ring that owns the request (local context). If so,
 	 * we can complete inline without task_work overhead. Otherwise, we
@@ -469,11 +468,11 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	 */
 	if (blk_rq_is_poll(req) && iob &&
 	    iob->poll_ctx == io_uring_cmd_ctx_handle(ioucmd)) {
 		if (pdu->bio)
 			blk_rq_unmap_user(pdu->bio);
-		io_uring_cmd_done32(ioucmd, pdu->status, pdu->result, 0);
+		__io_uring_cmd_done(ioucmd, 0);
 	} else {
 		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
 	}
 	return RQ_END_IO_FREE;
 }
-- 
2.55.0


