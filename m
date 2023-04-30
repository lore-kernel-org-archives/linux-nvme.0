Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60D0C77B73
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Apr 2023 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oWLOTplCTb15+ItkKDvIHTfyfj/21ATI17iwvK3v1Xg=; b=IbJ7hr6jTseOtjoPDm+jPhm/X1
	VqgY2TMMg95O3f8ilN1NKetUlfqIadLzSIM8JG3kb/YVdOaq834J80GTLMzDYudqv8xmwfrAVByT+
	yDmWL8JyU8G4ZvlaXy8HgJue01j78z2FaLTRMoNgzLmLnkBGclhqLHPGBSor1DSudcp8qHU1kmFpI
	Sav3rnDDae7jXsgWZbC8QYwhzaXD3An9CDMxAlV9FA3qrW1A17bbf4hWTzR+RNzmn/BEFv8qYFZbL
	WupucNkKe2eg0B1v2ggvfeyKJpkXQJZrIwbxOcewYHankM0+HQnOkSsdxi+PRSmtuG29Nvod7YtbP
	JZAI5m7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pt89q-00EHoU-1f;
	Sun, 30 Apr 2023 14:36:10 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pt89o-00EHnG-26
	for linux-nvme@lists.infradead.org;
	Sun, 30 Apr 2023 14:36:09 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f1738d0d4cso8660685e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 30 Apr 2023 07:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682865366; x=1685457366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWLOTplCTb15+ItkKDvIHTfyfj/21ATI17iwvK3v1Xg=;
        b=adBoNVhZUF2P26WVdHMt2tJoWq9bIYQoPiiyohz0etjSKmYOIPGVFFWsaZXvHNUd5b
         psQed773nqvuWPXjoeDRYak8xtjpMKtCDWm4e8/rYdk3/SPaATK8lFcapqNptgEkcqgm
         oen//6BerziMk9IoJjr/iygPlfJ3wEOemMAhN3CxKL0VI179rOvko5Gl0V3d2vVoCpt2
         Fxuj/FyVKJg924O7hNlgVEsUbYITfMeRmjLmUWv5xugLjSDqL9xSuWKxGcB4V2B/zjjK
         LAGOCyCDedTdH0ZHb3b6Wt5cruq8O9kJ5VmAJlb+Fsv9pl/gqAel/KC+RAm5b45MCgXP
         BTbA==
X-Gm-Message-State: AC+VfDzsrZAQruY7b+LTfobtyG87BFx0tlNiGxI+clDlBr2b97RmlaCN
	EneTFGeG0M/ularTR6bMAIg=
X-Google-Smtp-Source: ACHHUZ7nz6XoczydLlqmjutbUaDJZ83dYTS13ttqaBxRyVpkSJ5FOOZ5iNuc4pfoojqvCXwlaHRW7w==
X-Received: by 2002:a5d:6a91:0:b0:2ff:460e:bb49 with SMTP id s17-20020a5d6a91000000b002ff460ebb49mr9833275wru.24.1682865365870;
        Sun, 30 Apr 2023 07:36:05 -0700 (PDT)
Received: from localhost (fwdproxy-cln-020.fbsv.net. [2a03:2880:31ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id h7-20020a5d6e07000000b003048084a57asm16459222wrz.79.2023.04.30.07.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 07:36:05 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	asml.silence@gmail.com,
	axboe@kernel.dk,
	ming.lei@redhat.com
Cc: leit@fb.com,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	sagi@grimberg.me,
	joshi.k@samsung.com,
	hch@lst.de,
	kbusch@kernel.org
Subject: [PATCH v3 1/4] io_uring: Create a helper to return the SQE size
Date: Sun, 30 Apr 2023 07:35:29 -0700
Message-Id: <20230430143532.605367-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230430143532.605367-1-leitao@debian.org>
References: <20230430143532.605367-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230430_073608_687796_A0524691 
X-CRM114-Status: GOOD (  10.84  )
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


