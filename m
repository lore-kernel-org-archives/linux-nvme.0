Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBBDC433E3
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 08:19:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6EA420738
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 08:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2vhLohEZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qJl6i7O7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EA420738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=i+eeFf0oHi3vg2KoTHfyr6aUVb1ZUMibmsKY8cLEL2Y=; b=2vhLohEZaZBLgFJnkMU9If9J/
	7s5UPXs7EGIJ+tZRtrgz1CWwtLlT6uhIaY3FpXJ/YMqwNwVtHiUBGfNQwerI9SuO/jvMMrvdJ4j2N
	qXTDad4dTQefp8WQproyCs1mEASPzeNGzfDmZhMkE0FHKy5YWDdSyDsZh4fFeUXs6lEMAqiKnA4pj
	jya8+XcquzHSIbyAggUmqzkINZP6IhkNEpIh3vATDBxct5+sCHZYQSyd6P227qAWoTBGgxi1S3R37
	hbVrEBVd2nDoE72qYYOTPvvSHxy+n8IAvefusIW5jVzsnQ40Jyq5Jeg9Cx8FMmNx4SfEGusCIqNwa
	Yg+HH/n+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7aMv-0007wC-6u; Mon, 17 Aug 2020 08:19:49 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7aLG-000791-3j
 for linux-nvme@merlin.infradead.org; Mon, 17 Aug 2020 08:18:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=oOiQLMYi8Yod4J15l1ognWivc66CUvPQdjE1dkBwaEU=; b=qJl6i7O7vf5XzCK/H3/xZOz3BI
 CcWyC79PddEe2Q1mr13IErlBuPMVQNHfAWXwUH3KOWS9Hmz+DRCLgvNyR9MddFf0mwNGOCYNZTqIi
 oMHTtjqpwgO/VJ+eBB/BKwkP65SS8ox1lAl8ROM+jX5RfCil+3NerdcLWKzfz6KzU8OKjjmhpb2EP
 nWZAu9WeSUIdI2K94W1a/IWlSl2Prdj2UNWmEvtYUlb7k4F7/6eMIkhie3NelB2ZHuevTOb5XLDgm
 6pjQZXHfi/B2Bzm/azLuArDn+HD2bMPFGUI5Na+j6FDW0pn5uFMl7DklIZ/3qnWHSSaV0Hr5FO5gK
 isXvZscw==;
Received: from [2001:4bb8:188:3918:4550:cdf7:3d45:afb9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7aLE-00047U-HA; Mon, 17 Aug 2020 08:18:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 4/4] nvme: redirect commands on dying queue
Date: Mon, 17 Aug 2020 10:15:44 +0200
Message-Id: <20200817081544.837699-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817081544.837699-1-hch@lst.de>
References: <20200817081544.837699-1-hch@lst.de>
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

If a command send through nvme-multipath failed on a dying queue, resend it
on another path.

Signed-off-by: Chao Leng <lengchao@huawei.com>
[hch: rebased on top of the completion refactoring]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
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
