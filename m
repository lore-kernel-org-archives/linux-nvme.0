Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD0CC3600C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 20:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2AeP3tUa1PaSAs4qnZHRPSHqiV7KLICBeUZhC4wZNt0=; b=Xmd/6LwW010xwqwVoXE2WOmk+z
	FY1rSTb3fZ9o0nZKoiYiM+sVMg0mhXqZGDlakN7wF/LYr1aei3IFeJ6hHm1gMBw5Eb1DYjfUOoq57
	fsGDGH7Qgf60YVXv3OYW2QDsWVzmQH2IXisL6gXdNwaeA1yq5Jn31ZPxgg187stjEE6ysB1NBInMT
	OfzMEQRmJnvsnJsY4agUVrT+QbkF8vzHBEGkCauT+sYQRvbWumlMYUiuA9V6hrM2RPVleByLne1Ix
	JYvY5MKvqGmJxF6kaDma8nu5XRuua1rDoZe5ak4WI8Dl4q+IdWHdvrosgafp6c6ERjpLXeQvg1tCD
	D332yAqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1two46-000000048uQ-1JYu;
	Mon, 24 Mar 2025 20:06:30 +0000
Received: from mail-io1-xd64.google.com ([2607:f8b0:4864:20::d64])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1two41-000000048s8-0GU4
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 20:06:26 +0000
Received: by mail-io1-xd64.google.com with SMTP id ca18e2360f4ac-85b418faf5cso15545539f.3
        for <linux-nvme@lists.infradead.org>; Mon, 24 Mar 2025 13:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742846784; x=1743451584; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AeP3tUa1PaSAs4qnZHRPSHqiV7KLICBeUZhC4wZNt0=;
        b=BaFIDQPLZ26oIqH1M1iVzYjjx9l0heyiatBQM8jl1sivJAPMrzZzmruY5pG7xf89UO
         NxKbby02G9w+jaYb64jNi3WFA28KA+TmXff9By3s8soub6IXoTUOMm8qJ8Mj9rsH/v/U
         S94YjqaRIzAAMUF40yFJ+nf61HXlXjUUfj6DedDQeC6NTGxXOEdOVMAsFhYpqpCRxN0F
         Tv4TS0x8iwi0ykqf/j5UcCENFahZjswAim8+egopP8wEwD+LFJMvx4tNdVUMaoAxmavW
         1jN8OIit+xDlQ3wNzsv8vR9QPZgI9E/wXn7vjTYtN2BUaflJZh2bmJsJbjDw1TTzYqxw
         K7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742846784; x=1743451584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AeP3tUa1PaSAs4qnZHRPSHqiV7KLICBeUZhC4wZNt0=;
        b=BEJIAEwUHJxatRnVaxzUaxrIN2HOEfyG03A5G+ZhS016cNs2YFQmu8EJXOfSjrUtxn
         wn5d9+xJJrz+2OOp+OkiKLMPmvpjMi+tqewd0CLerbVDcLGXbaolZv+NN73Lp/3zqjJO
         pnx55Y6By8BYRO2qLzXRiMWcalBgJYU5JhUwaEld9smjaLyY+1yii4uNPtfum2qaPydn
         Nfnq0HRaqsuQQtzPNDjtBw43qgSpPy1mLTvt2AIr7ABrbr9E0oB+a5R1sD9+pOvJhZFd
         3sv3NZdU4uTIg2T1oDvlnfQLGo+tPM756U+9sSbmDMFMk4VaPqrieg3/ZPdweuZnD7j7
         Z3pg==
X-Forwarded-Encrypted: i=1; AJvYcCXCzh5guDP6GDEwMnMUwBqsd+mZ66gYleidSvoN9Q5uDAAlvtplmKYjqoD/XfQKqqYp6V50NhH+3v0H@lists.infradead.org
X-Gm-Message-State: AOJu0YxDOrkE4Vd/gEgjjgiWrooiJfsW7u1DdID09FCqPLcawbBfq4QX
	Ce2awj/vLhKOydTiqaYyRNNHrmwAULC8wBVkJHqnQtqY3V6R8yKa0lcKVok3jSaRWiBiivSEaQe
	TqY88BDhvNQ3OOSYXujuGZOogmPHrKmoZuiTvk/phwqjhZOaq
X-Gm-Gg: ASbGncu4CiEoTaEFmlSPz3FMUaYeCiAANEH3ZvNZhcYHvgAua1BSckCrzKvbsMO+ilt
	iDYeMSmGVvJ8PGxVUUF7O7e5wGGvH6gYJ72TNwwTn3k+Hky2IfKDunHq/oZBkxU5HYJyPxv45rK
	Y0FiJ5Imbyo3a/Eb3hO+4qb+7Me1Qun3yJ4bxEz8yR2TgjY0WO96OoKAbICZnJ3dnyTB0woSlUv
	q+w41W6rZviimngiTwhkmjMj6hRgmgAoDEfpFHt7aYbHQpWZ4iqxM+2wPLHdLK/+vkjFEHBlm5G
	m2NrHooMBsoA6L4R+so8tbPr+gytUIxodw==
X-Google-Smtp-Source: AGHT+IHNqvmP9ln5GrZ4X4+8LO1tZJJn7NGCANLbaSu7JIy8WsCk3TVzlhQISS+g7lZW4375/xs/ty7i0mo7
X-Received: by 2002:a05:6e02:1946:b0:3d4:3aba:9547 with SMTP id e9e14a558f8ab-3d59616811cmr38294575ab.4.1742846783927;
        Mon, 24 Mar 2025 13:06:23 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d5960fdf9bsm3732575ab.52.2025.03.24.13.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:06:23 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0B9543404B9;
	Mon, 24 Mar 2025 14:06:23 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 00019E40AE6; Mon, 24 Mar 2025 14:05:52 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Xinyu Zhang <xizhang@purestorage.com>,
	linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 3/3] nvme/ioctl: move fixed buffer lookup to nvme_uring_cmd_io()
Date: Mon, 24 Mar 2025 14:05:40 -0600
Message-ID: <20250324200540.910962-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250324200540.910962-1-csander@purestorage.com>
References: <20250324200540.910962-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_130625_101327_5B3B2963 
X-CRM114-Status: GOOD (  23.19  )
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

nvme_map_user_request() is called from both nvme_submit_user_cmd() and
nvme_uring_cmd_io(). But the ioucmd branch is only applicable to
nvme_uring_cmd_io(). Move it to nvme_uring_cmd_io() and just pass the
resulting iov_iter to nvme_map_user_request().

For NVMe passthru operations with fixed buffers, the fixed buffer lookup
happens in io_uring_cmd_import_fixed(). But nvme_uring_cmd_io() can
return -EAGAIN first from nvme_alloc_user_request() if all tags in the
tag set are in use. This ordering difference is observable when using
UBLK_U_IO_{,UN}REGISTER_IO_BUF SQEs to modify the fixed buffer table. If
the NVMe passthru operation is followed by UBLK_U_IO_UNREGISTER_IO_BUF
to unregister the fixed buffer and the NVMe passthru goes async, the
fixed buffer lookup will fail because it happens after the unregister.

Userspace should not depend on the order in which io_uring issues SQEs
submitted in parallel, but it may try submitting the SQEs together and
fall back on a slow path if the fixed buffer lookup fails. To make the
fast path more likely, do the import before nvme_alloc_user_request().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/ioctl.c | 45 +++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index f6576e7201c5..da0eee21ecd0 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -112,12 +112,11 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 	return req;
 }
 
 static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
-		struct io_uring_cmd *ioucmd, unsigned int flags,
-		unsigned int iou_issue_flags)
+		struct iov_iter *iter, unsigned int flags)
 {
 	struct request_queue *q = req->q;
 	struct nvme_ns *ns = q->queuedata;
 	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
 	bool supports_metadata = bdev && blk_get_integrity(bdev->bd_disk);
@@ -135,28 +134,16 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		if (!nvme_ctrl_meta_sgl_supported(ctrl))
 			dev_warn_once(ctrl->device,
 				      "using unchecked metadata buffer\n");
 	}
 
-	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
-		struct iov_iter iter;
-
-		/* fixedbufs is only for non-vectored io */
-		if (flags & NVME_IOCTL_VEC)
-			return -EINVAL;
-
-		ret = io_uring_cmd_import_fixed(ubuffer, bufflen,
-				rq_data_dir(req), &iter, ioucmd,
-				iou_issue_flags);
-		if (ret < 0)
-			return ret;
-		ret = blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
-	} else {
+	if (iter)
+		ret = blk_rq_map_user_iov(q, req, NULL, iter, GFP_KERNEL);
+	else
 		ret = blk_rq_map_user_io(req, NULL, nvme_to_user_ptr(ubuffer),
 				bufflen, GFP_KERNEL, flags & NVME_IOCTL_VEC, 0,
 				0, rq_data_dir(req));
-	}
 
 	if (ret)
 		return ret;
 
 	bio = req->bio;
@@ -194,11 +181,11 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		return PTR_ERR(req);
 
 	req->timeout = timeout;
 	if (ubuffer && bufflen) {
 		ret = nvme_map_user_request(req, ubuffer, bufflen, meta_buffer,
-				meta_len, NULL, flags, 0);
+				meta_len, NULL, flags);
 		if (ret)
 			goto out_free_req;
 	}
 
 	bio = req->bio;
@@ -465,10 +452,12 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
 	const struct nvme_uring_cmd *cmd = io_uring_sqe_cmd(ioucmd->sqe);
 	struct request_queue *q = ns ? ns->queue : ctrl->admin_q;
 	struct nvme_uring_data d;
 	struct nvme_command c;
+	struct iov_iter iter;
+	struct iov_iter *map_iter = NULL;
 	struct request *req;
 	blk_opf_t rq_flags = REQ_ALLOC_CACHE;
 	blk_mq_req_flags_t blk_flags = 0;
 	int ret;
 
@@ -500,10 +489,24 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	d.addr = READ_ONCE(cmd->addr);
 	d.data_len = READ_ONCE(cmd->data_len);
 	d.metadata_len = READ_ONCE(cmd->metadata_len);
 	d.timeout_ms = READ_ONCE(cmd->timeout_ms);
 
+	if (d.data_len && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
+		/* fixedbufs is only for non-vectored io */
+		if (vec)
+			return -EINVAL;
+
+		ret = io_uring_cmd_import_fixed(d.addr, d.data_len,
+			nvme_is_write(&c) ? WRITE : READ, &iter, ioucmd,
+			issue_flags);
+		if (ret < 0)
+			return ret;
+
+		map_iter = &iter;
+	}
+
 	if (issue_flags & IO_URING_F_NONBLOCK) {
 		rq_flags |= REQ_NOWAIT;
 		blk_flags = BLK_MQ_REQ_NOWAIT;
 	}
 	if (issue_flags & IO_URING_F_IOPOLL)
@@ -513,13 +516,13 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
 
 	if (d.data_len) {
-		ret = nvme_map_user_request(req, d.addr,
-			d.data_len, nvme_to_user_ptr(d.metadata),
-			d.metadata_len, ioucmd, vec, issue_flags);
+		ret = nvme_map_user_request(req, d.addr, d.data_len,
+			nvme_to_user_ptr(d.metadata), d.metadata_len,
+			map_iter, vec);
 		if (ret)
 			goto out_free_req;
 	}
 
 	/* to free bio on completion, as req->bio will be null at that time */
-- 
2.45.2


