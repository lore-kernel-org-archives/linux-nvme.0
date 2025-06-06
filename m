Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AA8C61CE7
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jun 2025 20:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6pMwQO2aENnooCdsprxoH/541aHidCWX82eOQdpi7Rs=; b=idhI47NXOyHJfbtsslnVQmmwXz
	67eS8D+nNfhNC+YYq6cbdPwSjL5QRSteECqZDYQYFvb/8qVKFDJJ2KmC/16b4AA/pkbeIIx30oStf
	ktUiKKUaKrfXy5zXy0WDC4CDfJ/MU4YWikYRsfG1MZwYO+iXYoDy6LM24food5NnSzzwt/962nYcn
	iFZSEWGJubyE6neEVVq/t48GJcJB9fgzYLo0m1hBmY5LXgK+WAP+rlcKTa1usPkTao6bJi/fnnS6p
	rkaWup11lNMw317it1WdS3GIuEb1PvDal2DpTek1SGH94xApcYyrdg0uzDC/1LNNPjT5EMAZY0Sbk
	E5u78JIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNdW5-00000000wOz-0c23;
	Fri, 06 Jun 2025 20:18:17 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNdW0-00000000wLm-14qw
	for linux-nvme@lists.infradead.org;
	Fri, 06 Jun 2025 20:18:13 +0000
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so1669628a12.3
        for <linux-nvme@lists.infradead.org>; Fri, 06 Jun 2025 13:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749241091; x=1749845891; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pMwQO2aENnooCdsprxoH/541aHidCWX82eOQdpi7Rs=;
        b=R9B+C7rOfrnKbhbltSx4j355mros49QJPCbaChT2Dngf9iwdEQLhvBye8bPxynSuOk
         CH4G5IeCrjzBve3Duz1/Zgt3WUbj2N70NDlyMtvvUJ/ZhPVWZfbEZjnGjF+fb0mZxDlA
         YTODbpAUZoFG9dfJx6Q58iXXM+9x5GCgHfHKI4Jda3ZMhcQiEg40k9VmUaLtJEjwv9D0
         zC4guCitS5iLp3G1mc0jPjCLbe8duQIASAE/oUfOjg9e/lBlLEqU/jgJXsl7gj8AOd7j
         2jXKiOMNzZd14stH3cOzPfte7d4kJGEA9fHAYQ/bKQPr7yS64wLa9h2MyGpd4tGf3u+N
         QEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749241091; x=1749845891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pMwQO2aENnooCdsprxoH/541aHidCWX82eOQdpi7Rs=;
        b=h45rYQVK7jqCVy257/9qFxkIEpapT/8eFd71lhw/OEfVzxQyfqsjUtC4xuLX924m/E
         gbbhVQiHdIpaokuKM43FgWHBnssBlbfpcdCeV5uoiqeMSqBkGBJBO9hX09sttGgUWQDe
         cBQn5/A0c125CUQK+qtRGcl9quY7xbR14eBwu2uwAhq5jSgaGDksNZOtuVvTvFpmHcOa
         oQGrS19B2a8gL71I8r34Ojrn30/MsbahmEDUGTdE6EklmtKTJdGyskdZAWFJoG/zr02h
         VEsol7gqmkRUMXJknWfFnNuDZXi6+zkL3oSspujpcvfQyQJ/uvq3cwRL/+wzUZnrmpnD
         orZg==
X-Gm-Message-State: AOJu0Yw5ipMSdrJ+uRnQi50ISkG9AONiG35/VAVcBbScMGKEpGOA4Exv
	GlACZuoLPMV7GXX+QEo0789roCNzwdjeEM3fPQdRNKFj8AbsvCsuke8y2ST3Bw==
X-Gm-Gg: ASbGncvSt/5P/1/o4XHLLTx1+Q7dygc1a6mNf0Tp9b/Ih3XB8mwpfyeaSasSSKw7sr2
	mKTVASkCxwRY+OZDPrFwCBhSwHDjaro90BGS6cG4Y7BDts6GuTju7s8eSxvu7A1BOvQIq9g9peO
	VybRZe6VkD2oywudcp8+yzpHYqLIJU56+twnEaQESq64zAY7HR2MHWgOEbG5LcywygjD9ami8SH
	sUFKIDS40gH54F3JAXmcbD9MBnugQ0C0HReVH2ixe4iEDRJ6W656FXjQyE+9ymbIDU+luWK4iBr
	X6FVV7MkvLMhRxMCPZDDF7RveO+0M6vl78NaGgXuY+3GqlheVqXS4DyQBymTUMH+pXGV/2DWSFm
	zcA0lBpi6FeX7Xw==
X-Google-Smtp-Source: AGHT+IG5R7lyFt/wY54xzCPQ+lHPKlci5echgDXeBO+FnEnxeGxk4YIZbRLaXWvEse6t3e5ajVg6kw==
X-Received: by 2002:a17:90a:d003:b0:312:e91c:e340 with SMTP id 98e67ed59e1d1-31347697e99mr6875314a91.35.1749241091320;
        Fri, 06 Jun 2025 13:18:11 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:8b15:3e66:8393:27ba])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3135c5939a0sm591537a91.41.2025.06.06.13.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 13:18:11 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH 2/2] nvme/ioctl: fix unsigned value as unsigned int value
Date: Sat,  7 Jun 2025 05:16:10 +0900
Message-ID: <20250606201654.9558-3-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606201654.9558-1-ikegami.t@gmail.com>
References: <20250606201654.9558-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_131812_293936_76991FBF 
X-CRM114-Status: GOOD (  11.30  )
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

This is to fix for the checkpatch.pl warning.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/ioctl.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 02edb0900413..880a40cb78d7 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -112,8 +112,9 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 }
 
 static int nvme_map_user_request(struct request *req, u64 ubuffer,
-		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
-		struct iov_iter *iter, unsigned int flags)
+		unsigned int bufflen, void __user *meta_buffer,
+		unsigned int meta_len, struct iov_iter *iter,
+		unsigned int flags)
 {
 	struct request_queue *q = req->q;
 	struct nvme_ns *ns = q->queuedata;
@@ -164,9 +165,9 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 }
 
 static int nvme_submit_user_cmd(struct request_queue *q,
-		struct request *req, u64 ubuffer, unsigned bufflen,
-		void __user *meta_buffer, unsigned meta_len,
-		u64 *result, unsigned timeout, unsigned int flags)
+		struct request *req, u64 ubuffer, unsigned int bufflen,
+		void __user *meta_buffer, unsigned int meta_len,
+		u64 *result, unsigned int timeout, unsigned int flags)
 {
 	struct nvme_command *cmd = nvme_req(req)->cmd;
 	struct nvme_ns *ns = q->queuedata;
@@ -207,7 +208,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 {
 	struct nvme_user_io io;
 	struct nvme_command *c;
-	unsigned length, meta_len;
+	unsigned int length, meta_len;
 	void __user *metadata;
 	struct request *req;
 
@@ -292,7 +293,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	struct request_queue *q = ns ? ns->queue : ctrl->admin_q;
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command *c;
-	unsigned timeout = 0;
+	unsigned int timeout = 0;
 	struct request *req;
 	u64 result;
 	int status;
@@ -349,7 +350,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	struct request_queue *q = ns ? ns->queue : ctrl->admin_q;
 	struct nvme_passthru_cmd64 cmd;
 	struct nvme_command *c;
-	unsigned timeout = 0;
+	unsigned int timeout = 0;
 	struct request *req;
 	int status;
 
@@ -423,7 +424,7 @@ static inline struct nvme_uring_cmd_pdu *nvme_uring_cmd_pdu(
 }
 
 static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd,
-			       unsigned issue_flags)
+			       unsigned int issue_flags)
 {
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
 
-- 
2.48.1


