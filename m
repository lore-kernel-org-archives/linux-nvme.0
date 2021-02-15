Return-Path: <SRS0=Cnjr=HR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B61C433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 13:06:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A12614A7
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 13:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A12614A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DjMVyzs5fHfk0K37CAEyLa11mdDvzUzi6gJ4ixdOmJU=; b=qtgJqr4bZBEQDTDSTIejGRoG8s
	mZ1FI2MbXlfj6IE+7ekR4prZfGmKsCk3MghtrhTVzSIE9VdsIMYyzNh2dp+h4FOMbaYlIWEK7AG+5
	kZbZBNOYFlh5luG/64rdbFm4UvYSdsykPNcpIgya3tXeXp2dD9U1jBuxNrEOmzCLhADBc3c/uFbwF
	xwBqCuvcbnUm7PDmnwGPQR4owAC81TftDomcIaconLkqnZqYgQ2F7l6MAfxQ15MLsAFchA79kqUVM
	GBAbWVNlV8x6ynPmzmyB/x4Nk8LAgvHfKDs53/qqQFWSlRJnJ75nU6A0qbyze4Y1IW5rhwPggQF9+
	ur76/lNA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBdZn-0006hy-Pw; Mon, 15 Feb 2021 13:06:07 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBdZk-0006fl-JU
 for linux-nvme@lists.infradead.org; Mon, 15 Feb 2021 13:06:05 +0000
Received: by mail-pf1-x42b.google.com with SMTP id b145so4156581pfb.4
 for <linux-nvme@lists.infradead.org>; Mon, 15 Feb 2021 05:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9N5ExewkUvque785U6FgAfqht4C9ooYfjyRxAMk7LA8=;
 b=agfd2oot+cSYVwYQTbtzyxhUMCvAU4PovEWyZKMztMe9hNdU1Vk/4xIt6I0bfQx2dO
 vcza8sSue6TxbTYJBJon9igP66/nP4AhUjbe2UvRRYIXfwqUPLfVdJvfBYJCf0WRVSVU
 qDz3hYgYowTJAMgE1BHsFPFq5ZT5kQLAvX2+vyW5KrG1GF7czhNT6YV7W0xUt6OBtYKb
 lEELDCc0pqP8lCc1bGYekU/GtBv8glm9Ku799GJZzAlvsnHJwqwbUXC2HPUdl24Lp1It
 hpYSfI2CGE1Mggp3N70H6t/RHOCSGbcNYb49iOC4OwRUGDUA8CFFwG2BRbh5vSqzgMyp
 d+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9N5ExewkUvque785U6FgAfqht4C9ooYfjyRxAMk7LA8=;
 b=N09mBN2iwm7Z2DIrDfqv2Ml8vgQrvkU45+1xtwRSV4lwoT8XYn1YFCInKiAZMy2wU+
 /4PCgwkTxczK5c+gtHTWAqcYlBzYlnLaQJWnPxSKlv9UWLXuDRRRY0vGVL7GCLiyqNYt
 s6Zl+3vKMKTXOKH562ld7GZEhoxtxinR3NF80+m6lGUpcAxbfePvZBGJqOCkcyul4g1Y
 jE16ed6qomX9QF2lYUbJUKOBMzkFihpVo5fnQZGsFIxyQzcBFomsF3iAY43oCKT+fIx4
 OwzKRAM6u2BK8zVeSWxh3WI8d965T3ZtC9eehU+84reIrgnXE1lPgHN+xhy5wzsqQw3/
 MqMw==
X-Gm-Message-State: AOAM533+uzTAp1wNBKUqIA2kEvOdsHQ/fXDaSgZJoLraxrLdp6bcUtQa
 EjAFxUfcrpY+pqR8Jnj2WzLpsuG307iHmQ==
X-Google-Smtp-Source: ABdhPJycyPa/JIFQOzyqFqADD59owWvS0Ko3LEnq4JvXqKiB4g7x66knmvcGuZz/Qg5drXI0ng/PRQ==
X-Received: by 2002:a62:528c:0:b029:19e:4a39:d9ea with SMTP id
 g134-20020a62528c0000b029019e4a39d9eamr15510756pfb.20.1613394362258; 
 Mon, 15 Feb 2021 05:06:02 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id q13sm11334490pfg.155.2021.02.15.05.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Feb 2021 05:06:02 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme: retry command if driver control flag given for
 passthru
Date: Mon, 15 Feb 2021 22:05:53 +0900
Message-Id: <20210215130554.32387-2-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210215130554.32387-1-minwoo.im.dev@gmail.com>
References: <20210215130554.32387-1-minwoo.im.dev@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210215_080604_667031_0F2C507A 
X-CRM114-Status: GOOD (  15.97  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

ioctl passthru commands are REQ_FAILFAST_DRIVER requests which are
non-retry requests if failed.  This patch introduced `driver_ctrl` flag
to the ioctl command structure: nvme_passthru_cmd, nvme_passthru_cmd64.
`driver_ctrl` field has not been appended, but replaced existing
reserved field.

Clear the REQ_FAILFASTER_DRIVER flag from the request if `driver_ctrl`
is given with NVME_DRIVER_CTRL_RETRY set to make it retry-able if failed
without DNR.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c        | 12 ++++++++----
 include/uapi/linux/nvme_ioctl.h | 15 +++++++++++----
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d77f3f26d8d3..20cd4a815944 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1143,7 +1143,7 @@ EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
 static int nvme_submit_user_cmd(struct request_queue *q,
 		struct nvme_command *cmd, void __user *ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
-		u32 meta_seed, u64 *result, unsigned timeout)
+		u32 meta_seed, u64 *result, unsigned timeout, u16 driver_ctrl)
 {
 	bool write = nvme_is_write(cmd);
 	struct nvme_ns *ns = q->queuedata;
@@ -1157,6 +1157,9 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
+	if (driver_ctrl & NVME_DRIVER_CTRL_RETRY)
+		req->cmd_flags &= ~REQ_FAILFAST_DRIVER;
+
 	if (timeout)
 		req->timeout = timeout;
 	nvme_req(req)->flags |= NVME_REQ_USERCMD;
@@ -1615,7 +1618,8 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 
 	return nvme_submit_user_cmd(ns->queue, &c,
 			nvme_to_user_ptr(io.addr), length,
-			metadata, meta_len, lower_32_bits(io.slba), NULL, 0);
+			metadata, meta_len, lower_32_bits(io.slba), NULL, 0,
+			io.driver_ctrl);
 }
 
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
@@ -1653,7 +1657,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			nvme_to_user_ptr(cmd.addr), cmd.data_len,
 			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
-			0, &result, timeout);
+			0, &result, timeout, cmd.driver_ctrl);
 
 	if (status >= 0) {
 		if (put_user(result, &ucmd->result))
@@ -1697,7 +1701,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			nvme_to_user_ptr(cmd.addr), cmd.data_len,
 			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
-			0, &cmd.result, timeout);
+			0, &cmd.result, timeout, cmd.driver_ctrl);
 
 	if (status >= 0) {
 		if (put_user(cmd.result, &ucmd->result))
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index d99b5a772698..b247b3eee2e3 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -14,7 +14,7 @@ struct nvme_user_io {
 	__u8	flags;
 	__u16	control;
 	__u16	nblocks;
-	__u16	rsvd;
+	__u16	driver_ctrl;
 	__u64	metadata;
 	__u64	addr;
 	__u64	slba;
@@ -27,7 +27,7 @@ struct nvme_user_io {
 struct nvme_passthru_cmd {
 	__u8	opcode;
 	__u8	flags;
-	__u16	rsvd1;
+	__u16	driver_ctrl;
 	__u32	nsid;
 	__u32	cdw2;
 	__u32	cdw3;
@@ -48,7 +48,7 @@ struct nvme_passthru_cmd {
 struct nvme_passthru_cmd64 {
 	__u8	opcode;
 	__u8	flags;
-	__u16	rsvd1;
+	__u16	driver_ctrl;
 	__u32	nsid;
 	__u32	cdw2;
 	__u32	cdw3;
@@ -63,7 +63,7 @@ struct nvme_passthru_cmd64 {
 	__u32	cdw14;
 	__u32	cdw15;
 	__u32	timeout_ms;
-	__u32   rsvd2;
+	__u32   rsvd;
 	__u64	result;
 };
 
@@ -79,4 +79,11 @@ struct nvme_passthru_cmd64 {
 #define NVME_IOCTL_ADMIN64_CMD	_IOWR('N', 0x47, struct nvme_passthru_cmd64)
 #define NVME_IOCTL_IO64_CMD	_IOWR('N', 0x48, struct nvme_passthru_cmd64)
 
+enum {
+	/* Retry command if failed with !DNR for <= nvme_max_retries */
+	__NVME_DRIVER_CTRL_RETRY,
+};
+
+#define NVME_DRIVER_CTRL_RETRY  (1 << __NVME_DRIVER_CTRL_RETRY)
+
 #endif /* _UAPI_LINUX_NVME_IOCTL_H */
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
