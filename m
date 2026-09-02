Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B082CC61DD6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 22:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KUYT2j/8GNxf6la1oNmocjOMbToIkSTfNNWKQ6vs8go=; b=PMmJEyeyp2ddQMh5n64fLgEpBw
	LTBqKR8fgl4XmGzDyUQ2/VSb76tkBOmE9coGU/wOKHqsbTrXlh69OGLpVWcPMRpJ/J+ngHz5AZz4V
	h89wt7X/IvZwv06/kbXWZg291GU/EPUjguXivHWRwip6tRUgMkm+dI/kTYyjtd61+1ZsacH8Brv9w
	NdZDASF9A591rrQ98RcPGX52oKWtV2vTYouqui7UkvMhzNRPHpV0VMAP9rZl3NVTnfjevALY0EGUS
	SQ/RHlgaXhc2QSKt6GtUHgNxZ1UuFIjJ3QZFSISItN6E1Nak2zE7hl+ZJyALlC/LReA8NixGWJQWv
	Xu7bjVtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1ttP-0000000G46p-1Trk;
	Wed, 02 Sep 2026 22:57:19 +0000
Received: from mail-qt1-x863.google.com ([2607:f8b0:4864:20::863])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1ttN-0000000G45R-0hnj
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 22:57:18 +0000
Received: by mail-qt1-x863.google.com with SMTP id d75a77b69052e-52d712fb5ebso2344821cf.3
        for <linux-nvme@lists.infradead.org>; Wed, 02 Sep 2026 15:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788389836; x=1788994636; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KUYT2j/8GNxf6la1oNmocjOMbToIkSTfNNWKQ6vs8go=;
        b=SLS/l5CEgYvYJnFC9W8G8vqrODLX9DTKPJFjjBOxS8N0isGtG98++e4pZRpc+e3Tv3
         kfzAPRXOSq76Wpb1Ne35VIwXhurIzg2uhkHvUQ9Th12h7R1COMnM5wQdeeyHoBGCqu7p
         /d/NHDQiXb/2rNNI0RTZzUUIIecYRavfW1QS1iw+9fdosjZWd1sZU7A14Bv7nKOkTOk9
         LNo8OIEBurehzWSlDpa7z69mbIDcps/B+7mTwkYyMDE2Z4MRc6NJTLRtAbbEnGSuS3Y3
         gIcJh7ntYJYZLIdiP0tFlSzOZUdKm1/YYiBdZKKxyjvw1AXHHwDD/tF1Wcwj6Tgk28Ty
         6ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788389836; x=1788994636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KUYT2j/8GNxf6la1oNmocjOMbToIkSTfNNWKQ6vs8go=;
        b=GPSdRC9MdqqvjjIqwbpPL3uIFu9nciHNiCaOt10ijQ6jDIbKjSzphAOskIcCfQUnZe
         Uh33De82ctNpNX9gHMl0fcFBWQPf1ksA0Oj8VK374WK5rFDlwbxuRNbhkgksHN5ipIhK
         Ecue4fe3rb2GcxwSHPskIhFB57+1ZkWZCLsofqX3zqwFo7jyVCkWgTybnFag94/FcOO6
         3+qBJmuEopqhzTenKjtNi+M74nKdeen96uQLTSYj0IoVsNpyyq9z4i9r3F1Dhsw9k19s
         VgeqFqcw2QpnCHblQC8TiqdrReNupXN1wsDOpoAoD4zF7IRZni1k2ysy6BlKamk+teuR
         EV9g==
X-Forwarded-Encrypted: i=1; AKwUvByVzREC4sP6ucqAHjRR/GuasILNascMVFXr5NnVY8hAFU5VikWn4eJFCb7WqZOSLkANaK2WwHWaD9b2@lists.infradead.org
X-Gm-Message-State: AFuF++mc5Q6Vux4G7jkzbf50OjZCSRuN7gdAFoPRpRTnz61ZC4XbAgj3
	pDCZXC5BBHg1lP/863kXaBY2d/qa7OFrbIk45MNSI2dCMv+ZC68qHs1hkELlGrq62g7C6CH0Pca
	cOrpfFF3NXT5jJOft0C5aGemO0uM9AySgsF7fnjcQrRn79UHp/j2c
X-Gm-Gg: AYBFou2VYeCahOBvSo34pa8WDdKZ/GlKFezMURaehL3n0paoiU5lL6CPnjKNhS8+5/n
	iDoI4uX1/4FzdRdCTl1aIMi/DhAhyhQ98+0dB8b362pMBNPSvwX+EGta47or/aOLQzoWvIo5p9d
	Z21+7/K25MVlIyRq3GOR/1fmajdqnKFN4jo3mPD7/Ct0/yqyQ4PU75sZB/Hq6YzBKKo6IqhQJ9p
	yRQioYL8XjNBpES/9nXuJs+D8yNHguOojE6zrSdSYcpsqfImQdotbKuLCmb7kP4DDuz7pUPd9tF
	Nxp+FP2rb6CSQKdCrYessA22BnCmEuO2M7+sSNDTWWMJcFl9BQ/xghZRjO5JNgWdBgmOwBZdN92
	mfI2l7OxLgb7KkiAT
X-Received: by 2002:a05:622a:283:b0:52b:4ec6:52c1 with SMTP id d75a77b69052e-53036ce96afmr58594011cf.3.1788389834170;
        Wed, 02 Sep 2026 15:57:14 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-5303319dea6sm377761cf.19.2026.09.02.15.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 15:57:14 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 7C5CD40420;
	Wed,  2 Sep 2026 16:57:13 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 70CBDE40404; Wed,  2 Sep 2026 16:57:13 -0600 (MDT)
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
Subject: [PATCH v2 1/2] io_uring/cmd: split io_uring_cmd_set_res() from io_uring_cmd_done()
Date: Wed,  2 Sep 2026 16:57:07 -0600
Message-ID: <20260902225708.2379840-2-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902225708.2379840-1-csander@purestorage.com>
References: <20260902225708.2379840-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_155717_220485_6F6EFF03 
X-CRM114-Status: GOOD (  18.91  )
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

In preparation for setting the io_uring NVMe passthru CQE results from
the blk-mq request completion rather than the task work callback, split
out functions io_uring_cmd_set_res{,32}() from __io_uring_cmd_done().
io_uring_cmd_done{,32}() now call io_uring_cmd_set_res{,32}() and then
__io_uring_cmd_done(). This allows __io_uring_cmd_done() to be made
CQE-size-agnostic, with 3 fewer arguments.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/io_uring/cmd.h | 23 +++++++++++++++++------
 io_uring/uring_cmd.c         | 33 ++++++++++++++++++---------------
 2 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 331dcbefe72f..67f2ef700c43 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -50,19 +50,21 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 				  const struct iovec __user *uvec,
 				  size_t uvec_segs,
 				  int ddir, struct iov_iter *iter,
 				  unsigned issue_flags);
 
+void io_uring_cmd_set_res(struct io_uring_cmd *, s32 ret);
+void io_uring_cmd_set_res32(struct io_uring_cmd *, s32 ret, u64 res2);
+
 /*
  * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
  * and the corresponding io_uring request.
  *
  * Note: the caller should never hard code @issue_flags and is only allowed
  * to pass the mask provided by the core io_uring code.
  */
-void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret, u64 res2,
-			 unsigned issue_flags, bool is_cqe32);
+void __io_uring_cmd_done(struct io_uring_cmd *, unsigned issue_flags);
 
 void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 			    io_req_tw_func_t task_work_cb,
 			    unsigned flags);
 
@@ -105,12 +107,19 @@ static inline int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 						int ddir, struct iov_iter *iter,
 						unsigned issue_flags)
 {
 	return -EOPNOTSUPP;
 }
-static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret,
-		u64 ret2, unsigned issue_flags, bool is_cqe32)
+static inline void io_uring_cmd_set_res(struct io_uring_cmd *cmd, s32 ret)
+{
+}
+static inline void io_uring_cmd_set_res32(struct io_uring_cmd *cmd, s32 ret,
+					  u64 res2)
+{
+}
+static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd,
+				       unsigned issue_flags)
 {
 }
 static inline void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 			    io_req_tw_func_t task_work_cb, unsigned flags)
 {
@@ -171,17 +180,19 @@ static inline void *io_uring_cmd_ctx_handle(struct io_uring_cmd *cmd)
 }
 
 static inline void io_uring_cmd_done(struct io_uring_cmd *ioucmd, s32 ret,
 				     unsigned issue_flags)
 {
-	return __io_uring_cmd_done(ioucmd, ret, 0, issue_flags, false);
+	io_uring_cmd_set_res(ioucmd, ret);
+	__io_uring_cmd_done(ioucmd, issue_flags);
 }
 
 static inline void io_uring_cmd_done32(struct io_uring_cmd *ioucmd, s32 ret,
 				       u64 res2, unsigned issue_flags)
 {
-	return __io_uring_cmd_done(ioucmd, ret, res2, issue_flags, true);
+	io_uring_cmd_set_res32(ioucmd, ret, res2);
+	__io_uring_cmd_done(ioucmd, issue_flags);
 }
 
 int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
 			    void (*release)(void *), unsigned int index,
 			    unsigned int issue_flags);
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 726a659f38c3..917b32a921e6 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -136,40 +136,43 @@ void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 	req->io_task_work.func = task_work_cb;
 	__io_req_task_work_add(req, flags);
 }
 EXPORT_SYMBOL_GPL(__io_uring_cmd_do_in_task);
 
-static inline void io_req_set_cqe32_extra(struct io_kiocb *req,
-					  u64 extra1, u64 extra2)
+void io_uring_cmd_set_res(struct io_uring_cmd *cmd, s32 ret)
 {
-	req->big_cqe.extra1 = extra1;
-	req->big_cqe.extra2 = extra2;
+	struct io_kiocb *req = cmd_to_io_kiocb(cmd);
+
+	if (ret < 0)
+		req_set_fail(req);
+	io_req_set_res(req, ret, 0);
 }
+EXPORT_SYMBOL_GPL(io_uring_cmd_set_res);
+
+void io_uring_cmd_set_res32(struct io_uring_cmd *cmd, s32 ret, u64 res2)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(cmd);
+
+	if (ret < 0)
+		req_set_fail(req);
+	io_req_set_res32(req, ret, 0, res2, 0);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_set_res32);
 
 /*
  * Called by consumers of io_uring_cmd, if they originally returned
  * -EIOCBQUEUED upon receiving the command.
  */
-void __io_uring_cmd_done(struct io_uring_cmd *ioucmd, s32 ret, u64 res2,
-		       unsigned issue_flags, bool is_cqe32)
+void __io_uring_cmd_done(struct io_uring_cmd *ioucmd, unsigned issue_flags)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
 
 	if (WARN_ON_ONCE(req->flags & REQ_F_APOLL_MULTISHOT))
 		return;
 
 	io_uring_cmd_del_cancelable(ioucmd, issue_flags);
 
-	if (ret < 0)
-		req_set_fail(req);
-
-	io_req_set_res(req, ret, 0);
-	if (is_cqe32) {
-		if (req->ctx->flags & IORING_SETUP_CQE_MIXED)
-			req->cqe.flags |= IORING_CQE_F_32;
-		io_req_set_cqe32_extra(req, res2, 0);
-	}
 	io_req_uring_cleanup(req, issue_flags);
 	if (req->flags & REQ_F_IOPOLL) {
 		/* order with io_do_iopoll() checking ->iopoll_completed */
 		smp_store_release(&req->iopoll_completed, 1);
 	} else if (issue_flags & IO_URING_F_COMPLETE_DEFER) {
-- 
2.55.0


