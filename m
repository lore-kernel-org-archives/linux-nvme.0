Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF2DC54EE9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 18:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8xAQy7aZ7BYH1DPQ+8tvyApZhb4BnQnHW544FcJ7XiE=; b=Jb3DYyXChhGnfuDXh3mNgZiyg0
	F/PldLrHHvEkMBDFV/VEN/VrZNmdZSaypTZ6tzCf72yMY6TaZKIO9NEp+2W9EvmewRXLx3uJvcMf4
	KD89gVmlhZoiTrbR1sdXgdtEfbGBkO+4Z+6wbgW/2Z19l/0NO2t1lrIAHtF2SW66r4NzUZ1wxbfOZ
	FpdJ9H42oapk6zbvfKnkdFqMs10csggBJ1M08gFM/Yw/FcbJJ0TG9mBo/DzymTe2mg98OujQmS58e
	0FVs0KcrnU5dUXuryrNtCADBJUrrExvj+Viar6CW2lni9GszdJgNfwGGuQVjb91ashz3IyGX8yNGf
	xvfdvcwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obQwB-00HLMU-BQ; Thu, 22 Sep 2022 18:28:39 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obQvm-00HL91-CA
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 18:28:15 +0000
Received: by mail-io1-xd2d.google.com with SMTP id e205so8473267iof.1
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8xAQy7aZ7BYH1DPQ+8tvyApZhb4BnQnHW544FcJ7XiE=;
        b=aR9k5LYhnfTw7XXQzoO5WAz8DP39KvgUKyrz1rGsakd/XddUjw6vg3NHGqsum9PG+V
         QoYoKbT2kP5nhO/G7Sy/qccemyc0E3pmzD1crhRZt6HqXTJEmz/xelocvDqKLNuVcNQL
         Sl0HAFLPpFWkeQlEmS28RX7jV9+hMHFzbx3TOKoTuYtLcwK9Es9RpjUt11hx8enBYeBL
         f8ky37PViY/csWh7e3o3oS3HydD07wSBCxDqzwz1zuVf+k0iAXXg38nE5IjnxNq1FTab
         lrWaeH8Gb5fnrrASwQQHIZ/F9tg1KlBE+kuCAi0dR8ZXyjP4xFMf/mRUd8VVQV7PK8FO
         ew0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8xAQy7aZ7BYH1DPQ+8tvyApZhb4BnQnHW544FcJ7XiE=;
        b=mREmVdkWE9YlYWCrVG20vVlTVObAQUWrN6NYlyjwpCWEbqxbORc109ivpGNDzKIvT/
         dgSeFFgtXbiM79kxa1yYdXPLABAPNVIHVpGpMKEpcqG6KVuxNlCNyC7HUi/A/h0IYB85
         iqmRdyy89XdBieeZxyyiyRAALAdfLlQRqgMhAIfNHPfh0zXvPO7EdCKIbx/D1QfMMC18
         zJnbgT9SUlFl/0s8K1KAJJhUMJTyo50zoa91X6S2OVgoeZsLr5QYqrE9z11CNnovyaB2
         pxJOPBU7Rk4unwp12bYjfwB58vevBsN9+trVB+kbE14zGGSv88GBX12aUoBkPvN/fxnG
         xrEQ==
X-Gm-Message-State: ACrzQf01TR8RFyQ4UtX6E1Y5pZiU3173wjQO1lYDmfWqJiBRUGQT8lPj
	FjlhC4WvrjvMSmaBXEs1ITDzEA==
X-Google-Smtp-Source: AMsMyM4SGqW5jyi20l7Smo7p+cJHNnri3FkeeL9qvvrk+1n6md6nK0KgGtTcdgUAs/H34Ch0+VvUPg==
X-Received: by 2002:a6b:ba05:0:b0:68a:8a2f:8fdc with SMTP id k5-20020a6bba05000000b0068a8a2f8fdcmr2255996iof.148.1663871291224;
        Thu, 22 Sep 2022 11:28:11 -0700 (PDT)
Received: from m1max.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q20-20020a05663810d400b0035a468b7fbesm2440646jad.71.2022.09.22.11.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 11:28:10 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Stefan Roesch <shr@fb.com>
Subject: [PATCH 4/5] nvme: split out metadata vs non metadata end_io uring_cmd completions
Date: Thu, 22 Sep 2022 12:28:04 -0600
Message-Id: <20220922182805.96173-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220922182805.96173-1-axboe@kernel.dk>
References: <20220922182805.96173-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_112814_441854_4D6E45BD 
X-CRM114-Status: GOOD (  18.93  )
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
 drivers/nvme/host/ioctl.c | 82 +++++++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index c80b3ecca5c8..1ccc9dd6d434 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -349,9 +349,18 @@ struct nvme_uring_cmd_pdu {
 		struct bio *bio;
 		struct request *req;
 	};
-	void *meta; /* kernel-resident buffer */
-	void __user *meta_buffer;
 	u32 meta_len;
+	union {
+		struct {
+			void *meta; /* kernel-resident buffer */
+			void __user *meta_buffer;
+		};
+		struct {
+			u32 nvme_flags;
+			u32 nvme_status;
+			u64 result;
+		};
+	};
 };
 
 static inline struct nvme_uring_cmd_pdu *nvme_uring_cmd_pdu(
@@ -360,11 +369,10 @@ static inline struct nvme_uring_cmd_pdu *nvme_uring_cmd_pdu(
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
 
@@ -375,27 +383,43 @@ static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd)
 
 	result = le64_to_cpu(nvme_req(req)->result.u64);
 
-	if (pdu->meta)
+	if (pdu->meta_len)
 		status = nvme_finish_user_metadata(req, pdu->meta_buffer,
 					pdu->meta, pdu->meta_len, status);
-	if (bio)
-		blk_rq_unmap_user(bio);
+	if (req->bio)
+		blk_rq_unmap_user(req->bio);
 	blk_mq_free_request(req);
 
 	io_uring_cmd_done(ioucmd, status, result);
 }
 
+static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd)
+{
+	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
+	int status;
+
+	if (pdu->nvme_flags & NVME_REQ_CANCELLED)
+		status = -EINTR;
+	else
+		status = pdu->nvme_status;
+
+	if (pdu->bio)
+		blk_rq_unmap_user(pdu->bio);
+
+	io_uring_cmd_done(ioucmd, status, pdu->result);
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
+	pdu->nvme_flags = nvme_req(req)->flags;
+	pdu->nvme_status = nvme_req(req)->status;
+	pdu->result = le64_to_cpu(nvme_req(req)->result.u64);
 
 	/*
 	 * For iopoll, complete it directly.
@@ -406,6 +430,29 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
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
 
@@ -467,8 +514,6 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			blk_flags);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
-	req->end_io = nvme_uring_cmd_end_io;
-	req->end_io_data = ioucmd;
 
 	if (issue_flags & IO_URING_F_IOPOLL && rq_flags & REQ_POLLED) {
 		if (unlikely(!req->bio)) {
@@ -483,10 +528,15 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	}
 	/* to free bio on completion, as req->bio will be null at that time */
 	pdu->bio = req->bio;
-	pdu->meta = meta;
-	pdu->meta_buffer = nvme_to_user_ptr(d.metadata);
 	pdu->meta_len = d.metadata_len;
-
+	req->end_io_data = ioucmd;
+	if (pdu->meta_len) {
+		pdu->meta = meta;
+		pdu->meta_buffer = nvme_to_user_ptr(d.metadata);
+		req->end_io = nvme_uring_cmd_end_io_meta;
+	} else {
+		req->end_io = nvme_uring_cmd_end_io;
+	}
 	blk_execute_rq_nowait(req, false);
 	return -EIOCBQUEUED;
 }
-- 
2.35.1


