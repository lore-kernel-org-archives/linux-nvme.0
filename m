Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC15EC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 16:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mrsB3UCm4bmi73wguDQBqQCr2m0pev3vraLfK00rcq4=; b=WrsLGFCRKEopF7Bn3a12eJ24Yb
	EtwtSlVo7G8ZhEbqjpfEumF+XRV7Th83CrZIvE8VZiWfYCm/Rv1bHplYDArOpnpewiZK+IUmo8MN4
	pglhqXihIX1Pf1g0oPCH806QhIWpcFO+xcL3BuDMmO6t+lM5BSFHwutHLplJqwzN4heVVzubWNEEP
	FosQnGH3cpe5HL0MYSbrB08ywBchEzvWeKY9zubBdXhQ2JKPOA2IYBnq1ZzZPq/k/aJYxXbN8j2xf
	uoSNrWcMjRYgXVCEzRoy8Tok2JU1fZWK7HfulpP9WZ/XKhBYF+yqLwS8Mqxlb8C6T9xe9OFhBP3n+
	bKoMugOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxtGV-006TUR-KL; Thu, 16 Dec 2021 16:05:55 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxtGJ-006TOS-5F
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 16:05:44 +0000
Received: by mail-io1-xd2c.google.com with SMTP id 14so35653178ioe.2
 for <linux-nvme@lists.infradead.org>; Thu, 16 Dec 2021 08:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mrsB3UCm4bmi73wguDQBqQCr2m0pev3vraLfK00rcq4=;
 b=NASmxMQXOzlzQl2P97eko9egq2Ee1UYORkMMfIMKOdwKqjMhjXLDTv/9JYPlKBgGCr
 oYeCIdjtUfNRkeKpro/j7f8I9AC7YQ0f6tSQUYAppLrQW5NSx2adWPwop+FeVVvPMwZf
 hMX8tXRXS3IJ8x86apPVybcmoWRw1Z2knYpIGBBBQUXUrDGaRZx5bl1rSsx0h2pZQEFB
 STbDmk7bPjwm2NWSA2mf6VHl2AUdvkGw+UN6veCxGHs8D5dUpLXg+hs6p8WvgR+vSz5j
 JJLipSh854HDnsQdrDVbPWzmviIyo/gLLA4+x4MDcBYeHq/0Ij1UZ6uSDBO0o9/DHqpd
 UdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mrsB3UCm4bmi73wguDQBqQCr2m0pev3vraLfK00rcq4=;
 b=shHxLn1aRky+KGJl+/eqcB2GcpjYFjxkcJhPAtM1HK3/WF7cNBdhfTbIfmtQBNVc5o
 ilnCwMixI8MzQcTGqjIHcIvbpwih2Vmm2Lwt7MQolWwx4JP++uAmIlDsN7CO8KWFVhPP
 SrysaFzjG1eM9H6HdhEk6qx8od1/uNLQd1ZCO8mxpO8t8mc1TqCTFP0zO1nNtFy2Hbmf
 QUV/RthWS3e912GEfat9NEnJalzKbASpEaLKX9AG/TjGx3DUlfD2KNJYf8jWgVGo3LiU
 LG7FL2i05rzdm9VD1V/Q/nZg4jJr3wkqD4eyU6/tgWvNNZpVArJGP9jVW5VY2u7poO3/
 wLhw==
X-Gm-Message-State: AOAM532+0yVq5JKVno/K2NROeabnqleQvbmSk7a0gBhfkyooE8tpeYOR
 NX5m3b+lNoPLJ1zij2nq0TydOA==
X-Google-Smtp-Source: ABdhPJzr/bFJjYd6Il7Y+kIQ7ggNza0pgizMOaeK51YYrulffnpxoSLrnypU+JIpE8iPqtsuB2JQEQ==
X-Received: by 2002:a05:6638:4089:: with SMTP id
 m9mr9928722jam.187.1639670742320; 
 Thu, 16 Dec 2021 08:05:42 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id s9sm3237155ild.14.2021.12.16.08.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Dec 2021 08:05:41 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
 Hannes Reinecke <hare@suse.de>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/4] nvme: split command copy into a helper
Date: Thu, 16 Dec 2021 09:05:35 -0700
Message-Id: <20211216160537.73236-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216160537.73236-1-axboe@kernel.dk>
References: <20211216160537.73236-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_080543_227228_6E3D279F 
X-CRM114-Status: GOOD (  11.52  )
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
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
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


