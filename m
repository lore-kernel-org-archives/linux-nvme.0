Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CE4C43217
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aPwnXC1Ikr2oZYqzkbcscL1qJcd24O1nmjDzOEoY470=; b=H8wc7l7RFcLW2elQe7nYjYcLsI
	1rw1eZ3E8mXNTHEoItsgbrtWAzGHiz6s+nRz4pOprRnPTdSJ4o6MpmJfAuLkgr0TYxzTYn1UtokHV
	otBR0Fd6hqaPRPCPClBZHqI0LqUg+zUbcHUuu9E8QXFY95f8UN7Etev6deTHSstIdSQ+REwea3Ffi
	bLqxxTYMGuyC88OXogO9x/8JROu2HQ5xLanZgorAiHlsf2nVF/iNjHBqUxeAJTZIkotQ9N89SRc6a
	zTeFqZUtEVcGVrH3153zkw6Xs/I79gm2mL1cLUi8GMasUOaIRdlP8m2JJBJooR2YOnMoAY69cqwBu
	lqeBMmWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouBAg-00B8Em-Iq; Sun, 13 Nov 2022 11:29:06 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6W-00B6Ms-LF
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:49 +0000
Received: by mail-wr1-f53.google.com with SMTP id o4so12409641wrq.6
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPwnXC1Ikr2oZYqzkbcscL1qJcd24O1nmjDzOEoY470=;
        b=GYTGXQlwjre2w+0ybx+pqdHPbzHr7C7Bp/eKr24qnuLtznYiVjK8VGJfA48hzh+3ST
         FNMauAk7nwah1eF/9vL933EXu7UvqvKhYOBu0DUGkFxc/v47hVQk47uh85aR9Cl7CFU8
         c0R+5AmydBSGspCHYLoCBuA6H+0i9inLo1VMV4hwIxqiViiH2MtvKgx+6RA2Y1CP5nGD
         z0HjSoL8IUayxvGz/KOf/wlj71+e5S9ijROzVZqQLSxHwgINO7UACBKdzIp19AlZ2Pvw
         4xGWpubq9liJxA0vl2zGGxD7btQGXb9FEuesDyhneU0wKNAwzYBI3R6NKhAa+g3PnIOi
         H2HA==
X-Gm-Message-State: ANoB5plEHfiN5qtKgmsTC4j2fvCHvVaqIoYXMl/OYRhNmfPMJYwt/Qah
	/m/cHTdyDHPPEPEtjikOt3TtFpPmlIw=
X-Google-Smtp-Source: AA0mqf4wEfLZ69ZxwFTBQqEYit9yhkBapXNR9A+DX4kJP+C5vEJBYdml0PtUpIZzLubSUlXqRiu8yg==
X-Received: by 2002:adf:ffc4:0:b0:235:83aa:a6ed with SMTP id x4-20020adfffc4000000b0023583aaa6edmr4903835wrs.543.1668338687985;
        Sun, 13 Nov 2022 03:24:47 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:47 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 18/20] nvme-auth: have dhchap_auth_work wait for queues auth to complete
Date: Sun, 13 Nov 2022 13:24:22 +0200
Message-Id: <20221113112424.1049834-19-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032448_713613_84A8B51C 
X-CRM114-Status: GOOD (  13.57  )
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
 drivers/nvme/host/auth.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 2fd1641b4c67..77555337cfde 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -896,6 +896,12 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
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
@@ -946,14 +952,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_init_ctrl);
 
 void nvme_auth_stop(struct nvme_ctrl *ctrl)
 {
-	struct nvme_dhchap_queue_context *chap;
-	int i;
-
 	cancel_work_sync(&ctrl->dhchap_auth_work);
-	for (i = 0; i < ctrl_max_dhchaps(ctrl); i++) {
-		chap = &ctrl->dhchap_ctxs[i];
-		cancel_work_sync(&chap->auth_work);
-	}
 }
 EXPORT_SYMBOL_GPL(nvme_auth_stop);
 
-- 
2.34.1


