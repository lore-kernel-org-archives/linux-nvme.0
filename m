Return-Path: <SRS0=VrRv=6P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D55C47256
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 21:46:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473432166E
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 21:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rnJFdiYG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5FDcY5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473432166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9BT0r6zmoBu8R/vnh/oBTjbFDdSwdaEdVhWcch05dX4=; b=rnJFdiYGsqqsGM
	7prP6u3EhiHdVQg0u3XY4fD4coIZ4p8c7HR8sdZvflV6NCSwpoTyR8bPCfdi3mZwftuQ1tDvUo93J
	75/Qk5yFDpMrcRFgaoAp0SSzkwI1FFLa3+oxUKeqp/uYs6hBys6iynDRN7Kca25xaNwmhWm9DUz7X
	yqaRs8I59SpBaNeFP59VI0CY6RbfvnbXRPUdzrww1wUdfwGy/HieYgMTHwm3b8hPEOGgmOOlxPjje
	iO6H//ctatnF5fupVvRADjKljM4iIhOc2x9EGSD1hWjS9kZMTGVMJ7knaaOBphvSD7Kf0Fpo7OqeA
	xXXyey/YV64RdXF0IEhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUdTr-0008MF-Cf; Fri, 01 May 2020 21:45:59 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUdTn-0008Kc-Tx
 for linux-nvme@lists.infradead.org; Fri, 01 May 2020 21:45:57 +0000
Received: by mail-pg1-x542.google.com with SMTP id l25so2777015pgc.5
 for <linux-nvme@lists.infradead.org>; Fri, 01 May 2020 14:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qotpNYJ8KdXXgcJkLqubIqFiJTfjw8xFeCbNWvxpBPE=;
 b=f5FDcY5p2QIUUPTnLY25WWoPOohDxfCxljx4bYoOUNZnhwCmXTPSaBrmRTuA4UmMdy
 emn6jAwfTXjuzdg3H2WzPR5dBHpEp9Cuvajo1AS0smD+dPR3Us/vA79hcftZek/q6Rpk
 0Ad83sRNlABMdJcVD4ZcIf95qyK3PnQDMUVmwsfF3bhLfqJg6M/yW0i+IHKfEj9VZJQ0
 WFgFaxkM1J+tExMZuUpGUytOkn5M7kqLOHlwmx81psYr9u/JJLziJZoZiB310GY1SovR
 rQl4IkP2E4kwxaGBOelKvQ042UrRhLmmkEenrJLU2+L9NjMvXrDDYmqpRc/8IpTGXELN
 F5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qotpNYJ8KdXXgcJkLqubIqFiJTfjw8xFeCbNWvxpBPE=;
 b=pG9P/56T6f1j1MJnCMJ2BMhpV60mIxZpN1aNOk5zU0dd6tsL1gvDj9uwcZ6obTkqAL
 dr1c1139mPxNiNCmaLMquFjjYJvbcpXdjb7D9hI+D4RtyU0dotE50dEe9MQWorP+Rrln
 ZON1skQGGtVPa6TJFbXoaJUlqd4pT8igaW2rFEvUB5q48/SXnxFf+41maytx6Z+TKIY2
 FUET4ZYvfW4lcyV7wyY6AkMQUDN0gUNTG9sr1PxqysaRM3aaHhPDi6Y+Ea10c7+w4/ly
 RkYFtr0mkxSM9PAoEPAM4LBzPm6WY5jH4K4LJRjMNDEppC8uWtF7+Ry7picmCn/9Smnp
 Mytw==
X-Gm-Message-State: AGi0PuaxTB35Lil+9ZfjSArVXhvMYWvUrZcKKqQcrTkojD8olD7SDBDk
 kkdIsECU86N3AoaGX+LvBIvu4Rhy
X-Google-Smtp-Source: APiQypK0dLXkuHlvqY4b+rjYKkOA+HpB1jbEheg3ZhxIoyf9d4nflofm7USLd/JW/kQ/y+GRnZabcw==
X-Received: by 2002:a62:25c6:: with SMTP id l189mr6221873pfl.28.1588369554260; 
 Fri, 01 May 2020 14:45:54 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a15sm522163pju.3.2020.05.01.14.45.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 May 2020 14:45:53 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-fc: change default devloss_tmo to 30s
Date: Fri,  1 May 2020 14:45:49 -0700
Message-Id: <20200501214549.95949-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200501_144555_969526_D619A8AF 
X-CRM114-Status: GOOD (  11.76  )
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
Cc: Arun Easi <aeasi@marvell.com>, James Smart <jsmart2021@gmail.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Transport default devloss_tmo is 60s. However, both lldd's use a
driver default devloss_tmo of 30s.  Rather having an inconsistency if
the transport value is used, set the transport default to 30s.

Signed-off-by: James Smart <jsmart2021@gmail.com>
CC: Himanshu Madhani <himanshu.madhani@oracle.com>
CC: Arun Easi <aeasi@marvell.com>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 1921d2195541..0aa3767cbb1c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -25,7 +25,7 @@ enum nvme_fc_queue_flags {
 	NVME_FC_Q_LIVE,
 };
 
-#define NVME_FC_DEFAULT_DEV_LOSS_TMO	60	/* seconds */
+#define NVME_FC_DEFAULT_DEV_LOSS_TMO	30	/* seconds */
 
 struct nvme_fc_queue {
 	struct nvme_fc_ctrl	*ctrl;
-- 
2.26.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
