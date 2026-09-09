Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0F9C79FB6
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 22:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tubVMf7ZqCGq+soHl3bfDL6vCCu/4h0yxEEMGvUD99M=; b=KT/OhACSKPN0EnhFV8yeKI+xgH
	+w8t1FCDXDwFt/WH9cHV5hdd42fkH1MiTPBLqqObnNuwu2wvaIBNpdYw1sGrmyzes7i//LJzYiXkr
	jRhKR/qN3hgwkdeK+WrvK506dZ9c94h305dQ9eQm6UZVfUArvJSeigWkhy+1sVNqtQUwwzgmr1CSU
	FJC8WXGFaAa2ZUwoM6pxeiXM2MmxOj0AMuKb4Ge+l5ie06wpduC7qnahnyeyRdZge/veVcWJy+AUw
	tk4AxdLQVFfC0TSr3lLuLT7vLx2QFtSmKfWsZ4Kr0Mn9Vt6YNddlvrMo2E2/kp2mJG34ebsKvu/Js
	4CnZLUTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Qmy-0000000D0ku-1QCg;
	Wed, 09 Sep 2026 22:29:08 +0000
Received: from mail-pj1-x1064.google.com ([2607:f8b0:4864:20::1064])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Qmu-0000000D0jI-3t9Q
	for linux-nvme@lists.infradead.org;
	Wed, 09 Sep 2026 22:29:06 +0000
Received: by mail-pj1-x1064.google.com with SMTP id 98e67ed59e1d1-384c94c9423so187663a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2026 15:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788992944; x=1789597744; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tubVMf7ZqCGq+soHl3bfDL6vCCu/4h0yxEEMGvUD99M=;
        b=UZ9SiTSZbLwgShpjC6gzDVlB2FuQor0LkEhiBaBuSrj5UgNgl6HrbWInrRv/EVDBoS
         bruB+Yvh87iaczf48GNRttytXlxWgzCkrf2jcMFsNObbBrplEMoql3L/30DSW4ce2nlk
         wDJf4d6YRqjPzww4vVwZyJlhxCAVlhuhEelQCt2WJcgKohIIseQlKREq6evuKz8rONRO
         qzkiWv7703fAsyFAdzSGQcPS9JV+THA0OEhquheBR94GvYplWfXEr8A0RY74sqvLcZLv
         /PR52TE0I7WB6jXqcdfkH+FsxXmkk3uMYlzSVqQ8b+vnM8ZRSWzhPOdtTMFFSR1oPGSj
         AclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992944; x=1789597744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tubVMf7ZqCGq+soHl3bfDL6vCCu/4h0yxEEMGvUD99M=;
        b=qrILa27enNmQBchsyM6qJm5J0AIROtN0QX60SnjNoHyfsc/dwhu9JQHUGIzChcrRti
         5DDtG+1BbYAdBZwHy1l7vpdMGj3NpYju1mlBNyofzjl0gEswQSCG0iX3gCtw7FD6IH1L
         NPsjWfIjFkQpqkrOmGOJjzgdxMDCAYsdTtNa/ezZO5J1NodL5tYXRWQ1oj9wO3IrWx+m
         0Sjoq3Pk1QPFINEs+xKGeeXr7NDE9IvVMevkFrpshu02Lcz6j5mgWvh7YtY2H4E3X63Q
         90RaaO/68KAmNx13Zv82huU51RhjmgT7eRSZNwPq9kBjByksBWgru5RTdQubxgb7pU1h
         BLHw==
X-Forwarded-Encrypted: i=1; AKwUvBwABHE/SDaWouqfFzefkw46WBXMOlVjE7Jxmjx+f446W1VN1zFW16EubN0yXXdhzRIoqa7PZ1wD8wqB@lists.infradead.org
X-Gm-Message-State: AFuF++mQwMFmQcjqfQG5ZdGLAMPsLhrz25tkUngyiTdeceqjmK11Ms5x
	Z6QRmD50+ogxa6pnuPsVbCLbfgxuZXfn55hmCvdAbcnMPob5hd+DuHN+fsW6tBDwWZeGHw38xWG
	43E/QCOFHixeXT4aWJpCXBrr6ZxJueJ10/5+N1vExAbj2hUD3NeYU
X-Gm-Gg: AYBFou0MHGQYvFVcO/s+3gM3690j/8ySmbM6AOxpU3bhKChXYc3V5pCRzHiR1efSc+V
	jVovJAbS2A3C6mFYtgt6sC4h3ZHT6t9xnOlgizXjtz3StpukEK6MElYQeszNSW43sFpXX5hkIzY
	eeZzAULaXsAG/teV93Q/34cqes49A9mcyyQnZN6oVSVDZUOCBNlL0uL/xchBR23fSWZRA+6AUKM
	X+2HxNYw+fibxzG5oTF88NtcQxgYRkQMCalmdQVQj8ShQoh15rR/m/OMyIcaEez4ultwUJu79Fs
	wtMkpnjmLM0vX4Zhe6GSlyjwoD4xWXImKpt9Ue8ocZCFRj5gQPJG4e/8RWl3i/7GC8o48Tv1Z30
	WQ+wzF6voKMqzL2qWrQ==
X-Received: by 2002:a17:90b:3a48:b0:38e:480b:99a5 with SMTP id 98e67ed59e1d1-39b3d5e53d5mr26180113a91.2.1788992943993;
        Wed, 09 Sep 2026 15:29:03 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39cd207d69csm504304a91.3.2026.09.09.15.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:29:03 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 2CF4E402B4;
	Wed,  9 Sep 2026 16:29:03 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2A37BE40322; Wed,  9 Sep 2026 16:29:03 -0600 (MDT)
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
Subject: [PATCH 2/6] nvme/ioctl: remove struct nvme_uring_data
Date: Wed,  9 Sep 2026 16:28:32 -0600
Message-ID: <20260909222836.2475352-3-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909222836.2475352-1-csander@purestorage.com>
References: <20260909222836.2475352-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_152904_973634_B50E132F 
X-CRM114-Status: GOOD (  15.24  )
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

This struct is only used once as a local variable type. Make the fields
separate local variables and remove the struct type to shave some lines.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/ioctl.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 3aa5d2f2dfbb..748a4cbf7e90 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -406,18 +406,10 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	}
 
 	return status;
 }
 
-struct nvme_uring_data {
-	__u64	metadata;
-	__u64	addr;
-	__u32	data_len;
-	__u32	metadata_len;
-	__u32	timeout_ms;
-};
-
 /*
  * This overlays struct io_uring_cmd pdu.
  * Expect build errors if this grows larger than that.
  */
 struct nvme_uring_cmd_pdu {
@@ -483,17 +475,19 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
 	const struct nvme_uring_cmd *cmd = io_uring_sqe128_cmd(ioucmd->sqe,
 							       struct nvme_uring_cmd);
 	struct request_queue *q = ns ? ns->queue : ctrl->admin_q;
 	bool open_for_write = ioucmd->file->f_mode & FMODE_WRITE;
-	struct nvme_uring_data d;
 	struct nvme_command c;
 	struct iov_iter iter;
 	struct iov_iter *map_iter = NULL;
 	struct request *req;
 	blk_opf_t rq_flags = 0;
 	blk_mq_req_flags_t blk_flags = 0;
+	u32 metadata_len, data_len;
+	u64 metadata, addr;
+	u32 timeout_ms;
 	int ret;
 
 	c.common.opcode = READ_ONCE(cmd->opcode);
 	c.common.flags = READ_ONCE(cmd->flags);
 	if (c.common.flags)
@@ -516,25 +510,25 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw15 = cpu_to_le32(READ_ONCE(cmd->cdw15));
 
 	if (!nvme_cmd_allowed(ctrl, ns, &c, 0, open_for_write))
 		return -EACCES;
 
-	d.metadata = READ_ONCE(cmd->metadata);
-	d.addr = READ_ONCE(cmd->addr);
-	d.data_len = READ_ONCE(cmd->data_len);
-	d.metadata_len = READ_ONCE(cmd->metadata_len);
-	d.timeout_ms = READ_ONCE(cmd->timeout_ms);
+	metadata = READ_ONCE(cmd->metadata);
+	addr = READ_ONCE(cmd->addr);
+	data_len = READ_ONCE(cmd->data_len);
+	metadata_len = READ_ONCE(cmd->metadata_len);
+	timeout_ms = READ_ONCE(cmd->timeout_ms);
 
-	if (d.data_len && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
+	if (data_len && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		int ddir = nvme_is_write(&c) ? WRITE : READ;
 
 		if (vec)
 			ret = io_uring_cmd_import_fixed_vec(ioucmd,
-					u64_to_user_ptr(d.addr), d.data_len,
+					u64_to_user_ptr(addr), data_len,
 					ddir, &iter, issue_flags);
 		else
-			ret = io_uring_cmd_import_fixed(d.addr, d.data_len,
+			ret = io_uring_cmd_import_fixed(addr, data_len,
 					ddir, &iter, ioucmd, issue_flags);
 		if (ret < 0)
 			return ret;
 
 		map_iter = &iter;
@@ -548,15 +542,15 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		rq_flags |= REQ_POLLED;
 
 	req = nvme_alloc_user_request(q, &c, rq_flags, blk_flags);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
-	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
+	req->timeout = timeout_ms ? msecs_to_jiffies(timeout_ms) : 0;
 
-	if (d.data_len) {
-		ret = nvme_map_user_request(req, d.addr, d.data_len,
-			nvme_to_user_ptr(d.metadata), d.metadata_len,
+	if (data_len) {
+		ret = nvme_map_user_request(req, addr, data_len,
+			nvme_to_user_ptr(metadata), metadata_len,
 			map_iter, vec ? NVME_IOCTL_VEC : 0);
 		if (ret)
 			goto out_free_req;
 	}
 
-- 
2.55.0


