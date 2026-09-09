Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1989C88E40
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 22:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l/XCD1uvPOJyUiPbDDQ58GyUdQGYRiCCBtvMcX3nnGY=; b=l9eIeJcBxwyRyV9xXnnOYLac8z
	jmAptUmD/fK04L7Eed5tAUU+PYI9xfGi8cRBVbeWGtw1heAg20QM50B0EQImIZ/0pIHmpZ9osk3qM
	NmZoAhKwofTzGm7Bg+g6X3E3JaHfd/wWz+U8cBgVu9D25oO5BNgq5Dv+7iMFkKY0Obe5ZF59q8kCa
	CLNFr21q9785wMvJCCninibvmjlwBciFHDN1hkx7/P8d85L4lu4mkPiqoiGYtUGgXHyl5sBxN9FUT
	pnqBmqsH0tzzhuacYEbmhQ0prZF2JBq/TlSktlXUVWPgo3J/olrD71bFcVe7DOxnlHKDcvUze2waw
	TW3n18Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Qmz-0000000D0lr-2pLE;
	Wed, 09 Sep 2026 22:29:09 +0000
Received: from mail-pl1-x662.google.com ([2607:f8b0:4864:20::662])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Qmv-0000000D0jJ-0840
	for linux-nvme@lists.infradead.org;
	Wed, 09 Sep 2026 22:29:07 +0000
Received: by mail-pl1-x662.google.com with SMTP id d9443c01a7336-2d6f9d13f50so1471905ad.2
        for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2026 15:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788992944; x=1789597744; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l/XCD1uvPOJyUiPbDDQ58GyUdQGYRiCCBtvMcX3nnGY=;
        b=FXeHdZrsmIi8LXCZOq7NvLG1V+b+CyBAOJVNqFbeD9h2ISSYMmh0KfFwBR0B34Q+/i
         fLtgsxwzLoG7hPpmzbjRxhS2GJBSde2CNcMuifv4yvXd6Hy0aqeoTX7ahL1CuurCItdC
         KJAXp/sVKi9xMxxVbLtzhS1GpJqIxsKPTC+A8sEG5RL7HuuKSBwljFnxhwEVF+9KlA5I
         ypTTMhPHXesfkLgT6tjFQHSYBNHYMz97X/Vjrxn2q7eXm2LQPKKuuylDal+ch7V+vIjF
         6y+2yFjZdZrrO5MatFvIjW7/trzhCVZnDvrkrfMIH6vaNowW/0XHpClThbLNHyf5hePy
         eDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992944; x=1789597744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l/XCD1uvPOJyUiPbDDQ58GyUdQGYRiCCBtvMcX3nnGY=;
        b=cfORd8jsFuLTJk4vW5f2Ag4woKX0v0Bfc1CJ3tOhj/RqCYjNxcrmUseMbl2yjobnQZ
         pohA7ghQLArVwmY4iZ78y714GrZ2VyRZQcn1SW6tFfC5GVRFVZ1HInz2GFJugxsBSbJ0
         uSlW99cSIerK5p5QWeW+BSEyGL1VAcRAso24n93z4tUyZZLmLQSAXrTLEgKng4NmVjjU
         gjKfrF2bdCjUCxUYTUeobcGmL5WcBJBkYIgYfWAkw1tftYC591MSSu497t81nR73aZvO
         2SyAt9EUFhC097Gvr1j5eHnTIVtyzo0QxT89f3f/sP1TizzYQhUurQJn3mxc+ZlyQMB0
         fWPQ==
X-Forwarded-Encrypted: i=1; AKwUvBzu25UMPX/E7CTOWsGcO7BMBvBsQdUqKtDloaJNFs+nCNRO0bQu70CR68wdHm8b2T5M44SHldWQBN4C@lists.infradead.org
X-Gm-Message-State: AFuF++llXMGQL5ZpfEP2jHlSYQZTn+iPXFx8ut4HA2qWT8gwFo6mG1XS
	vT5aV7RhlmyfjQmqeBqrphFSOplN4i3vfjgDFz9jlgT4WCJ4UZVwQNO/cXn71IuS/5D/zqn8hIV
	xDlfJMS8jBl/lHt9eX6lmnqFgUXSiQayQfP5Y
X-Gm-Gg: AYBFou0uQ/GA0GwsbTCEZD+PmmVBVCL/iQCaYcSyT8DZWmAlKcYlgUbNkmebVK42Pr4
	vxM5pauo5rs/aPWYPa1BKf7f4Vow51cvIRl6pI0KpU1caDejXSMTkcO2ZiKIb2/T+0El4Fyksug
	A37yz6iWuSZsPJdq6dFIkZRcfGqLJlDKqM+Pz+0ls4O8efNenTLPWX9nHzYwH4RfvFmAvFg6S+4
	+5PvvxoJ9yjrC1psHaOCVElzPcMN36uqThCr1hIQKCslWPoJvkPnODTTm7vspm4+vzER/9SgMEd
	FuMBwuKe2L4FjNjVR+A4haI/4WrFdRCLNxWWGyMSy2kIIlkob/Ra67r+6vBfE8E+8ZUlQOI9w6N
	l45Ft/FIrTAhXiUIFfTBbf2Aupyhi+o3/
X-Received: by 2002:a17:90b:4c03:b0:398:bac7:72d0 with SMTP id 98e67ed59e1d1-39b3d86acf2mr28286214a91.5.1788992944093;
        Wed, 09 Sep 2026 15:29:04 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39d77406179sm490126a91.5.2026.09.09.15.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:29:04 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 6EFA1401CC;
	Wed,  9 Sep 2026 16:29:03 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 6C2CBE40322; Wed,  9 Sep 2026 16:29:03 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 4/6] nvme/ioctl: pass iov_iter to nvme_map_user_request()
Date: Wed,  9 Sep 2026 16:28:34 -0600
Message-ID: <20260909222836.2475352-5-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909222836.2475352-1-csander@purestorage.com>
References: <20260909222836.2475352-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_152905_077881_FD7F9E1A 
X-CRM114-Status: GOOD (  16.95  )
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

To allow nvme_map_user_request() to accept an io_uring registered buffer
(represented as a ITER_BVEC iov_iter) for the metadata buffer, pass it
as an iov_iter argument. Move the conversions from user address-length
pairs into iov_iters to the callers. A NULL iov_iter pointer represents
no metadata buffer.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/ioctl.c | 46 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index e69c49c334a0..8e722184ecf1 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -152,21 +152,20 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 	nvme_req(req)->flags |= NVME_REQ_USERCMD;
 	return req;
 }
 
 static int nvme_map_user_request(struct request *req, u64 ubuffer,
-		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
-		struct iov_iter *iter, unsigned int flags)
+		unsigned bufflen, struct iov_iter *iter,
+		struct iov_iter *meta_iter, unsigned int flags)
 {
 	struct request_queue *q = req->q;
 	struct nvme_ns *ns = q->queuedata;
 	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
 	bool supports_metadata = bdev && blk_get_integrity(bdev->bd_disk);
-	bool has_metadata = meta_buffer && meta_len;
 	int ret;
 
-	if (has_metadata && !supports_metadata)
+	if (meta_iter && !supports_metadata)
 		return -EINVAL;
 
 	if (iter)
 		ret = blk_rq_map_user_iov(q, req, NULL, iter, GFP_KERNEL);
 	else
@@ -174,16 +173,12 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 				bufflen, GFP_KERNEL, flags & NVME_IOCTL_VEC, 0,
 				0, rq_data_dir(req));
 	if (ret)
 		return ret;
 
-	if (has_metadata) {
-		struct iov_iter meta_iter;
-
-		iov_iter_ubuf(&meta_iter, rq_data_dir(req), meta_buffer,
-			      meta_len);
-		ret = blk_rq_integrity_map_user(req, &meta_iter);
+	if (meta_iter) {
+		ret = blk_rq_integrity_map_user(req, meta_iter);
 		if (ret)
 			goto out_unmap;
 	}
 
 	return ret;
@@ -210,12 +205,20 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
 	req->timeout = timeout;
 	if (ubuffer && bufflen) {
-		ret = nvme_map_user_request(req, ubuffer, bufflen, meta_buffer,
-				meta_len, NULL, flags);
+		struct iov_iter meta_iter;
+		struct iov_iter *map_meta_iter = NULL;
+
+		if (meta_buffer && meta_len) {
+			iov_iter_ubuf(&meta_iter, rq_data_dir(req), meta_buffer,
+				      meta_len);
+			map_meta_iter = &meta_iter;
+		}
+		ret = nvme_map_user_request(req, ubuffer, bufflen, NULL,
+					    map_meta_iter, flags);
 		if (ret)
 			goto out_free_req;
 	}
 
 	bio = req->bio;
@@ -480,18 +483,19 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	const struct nvme_uring_cmd *cmd = io_uring_sqe128_cmd(ioucmd->sqe,
 							       struct nvme_uring_cmd);
 	struct request_queue *q = ns ? ns->queue : ctrl->admin_q;
 	bool open_for_write = ioucmd->file->f_mode & FMODE_WRITE;
 	struct nvme_command c;
-	struct iov_iter iter;
-	struct iov_iter *map_iter = NULL;
+	struct iov_iter iter, meta_iter;
+	struct iov_iter *map_iter = NULL, *map_meta_iter = NULL;
 	struct request *req;
 	blk_opf_t rq_flags = 0;
 	blk_mq_req_flags_t blk_flags = 0;
 	u32 metadata_len, data_len;
 	u64 metadata, addr;
 	u32 timeout_ms;
+	int ddir;
 	int ret;
 
 	c.common.opcode = READ_ONCE(cmd->opcode);
 	c.common.flags = READ_ONCE(cmd->flags);
 	if (c.common.flags)
@@ -520,13 +524,12 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	addr = READ_ONCE(cmd->addr);
 	data_len = READ_ONCE(cmd->data_len);
 	metadata_len = READ_ONCE(cmd->metadata_len);
 	timeout_ms = READ_ONCE(cmd->timeout_ms);
 
+	ddir = nvme_is_write(&c) ? WRITE : READ;
 	if (data_len && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
-		int ddir = nvme_is_write(&c) ? WRITE : READ;
-
 		if (vec)
 			ret = io_uring_cmd_import_fixed_vec(ioucmd,
 					u64_to_user_ptr(addr), data_len,
 					ddir, &iter, issue_flags);
 		else
@@ -535,10 +538,15 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		if (ret < 0)
 			return ret;
 
 		map_iter = &iter;
 	}
+	if (data_len && metadata && metadata_len) {
+		iov_iter_ubuf(&meta_iter, ddir, nvme_to_user_ptr(metadata),
+			      metadata_len);
+		map_meta_iter = &meta_iter;
+	}
 
 	if (issue_flags & IO_URING_F_NONBLOCK) {
 		rq_flags |= REQ_NOWAIT;
 		blk_flags = BLK_MQ_REQ_NOWAIT;
 	}
@@ -549,13 +557,13 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	req->timeout = timeout_ms ? msecs_to_jiffies(timeout_ms) : 0;
 
 	if (data_len) {
-		ret = nvme_map_user_request(req, addr, data_len,
-			nvme_to_user_ptr(metadata), metadata_len,
-			map_iter, vec ? NVME_IOCTL_VEC : 0);
+		ret = nvme_map_user_request(req, addr, data_len, map_iter,
+					    map_meta_iter,
+					    vec ? NVME_IOCTL_VEC : 0);
 		if (ret)
 			goto out_free_req;
 	}
 
 	/* to free bio on completion, as req->bio will be null at that time */
-- 
2.55.0


