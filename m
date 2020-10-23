Return-Path: <SRS0=yBWI=D6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41B1C388F9
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 19:16:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DF920E65
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 19:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nY7KaAvT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlTU3yUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DF920E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wL8XTxQX2aHPlb+wtRes6hs4lStHlvaN2mkBv7LD7oY=; b=nY7KaAvTs2ttz87pLB23co69/3
	i7zIgHOK4hwcndEa3iiHiMqDHOA7XO6Bq4y42FYRxJV39YRji5rmk5KYTsrHDjMswDfA3HuSGbmPl
	Zy8Kcq8o+lAfCDUB8VY39DDS+xwezdVO4QxpvizBJN4HjYcJstSzEU2a1VYZytI5G5DqWEigct6Wr
	QgqP1076w1ErI7bcXb4fHAPaRSAUv2nQvtu5fbeAsQMUDgiAVuuMOC8ZT58tOIcI2Tg9WDPuNZWU4
	4zJb9JTPBNTVaDHdyjm9aG//tY7RxU0Y1Wes0mB5OeAVo6YYpS19JY00obcmfuncgeBV6pC5fXGTa
	p2RSqSkA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kW2YH-000667-9f; Fri, 23 Oct 2020 19:16:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kW2YD-00065i-Nk
 for linux-nvme@lists.infradead.org; Fri, 23 Oct 2020 19:16:34 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A383720E65;
 Fri, 23 Oct 2020 19:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603480591;
 bh=dX2naa1E6pBP7uRWKjg3T365ORDSN0ZwDchDDAqQf2U=;
 h=From:To:Cc:Subject:Date:From;
 b=LlTU3yUSi9yNtZXKZpFhp1cDeP2O4K/kM+P4gq2PAiPadhY0A1Dz46/q7BRSmwJDY
 wobNAQTpWsi+VfE8kbOwrM3NnOdYJ1Qq7w2MmJ50Wq0oYAnOVO5nQZdUyy7TMXpa9F
 +A5CgzW2DQfUD4Ac/PQUPZduMxZL5xfqMFJ4vUqQ=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Subject: [PATCH] nvme: ignore zone validate errors on subsequent scans
Date: Fri, 23 Oct 2020 12:16:28 -0700
Message-Id: <20201023191628.1729393-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201023_151633_860581_638D4066 
X-CRM114-Status: GOOD (  15.05  )
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
Cc: Keith Busch <kbusch@kernel.org>, Michael Nguyen <michael.nguyen@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Revalidating nvme zoned namespaces requires IO commands, and there are
controller states that prevent IO. For example, a sanitize in progress
is required to fail all IO, but we don't want to remove a namespace
we've previously added just because the controller is in such a state.
Suppress the error in this case.

Reported-by: Michael Nguyen <michael.nguyen@wdc.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
Yet another reason zone management commands should have been in the
admin command set!

 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 95ef4943d8bd..376096bfc54a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2125,7 +2125,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 
 	if (blk_queue_is_zoned(ns->queue)) {
 		ret = nvme_revalidate_zones(ns);
-		if (ret)
+		if (ret && !nvme_first_scan(ns->disk))
 			return ret;
 	}
 
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
