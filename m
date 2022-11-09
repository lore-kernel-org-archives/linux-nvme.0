Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1056AC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PXTOKLp0bJTIuBuXkf9iCEM5dhJDIMDvm1n5Ip7xGqg=; b=FfjYtLdAQvxLW9jdeXWV+hQ16T
	jz0HhzZjtoEEP3b8/DstvC4LoAgQbtXMAXkojDWLCvZelprDNPgVKg0v0m8AQd84tpP1r6en6dMWv
	LZwyml8nc8tAQCLemNQN57OOiMI/Mv4GmdBOwnqchBMUe+dFDveQ0TdV7n8aC3vJNrrhdG8u0iMRp
	lKzNamhXURXw/lZQ+xZx649wWVce+ZUfpG2ONCbEdJjOfON0MldK+KaorDsOgFBSa/wGQmuQIUXjF
	j2xqyqq2pbgB/hZ9YyStGA/L5jx8EMeHa7TkdQW8TwEjrLupIsVzxUJTQWZflcVyGj9StLbhheEER
	P0hMQ9GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc47-00APiu-TE; Wed, 09 Nov 2022 03:47:51 +0000
Received: from mail-pg1-f177.google.com ([209.85.215.177])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc14-00AOQN-VX
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:44:44 +0000
Received: by mail-pg1-f177.google.com with SMTP id h193so15103982pgc.10
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 19:44:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXTOKLp0bJTIuBuXkf9iCEM5dhJDIMDvm1n5Ip7xGqg=;
        b=qJSEM52135y9Pt0f9BOO8ni8Y5kSSAwcOGSle75AqkJ6S7U95ZBRfPSFFnVlXkkX6W
         +BjOCSwWK1rsnxpRkbdf2LweByfYf3SXkvAVv/LeeacgI45JaxuarqtOhx2a8McczYS1
         OpprUgdL+y28ZZAVcr6qBacgzEiMYAQs1Qtw3aSw1cr83Wb2Rnn7TZllyXHEnjwEMCMr
         nyBQQjHbdtgw7Qjp9UGGp+15tt1FxPWAKrQ0NDKjMimwKSEDW6kkGza2aK52VvcZ9dUs
         0r8Re0nB4XNHE5Raei8Y+E7dFzFBhzebDPlKwD3PuWk3KPVvFaWh6ypyJfDsl9PT6srH
         KwNg==
X-Gm-Message-State: ACrzQf3It+YCFMQRxPdF9NZQgepTRzxOcDfX+2aeIo9u6/43yHJ9K5P0
	GibcOhaxzC6LpzB4YdxuM1NLcfiLhQhPceTf
X-Google-Smtp-Source: AMsMyM5sAG6ED8zELYaDkE0gvSZJOLi6ujG8uSJBPXBJW8fYthHEZNHh6J6thP8e5ZY2XmRERP76DQ==
X-Received: by 2002:aa7:8c59:0:b0:56e:aa67:4fc1 with SMTP id e25-20020aa78c59000000b0056eaa674fc1mr24156007pfd.56.1667965481891;
        Tue, 08 Nov 2022 19:44:41 -0800 (PST)
Received: from localhost.localdomain (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b00186cd4a8aedsm7765612plr.252.2022.11.08.19.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:44:41 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 14/16] nvme-auth: have dhchap_auth_work wait for queues auth to complete
Date: Wed,  9 Nov 2022 05:44:17 +0200
Message-Id: <20221109034420.1000086-15-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109034420.1000086-1-sagi@grimberg.me>
References: <20221109034420.1000086-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_194443_030701_AB5DB389 
X-CRM114-Status: GOOD (  12.93  )
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

It triggered the queue authentication work elements in parallel, but
the ctrl authentication work itself completes when all of them
completes. Hence wait for queues auth completions.

This also makes nvme_auth_stop simply a sync cancel of ctrl
dhchap_auth_work.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 0159179c2455..e88d6254f2f5 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -924,6 +924,12 @@ static void nvme_dhchap_auth_work(struct work_struct *work)
 	 * Failure is a soft-state; credentials remain valid until
 	 * the controller terminates the connection.
 	 */
+	for (q = 1; q < ctrl->queue_count; q++) {
+		ret = nvme_auth_wait(ctrl, q);
+		if (ret)
+			dev_warn(ctrl->device,
+				 "qid %d: authentication failed\n", q);
+	}
 }
 
 int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
@@ -974,12 +980,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_init_ctrl);
 
 void nvme_auth_stop(struct nvme_ctrl *ctrl)
 {
-	struct nvme_dhchap_queue_context *chap;
-	int i;
-
 	cancel_work_sync(&ctrl->dhchap_auth_work);
-	nvme_foreach_dhchap(i, chap, ctrl)
-		cancel_work_sync(&chap->auth_work);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_stop);
 
-- 
2.34.1


