Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDD6E63FFA
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2026 21:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Vqjn8PI0owOj+dl3IsGnOnkCkDv7BUM2CiLCXiFENmE=; b=YVv2JgutwOGmixXn6SEayVk//9
	PC+I/MMWm84/2dBaYFBQnHLr/8Sh+JKniWiRXINAWKoJzSUKXBCejujbtO/OMX2TfVvw3p5plTu/N
	QC6chVCvLXV+zF6nAVhnjgitEquxF7pJa34ywfsZ5NUxBVStgtvBhf+BFIxiNbIw/reTJ8ivcOjQm
	utu1UoN7dZCKRjlQefn9eDmGgviVcMCyJiD87uB8uTeUPejvDs8zToH9AVwC31UKfIh2pF3ynt0Rb
	23OkV/iCfvdWTVmeBB+isF9hkQS1WR8qwf30MXt5jqfRkiScEHiXxrIdtnhaWd+HhTwRHkSndyLjI
	57XVhobA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w98T9-00000003l0y-49ly;
	Sat, 04 Apr 2026 21:23:51 +0000
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w98T7-00000003l0C-0kIU
	for linux-nvme@lists.infradead.org;
	Sat, 04 Apr 2026 21:23:50 +0000
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BFE443F18C
	for <linux-nvme@lists.infradead.org>; Sat,  4 Apr 2026 21:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1775337826;
	bh=Vqjn8PI0owOj+dl3IsGnOnkCkDv7BUM2CiLCXiFENmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=T6z0ImG47AwksPDYq4Ip4LxmvkcYIYeKWxROez5p07dcYPse/AyNfjpTW3rJm3mkO
	 tOT8R6XozAG3ZICTHPkBtxTOeNbnKnNBpt3UPcRnVCTfKTqQlPMEHj36mGzxNggPSR
	 OhIhNS9BiGqWdtCEYAkCCK+iBq9caiPq5D2MzwTmJOCYEgrwXSaOG8mkKnjQBvmpT7
	 eX2M9QGlqVbsa2614pN/BxWbkNRDYh1B984jLTwt7dmcf+OEIhyPlt7A+j/O0I7HAb
	 /0GyOPGduDYRYH0ysZk4Og/Bfm/pDyOuJcuyUVbiri648acK75//4M6WqcsH+TEjmN
	 qlKjPOLf1AratUkAqgoPhHAiti5ceKtXeRq4O0C/ajxXRRUr/UyyXq5wEi9Q0agtu9
	 Sw/bkW86kh1kFkc5VmV0G7jnoDLZ050eZOS4hZGbF7xFApo3Hd1QMcGaHdQHvLRjrw
	 Bf+L4+JdAWydvBApZ4hHWJHwM9ckbN746iMXhAszBJejwU7pWcgjHD3awlYFjLiPsC
	 z8rdI8WMEsl4xp/fD+E+N+zHcaLJ6Xhxs0LWE4ER2YjuNJ/1/rFtTLv10ivFfV3mjY
	 LiQBkQIrEU3HgbFvI6Rq+1BQRF7+EKkMkO3+5oZjlOTd9kYthN+RPlIdw/6sSCBrsk
	 pcom9ykGsCgLmaehgIzS1Cxk=
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d0de4bfb7so4237108f8f.3
        for <linux-nvme@lists.infradead.org>; Sat, 04 Apr 2026 14:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775337826; x=1775942626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vqjn8PI0owOj+dl3IsGnOnkCkDv7BUM2CiLCXiFENmE=;
        b=EuoVs0g0OXDt50Z5Kgl3pkL8ofVT0BhRvLMU1yfncbviqjfvF0ROVi5NsYThbRrD+4
         +gAfZxniBESPDkEe+E5EKrGN7Gv1buEI60TY1ix8beetfhlXYStdBQNPFbrpTMQ0PzNC
         p/PifeUa/jcdocdTp176wTdI2rYOJ7ESHSwqj1iF6zyNklWJJJoKKYRZNzZUnvx0ymwY
         SQc/mU9rbrqiBrHEmIy0QePMi+AzLFfqowh5bb9+brzNR269m94V5a4guKWHeyAAIB8m
         XMBGHsp8SN425zPWbYMw/lfwj5fvjuMeo6yeqVmfTYp8QQ9XQivCUcd6OC3/ENAlBk99
         kxVA==
X-Forwarded-Encrypted: i=1; AJvYcCXRWViN8STz5gJrbxxizMVGu2E/1BOEy3WhDQJ556CNp9mk4n0q1y5KwbltMzeoV0t1HMOYr8LEj2N8@lists.infradead.org
X-Gm-Message-State: AOJu0Ywmim5zXJFtHjllIgzCS1H6lXgYWDmdCllokCpPrUotT1wnCSO1
	gntmD6SYnQbK/W5BgsfEofwi0L/sYPOkrgHKn+b7Fdla87hA9ha/maULDbA5DHoqHbuxmrSgV30
	n9zXT5/9vLKNzak2f50bOgHAB8xfly2JMvgclMBElBybxilV5ndewo1ShCB/XfUe9SGRA2fAHJS
	6W/k3ahkiI
X-Gm-Gg: AeBDietlWLvrJ/N0/92kmrjlBDLKDHAu6aeOYQuPjAMT44KdBdIumomfAyZvqIht7vf
	2WTrQHStFzXZx0lBV3MUH6WZ6MfIclblIuliDp3zpyvyKDamVbQPa3YVFMuNnkPUHgCreeGKAMv
	+pCJs9mWiZX/zbkevDvO7ncyuka+IM+gJLmrzMVLihaVOUM1K0jl3ExWihp3ZGsj4vGknyD9o04
	5N4BFS1fOHKX8J/C4cPITEYfef88VgfXjUQlwIXR6Nm4nkh1VL+OwQ4BRXaYmOqe1RLmwoxlScK
	1PerWA/qanLH/1Qbvvh1HOoQL6ZI9SoNlxkOEng6SinBiNWmSbtipdkPIbpFRx3A/PRRoy+1h+n
	KIoOpcpUk4ppX+bT1+IdcZKk=
X-Received: by 2002:a05:6000:2313:b0:43d:855:f161 with SMTP id ffacd0b85a97d-43d2927f945mr12169365f8f.11.1775337826291;
        Sat, 04 Apr 2026 14:23:46 -0700 (PDT)
X-Received: by 2002:a05:6000:2313:b0:43d:855:f161 with SMTP id ffacd0b85a97d-43d2927f945mr12169357f8f.11.1775337825900;
        Sat, 04 Apr 2026 14:23:45 -0700 (PDT)
Received: from localhost ([176.41.26.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5419sm32068643f8f.11.2026.04.04.14.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 14:23:45 -0700 (PDT)
From: Cengiz Can <cengiz.can@canonical.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	ioerts@kookmin.ac.kr,
	sagi@grimberg.me,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 5.10.y] nvmet-tcp: fix use-before-check of sg in bounds validation
Date: Sun,  5 Apr 2026 00:23:44 +0300
Message-ID: <20260404212344.1808777-1-cengiz.can@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260404_142349_372633_668ED653 
X-CRM114-Status: GOOD (  14.82  )
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

The stable backport of commit 52a0a9854934 ("nvmet-tcp: add bounds
checks in nvmet_tcp_build_pdu_iovec") placed the bounds checks after
the iov_len calculation:

    while (length) {
        u32 iov_len = min_t(u32, length, sg->length - sg_offset);

        if (!sg_remaining) {    /* too late: sg already dereferenced */

In mainline, the checks come first because C99 allows mid-block variable
declarations. The stable backport moved the declaration to the top of the
loop to satisfy C89 declaration rules, but this ended up placing the
sg->length dereference before the sg_remaining and sg->length guards.

If sg_next() returns NULL at the end of the scatterlist, the next
iteration dereferences a NULL pointer in the iov_len calculation before
the sg_remaining check can prevent it.

Fix this by moving the iov_len declaration to function scope and
keeping the assignment after the bounds checks, matching the ordering
in mainline.

Fixes: 043b4307a99f ("nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec")
Cc: stable@vger.kernel.org
Cc: YunJe Shin <ioerts@kookmin.ac.kr>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Signed-off-by: Cengiz Can <cengiz.can@canonical.com>
---
 drivers/nvme/target/tcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5d8e57e5fdb1..6db9dcdbb3c3 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -300,7 +300,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 {
 	struct bio_vec *iov = cmd->iov;
 	struct scatterlist *sg;
-	u32 length, offset, sg_offset;
+	u32 length, offset, sg_offset, iov_len;
 	unsigned int sg_remaining;
 	int nr_pages;
 
@@ -317,8 +317,6 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	sg_remaining = cmd->req.sg_cnt - cmd->sg_idx;
 
 	while (length) {
-		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
-
 		if (!sg_remaining) {
 			nvmet_tcp_fatal_error(cmd->queue);
 			return;
@@ -328,6 +326,8 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 			return;
 		}
 
+		iov_len = min_t(u32, length, sg->length - sg_offset);
+
 		iov->bv_page = sg_page(sg);
 		iov->bv_len = iov_len;
 		iov->bv_offset = sg->offset + sg_offset;
-- 
2.43.0


