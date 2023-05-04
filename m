Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F33C7EE29
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 12:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wSyb6givsMExpGuHktpWfu+gxOuU871A0uj9kukvqHo=; b=rRpb/bdfrU7ZT+55H2Larz26Rw
	1wXA1C1SWr1C9hZBuJRwVrlpqCP1WxXDqTmso1zy9GJh+76ktDBugxMPr+YLPe5CEzsYGlfImblaz
	+QiFLnDt0h5AJSq5gJynXYqOkrqHmYwArmd5Jp5c9JZwGOs9Dj3DnE39ncoHHjbQBG9B05sguRc/c
	ytwaQCm/TIL91YWakLNsAcfF/2R0uoKiViDBE+Da3O/LAVpVNxNiBnLn2QadmEDd9dgLImzG6ba3/
	exqUKlOIfx2OvkIyMtKD6BSD0e8ZwPz3rnKuUFZySnTmjfHF1KAgoLZq2gHaRQkG1SdEYIFx+/Sm+
	kjplPlEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puXvT-007oHw-2K;
	Thu, 04 May 2023 12:19:11 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puXvQ-007oEF-2l
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 12:19:10 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3f4000ec74aso3206205e9.3
        for <linux-nvme@lists.infradead.org>; Thu, 04 May 2023 05:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683202745; x=1685794745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSyb6givsMExpGuHktpWfu+gxOuU871A0uj9kukvqHo=;
        b=kZktC0T9HBKn8cxrFIk0clKZ8QKlle3OC9IPPftDPPVuHzRmmp5pDcD/lHucNXfpQV
         Rt/8Y+i8MVMqQQEC0IGjdEfO1R1LyFfOuqQ13I9D9afhIn+n5FJdPkhevkGxb8AWvXTV
         DdXFPT4zWuQgbeU42kPBr6Ax9RYdDgDnlkMac/sSK9Mv3Qxps0TNZ4Lm9/ZwJvd8yzYL
         +faREB1+lDUw5j9UaAmvv2WmpLv4VmNUVoFRTrVgvGPFh2D7mX8zUM2y2aKcZbHgk6P7
         PlBc2bDZTvOdSAiQopZznpmdHQpiD3OQB9n8oplPEul1A1fqTRgsucfn+kjQglFH7dhG
         Io1w==
X-Gm-Message-State: AC+VfDzk2Lt+CCrV7N6l8r2mZ3lKrWjnPhOynPDalGZ3j0OjHGxXrN+x
	r55hKJNQWer5uqVaoBZGOt0=
X-Google-Smtp-Source: ACHHUZ6U41Ymc//NQ1NfFRXTc5vZxexdvF5yf/UL7aT819ElkY5jwLddGgqGkL2K4aqY7X/9EkOZQA==
X-Received: by 2002:a1c:f717:0:b0:3f1:8aaa:c20c with SMTP id v23-20020a1cf717000000b003f18aaac20cmr17008034wmh.7.1683202744867;
        Thu, 04 May 2023 05:19:04 -0700 (PDT)
Received: from localhost (fwdproxy-cln-027.fbsv.net. [2a03:2880:31ff:1b::face:b00c])
        by smtp.gmail.com with ESMTPSA id y4-20020a05600c364400b003f175954e71sm4830463wmq.32.2023.05.04.05.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 05:19:04 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	asml.silence@gmail.com,
	hch@lst.de,
	axboe@kernel.dk,
	ming.lei@redhat.com
Cc: leit@fb.com,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	sagi@grimberg.me,
	joshi.k@samsung.com,
	kbusch@kernel.org
Subject: [PATCH v4 1/3] io_uring: Create a helper to return the SQE size
Date: Thu,  4 May 2023 05:18:54 -0700
Message-Id: <20230504121856.904491-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230504121856.904491-1-leitao@debian.org>
References: <20230504121856.904491-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_051908_892657_600A8BA6 
X-CRM114-Status: GOOD (  11.60  )
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

Create a simple helper that returns the size of the SQE. The SQE could
have two size, depending of the flags.

If IO_URING_SETUP_SQE128 flag is set, then return a double SQE,
otherwise returns the sizeof of io_uring_sqe (64 bytes).

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 io_uring/io_uring.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 25515d69d205..259bf798a390 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -394,4 +394,14 @@ static inline void io_req_queue_tw_complete(struct io_kiocb *req, s32 res)
 	io_req_task_work_add(req);
 }
 
+/*
+ * IORING_SETUP_SQE128 contexts allocate twice the normal SQE size for each
+ * slot.
+ */
+static inline size_t uring_sqe_size(struct io_ring_ctx *ctx)
+{
+	if (ctx->flags & IORING_SETUP_SQE128)
+		return 2 * sizeof(struct io_uring_sqe);
+	return sizeof(struct io_uring_sqe);
+}
 #endif
-- 
2.34.1


