Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B2AC79FBD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 15:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X+pMe6zV5KmHjmCdDkn3PgSMEGRc3mfq+qsXjrF4xPM=; b=vehlP6RFcO/4K3Qvewa6NYf63D
	Zb8pY56nmfcNRu9xB2BflXSxwjKQGCW+9WvrZCxk4tBr0A0J0IstWA3gvxWA7i16X2cqRClmoTvnW
	WIUfCUPGf2QIw3BxVkAqUrzIrYOzOQqh8Of5ZgAMcEgQcn6uBneu/yGxS7vEczv9QsJyx5Jsa6nc8
	02fUpfwd3p9lQJditED/ecoUD7lkXaVbQh5stKnzbr63KZ6HAY1M3vlPiuOM7s4vyNZC56j5ICxqY
	ejfwZKuN6/yMOHeIwfoBLQMjKgbSR8/8w0jmGN4BU/HqH0kdreU/63huVrALbuGu+yxZYvgczV2i/
	DEXQJKzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Khy-0000000CFoR-0lhb;
	Wed, 09 Sep 2026 15:59:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Khx-0000000CFnV-1L7r
	for linux-nvme@bombadil.infradead.org;
	Wed, 09 Sep 2026 15:59:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=X+pMe6zV5KmHjmCdDkn3PgSMEGRc3mfq+qsXjrF4xPM=; b=pNkEuaQq/95KdHL92lbfGCagtQ
	S2Jnpf44iYguya2X0jZaY6C+UydRRxCEkDXcbJkKNm2ha+oUm4JOhOkbFRUAfMIB14Qlq7kz5hZrL
	S1/tjr9iH+l5QY/vkgJAeWsbFnv4xoxIwd3lsYSAFS0bKzLEP5ao5Mc0FZE5vjwCDgcS7YrPxAbRt
	XnyXChw0+Z3fua00RrbIh7GUfDCQg5om0rb9anXFaSxojIfsH/OpN6Oz9WvYw0Bvqg+5+1BImYO2T
	IoaOkqVVDLV6HzAVbYWDAcBcNOIXD0J2ra0QTrLfhAD8fxVVnZ1Oc3CMcDXIDd/4REVeod9WyahjR
	UzDA4Euw==;
Received: from mail-ot1-x361.google.com ([2607:f8b0:4864:20::361])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4Khu-00000001PAq-1Zv8
	for linux-nvme@lists.infradead.org;
	Wed, 09 Sep 2026 15:59:32 +0000
Received: by mail-ot1-x361.google.com with SMTP id 46e09a7af769-7f421638271so69680a34.3
        for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2026 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788969568; x=1789574368; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X+pMe6zV5KmHjmCdDkn3PgSMEGRc3mfq+qsXjrF4xPM=;
        b=C/6DNapUyEC3JFmlo7Ipn0U3/PAEceieJnRbLA6DNCH/rk3bYWS2qK2U37lO+FFhgY
         zowfgYZtufEFMY/yjx3nJ8MSMxUW1LR3UTtSEIv+11CpJhhJaEn+KHIPDeMu/rvMPJ4Y
         doy/UMK5qv0pWIvKJNDZg8HYq7sCLUQIsyKHf+CK3XxVmR/UsCw8tZbedXb46vsLxHkC
         70ey1PSA+EXyADbu8TJ3y8NEaqQ54cx6g/79aaBELKTsovPMcJY/bRmxn1XmfYNBdru7
         uTO9yhOYNYsVeP9kaS1rNym9ThlXkVkzwtvX2jzxN7CFGLl9svbD6a12eyy4mUIcmA2P
         kYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788969568; x=1789574368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X+pMe6zV5KmHjmCdDkn3PgSMEGRc3mfq+qsXjrF4xPM=;
        b=LtdJNuF5OMa18dhd13mOrbacY3Bd2HTjBRyvt+D9TzEPvRs3KkTFozgOnrQxH1vDLd
         BUZSpe+P19RS8m1OxmoWl5zpSeCFZeMlS1G2B1GRmcJrwavsQWGLarDHVa3qbm4xQFTS
         /gSNZGXRfcPG1mtI72Vp+xFYwbV41w+TCrHMMsijGxPg0VG+73uUJWMni7wfpZh+2pZu
         z+VgjslXpbG+hx7KcdDssFvEWVakdZtrtMoC2AncIkqepmphfZ07ZoBDTbH5yaVkk03g
         ZluerwphleC7NcWRwyAWSrkvWYln6xZTQBx6ZUf28+XfMIibaXt9Gi+kvPorzkoCuqlL
         PeLg==
X-Forwarded-Encrypted: i=1; AKwUvByuNR3gVkpuAtixZXU11VyE0m33tiSziiedRAm3V778g299hYqAZNtnaL+m49KChNSIDzGgLfXCfMxw@lists.infradead.org
X-Gm-Message-State: AFuF++mcEkogevPNQSI3smXXdQbzmjjg/vylzl4CCIERxH+jBsdsxe4B
	VjNohOUvkLIXhOX6X4OM+ycisKDYR/sVqOI9Fm7OAxNFQHi6VJy1mf2R8BzyKJcs/3qBNkVsAAl
	8ZMivSp0AQx5Nrv8tLxONB6XyKgPZ7brcYkx58hwAV2yWhsUzp9k7
X-Gm-Gg: AYBFou3lusER+9MagVNKoTV9wIiJYc7NdqT2JJJHW3OyAxODoJfqncWaE0tCIIM0yub
	dAnECQLYbJonFsQ0yojBicKCfUBac7spPfuVG3tJdq6gjLe6FCCPqasA64NqThvwEAvtXtIhz6O
	UnrmnjUyQuvAHZoQCRChMnj28Rx/3YCzK2ca171ob7FDwYncNQc9bibXLTCJp1ptwK4XOtWCcHV
	TKpgCVdRwpCifoZe00Vnqmq1TGgM6y8HaOrquOAAsWpACyZI2ACofXjHBWIS8tdonadhnCmomG1
	/wU5JVEMJCdKL1SYNS64GJ2r54Nddy0rvWTOYMyMvSORrhZkcqc/9Dk0lWGDkqGu5ka1HmtlVYq
	UVWGiumALctxrF+eLaQ==
X-Received: by 2002:a05:6830:3c8e:b0:7f4:37a9:6df9 with SMTP id 46e09a7af769-7fb77233fb0mr18560557a34.0.1788969567677;
        Wed, 09 Sep 2026 08:59:27 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7f9f668f694sm2368876a34.4.2026.09.09.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:59:27 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 3435E402AE;
	Wed,  9 Sep 2026 09:59:27 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 310C2E4026F; Wed,  9 Sep 2026 09:59:27 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Ming Lei <tom.leiming@gmail.com>,
	io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 2/3] io_uring/cmd: split io_uring_cmd_set_res() from io_uring_cmd_done()
Date: Wed,  9 Sep 2026 09:58:47 -0600
Message-ID: <20260909155848.2069290-3-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909155848.2069290-1-csander@purestorage.com>
References: <20260909155848.2069290-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_165930_582382_C240F29C 
X-CRM114-Status: GOOD (  18.38  )
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
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/cmd.h | 34 ++++++++++++++++++++++++++++------
 io_uring/uring_cmd.c         | 19 +------------------
 2 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 331dcbefe72f..2e4368d611ee 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -1,10 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 #ifndef _LINUX_IO_URING_CMD_H
 #define _LINUX_IO_URING_CMD_H
 
 #include <uapi/linux/io_uring.h>
+#include <linux/io_uring.h>
 #include <linux/io_uring_types.h>
 #include <linux/blk-mq.h>
 
 /* only top 8 bits of sqe->uring_cmd_flags for kernel internal use */
 #define IORING_URING_CMD_CANCELABLE	(1U << 30)
@@ -39,10 +40,28 @@ static inline void io_uring_cmd_private_sz_check(size_t cmd_sz)
 #define io_uring_cmd_to_pdu(cmd, pdu_type) ( \
 	io_uring_cmd_private_sz_check(sizeof(pdu_type)), \
 	((pdu_type *)&(cmd)->pdu) \
 )
 
+static inline void io_uring_cmd_set_res(struct io_uring_cmd *cmd, s32 ret)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(cmd);
+
+	if (ret < 0)
+		req_set_fail(req);
+	io_req_set_res(req, ret, 0);
+}
+
+static inline void io_uring_cmd_set_res32(struct io_uring_cmd *cmd, s32 ret, u64 res2)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(cmd);
+
+	if (ret < 0)
+		req_set_fail(req);
+	io_req_set_res32(req, ret, 0, res2, 0);
+}
+
 #if defined(CONFIG_IO_URING)
 int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct iov_iter *iter,
 			      struct io_uring_cmd *ioucmd,
 			      unsigned int issue_flags);
@@ -54,15 +73,16 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 
 /*
  * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
  * and the corresponding io_uring request.
  *
+ * io_uring_cmd_set_res()/io_uring_cmd_set_res32() must be called first.
+ *
  * Note: the caller should never hard code @issue_flags and is only allowed
  * to pass the mask provided by the core io_uring code.
  */
-void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret, u64 res2,
-			 unsigned issue_flags, bool is_cqe32);
+void __io_uring_cmd_done(struct io_uring_cmd *, unsigned issue_flags);
 
 void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 			    io_req_tw_func_t task_work_cb,
 			    unsigned flags);
 
@@ -105,12 +125,12 @@ static inline int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 						int ddir, struct iov_iter *iter,
 						unsigned issue_flags)
 {
 	return -EOPNOTSUPP;
 }
-static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret,
-		u64 ret2, unsigned issue_flags, bool is_cqe32)
+static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd,
+				       unsigned issue_flags)
 {
 }
 static inline void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 			    io_req_tw_func_t task_work_cb, unsigned flags)
 {
@@ -171,17 +191,19 @@ static inline void *io_uring_cmd_ctx_handle(struct io_uring_cmd *cmd)
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
index 726a659f38c3..3d5d8b5f4ebb 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -136,40 +136,23 @@ void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 	req->io_task_work.func = task_work_cb;
 	__io_req_task_work_add(req, flags);
 }
 EXPORT_SYMBOL_GPL(__io_uring_cmd_do_in_task);
 
-static inline void io_req_set_cqe32_extra(struct io_kiocb *req,
-					  u64 extra1, u64 extra2)
-{
-	req->big_cqe.extra1 = extra1;
-	req->big_cqe.extra2 = extra2;
-}
-
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


