Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51095C43461
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:27:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135A7207EA
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PSLXRVLv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FEK8HMMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135A7207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=K3ynbiXaIeGHS/2JTotc6hl3FLS1UvgRPwn7GVs+Ctg=; b=PSLXRVLvF0F1aLqRmFLPqdg+o
	ZU0OWGdIO7PS6WjB6VPOCVF9wrkIlzkvhUnLmPawPO7zCG057OYIYXneUbF+0+a/N0VCeyWe0zSIy
	TuKbKX85dwwhBEKE87+FDbPyHHVHnhqzqus8RLXAyB2lWKsxiU2IKfRHx2L6ZXL8SHgVBlQN1epxX
	NIi687SB7fqoYfK3ihlLt0Nq6u2MZenHil4kC4B7ilFbpmPb8VD93Fm08pbdHqU1PUiNlkdtaQjR2
	08g3RuH+Gq2Fb0RIHr9WHhsI7TrJhEZHqIs3xBkLLBk8EoMNtASn747Z+cM263sm0bjRB+KYgP1OR
	amaN0O7Nw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCsH7-0005Xd-2d; Mon, 31 Aug 2020 22:27:41 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCsH3-0005Vg-A6
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 22:27:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598912857; x=1630448857;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Le9vxQimsN6/9onRjyyvOHnJL2qmdkZoZwEOYlq5dtU=;
 b=FEK8HMMcxa1bJTSQyxmea8Et904B6LElkiooDKijlQLZW2qg86Pz7HfA
 lbbaLAXpAmd/fXBmHsbtGVBIuM1PuPQlUMOiQ6LlK6UUzPs8XxKgmNhL8
 bbT5CNN4DZ8MLfKi+6OOP4f6T5vyNfU1XIbI6RnZjHTVQgW3o/AZDro3g
 K8C5FYa4OMEBQwFbfM6FzvF1qhLMXA3lbQwZn0xXt1HSMcp7UNZQyOzIU
 iL/Mh1R/fVr/dte1HSEzQNvPN3yXoNLkv74C+lKV55NQ5NjibYujQirqw
 8RMoeU1M9wix9uLSmkmz6+0akmnGRnFaJFqHsfGAIW9pHok/dtoxICtd1 g==;
IronPort-SDR: A61R3EqXo4Ee9CMvFgSfcU2SlImDzDQP/aa9lPsz5DDoEV8DiF7CCdtfVoEZeBeuNk/UZ/rxok
 mgJ23gl3MZnh4f9DTKYw+QuYyl7ctKX1oMvCyuITx9SzSmlLMja54gnssIrLGkzoYMhopsbT+U
 5j6DJTWC8LnDdSgkVW9+MDZ9w9PL8wlCWomuciOJruaiMM3l+AYV7EmFK0SZ48Zl6pPLKj5nPv
 zpdszhXCn+DySkDz92FYgt8WG9YyMXJs3JQ94NGePHVFHu0WDr1fDjY8kT94ZLNthdk6GS9PmI
 YtQ=
X-IronPort-AV: E=Sophos;i="5.76,376,1592841600"; d="scan'208";a="147482843"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2020 06:27:36 +0800
IronPort-SDR: hCUOweE6CgklTHTJNLJnO9TkojHktKVdufI+05210vL0U4SOpYZ6GgBaLiinYr3dPM54drpAv3
 J6uYrzoQQiOQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 15:15:04 -0700
IronPort-SDR: 0p121oaPuNj+m1/giudzoz8GLMVpgfU0r+1I2jcz+vSeVtFCmZksXBy1S3GgYLos61y2ypqMcJ
 gE8nU1TG7kQw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Aug 2020 15:27:36 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 05/12] nvmet: use unlikely for uncommon commands
Date: Mon, 31 Aug 2020 15:27:00 -0700
Message-Id: <20200831222707.35611-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_182737_773200_A7559269 
X-CRM114-Status: GOOD (  16.78  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
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
index 682291fb6d7b..8f9c2144a103 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -258,7 +258,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
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
