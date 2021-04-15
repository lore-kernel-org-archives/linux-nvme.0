Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587CDC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 09:06:58 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B927E610CB
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 09:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B927E610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=twMtv5d77TB0e0iGek+YXe/to24u5gEodov3n5eJLYw=; b=KrHHYZBr6bOLGh5i+3CdYeC95W
	G4DI3eb5DdLAJ5VUvew/0nwpeXPDeAbJINAhmKIUcwpCWXyw5WBb3t+3y++/TJfl8+BB2nK2Wga3s
	NIWIwrQd+xmhK1u/0RGvjqh9UswbA/jMFWSCRxgAVpOaOTufcl0pYwRPwjzXE5JlZvGREpYqEIf51
	dgUjApmQjvacGTKr/HKvHBtHPvFwOkjx311KHxxNwdHJSVROymCBShpmkF1OQNuZ/33xe9jlMgNKc
	n4pA0olF+GVzwuc6NL2RYDJ9b+/TCFJbvOIPcG4mKO57SNIAKfxGqBUrah01vvrMfOYF3SVlJMVYd
	qNk9n0CA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWxxN-00FSEV-8J; Thu, 15 Apr 2021 09:06:37 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWxxA-00FSCI-R0
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 09:06:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=M3lrY34veeEJKRlcX9a/uEBcdFU5CIM+KgKP2UYU3d8=; b=snh+hejbLP+sqHyQ0OzP2K1M9w
 7jXc1ZhevEbb0xChkEbQf5wP6vtNMXfog8kP7e6Ir1+R0mxus4o0x6z6hH+O0x9I9cDJ3GLe8Rdx6
 cKbsvVbOcZyL6DqisbLYFbD8Iz0Ts92qTfr5ZIZGpxUljT+8SxjOaNnC3e4w8f/PA06R02L5s56Wg
 9AylR0VGZOv+1iDfh9Rz6+iTRcSzqX9Rx3vACql2Y+t2lRkJBJ3NIsrd8Oi+Xv7cWOT+bXZxjdbaz
 Rj/vTuhEGYWcfQf1s09D9EPqOqLo8JWEZ2c+2t1rlR7yfILxc9+ncT6q6z5IaZjxrWi/nXqGr3Dzb
 4p3EVo+Q==;
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWxx7-008PRK-E1
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 09:06:23 +0000
Received: by mail-pf1-x42c.google.com with SMTP id p67so10692182pfp.10
 for <linux-nvme@lists.infradead.org>; Thu, 15 Apr 2021 02:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M3lrY34veeEJKRlcX9a/uEBcdFU5CIM+KgKP2UYU3d8=;
 b=SmkRWtr7TDJvtKGFylPte8KdszA+I1lnkobtNykP0qsJyk9EK6lURJSBpq2LcR+XIE
 kLgfWbREJa2RUnWueIUU96YnvsfzZHNT6wXZk/q6rqsJGNFiY1+Q7cRUUeveqHstTahs
 iZK5T0qjTjp4Z5FK2wkew8LnTStlGiaXYdyguvOBeQW3RNLcd1MJ4e2yMv0uVv4tTDh3
 lEm0AScdydf7tjslgRkGLZG496GQh4S59Wbuvt730vEtfGfrhxY0FflQsfB+onKlgC20
 K2CbvKal/fPhNhc98eqzQEzrwXtPXUslFkpHCtNfPH1bPHzwgY/NZuGlwUtdclbE7B5P
 2erQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M3lrY34veeEJKRlcX9a/uEBcdFU5CIM+KgKP2UYU3d8=;
 b=pIV4HruJ6c5XzYOYhKwGnQKdK+1FxQQuOH6ukmNObFpA3roA/uc6J9ua+NfRyWhjqr
 qWdyogRMsUXuA/x0UvrlHil51NgtUPQxbFh1hrmVjEC36yKEbYL/P/27SMuZgYpGDYy2
 eblRc+8jr6t/jougqQkvZYOTXvrXeC/BEf5FCxoSXCOPUo2ciMK3U1zFG9gF2KqxK5/l
 oPbYDo2GkyCEQEsfTPTiYiZVdW4H0CJaRDzE9T1fSEt8uE4tt0OGuMpysGivE3fFKHW3
 OYL9SHP2HPohpQVGJ7WbYMrJcYzXsjOxy/yC8rrPzmD+bVy3COmxdk98NeDZgeQPBWzn
 OkWw==
X-Gm-Message-State: AOAM530rdcxAopYC4Ngf7k/4uaG8QCrf4DNWJ19BJvA5Vv56PgixRXs2
 bfRBMuPKZGpdOLCclR8i+U4=
X-Google-Smtp-Source: ABdhPJw5B52v4BO3rSudWJyKWnRHZ4rIgPk69GU3Tvqj11PtKCDhfnt2qSNq+aA0Yvmd4w09p4KjsA==
X-Received: by 2002:a62:e20f:0:b029:258:ba64:e43e with SMTP id
 a15-20020a62e20f0000b0290258ba64e43emr111085pfi.44.1618477580236; 
 Thu, 15 Apr 2021 02:06:20 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id gd13sm1784550pjb.56.2021.04.15.02.06.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 15 Apr 2021 02:06:19 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: sagi@grimberg.me,
	hch@lst.de,
	chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org,
	houpu.main@gmail.com
Subject: [PATCH] nvmet: avoid queuing keep-alive timer if it is disabled
Date: Thu, 15 Apr 2021 17:05:30 +0800
Message-Id: <20210415090530.2353-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_020621_489149_DC666599 
X-CRM114-Status: GOOD (  10.72  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Issue following command:
nvme set-feature -f 0xf -v 0 /dev/nvme1n1 # disable keep-alive timer
nvme admin-passthru -o 0x18 /dev/nvme1n1  # send keep-alive command
will make keep-alive timer fired and thus delete the controller like
bellowing:

[247459.907635] nvmet: ctrl 1 keep-alive timer (0 seconds) expired!
[247459.930294] nvmet: ctrl 1 fatal error occurred!

Avoid this by not queuing delayed keep-alive if it is disabled when
keep-alive command is received from the admin queue.

Signed-off-by: Hou Pu <houpu.main@gmail.com>
---
 drivers/nvme/target/admin-cmd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f4cc32674edd..b8a33d1506ba 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -926,8 +926,12 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
 	pr_debug("ctrl %d update keep-alive timer for %d secs\n",
 		ctrl->cntlid, ctrl->kato);
 
-	mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
-	nvmet_req_complete(req, 0);
+	if (ctrl->kato) {
+		mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
+		nvmet_req_complete(req, 0);
+		return;
+	}
+	nvmet_req_complete(req, NVME_SC_KA_TIMEOUT_INVALID);
 }
 
 u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
