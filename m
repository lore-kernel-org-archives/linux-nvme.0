Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4013BC433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 15:20:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E0120866
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 15:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KBtaNJnJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TQavBIQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E0120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kjg0gEaxQ1LtQqEqMZuBNYS/hcFiY8qrso/jzEK5ar0=; b=KBtaNJnJmZpeeW0FwsBulF0tO
	BiXGnVjRcjW7C0i5Bs1jKImGk1Su5NRt+p2qi6/Yjc8Pf0mZ84hP+HjfY40tZB8In9yLECVlT2A1A
	F9ec0Gdzo7Ql8TM9c5CKHEid0EZPhwBR2nx6VgxKmKj25rE5HpL1xOcemTxYe9z2rgYEwxnDhrZXS
	OZlinOLONw4CylxMXHEtBhHhGrY5azZk49ilmeMjnTjxyDwJYVg0YmCnXtpXYUwGPlrZIIdEV6yL3
	Yv6vOCOKXowjhB7/jqie+mCY0N+KjqBhWRMQFXz3C1E7bPYbMa88SCXWJf+LQqOEiWK0+b8m3jIKl
	VXmj2LUwQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6bUx-0005WT-Gj; Fri, 14 Aug 2020 15:20:03 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6bUs-0005UK-LY
 for linux-nvme@merlin.infradead.org; Fri, 14 Aug 2020 15:19:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=0kp0ua0L2OHdf1RkVt13CGJO4wvMENyOsv0vAyiIQGg=; b=TQavBIQM60qlTUOHM0Y94qKF5C
 DiQwCIygdZXMgSm07QMik4a8pQOTvLO40dIvGJuq9SSlMcenIGjwElJ55hOToTwESvAWuItIOn3PQ
 0OYZQnik31zRudu2BrAs/3ilpgMzfnG5GtEQ1EFzCg0td/aq1SnEHI99nmTz+PqStyR/BFs3poV4N
 BTDdfFoHTdbTsU4Gj7+HirPulcxZq0YtMYirhQeRWo1pD9/eO/8OQLqLxvnK5TZytZgg/jEXP96qE
 zOH1TzZie5a+O+rvNhC9ae191d/TRzkYw7LO+VLh6y8K6HZWy7mKfFvN7sS0ZYAHTsMpB+VgJagol
 bNca6dwA==;
Received: from [2001:4bb8:188:3918:7a5b:6477:9ea2:acfe] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6bUr-0002Yf-6r; Fri, 14 Aug 2020 15:19:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] nvme: redirect commands on dying queue
Date: Fri, 14 Aug 2020 17:15:28 +0200
Message-Id: <20200814151528.277465-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200814151528.277465-1-hch@lst.de>
References: <20200814151528.277465-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chao Leng <lengchao@huawei.com>

If a command send through nvme-multupath failed on a dying queue, resend it
on another path.

Signed-off-by: Chao Leng <lengchao@huawei.com>
[hch: rebased on top of the completion refactoring]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8d474adad721fb..271cb9bf29dcd0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -275,13 +275,13 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 		return COMPLETE;
 
 	if (req->cmd_flags & REQ_NVME_MPATH) {
-		if (nvme_is_path_error(status))
+		if (nvme_is_path_error(status) || blk_queue_dying(req->q))
 			return FAILOVER;
+	} else {
+		if (blk_queue_dying(req->q))
+			return COMPLETE;
 	}
 
-	if (blk_queue_dying(req->q))
-		return COMPLETE;
-
 	return RETRY;
 }
 
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
