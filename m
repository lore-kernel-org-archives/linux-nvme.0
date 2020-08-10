Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED98C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:55:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B147020774
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lwLFExX5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lUXJMrVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B147020774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tiLMl3tDlIjPmZ00F5uYcM7NegtAgovnasVtiCz9wxw=; b=lwLFExX54aoT5/T11DDtLZ5AI
	gWOIqZw5Bw2EaRiVPEiTWmWMWYLUvADFS6/R2ruleXgP2HvqWccP55VLC//r/+U7dPZmBHl9pSCud
	aByNaA+CTZ3mlucemeWlCkfBvHl3qoE8Q7XdxIlhccCmNix96goEB2WdmFsPKOGfh2IAlqHvPNx5k
	8j6jGBY8r2AndCHYpyN8VfAlFMu1csBqUO4qEP4ovNH6nDlmL0FkHj/AgnUbJMbR6V5f5Js/LL2Rz
	JcZkkRbU5M8kYz6zMRlIAXYl55K+/L2dowCVWsnwbQ09/Dy9oLAa2UHwHF5kCsQ4oK0OBZOQPp7dX
	0foWCejJg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Cxe-00077j-Qy; Mon, 10 Aug 2020 18:55:54 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Cxb-00075o-0d
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 18:55:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597085750; x=1628621750;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cEolTPlZCwGhUvrD/hK3RHS2jlip9mh6QDCpiAycjQk=;
 b=lUXJMrVU8NCF36zokG4xM0udaFpJiwN/MyBxxUXBtrWzfC/15vOwdoW9
 pJtdlwXv2HwUqM9wPTYLyhm25vPKmT6PNMygZrb6Isom0Zt/Ucs++b0DA
 gAzHZVvuLUlZkdQhr6YBjaRmfMs9s26uP4W4zOEoFfyhwV/R10/GpPHj8
 80V9D9d55LbaL2usOFj512LOXCaYjDNV1dizviUlg4EF6QyUKFr+Vvz9Y
 EOdKnShLk3zyQCGz4gtvLFj9OMMpYEhxhsCrBz9CCaMyxzHwMLfB88ij7
 N2gstK1ZSb6v2YQ/2g23vgzqPPfIfHI+gr/ZgVuXT1eM1BpzqgTtA8qds A==;
IronPort-SDR: lYhcxA36Kn3HB+vka7QKZ8bcHNUd7F9pFp7ATV44txYTlLlxlJWnRhOQ8FNIvNwcKBRU6O4nWB
 BpENIrTXW9GPwQnWx5OaBTSis8v4txNoBFCW1tvaCvEZwbqKsGINn3QQq+XVq+iM8Mr3itN4kG
 l1o4m7xlqRarox0RLux4mIOh9tcnM2TQTbzS26hqzVm2GG5nQm4+GGMfW2knizhIbtpNDnZS7k
 wH0qBbAVqDG7o/3xYgTkQ5PY9HzB8LHo/oFd8E40p5biY4oOeA7RtqAH2nu2a+Fqq48519xnOg
 iVY=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="144602305"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 02:55:50 +0800
IronPort-SDR: oLZgCETaOWbMGTb7WFKenq8+WoaqLvOVDrsd+gMAnEeIrSoZSiJL/0cSkCZ9t3nxUkBwRB0BWt
 r6dAIlcBEQeQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 11:43:01 -0700
IronPort-SDR: XX8r5quwPTLBG7BqQs6JMmHQq1vkLthPg3SJ3824NG8+Wgvw+su7OjiGJkQIXWjlkNCPKDtPDh
 w9jXTYM3Aiog==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2020 11:55:50 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 06/14] nvmet: use unlikely for uncommon commands
Date: Mon, 10 Aug 2020 11:54:48 -0700
Message-Id: <20200810185456.7713-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_145551_447229_45A20B45 
X-CRM114-Status: GOOD (  15.17  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I/O commands (nvme_cmd_read, nvme_cmd_write) are most common commands
when accessing passthru controller, most controllers should not
have set the effects for r/w I/O commnds (atleast I don't know at this
moment). Also, check for req->p.use_workqueue is true in two admin
commands only which are low frequency commands.

Annotate use_workqueue and command effects check with unlikely in the
fast path.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 9a175b8b9d57..00270e20c83a 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -254,7 +254,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 	 * which is typically in interrupt context.
 	 */
 	effects = nvme_command_effects(ctrl, ns, req->cmd->common.opcode);
-	if (req->p.use_workqueue || effects) {
+	if (unlikely(req->p.use_workqueue || effects)) {
 		INIT_WORK(&req->p.work, nvmet_passthru_execute_cmd_work);
 		req->p.rq = rq;
 		schedule_work(&req->p.work);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
