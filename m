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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E67C433E9
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jan 2021 14:47:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD27235FF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jan 2021 14:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD27235FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=naL9scfA1u9KbmKCWIFqecGIWUNNUzkrzHFyUumMM4o=; b=e5eJjrndwPcpwjZvARJ1ugDviT
	1DXPIm/fxU2TTP++oj75Dx8NPYDNBqsB3LtORehJGY4/gdMrLKshsX86PYn41Lx0IeiAR30kljM+f
	YinNDA4AiC0ObmXjKNxU0W/xUweJz0RtJEeS53m9mZFD9HA3wlF7vfnN9n9LdDQsA8eZc2inLE261
	yxkihG6AEAqgEzF7HmfIbc5ZvjMWYpcH9FzAKQBAKrA7SMAlEKJqJ3sW1weBOUary8ROfJHfqeoqs
	6FETM59DKBO20EazYCOlYr1f7LRI9cNCPQDLLthUtzdgo4OtQL8+HYr3ZNXhxvBZ1BjUxVOqL8oAt
	hR0PdUmA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxt2w-0003ME-3u; Fri, 08 Jan 2021 14:47:22 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxt2t-0003IK-HJ
 for linux-nvme@lists.infradead.org; Fri, 08 Jan 2021 14:47:20 +0000
Received: by mail-pl1-x632.google.com with SMTP id q4so5762448plr.7
 for <linux-nvme@lists.infradead.org>; Fri, 08 Jan 2021 06:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Csm3BcFUkY+Zk0CMkUG8slH8/RvLEi0kqJM3xLFE/fI=;
 b=mYRNKVInEQ34RYR/ZTYK132//1zQ8WNODcPZAynF1++Uff0nAuCwY84pFmdTmodK2s
 MIr4hHj+6qaH6lkO3r1ke8sbJWPhDe4bNcSvTIK5feA48T8eYZc7V4lWIavlRz7fnYoa
 9S4mJjT5ZmT2T/yLKLhZMSbmKakLaX5oLd9dWsDvMPpYC+PqCRm9ZHXlpWhAJgfZcU/P
 vr+i3Rg+iPrHaNxDFL15H5rF7G9SKazFrRnYLhOVjnKoF4pXtLbYqn4nTvR+V+GYHj3t
 WCoe8ALJGCi6P2NkQYI43E5Bvaz98/1iiovc2muHfPuewA1D/xq9c/OgrYV8gLbeL6eP
 vd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Csm3BcFUkY+Zk0CMkUG8slH8/RvLEi0kqJM3xLFE/fI=;
 b=bXzSehkN4A+BdCmJc5y1P49BEeKj9G2a5O6t1+DhmFgunc2Rm2jBfpnMuavpWWiRmg
 vwd85Q+kEQSNB5yFWiJYNQgrHS+gp+Fhi4KU/vrvb3NU5G0972cVVJ6bNp4SaMiqL7zE
 XPd2GzaJwvRQ2chy90z8tD82qZJ46Q/H9ECkvadCFRWtsl1M7+uZ3Zue9soLZ4njS4I2
 wOatVpiRo4U64OhYCbsirZaiawgwV1v/p+GVolohVW47KUkFKzpLNo2DtUJZAHGK/1lN
 s192NA3Qcp/d8w1JvnnUqvAq+VgZZd2OJkJug4OBFzlhwcRnkgqV1tGhn9uFj3tdpqjD
 qhKQ==
X-Gm-Message-State: AOAM531al++u9eu4Qm/URxvdZoTFV/5HY1MVeEnUV/410VorqpNI7tzI
 zdTO6p1AVu2WXaXrwzaF4ZEaQ0ki5gEjqQ==
X-Google-Smtp-Source: ABdhPJzh5XpulWCKYuCmzNGeobUlz8Rdlw5vvp7wEnnP/u2qz1+y/lGiSr1p7q7/fAhNGzsaLOOmlA==
X-Received: by 2002:a17:90a:7485:: with SMTP id
 p5mr3984206pjk.132.1610117236948; 
 Fri, 08 Jan 2021 06:47:16 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id w11sm9875391pge.28.2021.01.08.06.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 06:47:16 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] nvme: add parameter command_retry to enable retry
Date: Fri,  8 Jan 2021 23:46:59 +0900
Message-Id: <20210108144659.7126-4-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108144659.7126-1-minwoo.im.dev@gmail.com>
References: <20210108144659.7126-1-minwoo.im.dev@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210108_094719_700788_E6EB9CD8 
X-CRM114-Status: GOOD (  16.70  )
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

nvme_init_request() has set REQ_FAILFAST_DRIVER to make requests
non-retryable.  This command flag value is checked in
nvme_decide_disposition() to decide whether to RETRY or other
operations.  In that point, blk_noretry_request() macro will be used to
check if command flags have one of REQ_FAILFAST_*.  If so, it just
decides to complete the request without retrying.

This patch added a module parameter named command_retry to turn on the
command retry feature in this driver.  If turning it on,
REQ3_FAILFAST_DRIVER will not be set to requests so that retry can be
reached out to nvme_retry_req() based on the module parameter.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6e428fdc25a8..e1836ca9956f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -44,6 +44,10 @@ static unsigned char shutdown_timeout = 5;
 module_param(shutdown_timeout, byte, 0644);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
 
+static bool command_retry;
+module_param(command_retry, bool, 0644);
+MODULE_PARM_DESC(command_retry, "retry commands up to nvme_max_retries");
+
 static u8 nvme_max_retries = 5;
 module_param_named(max_retries, nvme_max_retries, byte, 0644);
 MODULE_PARM_DESC(max_retries, "max number of retries a command may have");
@@ -560,7 +564,8 @@ static inline void nvme_init_request(struct request *req,
 	else /* no queuedata implies admin queue */
 		req->timeout = NVME_ADMIN_TIMEOUT;
 
-	req->cmd_flags |= REQ_FAILFAST_DRIVER;
+	if (!command_retry)
+		req->cmd_flags |= REQ_FAILFAST_DRIVER;
 	nvme_clear_nvme_request(req);
 	nvme_req(req)->cmd = cmd;
 }
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
