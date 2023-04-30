Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E0BC7EE2F
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Apr 2023 14:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xYztlqpoEVeIHrKJhvcjUMJ8ItqPkXoCxbhVy1uECD8=; b=eo1w6oonQAE5jCpSumip2C0yhw
	Tk38NoJm8qv0Ld/y0XKYZ0TuH8fEPKmL9Vnr/fFSDVlKeZlFe/ppbIF0+G8s2IseYDaRYhoPD/pKN
	IbV4sJMGyvNdoMmPOREEzls73dx0pq7+T6zLT+KhBa+UtUepSeo0zANIHPGCGaSuKVpvMB7sNnXAL
	k7WqzTAJxyf/H9P7WfWGZhU5cCaSb8GSyQ9Q39/w+LBjC5ZJ6SJz1CGvQEXUsAOo6ZY6jiQXkOaSa
	nhfFkxCGIwJSdlMqTdzO7/3Im+v2+BDs1WxeuG7Lv/YmygU8Z/0Qx+onk/K1P5P6/7ls023Mgqxfe
	qztVYvWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pt89w-00EHrH-1a;
	Sun, 30 Apr 2023 14:36:16 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pt89r-00EHnu-1w
	for linux-nvme@lists.infradead.org;
	Sun, 30 Apr 2023 14:36:13 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f1e2555b5aso9206835e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 30 Apr 2023 07:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682865369; x=1685457369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYztlqpoEVeIHrKJhvcjUMJ8ItqPkXoCxbhVy1uECD8=;
        b=BxEOk/tH+LUOgwwvJ2H5jhXKsOKfR4QG8iCpe5vQTjVCBFj9vO2ByrWb8+N5xFZbqA
         mib7S45tMGLWYwHhOLFKEkgT0J3G6uNKGgE7PKz3+cDfi9g3iwZ3IbuXsMyfp8gSUh8K
         BOR8XcKljsb2lJkeTl+aZ6gInrM63UPqEwmKJoTD+jNbg+YB2d7aVRCcyv2hfGZR7pQx
         CnsC95xydfb3hECQCpmzjB7wdEqqAjSlOUT4pL5J7v1u+nSW1SyVp4dtfR7bqOF7Ply9
         zZQP83jr7Lc0+ndUDZJOL266niTgUNTHy9ywXEiRzr3/tqZOICr1mSQ6+IMXQ5sLyvc9
         Qcvw==
X-Gm-Message-State: AC+VfDzuzz9K6t4ir0+Ww4dxUjHyvcrh4l2Hb8y2chUh33hnRHUbjW15
	50CvumlMOHw9CYByc+wfUeY=
X-Google-Smtp-Source: ACHHUZ5664eOiLW3ZPACCqiNPyzg5aNNsS92B900veDjENR7znnwEFn7Tk4ea/zKV8HHvuHnyLT7PQ==
X-Received: by 2002:a05:600c:3797:b0:3f2:5a60:a03e with SMTP id o23-20020a05600c379700b003f25a60a03emr8721130wmr.14.1682865368556;
        Sun, 30 Apr 2023 07:36:08 -0700 (PDT)
Received: from localhost (fwdproxy-cln-026.fbsv.net. [2a03:2880:31ff:1a::face:b00c])
        by smtp.gmail.com with ESMTPSA id g10-20020a7bc4ca000000b003f171234a08sm29747037wmk.20.2023.04.30.07.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 07:36:07 -0700 (PDT)
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
Subject: [PATCH v3 3/4] io_uring: Remove unnecessary BUILD_BUG_ON
Date: Sun, 30 Apr 2023 07:35:31 -0700
Message-Id: <20230430143532.605367-4-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230430143532.605367-1-leitao@debian.org>
References: <20230430143532.605367-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230430_073611_650500_529918A3 
X-CRM114-Status: GOOD (  12.58  )
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

In the io_uring_cmd_prep_async() there is an unnecessary compilation time
check to check if cmd is correctly placed at field 48 of the SQE.

This is unnecessary, since this check is already in place at
io_uring_init():

          BUILD_BUG_SQE_ELEM(48, __u64,  addr3);

Remove it and the uring_cmd_pdu_size() function, which is not used
anymore.

Keith started a discussion about this topic in the following thread:
Link: https://lore.kernel.org/lkml/ZDBmQOhbyU0iLhMw@kbusch-mbp.dhcp.thefacebook.com/

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 io_uring/uring_cmd.c | 3 ---
 io_uring/uring_cmd.h | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index a1be746cd009..743d1496431b 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -71,9 +71,6 @@ int io_uring_cmd_prep_async(struct io_kiocb *req)
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
 	size_t size = uring_sqe_size(req->ctx);
 
-	BUILD_BUG_ON(uring_cmd_pdu_size(0) != 16);
-	BUILD_BUG_ON(uring_cmd_pdu_size(1) != 80);
-
 	memcpy(req->async_data, ioucmd->sqe, size);
 	ioucmd->sqe = req->async_data;
 	return 0;
diff --git a/io_uring/uring_cmd.h b/io_uring/uring_cmd.h
index 7c6697d13cb2..8117684ec3ca 100644
--- a/io_uring/uring_cmd.h
+++ b/io_uring/uring_cmd.h
@@ -3,11 +3,3 @@
 int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags);
 int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_uring_cmd_prep_async(struct io_kiocb *req);
-
-/*
- * The URING_CMD payload starts at 'cmd' in the first sqe, and continues into
- * the following sqe if SQE128 is used.
- */
-#define uring_cmd_pdu_size(is_sqe128)				\
-	((1 + !!(is_sqe128)) * sizeof(struct io_uring_sqe) -	\
-		offsetof(struct io_uring_sqe, cmd))
-- 
2.34.1


