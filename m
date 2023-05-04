Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA49C7EE23
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 12:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=it1Jg8DeNZi+uSQaZN6tyTLLss5U0nLB9ujTI6DLQlE=; b=2/4XUc3eF2oLqpOGUW6DjySCD6
	Qei4OfpMHYMfazagfAKwxZZRmBJPviUyLpgA1H00jFoKGOXn4NactfxFxzI3qe4uX0HrvEYOqD8Cx
	MXZKN1qABNE80w0iaPn1pfa3TA/mtfwryNNFYjh4iYPJVtbd8gN2kTdxGGyuPtuu5gS87GHIaaBjQ
	OOgOYJhnJFKGjiUg6Ma7C8/uJ9PsFPfnBw4HkZ3ZY8Q98Hfre8evJBK1bejX++rBIJqcguZ8rKbXv
	hxalypt33aV1dnvHt1ofL8bwQDzucuVpFq6QDRAYVjj9L5aO7taOL3rgUDBKecjki9Nf/nEcg0Uxb
	JJc21SEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puXvW-007oJy-03;
	Thu, 04 May 2023 12:19:14 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puXvR-007oF5-2r
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 12:19:11 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3062b101ae1so256146f8f.2
        for <linux-nvme@lists.infradead.org>; Thu, 04 May 2023 05:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683202747; x=1685794747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=it1Jg8DeNZi+uSQaZN6tyTLLss5U0nLB9ujTI6DLQlE=;
        b=PNndAKyf0dfd4pPVBT+56VP2kcf4a0SQ1am5UPb/9W0oBogEvAoNQ7MUJL6dV5PfwN
         SF4mMkTlRWshe5VX20x+yDYQfzWLWM/rXLWdY0mffZRbPnbqH/hlB0hBH9Dn8eppVclY
         pLfd9C1M9uzuvdQtuCv4BGGsBM9obxK9cVOUTk9XNigs+O2worp+3/POiLhinf/BSgYG
         oRpxl7aVUhwhL++2lya2QLOg6T8F9Hh0TEBHZujgDBaJHUhsW5+WwLzu6Las3RGfxcZo
         ljlI1wazy5ZK5fgjhU9hmuKqeZfF16u93oCYeNNt+2KhFloWn8AXXVNxJfH+QHm0cNyc
         pt2w==
X-Gm-Message-State: AC+VfDwLi3M7GoZwlaW/erV8K3P0RZt+odT8B9NyX7FxPnH1JsLnjemR
	lRNFViAosjIPHaVaJDct+Qs=
X-Google-Smtp-Source: ACHHUZ5pFqkNjG1UPGsV75RqUHWvgJLeZ2Ye5mVCDjBw50wrtT9suVc5ow9F1hW4QpWHoybLEEvBqg==
X-Received: by 2002:adf:fec7:0:b0:307:41a1:dc86 with SMTP id q7-20020adffec7000000b0030741a1dc86mr902784wrs.67.1683202747127;
        Thu, 04 May 2023 05:19:07 -0700 (PDT)
Received: from localhost (fwdproxy-cln-030.fbsv.net. [2a03:2880:31ff:1e::face:b00c])
        by smtp.gmail.com with ESMTPSA id m18-20020adffa12000000b003047297a5e8sm29871228wrr.54.2023.05.04.05.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 05:19:06 -0700 (PDT)
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
Subject: [PATCH v4 3/3] io_uring: Remove unnecessary BUILD_BUG_ON
Date: Thu,  4 May 2023 05:18:56 -0700
Message-Id: <20230504121856.904491-4-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230504121856.904491-1-leitao@debian.org>
References: <20230504121856.904491-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_051909_932598_78FE7F03 
X-CRM114-Status: GOOD (  13.04  )
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
index ed536d7499db..5e32db48696d 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -70,9 +70,6 @@ int io_uring_cmd_prep_async(struct io_kiocb *req)
 {
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
 
-	BUILD_BUG_ON(uring_cmd_pdu_size(0) != 16);
-	BUILD_BUG_ON(uring_cmd_pdu_size(1) != 80);
-
 	memcpy(req->async_data, ioucmd->sqe, uring_sqe_size(req->ctx));
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


