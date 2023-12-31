Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A09C3DA6E
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Dec 2023 06:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yJe9eBrJyCHcGWa48DR2zpz8+2I/CTtc/z1iCtIVd6k=; b=nhEV6J9PmPiR+RXY7VaAkZy90f
	HRANrA9aW+FmBczw6CS+3IJsRbcHHF1+AmPCzCAuRyTRjBRoFx2t8oaKqhlt4BU/8HVyY9clwUQyE
	DZD0xLjjv91z0svGIqq1eCcwKQPQVYDfsEzNPLjwNz0uJdCoqQCd9DpObSaV49lP1h0uaOd6zgPc+
	Gt03UAot+xfDvxUZVcLpm2DaOoX+igjT+TPZbFC5UNYZCrUrx/77eEbud2HwzeBRoD7SVG/3bfxSA
	jOe9GMIbLoUjG0nFoOFP9lmiPYW6AzQ0ENy9vKmk0cAsVN5OACUmwwlUoIRWd6YBYaNkk8N+Uxg6K
	FH176dKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rJpkw-0047k6-0N;
	Sun, 31 Dec 2023 06:57:06 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rJpkt-0047iz-0K
	for linux-nvme@lists.infradead.org;
	Sun, 31 Dec 2023 06:57:04 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VzWKrjD_1704005805;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VzWKrjD_1704005805)
          by smtp.aliyun-inc.com;
          Sun, 31 Dec 2023 14:56:50 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: tcp: remove unnecessary goto statement
Date: Sun, 31 Dec 2023 14:56:44 +0800
Message-ID: <20231231065644.23319-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231230_225703_303641_24A0E301 
X-CRM114-Status: UNSURE (   8.14  )
X-CRM114-Notice: Please train this message.
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

There is no requirement to call nvme_tcp_free_queue() for queue
deallocation if the pskid is null or the queue allocation fails, as
the NVME_TCP_Q_ALLOCATED flag would not be set in such scenarios.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/tcp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 08805f027810..d3dda851f8dc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1922,14 +1922,13 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 						      ctrl->opts->subsysnqn);
 		if (!pskid) {
 			dev_err(ctrl->device, "no valid PSK found\n");
-			ret = -ENOKEY;
-			goto out_free_queue;
+			return -ENOKEY;
 		}
 	}
 
 	ret = nvme_tcp_alloc_queue(ctrl, 0, pskid);
 	if (ret)
-		goto out_free_queue;
+		return ret;
 
 	ret = nvme_tcp_alloc_async_req(to_tcp_ctrl(ctrl));
 	if (ret)
-- 
2.43.0


