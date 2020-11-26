Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233CBC56201
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 02:42:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A67207BC
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 02:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OFHwNveP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QiL/qLO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A67207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QmZbNxz276iLlLPnV5+LNvJULN4MWuYMQCDbJpiL+8k=; b=OFHwNvePJaiUF2Zg4NFmSoAaL
	AENmBroTrgMhWz7aMs6kQT7wDLPQlqG8czVtsRwpGd5KXVL2KvL+w2bG5SzdqLH+X6dFqIwzaUpAo
	7cm0NdUDpzXzG+tHvs+FqdyQ429vwht6jLB4xbZwoGRWDL0QEA5BjulcOjRtXsRcCbwOuKNiJ9KBI
	8Pb0BSrDrAj0prGRe/ipW59ZtJIbSGR6DdPVIQBxd9zwYpw+LEZ3ppuRZuwEQHHVGBeRbjz/e+LuQ
	regsjMxU6NJoOlgGrqMCUozK+yXbdj1isW7p19pd5oSWu01FKGg1f7pFzmqKrNigMrXCRuvtLh+yO
	u6VRw3pWQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki7EV-0005NO-Lo; Thu, 26 Nov 2020 02:42:07 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki7EL-0005JT-1Y
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 02:41:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606358517; x=1637894517;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hUhzJ651cVoNvniIQeg3wff/FCoz1DE77FDFCSJt0Zk=;
 b=QiL/qLO+b6/bIlcjaMF1pkSbdGT4e7x6dABllb48MiVEpDSLYfGBt9TV
 xCB86idt92Dq/tQT7Fa10jOU0ATT5PzDXwherRx7gnPCJGMcZuLabHxNS
 W++de/9O6rG55KMeAKSVZBMbO7KWMgi04pPWrGrRNRLNuWmM4yye/HcH/
 5SJGwejItjLO2Y3CXU/z4qTIA9ee0FvEZYt0sOCKHn5jwHN2nLcsOOApJ
 nDKLLxcCg8Vdowlc90YuBsJrcBpTAoubT8KZvQv56EoxVKv/UpM1kP6hD
 ul4obe245bLpP/dIgkAQy/JDEvnF6NwaxzAw4vcxGVosmD6f9e02IwERt A==;
IronPort-SDR: IXUzKO/tzYz7nGreSsUYPGFRfJQzSTKqrm0NXV8JdEiJGuirBPUY2OQJSHkCRpRc/pBl7TfIa6
 WvpxtyrZ9Rmf/5Fgoxfv9cmTT3gKi0wkbqsQ/bSSe+I5uRcxre4u6MpnEfIAq7p3fBPBmD35FT
 BMhYiGEbKbHdPuB42o5xAKAIUIawda5IG18RKnTgN1JFPp+vIHVk+Rrjz/B1H0odgc4C8rP8J6
 N0nhXJBT1aftuJwx62aSyRWNufFhkdYe8gJxpJRan5D0ZsvVmJdlFcx2FDoNHDdQtSJaY7Qkgd
 +QY=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; d="scan'208";a="153445818"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:41:55 +0800
IronPort-SDR: /1NLZE6KJu8fxBclLReMyDzCKH1rtzldUhbH1KF2HhtR1qKGSO37M5aeCFHL0U1WbJa1Tl5uah
 ijznjB5TMo+5gptqVNsRWPG0Q4tSFJJVs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2020 18:27:38 -0800
IronPort-SDR: OQvfIqn9EiwcYC7awggW4nUlJ1jJ8l8UvELmdegT05BX7QVx4OJyNRt0t/Ln3dOxKG4z0K6RKU
 OXzggKKmNl7Q==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2020 18:41:55 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 7/9] nvmet: add zns cmd effects to support zbdev
Date: Wed, 25 Nov 2020 18:40:41 -0800
Message-Id: <20201126024043.3392-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_214157_527749_10959F46 
X-CRM114-Status: GOOD (  12.33  )
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
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Update the target side command effects logs with support for
ZNS commands for zbdev.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index cd368cbe3855..0099275951da 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -191,6 +191,8 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
 	log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
 
+	nvmet_zns_add_cmd_effects(log);
+
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 
 	kfree(log);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
