Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21029C79FB6
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 15:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BpyMKG/NmuIVEN51AvPLm78UGTP27UIsJPJty8qt2D8=; b=jul+KucgfuePFAjq7x/f7xymPj
	hy2CgfYO5+0dEtdEv/JFSH+hsGb7IPIxYf8R0vt/O+ySOqtNg7hPhPjFzRJ/DSmRhvxs50bprLnKl
	418M7wewDzOpkrlfaOlIjaM02jDqHXhnLr11Pd/DeoV28gUXgC1cmiM4ze6HWF1AYbbQ0chkdPLm4
	7/us+g32nmWF9JKgZaNHWiPn6bPFnJmT5bLVXiqfUcHXawVNX4c1AT2CoAbwi9DlafJ1jbsw8s51y
	94gGZ+YXzO5thoIp4Wjcbup3H8bimjN+IEC7zUtwA7iQNSwe9Qsl0wlBdMcxR8zgQBVtPN2rOtmW/
	Q1euW+4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Khv-0000000CFnM-0Mfk;
	Wed, 09 Sep 2026 15:59:31 +0000
Received: from mail-ot1-x364.google.com ([2607:f8b0:4864:20::364])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Kht-0000000CFmj-01wj
	for linux-nvme@lists.infradead.org;
	Wed, 09 Sep 2026 15:59:30 +0000
Received: by mail-ot1-x364.google.com with SMTP id 46e09a7af769-7f4f88a759fso74889a34.3
        for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2026 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788969567; x=1789574367; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BpyMKG/NmuIVEN51AvPLm78UGTP27UIsJPJty8qt2D8=;
        b=FdRsSpctnO5ojfV2COA7+4UKjLcE/av+mQIKBOw10KyHMxNmjxJFfSTLjeJIxSrqAC
         zoFAz11VQjJp9KsuEh0gpipuLwHUzByLB2ZVBH1O7DSptkNBvNUaexTzybahk5xdylJy
         ju7lPRqPTF3c/PE7GI5FL+rCm9HCHB7Ku0sj0LPny3Mlc/uzCSqSKZc20iQLtdim6z0J
         gcuUT/eizWL4kX3vMaYyPX+lN/P0VrXs39Iyy5jdCK88VXS4m+Rp/dtIPupx8XmzZ3fN
         cCZ0M0Igaz0aweDTxv0KT4i7Usl0TpjvNxOGrtd8iJJeUW7qOrOm/BI3tB+p6ffBoQ9u
         txTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788969567; x=1789574367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BpyMKG/NmuIVEN51AvPLm78UGTP27UIsJPJty8qt2D8=;
        b=jv86Bnvb+FpSRVONaRbOtE2Vm80bsYRWr/JClI12VEEyLG+jHA0NjiwomShOnqbVr9
         D/Ivz2MZdcL0/1aBC5b5MxJV9/0pXysFch91klnKfOO348hh3RsC1E/yi6a4uyo3xyFL
         /97esoHUaV9QhAiHnnXR5ipbyUp6a1Il7708Wvxz0HAPLD+3cg2uKo8JdkLeC8LStNYj
         VNfNZSiZenPSp3nm9xdg+y19wL7lElcO6c7PL9T5agtOmA0K/coibc5sdDnSYM7O3r9y
         XzydjIreelLLBy00BGxst/peh3wIExNsWWdZmUoHuK7Q0STPcwLBIcLLNRad9mN5tiQ3
         H7GA==
X-Forwarded-Encrypted: i=1; AKwUvBwGBofFGBujygHGFXx1bZ4JbYpqraeOg3Xi8iCx/EBSleBVDTjg09TwIYDQeA74nlDGCpAhWln4VueM@lists.infradead.org
X-Gm-Message-State: AFuF++k4UKxXMKsCUxdfFWzJvj5Jk4XA3EfRqdJw+TK6p9vNXtEOC7fl
	guDRNv4aucqOOz6E8kn7lZlcZ0jNnN1DfVRbZiicyAibOGbedfpytXadMZ/6B/Bdt7VlgNpKMkm
	8rUb3LvhHadafMoW4NDMLZ8v+5nA+gRi6pwaE
X-Gm-Gg: AYBFou3rFWbfJEqJiXpugC0HZwFRIZa2sxfKqsYmndHcN2E0NujvEv8XYXJC/irLsw7
	dKm1kyJ3uZo0FM58gw2suolGu69zL73kd8vEbMoL/jJEQ6HeHybRGCB1lqxi+eQkzak5JMesb80
	WugN3KKX0MGt6T6GR/bLv/m+GoDlrdZWfO1Yk/93XD6w07HrGdcU6oU0hoFfWeO9Y+EmfinsjDU
	juuMrTmWou5gYUNgs88vfx+xbz1mthfGvDrDV+cezmfx/lXitEYuanJh6y+XMqdcLYiSngQt4ON
	aZEHf/q2w+rSdQjEQ73946VGie43xyw+kHHFQjLxHc3fytXzyM9T5VFKZBGv7fVwrkdu0wsL/Nn
	wlg29vIb4W3py6BYF13p0lzU6Su/bzPY9
X-Received: by 2002:a05:6830:3495:b0:801:b3e8:25ab with SMTP id 46e09a7af769-801b3e8a6c8mr1961931a34.2.1788969567461;
        Wed, 09 Sep 2026 08:59:27 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7f9f1b0f661sm2564948a34.0.2026.09.09.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:59:27 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 0CDF7402A9;
	Wed,  9 Sep 2026 09:59:27 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 09997E4026F; Wed,  9 Sep 2026 09:59:27 -0600 (MDT)
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
Subject: [PATCH v3 1/3] io_uring: move req_set_*() to public header
Date: Wed,  9 Sep 2026 09:58:46 -0600
Message-ID: <20260909155848.2069290-2-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909155848.2069290-1-csander@purestorage.com>
References: <20260909155848.2069290-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_085929_206971_2045D2C1 
X-CRM114-Status: GOOD (  13.77  )
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

In preparation for using req_set_fail(), req_set_res(), and
req_set_res32() in include/linux/io_uring/cmd.h, move them from the
private header io_uring/io_uring.h to include/linux/io_uring.h.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/io_uring.h | 32 ++++++++++++++++++++++++++++++++
 io_uring/io_uring.h      | 31 -------------------------------
 2 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index d1aa4edfc2a5..505caa99c621 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -1,13 +1,45 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 #ifndef _LINUX_IO_URING_H
 #define _LINUX_IO_URING_H
 
+#include <linux/io_uring_types.h>
 #include <linux/sched.h>
 #include <linux/xarray.h>
 #include <uapi/linux/io_uring.h>
 
+static inline void req_set_fail(struct io_kiocb *req)
+{
+	req->flags |= REQ_F_FAIL;
+	if (req->flags & REQ_F_CQE_SKIP) {
+		req->flags &= ~REQ_F_CQE_SKIP;
+		req->flags |= REQ_F_SKIP_LINK_CQES;
+	}
+}
+
+static inline void io_req_set_res(struct io_kiocb *req, s32 res, u32 cflags)
+{
+	req->cqe.res = res;
+	req->cqe.flags = cflags;
+}
+
+static inline u32 ctx_cqe32_flags(struct io_ring_ctx *ctx)
+{
+	if (ctx->flags & IORING_SETUP_CQE_MIXED)
+		return IORING_CQE_F_32;
+	return 0;
+}
+
+static inline void io_req_set_res32(struct io_kiocb *req, s32 res, u32 cflags,
+				    __u64 extra1, __u64 extra2)
+{
+	req->cqe.res = res;
+	req->cqe.flags = cflags | ctx_cqe32_flags(req->ctx);
+	req->big_cqe.extra1 = extra1;
+	req->big_cqe.extra2 = extra2;
+}
+
 #if defined(CONFIG_IO_URING)
 void __io_uring_cancel(bool cancel_all);
 void __io_uring_free(struct task_struct *tsk);
 void io_uring_unreg_ringfd(void);
 const char *io_uring_get_opcode(u8 opcode);
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 896aab1ed026..109261722ca7 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -316,41 +316,10 @@ static __always_inline bool io_fill_cqe_req(struct io_ring_ctx *ctx,
 	if (trace_io_uring_complete_enabled())
 		trace_call__io_uring_complete(req->ctx, req, cqe);
 	return true;
 }
 
-static inline void req_set_fail(struct io_kiocb *req)
-{
-	req->flags |= REQ_F_FAIL;
-	if (req->flags & REQ_F_CQE_SKIP) {
-		req->flags &= ~REQ_F_CQE_SKIP;
-		req->flags |= REQ_F_SKIP_LINK_CQES;
-	}
-}
-
-static inline void io_req_set_res(struct io_kiocb *req, s32 res, u32 cflags)
-{
-	req->cqe.res = res;
-	req->cqe.flags = cflags;
-}
-
-static inline u32 ctx_cqe32_flags(struct io_ring_ctx *ctx)
-{
-	if (ctx->flags & IORING_SETUP_CQE_MIXED)
-		return IORING_CQE_F_32;
-	return 0;
-}
-
-static inline void io_req_set_res32(struct io_kiocb *req, s32 res, u32 cflags,
-				    __u64 extra1, __u64 extra2)
-{
-	req->cqe.res = res;
-	req->cqe.flags = cflags | ctx_cqe32_flags(req->ctx);
-	req->big_cqe.extra1 = extra1;
-	req->big_cqe.extra2 = extra2;
-}
-
 static inline void *io_uring_alloc_async_data(struct io_alloc_cache *cache,
 					      struct io_kiocb *req)
 {
 	if (cache) {
 		req->async_data = io_cache_alloc(cache, GFP_KERNEL);
-- 
2.55.0


