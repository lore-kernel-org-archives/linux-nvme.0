Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BB6C32771
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 01:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OWQyl94A5qNKtPnF/8PyOhg9aeGApg21Zf8bAO/j86s=; b=OcE2RP2UKUGbl/hIg2Ls6lsXbq
	cY+CgsvG0Zcth53GeLsjS0YHj6lrBnJ5vrOSJFLjqTUjv7PXFUe+EPSlH/1cUtZ5frKKOCwRvxxHx
	ysqUGxHBoZFoI34zDEy4WDUFqvY1bFLitRnGzZMG2+DT+fZASW0C5tgNhXb3ht9knx4LZP+iXjC8M
	qhSw0ETs7jWILJ6uoHPTUnlWalzfRX7eGbrlvp5Nb3QyNn+TNSvxwwnogx9agg8yZ2agMrdmbYOJ5
	FFUvgDQNvVxHhRTZGXI9lwOs55HXmI69h8zwRq4dsvX7pGTEf6LadiudSDP1IyBEdHQtPt8pbMxdg
	20khODhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oczeS-007h5t-QV; Tue, 27 Sep 2022 01:44:48 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocze8-007gyc-4A
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 01:44:29 +0000
Received: by mail-pf1-x435.google.com with SMTP id d82so8359192pfd.10
        for <linux-nvme@lists.infradead.org>; Mon, 26 Sep 2022 18:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OWQyl94A5qNKtPnF/8PyOhg9aeGApg21Zf8bAO/j86s=;
        b=mP3PeN6PCELyvJQ+DXmQS2FoJwddmxuB7MQ2/UGEabb+Nm+/V452tOJaIqhRCFbWIv
         IDC2qnSZZmCGdo5dh/q1ZBrd1oigApYXtLJPSyGuJcrx8rVIz3Xa9fMTdc/32SjSGYm7
         R1IZP4E6Ph619vy2hU2ZZMhbef7T8doLfRUOMdOWG67R4osTEnmvvI4sEeF4Dotkbtmv
         CrJeo7+GHMCQX9bmnTYIvdrUCh1UfScfimPbsJ1bRgeXH5KLwHYydc/+NxR7gHcVuM7W
         vDmc3SweNBhuBsmVtob4aqGhkqVJzVipuHgB1xuPXoC3Yk7y4SIW9wNbXnUChX9C0mQN
         sIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OWQyl94A5qNKtPnF/8PyOhg9aeGApg21Zf8bAO/j86s=;
        b=SAetjf3eTnSFu1noKsX56vX7p4T/daHqs6kxZPIIQtmF5HnGsalI4Lt2VPYUjQBVE4
         kvE7rnw2Ifm1eTUuZtXPAnnR6X84u3kwBMUlw3rXTu7rEJxD1B+UTXq0bV8NYc+y3mpv
         CpX0LKqix11JYxHC8LVMoJaLB0vzWDZXLFfcUoXO44hwRFMudIjRN61OAv4/ife/haxs
         0dIFt9Lwgn9fXTBmChD7higiGl71fsHvuQHB28qRYcfFIpQFj9N2+6HGgXK4sEe2uyXS
         IF+sHUlwwg9BPsFpUwJ5n2Rx/XQxnnoD9crOLuuM7nYDJJ110GiQ7mi1ued2nQM4eRjf
         HgMA==
X-Gm-Message-State: ACrzQf2Z8gRjnWVZHJVYvFVDO1WLpcB5+r/SUAPM9kvr7mhExwX8wuzc
	KIbUep4XZ/il6XyKQir2ZZDpoA==
X-Google-Smtp-Source: AMsMyM4b4xjI5VuwTPQxKRtlKpdTkx4cE0vHyJY+Uc0NtDg0sPzbmbmbPkA9/NgxXSIQ4gKYg+MuEw==
X-Received: by 2002:a62:1bc8:0:b0:546:c62e:e84 with SMTP id b191-20020a621bc8000000b00546c62e0e84mr26532012pfb.45.1664243066985;
        Mon, 26 Sep 2022 18:44:26 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o2-20020aa79782000000b00537d60286c9sm183062pfp.113.2022.09.26.18.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 18:44:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Stefan Roesch <shr@fb.com>
Subject: [PATCH 4/5] nvme: split out metadata vs non metadata end_io uring_cmd completions
Date: Mon, 26 Sep 2022 19:44:19 -0600
Message-Id: <20220927014420.71141-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927014420.71141-1-axboe@kernel.dk>
References: <20220927014420.71141-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_184428_191121_A4308509 
X-CRM114-Status: GOOD (  19.19  )
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

By splitting up the metadata and non-metadata end_io handling, we can
remove any request dependencies on the normal non-metadata IO path. This
is in preparation for enabling the normal IO passthrough path to pass
the ownership of the request back to the block layer.

Co-developed-by: Stefan Roesch <shr@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/ioctl.c | 79 ++++++++++++++++++++++++++++++---------
 1 file changed, 61 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index c80b3ecca5c8..9e356a6c96c2 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -349,9 +349,15 @@ struct nvme_uring_cmd_pdu {
 		struct bio *bio;
 		struct request *req;
 	};
-	void *meta; /* kernel-resident buffer */
-	void __user *meta_buffer;
 	u32 meta_len;
+	u32 nvme_status;
+	union {
+		struct {
+			void *meta; /* kernel-resident buffer */
+			void __user *meta_buffer;
+		};
+		u64 result;
+	} u;
 };
 
 static inline struct nvme_uring_cmd_pdu *nvme_uring_cmd_pdu(
@@ -360,11 +366,10 @@ static inline struct nvme_uring_cmd_pdu *nvme_uring_cmd_pdu(
 	return (struct nvme_uring_cmd_pdu *)&ioucmd->pdu;
 }
 
-static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd)
+static void nvme_uring_task_meta_cb(struct io_uring_cmd *ioucmd)
 {
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
 	struct request *req = pdu->req;
-	struct bio *bio = req->bio;
 	int status;
 	u64 result;
 
@@ -375,27 +380,39 @@ static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd)
 
 	result = le64_to_cpu(nvme_req(req)->result.u64);
 
-	if (pdu->meta)
-		status = nvme_finish_user_metadata(req, pdu->meta_buffer,
-					pdu->meta, pdu->meta_len, status);
-	if (bio)
-		blk_rq_unmap_user(bio);
+	if (pdu->meta_len)
+		status = nvme_finish_user_metadata(req, pdu->u.meta_buffer,
+					pdu->u.meta, pdu->meta_len, status);
+	if (req->bio)
+		blk_rq_unmap_user(req->bio);
 	blk_mq_free_request(req);
 
 	io_uring_cmd_done(ioucmd, status, result);
 }
 
+static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd)
+{
+	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
+
+	if (pdu->bio)
+		blk_rq_unmap_user(pdu->bio);
+
+	io_uring_cmd_done(ioucmd, pdu->nvme_status, pdu->u.result);
+}
+
 static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 						blk_status_t err)
 {
 	struct io_uring_cmd *ioucmd = req->end_io_data;
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
-	/* extract bio before reusing the same field for request */
-	struct bio *bio = pdu->bio;
 	void *cookie = READ_ONCE(ioucmd->cookie);
 
-	pdu->req = req;
-	req->bio = bio;
+	req->bio = pdu->bio;
+	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
+		pdu->nvme_status = -EINTR;
+	else
+		pdu->nvme_status = nvme_req(req)->status;
+	pdu->u.result = le64_to_cpu(nvme_req(req)->result.u64);
 
 	/*
 	 * For iopoll, complete it directly.
@@ -406,6 +423,29 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	else
 		io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_cb);
 
+	blk_mq_free_request(req);
+	return RQ_END_IO_NONE;
+}
+
+static enum rq_end_io_ret nvme_uring_cmd_end_io_meta(struct request *req,
+						     blk_status_t err)
+{
+	struct io_uring_cmd *ioucmd = req->end_io_data;
+	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
+	void *cookie = READ_ONCE(ioucmd->cookie);
+
+	req->bio = pdu->bio;
+	pdu->req = req;
+
+	/*
+	 * For iopoll, complete it directly.
+	 * Otherwise, move the completion to task work.
+	 */
+	if (cookie != NULL && blk_rq_is_poll(req))
+		nvme_uring_task_meta_cb(ioucmd);
+	else
+		io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_meta_cb);
+
 	return RQ_END_IO_NONE;
 }
 
@@ -467,8 +507,6 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			blk_flags);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
-	req->end_io = nvme_uring_cmd_end_io;
-	req->end_io_data = ioucmd;
 
 	if (issue_flags & IO_URING_F_IOPOLL && rq_flags & REQ_POLLED) {
 		if (unlikely(!req->bio)) {
@@ -483,10 +521,15 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	}
 	/* to free bio on completion, as req->bio will be null at that time */
 	pdu->bio = req->bio;
-	pdu->meta = meta;
-	pdu->meta_buffer = nvme_to_user_ptr(d.metadata);
 	pdu->meta_len = d.metadata_len;
-
+	req->end_io_data = ioucmd;
+	if (pdu->meta_len) {
+		pdu->u.meta = meta;
+		pdu->u.meta_buffer = nvme_to_user_ptr(d.metadata);
+		req->end_io = nvme_uring_cmd_end_io_meta;
+	} else {
+		req->end_io = nvme_uring_cmd_end_io;
+	}
 	blk_execute_rq_nowait(req, false);
 	return -EIOCBQUEUED;
 }
-- 
2.35.1


