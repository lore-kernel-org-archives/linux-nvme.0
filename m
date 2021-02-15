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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54667C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 13:06:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5A3964DEC
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 13:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A3964DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IYoRzcdhlHW1vg8eBzkQDYgy88UzhydHs5+fXNvafjQ=; b=n7AS4fVyuuV86qMtznvOoMTY2T
	2gfi1mwe8eiSAVmBiBoSuCNVfEjw5+xSMr1tHtTJUHsndbm89BycDvT0ck+b25kYPRoIQF0Ed2xpV
	22QWwFRo3tl8hxWbeDgx4XN0ZARdzDL+NmoMxdoiHTq2O1qzVqyLnsB7cg8HGUz83UvOLaqh7rFzu
	oEbs07HpP/lN4llaKrRd/EFtUBTjvLri87c/jouq+HHwmj1srJzOlJ3yiCbGOUkbLGNYDjoDQXNBU
	jc2Z43XIAg9bucT3y1r6EnQHC5YiYDguhYxvISVA+NYXDXmPEMRJIsf6VKWsnVizdFSW99BkpMkSV
	PQKZjnyQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBdZo-0006iM-Vi; Mon, 15 Feb 2021 13:06:09 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBdZm-0006hM-KG
 for linux-nvme@lists.infradead.org; Mon, 15 Feb 2021 13:06:08 +0000
Received: by mail-pl1-x62c.google.com with SMTP id r2so3703979plr.10
 for <linux-nvme@lists.infradead.org>; Mon, 15 Feb 2021 05:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=O/gRuDH6VVnApSmGIKi27QRWbNS2fhRQuv911IurJMg=;
 b=PKK36CbdBxP9F+L10+D1muU1uSEEdo6KG8ufjlWB2p8wm9YUOyFz+YsQCen2S5fnsj
 SnRfcXJ8zMTFuORHJjNSE+5u4pvvDxn3au/nG7PH9NniNNBo99v7f0/V5YasPwDZjtbC
 eTnLuvGNlMFBN96Gy51vhf5D5HL01y2NAMRe+L96lIJ65a9L4bGtDc93QC/6bEpAo6vp
 qSmsrFIU/ZC82oLiNrtq0QPf3srMJsHLrhQHUDkiJpmFnDGwX/R0c8rRgtuvMn8TWfZP
 JF4JTX5ddP5vdEQ7b0xDm9nYg51AdzM2N4cPCtxe+2fej96NkyDq20t+HBCQ8xMt+tUJ
 QbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=O/gRuDH6VVnApSmGIKi27QRWbNS2fhRQuv911IurJMg=;
 b=ghQlgv6c4qgcet9p6yBXJ+NXnRW3vX2nwgv2CXwQS8WWoFhWDl6PG4J2edorwj3PaM
 bUv8Box5CmufWYmmheSrXENvkwJ9DZLMwopK5Gt3AUGLyEU+L3332V/2CCWL5cm57BKc
 fNzAo9jq6N6r4D5SyN3rSKMRULJ5sBkpGy7n7e8BNPZ13xjORsDBnL7X4cXAFp04OT1u
 qPRDgJZ+NMXbgxV06kWPzir0gsYEaGhla9xpSjHiU6zbm/kEKVBWguSCAwy0srLmnWPv
 wDqlI87NnWhKHCzJoHaEsh8x1XVWC6oBbu+SNUYsSpkuscdQTtOdFwkygbz/jehLNKWU
 COSg==
X-Gm-Message-State: AOAM530ZEQSKte7Dy/QTuAT7vT2XFLuNn9UenuKCfe0UoCKSlhSV3H5U
 2rtCDG248Ai0fwEQLhO4WAo5yOoSv27o4w==
X-Google-Smtp-Source: ABdhPJyGE7ry7HvzlAOt5cUn5UwVpqAY/XoehQ1ZqunmaFJzj7uUCIaRSgInpeQzyO47IXJqWVI+JA==
X-Received: by 2002:a17:90b:1649:: with SMTP id
 il9mr15613243pjb.62.1613394364195; 
 Mon, 15 Feb 2021 05:06:04 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id q13sm11334490pfg.155.2021.02.15.05.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Feb 2021 05:06:04 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [nvme-cli PATCH 2/2] nvme-ioctl: add command retry driver control
 flag to passthru
Date: Mon, 15 Feb 2021 22:05:54 +0900
Message-Id: <20210215130554.32387-3-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210215130554.32387-1-minwoo.im.dev@gmail.com>
References: <20210215130554.32387-1-minwoo.im.dev@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210215_080606_790734_CECE8B2F 
X-CRM114-Status: GOOD (  19.67  )
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

Replace existing reserved field in passthru ioctl command structures.
This patch also removed the `--rsvd` option from the passthru command
because even if it's given, it's not going to be passthrough to the
kernel driver: meaningless input.

This patch introduced the first flag value for command retry in case of
!DNR failure case from controller.  If `--retry` option is given to
passthru command, it will be retried by the driver itself rather than
returning error to the user-space direcly.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 linux/nvme_ioctl.h | 12 +++++++++---
 nvme-ioctl.c       |  5 ++---
 nvme-ioctl.h       |  2 +-
 nvme.c             | 15 +++++++++------
 4 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/linux/nvme_ioctl.h b/linux/nvme_ioctl.h
index d569414211d1..17dde016cb5c 100644
--- a/linux/nvme_ioctl.h
+++ b/linux/nvme_ioctl.h
@@ -23,7 +23,7 @@ struct nvme_user_io {
 	__u8	flags;
 	__u16	control;
 	__u16	nblocks;
-	__u16	rsvd;
+	__u16	driver_ctrl;
 	__u64	metadata;
 	__u64	addr;
 	__u64	slba;
@@ -36,7 +36,7 @@ struct nvme_user_io {
 struct nvme_passthru_cmd {
 	__u8	opcode;
 	__u8	flags;
-	__u16	rsvd1;
+	__u16	driver_ctrl;
 	__u32	nsid;
 	__u32	cdw2;
 	__u32	cdw3;
@@ -57,7 +57,7 @@ struct nvme_passthru_cmd {
 struct nvme_passthru_cmd64 {
     __u8    opcode;
     __u8    flags;
-    __u16   rsvd1;
+    __u16   driver_ctrl;
     __u32   nsid;
     __u32   cdw2;
     __u32   cdw3;
@@ -88,4 +88,10 @@ struct nvme_passthru_cmd64 {
 #define NVME_IOCTL_ADMIN64_CMD  _IOWR('N', 0x47, struct nvme_passthru_cmd64)
 #define NVME_IOCTL_IO64_CMD _IOWR('N', 0x48, struct nvme_passthru_cmd64)
 
+enum nvme_driver_ctrl_bits {
+	/* Retry command if failed with !DNR for <= nvme_max_retries */
+	__NVME_DRIVER_CTRL_RETRY,	};
+
+#define NVME_DRIVER_CTRL_RETRY	(1 << __NVME_DRIVER_CTRL_RETRY)
+
 #endif /* _UAPI_LINUX_NVME_IOCTL_H */
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 3e19023be890..2176fb3747ec 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -90,7 +90,7 @@ int nvme_submit_io_passthru(int fd, struct nvme_passthru_cmd *cmd)
 }
 
 int nvme_passthru(int fd, unsigned long ioctl_cmd, __u8 opcode,
-		  __u8 flags, __u16 rsvd,
+		  __u8 flags, __u16 driver_ctrl,
 		  __u32 nsid, __u32 cdw2, __u32 cdw3, __u32 cdw10, __u32 cdw11,
 		  __u32 cdw12, __u32 cdw13, __u32 cdw14, __u32 cdw15,
 		  __u32 data_len, void *data, __u32 metadata_len,
@@ -99,7 +99,7 @@ int nvme_passthru(int fd, unsigned long ioctl_cmd, __u8 opcode,
 	struct nvme_passthru_cmd cmd = {
 		.opcode		= opcode,
 		.flags		= flags,
-		.rsvd1		= rsvd,
+		.driver_ctrl	= driver_ctrl,
 		.nsid		= nsid,
 		.cdw2		= cdw2,
 		.cdw3		= cdw3,
@@ -133,7 +133,6 @@ int nvme_io(int fd, __u8 opcode, __u64 slba, __u16 nblocks, __u16 control,
 		.flags		= 0,
 		.control	= control,
 		.nblocks	= nblocks,
-		.rsvd		= 0,
 		.metadata	= (__u64)(uintptr_t) metadata,
 		.addr		= (__u64)(uintptr_t) data,
 		.slba		= slba,
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index 2b7640734398..a442da0275cc 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -17,7 +17,7 @@ int nvme_submit_admin_passthru(int fd, struct nvme_passthru_cmd *cmd);
 int nvme_submit_io_passthru(int fd, struct nvme_passthru_cmd *cmd);
 
 int nvme_passthru(int fd, unsigned long ioctl_cmd, __u8 opcode, __u8 flags,
-		  __u16 rsvd, __u32 nsid, __u32 cdw2, __u32 cdw3,
+		  __u16 driver_ctrl, __u32 nsid, __u32 cdw2, __u32 cdw3,
 		  __u32 cdw10, __u32 cdw11, __u32 cdw12,
 		  __u32 cdw13, __u32 cdw14, __u32 cdw15,
 		  __u32 data_len, void *data, __u32 metadata_len,
diff --git a/nvme.c b/nvme.c
index 5324e8bbe79f..419b2ecbf30f 100644
--- a/nvme.c
+++ b/nvme.c
@@ -5060,11 +5060,11 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 	int err = 0, wfd = STDIN_FILENO, fd;
 	__u32 result;
 	bool huge;
+	__u16 driver_ctrl = 0x0;
 
 	struct config {
 		__u8  opcode;
 		__u8  flags;
-		__u16 rsvd;
 		__u32 namespace_id;
 		__u32 data_len;
 		__u32 metadata_len;
@@ -5084,12 +5084,12 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 		int   read;
 		int   write;
 		__u8  prefill;
+		bool  retry;
 	};
 
 	struct config cfg = {
 		.opcode       = 0,
 		.flags        = 0,
-		.rsvd         = 0,
 		.namespace_id = 0,
 		.data_len     = 0,
 		.metadata_len = 0,
@@ -5104,11 +5104,11 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 		.cdw15        = 0,
 		.input_file   = "",
 		.prefill      = 0,
+		.retry        = false,
 	};
 
 	const char *opcode = "opcode (required)";
 	const char *flags = "command flags";
-	const char *rsvd = "value for reserved field";
 	const char *namespace_id = "desired namespace";
 	const char *data_len = "data I/O length (bytes)";
 	const char *metadata_len = "metadata seg. length (bytes)";
@@ -5128,12 +5128,12 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 	const char *re = "set dataflow direction to receive";
 	const char *wr = "set dataflow direction to send";
 	const char *prefill = "prefill buffers with known byte-value, default 0";
+	const char *retry = "command retry if failed with !DNR";
 
 	OPT_ARGS(opts) = {
 		OPT_BYTE("opcode",       'o', &cfg.opcode,       opcode),
 		OPT_BYTE("flags",        'f', &cfg.flags,        flags),
 		OPT_BYTE("prefill",      'p', &cfg.prefill,      prefill),
-		OPT_SHRT("rsvd",         'R', &cfg.rsvd,         rsvd),
 		OPT_UINT("namespace-id", 'n', &cfg.namespace_id, namespace_id),
 		OPT_UINT("data-len",     'l', &cfg.data_len,     data_len),
 		OPT_UINT("metadata-len", 'm', &cfg.metadata_len, metadata_len),
@@ -5152,6 +5152,7 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 		OPT_FLAG("dry-run",      'd', &cfg.dry_run,      dry),
 		OPT_FLAG("read",         'r', &cfg.read,         re),
 		OPT_FLAG("write",        'w', &cfg.write,        wr),
+		OPT_FLAG("retry",        'R', &cfg.retry,        retry),
 		OPT_END()
 	};
 
@@ -5213,7 +5214,6 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 	if (cfg.show_command) {
 		printf("opcode       : %02x\n", cfg.opcode);
 		printf("flags        : %02x\n", cfg.flags);
-		printf("rsvd1        : %04x\n", cfg.rsvd);
 		printf("nsid         : %08x\n", cfg.namespace_id);
 		printf("cdw2         : %08x\n", cfg.cdw2);
 		printf("cdw3         : %08x\n", cfg.cdw3);
@@ -5232,7 +5232,10 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 	if (cfg.dry_run)
 		goto free_data;
 
-	err = nvme_passthru(fd, ioctl_cmd, cfg.opcode, cfg.flags, cfg.rsvd,
+	if (cfg.retry)
+		driver_ctrl |= NVME_DRIVER_CTRL_RETRY;
+
+	err = nvme_passthru(fd, ioctl_cmd, cfg.opcode, cfg.flags, driver_ctrl,
 				cfg.namespace_id, cfg.cdw2, cfg.cdw3, cfg.cdw10,
 				cfg.cdw11, cfg.cdw12, cfg.cdw13, cfg.cdw14, cfg.cdw15,
 				cfg.data_len, data, cfg.metadata_len, metadata,
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
