Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40085C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 09:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BG/QZrF/T+yK62BF4hIaXJ89uhpZSpmPzCTogGcACsI=; b=QiPqdm4Tc7OCj+OBCCuMU5dLfR
	zZ0LuW0lApwXE2e44Thb7ZT2sPSU8Py4XJIZW999LE/8nNscTrDKsME+BmSgbIeg06hTV0D8MBFZQ
	N/t+cRHAgTM2a4Z+DsxyP20OCwaFzKaF3NSVkLqj+dUt3igp8s84bAA4lW+Qd+jbIKUHoT8RmrEci
	LdYdXphZ/z5LZYMrl74vS5IXUhBtdK7slELztJOPCZCWGiT6SKykZ0wc/Atir5pgEAPxEpdfKvzQk
	1vN9iDdWSA7Fxd+5BjlGy1+fLvzNuzDEFVUUnuEe8C6NnjKptgXr7bM4vbFXv9k0rpl/oobE5vfyy
	FTm1tBkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJXTI-00ECWH-0F; Mon, 14 Feb 2022 09:16:36 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJXKb-00EAIg-70
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 09:07:38 +0000
Received: by mail-wr1-f53.google.com with SMTP id e3so25736400wra.0
 for <linux-nvme@lists.infradead.org>; Mon, 14 Feb 2022 01:07:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BG/QZrF/T+yK62BF4hIaXJ89uhpZSpmPzCTogGcACsI=;
 b=R0ewz+bb8c6rdnbHMxbFE0UIuV0G0Fk3jbyQ3UCCqZV9El36zuzFobNa5OdX8tTNri
 8/YecL4LXdbF8utIJS+pmv/HFryRMLQQ8mB5MxXAKCGwiaZBW4G1j0+IXcHtrzQIvrBR
 kZlKQdwAjjaEMEgWctioG2fqoJEC1je9vSXIIs0T3TN+KRqL/DRZFG3fshCumboZknnp
 vxnhk0egV4W51cjUn90TxMh3+bXfJit5AC1a5ihbrmbLVokUxS2RbhOwgLTl9cjqbe0Q
 MsutyBuRU0/6HFtmcS/0xvouNgmfprBHnDoq+9fKtFFp16FdL6jOhP4MDuI5B3irC6UJ
 gpug==
X-Gm-Message-State: AOAM530jzjlHCbd88+kHy5yg2xsXgRHjuTQIXd4oy9NFFlxzCdyuKZa8
 Xc1F7+EdP7z+GxiMNRD5yVodYTzA4RA=
X-Google-Smtp-Source: ABdhPJxVXhhBRIH6zloydWDBNFqsD+ldvNY7nxBoBAwZVMyyVLqRYq4J2z1OfrCNbAYn+N//nK6M2w==
X-Received: by 2002:a5d:6d05:: with SMTP id e5mr10764044wrq.214.1644829655145; 
 Mon, 14 Feb 2022 01:07:35 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h4sm34595498wre.0.2022.02.14.01.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Feb 2022 01:07:34 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 1/7] nvme-tcp: fix bogus request completion when failing to
 send AER
Date: Mon, 14 Feb 2022 11:07:26 +0200
Message-Id: <20220214090732.479193-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214090732.479193-1-sagi@grimberg.me>
References: <20220214090732.479193-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_010737_290600_8803F49E 
X-CRM114-Status: GOOD (  13.96  )
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

AER is not backed by a real request, hence we should not incorrectly
assume that when failing to send a nvme command, it is a normal request
but rather check if this is an aer and if so complete the aer (similar
to the normal completion path).

Cc: stable@vger.kernel.org
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 01e24b5703db..1096a0b0a268 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -913,7 +913,15 @@ static inline void nvme_tcp_done_send_req(struct nvme_tcp_queue *queue)
 
 static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
 {
-	nvme_tcp_end_request(blk_mq_rq_from_pdu(req), NVME_SC_HOST_PATH_ERROR);
+	if (nvme_tcp_async_req(req)) {
+		union nvme_result res = {};
+
+		nvme_complete_async_event(&req->queue->ctrl->ctrl,
+			NVME_SC_HOST_PATH_ERROR, &res);
+	} else {
+		nvme_tcp_end_request(blk_mq_rq_from_pdu(req),
+				NVME_SC_HOST_PATH_ERROR);
+	}
 }
 
 static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
-- 
2.30.2


