Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C76FC36016
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 15:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rvZNgJEOLv7vlUnMHFowwsJc7mv9fgxFUo+rGJDtCw4=; b=ak8/npFiIwUEt4VJyHpZ1WUEVx
	je70/lLavhrBYyHv87jJpnCzMFxvIVKi36VageuIHH1LZoUvzUjYzjJaLjpknzdkKNZYy4L+811sV
	GBkhlbupgcmunzJNVaBkQ8G2oafsXR7ivZtFY+SZf5qPgUidecgPssaAfbQbnTtFdD9FjhSpcx0pP
	xfbFPOKnvIgRPf4E7vx3iUcCG0z5xhJWo7xElIGgb1lQOaLlIt10DQr+5bEViPiuS0075G8raRWxf
	QFC8o62zCptzyA1RqDHAtTBSzSl987q+IIrcEepZzxzu5h/gG7dTQLUYoAR00bPZnj12Q7wYt9RtJ
	2agf4kuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyC2P-0000000DpJ5-1PDD;
	Fri, 28 Mar 2025 15:54:29 +0000
Received: from mail-io1-xd63.google.com ([2607:f8b0:4864:20::d63])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyBvx-0000000DoLb-3cBs
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 15:47:51 +0000
Received: by mail-io1-xd63.google.com with SMTP id ca18e2360f4ac-85b418faf5cso9756239f.3
        for <linux-nvme@lists.infradead.org>; Fri, 28 Mar 2025 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743176869; x=1743781669; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvZNgJEOLv7vlUnMHFowwsJc7mv9fgxFUo+rGJDtCw4=;
        b=TKRips4yGKshyYanLZvETa9CSGHMSWONtC59YtrauYlTtzV564LNnlbeVVOOUqM9Ja
         p7A6a5qvGisHBK0woEolnnHImIFyYwH1YBP8XGFbxZsRRLK+hgALAeiBF/7sURc3TpF0
         rdCRM7Lq4ZV8Im3WuyoakaHzVUc7eJIYCWC6Rl9V+mxI04cHlgxZdhRYUMKqr6lgw8iP
         Xcm419U2MUFIKS6VF/JIZOwp7pfLhGrPlrd89rikE74K2ZO2hFYm9/g9OIjj1FgPucr2
         DvZjXSxRGdsBfV1iaJ/tdwMYtaVWGxYdKJtFtJ+AbDwgjNU+7DvouDEO7XYVojxZTSAi
         6CpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743176869; x=1743781669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvZNgJEOLv7vlUnMHFowwsJc7mv9fgxFUo+rGJDtCw4=;
        b=beU3jPuVAutnrYEtwNmEG0Em2LTp2BOdQ4uLkwNOkfwJHZw9HmTk0claselPJZIxSi
         a6gnwJYNDxwDhHEkCleMsfYAvor2lZAFoFz47YFc2YNGGXnhW+jJzo8tGUCnffvb7bgl
         RiIVAL0olLT+V6jUyCareuZoouV3cdtZMy9acULZT3sFRwlD+tErBwBOOmu+IHNH/w6f
         2fFnbl+Nkod1efu+ZN5gq9vjQijwGqlLThx0NgdYRIP/vE1VuR+wLFRM8bKl5LlXm38T
         FwkpyD9uhLIH9HGkOCG66WZ5+SYEmrCZl/3meyaISxDDIM8fI6MnDzLSoMnZSYkowVj1
         exMw==
X-Forwarded-Encrypted: i=1; AJvYcCWvvdza4IbJEbp6B/4cfH4IXhZA/yaArXGw9l40JBTjorgGhGcfL89FEaVEbEDEoIfb4TeRdNKVARJ2@lists.infradead.org
X-Gm-Message-State: AOJu0YyE7AZut8DqGDyq88vVfPc3W3LrndsN+XUczRYOpt8OWktQXGva
	RgJUD7wU4VW/Bl+7FnfEVZhA7FSY5aX0sQzyvcJG6gEeDNkCyRxVdqTL3RgtKTDIsyneyQGAl/M
	cwI63BsXlOIKB7mQoiyeq5qbQ07OER1Qc
X-Gm-Gg: ASbGncswuQJBX9lKSUoLw1PPUrM8xMzhh77JvlIExoRzlRYELWS4htnlPjRAqWTztxE
	gIlDSXLlQvS521T/nFcpEIahCrmL3G/OwuK5FwxkfIKiNmoes/g5EHzdD4RLrmbgkUtzUq3B8Ir
	FEDOfabWY6uUfvlaOLVE98df6QKFKXpNTMw5VQTJD8OCQKWcz9iqwpHYsT5a2wL5Q9CloTFcIbJ
	OzXjv7cPdVTOe2nutSU/1nKiUxMSxCvDGoFI945XnJ5jWqZQ+MF9+RwVvSj1mCbcPcAC4XsbZ9M
	87eaFx8F5ArY0kpHo8GCqgMrl7fZLRsAYpkBIGmTdwU3ODDX
X-Google-Smtp-Source: AGHT+IHZyp/hTQTgBPdjdI/PAGSVR+TwdInUQ4bs/fMWlLnjp1ni0mf8CfgyGlPr5zMbfOYKigzJ9+sGNsfR
X-Received: by 2002:a05:6602:1691:b0:855:d60d:1104 with SMTP id ca18e2360f4ac-85e83cee041mr242544339f.2.1743176868650;
        Fri, 28 Mar 2025 08:47:48 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-85e900121a8sm23348939f.11.2025.03.28.08.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 08:47:48 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9515D34018F;
	Fri, 28 Mar 2025 09:47:47 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 912C3E40A9F; Fri, 28 Mar 2025 09:47:17 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 3/3] nvme/ioctl: move fixed buffer lookup to nvme_uring_cmd_io()
Date: Fri, 28 Mar 2025 09:46:47 -0600
Message-ID: <20250328154647.2590171-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250328154647.2590171-1-csander@purestorage.com>
References: <20250328154647.2590171-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250328_084749_899541_14745C76 
X-CRM114-Status: GOOD (  23.30  )
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
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/ioctl.c | 45 +++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 42dfd29ed39e..400c3df0e58f 100644
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
@@ -467,10 +454,12 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
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
 
@@ -502,10 +491,24 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
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
@@ -515,13 +518,13 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
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


