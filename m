Return-Path: <SRS0=mUlG=GL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD6AC433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jan 2021 14:47:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8D4235FF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jan 2021 14:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8D4235FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Xb2JmHGCqsla4VGLVaudOaLNIuaP+HDkZDOkoi0I90=; b=QKZcLB+qUJwZ5FS6+Y5EyTW7JD
	PzaYMIVxhSWQHCEO8aQbgMqFyKLnntLFsw1DZrnp6dJEuiiPgLkjs4OwfNtQkCKbGIA9SGhWKeMmy
	+kwrek4AQLB14XZaust9NlggJVEHVDXbPRAARpTALA65KXkWvmlfoWWI425cPcIv1ICQ3hU0j2AS7
	8cx5vxqsrvWqR2gQAoV79J46F5wUhkAEHfW0klEbq9QYp/3dF4UaR80DI13GEe2I4QDehajOBCJ8V
	GPD7maEr39JOn1kwUzu/96bf1TFXJOv/U58c6G7L60La8HuG1HEv8/8J7vtB0HhF/00ybVNRxNe7J
	xJQnFAFg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxt2q-0003HY-Rf; Fri, 08 Jan 2021 14:47:16 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxt2o-0003EN-9i
 for linux-nvme@lists.infradead.org; Fri, 08 Jan 2021 14:47:15 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2so6375820pfq.5
 for <linux-nvme@lists.infradead.org>; Fri, 08 Jan 2021 06:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pxw/+Q9QrzSYFB8Us6yvkM/4KvUR/CwP98yYrhz4hiQ=;
 b=K4/9OGJKb6fjw7dYfjJLcuVuScnkMPqsvgSWfWm/D+xU4x5Y4vVKfoz0RqS4phwMOv
 n3NkwZx+xbuFlJGo8hQm8QdBS9rM89In/JP9NKtZZ25Ep3vp898ujEv4DP4Mw4B+MF6z
 ikcJ/uJk7FxTxPKO4kKNKjy3L3cumqerqqvOBpy9FOU9IB+7Tpjnl44eHJi+T0sogL/i
 XfLnX4m72WBQSBlDvM0P3vAcnQqUFKYlBJW8Ox7I6yTrypaBiVA6ZC0w3oKb31ybWHGH
 KeJr9UNE10966zxubSPJwKzy3vsIZ5UhJIRsCSaqD2Zxag3W+NqrxpSaysLWsoV/AHbe
 xJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pxw/+Q9QrzSYFB8Us6yvkM/4KvUR/CwP98yYrhz4hiQ=;
 b=fzLVSzl4VzNmkZJL7JzdvuCcFnV9m5VSsw7wJ9R3bf4j+ChLamTMaHSfFFN04BVwmf
 98WTGIEDJ88pAa8beh/tVujSQ4Y9iZUKSdcqT+NwOQ6hFVtiVtnUQKCs3qIvIvxTXEcu
 AErp+9JUIsBkjFcARoj/fIC3+OpGKjHONTHVRijdamOrDFWolIXFh0H1qP69IyCcEvMp
 oPpy/gf89o8/0tW3nVjGnguQraaiJNa/o0mdNhNXxk3vmTKbhbFJ1fKjzxIaFuaa78MC
 x0hzObUdpG5202Ln/csLIkdejpUgpFUho5HUsJqafYO8SCYKRE2xfX0F/lLk1dFhCPUO
 oH0g==
X-Gm-Message-State: AOAM5312SnODqCgwYuMNW0OwKkfspuUVpgZGNiJXLCvpIouwlLToiFEC
 08zxXh4yBdh8e3V7qXQjfwQN6kDT1wPYpw==
X-Google-Smtp-Source: ABdhPJxnavcI5NaIZYMYEqohRH6umsdPUGgCLamXfz4msTOYlaOlEUueQ2FqXS+LCCmJJdWH7tlFrA==
X-Received: by 2002:a63:f512:: with SMTP id w18mr7407498pgh.154.1610117231643; 
 Fri, 08 Jan 2021 06:47:11 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id w11sm9875391pge.28.2021.01.08.06.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 06:47:11 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] nvme: support command retry delay for admin command
Date: Fri,  8 Jan 2021 23:46:57 +0900
Message-Id: <20210108144659.7126-2-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108144659.7126-1-minwoo.im.dev@gmail.com>
References: <20210108144659.7126-1-minwoo.im.dev@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210108_094714_351727_7B129783 
X-CRM114-Status: GOOD (  14.55  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Once driver decides to retry a command that failed, it can have some
delay based on Command Retry Delay(CRD) in Completion Queue Entry.  If
CRD indicates Command Retry Delay Time 1, 2, or 3, driver calcualtes
delay in Identify Controller data structure.

This feature can be applied not only I/O queue commands, but also admin
queue commands.  Admin command during the initialization may fail due to
some un-ready state of a controller, so it would be better to have this
feature for admin commands also.

This patch simply removed getting namespace instance(struct nvme_ns) from
the struct request and get a controller instance(struct nvme_ctrl) by
nvme_req() helper.  Now, nvme_retry_req() calculates the delay
regardless to namespace instance which meant this request is for I/O
command.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ce1b61519441..d0c99a9400ea 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -280,14 +280,13 @@ static blk_status_t nvme_error_status(u16 status)
 
 static void nvme_retry_req(struct request *req)
 {
-	struct nvme_ns *ns = req->q->queuedata;
 	unsigned long delay = 0;
 	u16 crd;
 
 	/* The mask and shift result must be <= 3 */
 	crd = (nvme_req(req)->status & NVME_SC_CRD) >> 11;
-	if (ns && crd)
-		delay = ns->ctrl->crdt[crd - 1] * 100;
+	if (crd)
+		delay = nvme_req(req)->ctrl->crdt[crd - 1] * 100;
 
 	nvme_req(req)->retries++;
 	blk_mq_requeue_request(req, false);
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
