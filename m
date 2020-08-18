Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D7CC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 07:12:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 061C420658
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 07:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1kVznHDA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sl9W4fAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061C420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4CeU1cwMsxkL3cMBcXglH86FxmvmgrMlUpZmsityWNc=; b=1kVznHDAi9KajLuKyBFdo6wH3
	7pLAKDTJ6UJfubZZyDUijzg3NwDfzqk8MVM0u9bnG1glWSVR6Gk38PSnD6Pp44ToqTVOOW49+Fs2U
	jTdnTMfB0R0tNgV6Ol+0FDF2OdRB5jtQ1/6vrXqxtdjwzvx94nCvUdBv/pF7zrRo/2s/0fZh4NDSf
	0ixdYbMQkdB9A1Ad2hKY0j4eEcEBuL0/7FUBPD0LLS1zBcBfkXT4LoNmNgG/DhcjRuzRIQ0ChOY/H
	sUAqfpgyUSRl9+gjdAife8tUOAITlWQFzouVc3VRANYxIWDhI7zaIv4mOuEKo7FkENdhY+za48C+p
	c89z1/y9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7vn3-0001HB-Rk; Tue, 18 Aug 2020 07:12:13 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7vmd-00015l-S5
 for linux-nvme@merlin.infradead.org; Tue, 18 Aug 2020 07:11:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=fhMdALc23y22WFIGPH8T4RpaHN8OqbaoDj9KNCvRbFo=; b=Sl9W4fAmohAkwvRkerw0o/cEab
 /3x/AKHTUU8TLc/d4KxpOMs8MH1PFvRB+kRPhlul5zzQNGXgrz20sB+C5NOqT2GpwOINEg2v8LLJq
 iHzUMXiZp/5HaI6rinOJiIAhtQNOdFrFKZtuqLD27OoBygH19jbAQw6u0bgNfa+b0gRnmFAj4BKf9
 Mwkhsvh2Q3MN7UTt1p7+2Qg4QYxlVkUwVmAUm96NY5o+XTe8Bj+OZk2YaaYDnG4Sn2ohlf/NHViH+
 zTjhxF/Hm9up9ptkuS5X7yxMakIbO+/Mz3MdIIviON251TqSvOaTKNaism/mMyKd4k2OmBK+3BJFw
 LUaJrpKA==;
Received: from [2001:4bb8:198:f3b2:a8c9:886a:f150:c8c6] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7vmc-0005ZB-6N; Tue, 18 Aug 2020 07:11:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 4/4] nvme: redirect commands on dying queue
Date: Tue, 18 Aug 2020 09:11:32 +0200
Message-Id: <20200818071132.1136033-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818071132.1136033-1-hch@lst.de>
References: <20200818071132.1136033-1-hch@lst.de>
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
Cc: Keith Busch <kbusch@kernel.org>, Mike Snitzer <snitzer@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chao Leng <lengchao@huawei.com>

If a command send through nvme-multipath failed on a dying queue, resend it
on another path.

Signed-off-by: Chao Leng <lengchao@huawei.com>
[hch: rebased on top of the completion refactoring]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/nvme/host/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 36bb0fe9c7f6f8..a6785b86359fab 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -274,13 +274,14 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 		return COMPLETE;
 
 	if (req->cmd_flags & REQ_NVME_MPATH) {
-		if (nvme_is_path_error(nvme_req(req)->status))
+		if (nvme_is_path_error(nvme_req(req)->status) ||
+		    blk_queue_dying(req->q))
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
