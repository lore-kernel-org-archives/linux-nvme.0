Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CE7C2D0A3
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 11:39:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56486206D5
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 11:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="04Wow30P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS1wFV9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56486206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jYK2FamGCUNKvSfvVs2Uv3sqPYaPs4yV17a/TdS/Y+U=; b=04Wow30Ppxgo0ZUfjkCAy77QjG
	LyQgvd23byooV9fA8hDKGdP08inSkCF+rMdhZhS1+pYgRdw4u+5p1FKcetiznkKV/dBOhmvIl0D6n
	/NeX1rs8912EkCXGMVC1ZB0l2qzUWKg8zd8o401tzCC7gu3cnipx/jLF4YiLXjzYHmkf0LvBUo61R
	wV8Z/9MRPzKvGohoIUEM93894BNTX0NOrv7O6W/mkTH7A8+kzkmcoK9DSS8FUmTeqfXlDcMn7LVwI
	NVpqDHi5r4I67R5sGcBw7zFA7M4RXLqUtw+jpRuAy4Aubc8gu/8kbPs8NwRsuyFPRybvf+AS/WsX5
	V30mkc1w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb05s-0004r8-5N; Fri, 06 Nov 2020 11:39:48 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb05o-0004ql-Ci
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 11:39:45 +0000
Received: by mail-pg1-x544.google.com with SMTP id z24so740512pgk.3
 for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2020 03:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=XcoevMCyTf4gd+tlI+UZVZIw43UhfanB3uGdL+RkfHk=;
 b=QS1wFV9ZXDR4rjIYGC494C6VsDVg0dL6pj++5dFudH/8Y2Du2ds3alRUIcZKqGpACB
 50OVhap5QUnIST+bg0BvfmTatPlSVXpLvqccyLC8KEyC+IBt379SROD/HMOmdFBSS32g
 WIeBWKKu66AbuPim0xDIRLnnlDazMT4phw0pfGfHOwtzoPUtVLusoNO4gVg9/JdZT0YJ
 iN3ZR7sHIKB3AGQ8dzyxmt7IeW2Qwx53NO3owogFFLUjeP9opSfVA2gs0jycGIgBJvmD
 WZV+7bVwcZIsGXlLANKYswQ4ZnuVxlUfn7RH0+m0iIkjLmC74RX9BP5pNbjSjbhQsMZb
 Yu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=XcoevMCyTf4gd+tlI+UZVZIw43UhfanB3uGdL+RkfHk=;
 b=EHhNKzAcbOSfwYGoZD7PW8sCE8Pa2N+YeDWJ75YZTClVhAh1dWDvCGgJtfJSyUHTs+
 9B0hkZOMpdqutwncglsssGtsNqanigIKldXZ4Q0kx7WcJW/IROZd4AS85cFMwkHaOOg9
 fkp6dtxWJeU/8tZCgbon2SHzbEAOGWOnt1b/2Qrbz7kFeCPEZ15iObi++RjWScGnL/XN
 yEUz4LFYfaAN9HhuF5o7+ay/N1tCjG7s9HtY3q0YpJWROsKydxuw5rz7Z9WcI6i5+iPC
 lp30ckkpacZlnNlU5SY76r4RYZLcS2ZODr/g8SfayqxRpz8NVMj8c8Z/bT1i/wbv/qur
 jv4g==
X-Gm-Message-State: AOAM532R0RR4p7YIuCN71i5AaCVvvmDwqKT5YZxYLDYTYM3EqFTgUxl0
 UEw9Pxh8pZnBhMSVdv/gVdR4FQX6mSgs1A==
X-Google-Smtp-Source: ABdhPJzjFCFPvugrLJ8NIfzMoOoDfHBhq69saHPDOgdTzLSKvH7YgaHle5MwJqj1m2Tr9EGiLRQbHw==
X-Received: by 2002:aa7:9255:0:b029:158:ca2e:3f33 with SMTP id
 21-20020aa792550000b0290158ca2e3f33mr1642276pfp.59.1604662782071; 
 Fri, 06 Nov 2020 03:39:42 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id e184sm1846399pfe.146.2020.11.06.03.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 03:39:41 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: remove 'qid' argument in case with nvmeq
Date: Fri,  6 Nov 2020 20:39:28 +0900
Message-Id: <20201106113928.14013-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_063944_477174_3628CBC7 
X-CRM114-Status: GOOD (  15.15  )
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

qid can be retrieved from the struct nvme_queue directly which might
already be set when the queue is allocated in nvme_alloc_queue().

This patch removed qid argument from nvme_init_queue() and
nvme_create_queue() and replaced with nvmeq->qid.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/pci.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0578ff253c47..fec79b5246da 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1505,9 +1505,10 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
 	}
 }
 
-static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
+static void nvme_init_queue(struct nvme_queue *nvmeq)
 {
 	struct nvme_dev *dev = nvmeq->dev;
+	unsigned int qid = nvmeq->qid;
 
 	nvmeq->sq_tail = 0;
 	nvmeq->last_sq_tail = 0;
@@ -1520,11 +1521,12 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	wmb(); /* ensure the first interrupt sees the initialization */
 }
 
-static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
+static int nvme_create_queue(struct nvme_queue *nvmeq, bool polled)
 {
 	struct nvme_dev *dev = nvmeq->dev;
 	int result;
 	u16 vector = 0;
+	unsigned int qid = nvmeq->qid;
 
 	clear_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags);
 
@@ -1548,7 +1550,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 		goto release_cq;
 
 	nvmeq->cq_vector = vector;
-	nvme_init_queue(nvmeq, qid);
+	nvme_init_queue(nvmeq);
 
 	if (!polled) {
 		result = queue_request_irq(nvmeq);
@@ -1699,7 +1701,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 		return result;
 
 	nvmeq->cq_vector = 0;
-	nvme_init_queue(nvmeq, 0);
+	nvme_init_queue(nvmeq);
 	result = queue_request_irq(nvmeq);
 	if (result) {
 		dev->online_queues--;
@@ -1733,7 +1735,7 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 	for (i = dev->online_queues; i <= max; i++) {
 		bool polled = i > rw_queues;
 
-		ret = nvme_create_queue(&dev->queues[i], i, polled);
+		ret = nvme_create_queue(&dev->queues[i], polled);
 		if (ret)
 			break;
 	}
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
