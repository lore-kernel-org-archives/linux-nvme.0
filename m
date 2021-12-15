Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D495CC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Dec 2021 16:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZzPVTfgisDXhr5KSCCKdMaU8KCMcU6kyZCK6gX9Tpbw=; b=0EznVRnzI5IEQ2MIpLFef+xlX8
	xjogMLFuTqEDXdgfADZq1uOJyTbF9WYYxVTx/1ijrlwJl/Bda5l9QPf/QKzxpadAAQT0+edSKtddv
	Kr5FEQNQjl6MWoPLKXZJ4S7zlsVPwsf0K1c6PC7SDZTwrwQ1Yyq3+yGjHIIwRdY29RMPpjthqVQkb
	gzrFear6/+bvI8jJNGSIHH3DGkDsUqHOh8AUWbtb32kPSVFxrgttuJU6IfEP+jJ/hn92RPft0AIFp
	9imSmFfr3V0fuZ5MvT6MN96JIb3W0objU5q3bm3Q181gFdjdoKy0y/TaGtGNkZGEwU/YaRTuh8FZd
	2EbF+9CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxXQR-001psy-I5; Wed, 15 Dec 2021 16:46:43 +0000
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxX4r-001gpo-IA
 for linux-nvme@lists.infradead.org; Wed, 15 Dec 2021 16:24:28 +0000
Received: by mail-io1-xd2a.google.com with SMTP id x6so30832474iol.13
 for <linux-nvme@lists.infradead.org>; Wed, 15 Dec 2021 08:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZzPVTfgisDXhr5KSCCKdMaU8KCMcU6kyZCK6gX9Tpbw=;
 b=FUYh99cWyVn5DKtPS1l684xkvLXgyleEJaHJ047Gp+GwB+Ci1iK7mvEuNqqGGADSuT
 yLrUTTIqDH8rSCnUTAOrdoHw1nmBbcOxEcUiZGWpbaxkwjc1ZMArtWrS2BLxLQUs/v7X
 fOa14msslBo9VytcB3y9kHRu/nPmtyeTs2QFIHDQ5KtU+wg4amT860tT1b/SaNZIXOkG
 tvt7BqImsVoEXe6B7W3jA79Zwy/PBPtYQHEn1Eklv3EK44t5vHx/iUcykIu/KcmpHVAA
 vS9lFWztEcJhWEedOmuQNb0xvL73L9sqvMPXgcmQ1Ulmhiv/5bkXOK+Hrjd8HzX3b7Dr
 OKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZzPVTfgisDXhr5KSCCKdMaU8KCMcU6kyZCK6gX9Tpbw=;
 b=KcDzxOhDNyCP8x10uZZO9I9J/mozqsKvj0UhlTrqeYrpyKCRCDLvbcVu/7SjDg+6KM
 G04B061SInXkBy2sksRSZYQnc4xog/brZiLOKxrWalM4DrQu3Ij7Df1JSiQbDLnpmWuW
 nlRifmtZJmWCbLWOfOE30ngDmU6oSHoxx7nZMjE9l3bi/sOb+ndHTprLhhsUkvrOVOT6
 8TFxbAFhdD4Ek1itOEHaTPQFOg9pTsk0Dv3vSWv823CXSgP4QyRIjVUM8y+6p0DPIl+Y
 O7r+m5C+FPjog7a2w4Xq8H34wKiiSya2xHvhaOplUBVvLVTRbqx0+RqmrRlBpuynqTKs
 NaPA==
X-Gm-Message-State: AOAM533EXY2J66jDfxgHkxU07FfYdp+c8WLWWaOXHmSwJg4tNne6aHZQ
 GTMSsV/WY6pmwBRX5jwSrgYEP5oIqJcTaA==
X-Google-Smtp-Source: ABdhPJw4R0XiVxp960OKfbwFzL+UQKbLRFWzaJigp4wFZsWhXzum7JVsqEg1TZG193tAMa11ph5hag==
X-Received: by 2002:a05:6638:3049:: with SMTP id
 u9mr6447426jak.132.1639585464597; 
 Wed, 15 Dec 2021 08:24:24 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id g1sm1153170ild.52.2021.12.15.08.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Dec 2021 08:24:24 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/4] nvme: split command copy into a helper
Date: Wed, 15 Dec 2021 09:24:19 -0700
Message-Id: <20211215162421.14896-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211215162421.14896-1-axboe@kernel.dk>
References: <20211215162421.14896-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211215_082425_703357_0B92CF90 
X-CRM114-Status: GOOD (  11.59  )
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

We'll need it for batched submit as well.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8637538f3fd5..09ea21f75439 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -500,6 +500,15 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 	nvmeq->last_sq_tail = nvmeq->sq_tail;
 }
 
+static inline void nvme_sq_copy_cmd(struct nvme_queue *nvmeq,
+				    struct nvme_command *cmd)
+{
+	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes), cmd,
+		sizeof(*cmd));
+	if (++nvmeq->sq_tail == nvmeq->q_depth)
+		nvmeq->sq_tail = 0;
+}
+
 /**
  * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
@@ -510,10 +519,7 @@ static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
 			    bool write_sq)
 {
 	spin_lock(&nvmeq->sq_lock);
-	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
-	       cmd, sizeof(*cmd));
-	if (++nvmeq->sq_tail == nvmeq->q_depth)
-		nvmeq->sq_tail = 0;
+	nvme_sq_copy_cmd(nvmeq, cmd);
 	nvme_write_sq_db(nvmeq, write_sq);
 	spin_unlock(&nvmeq->sq_lock);
 }
-- 
2.34.1


