Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0760EC47422
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jan 2024 08:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OubxRhjwNGhCCbE8VFK57pWqQqenz4a+XmgUQSGoBsU=; b=bY0OStACjS+l8od49uaANMNj4g
	99wFJYDYIQY57rpimb/qSg+QSz9W/o8Cyg+SqLt/PvEpnXek4sjbjz+06qwytwKLGUoS3PXHg6tne
	iovpHVZcpcxcwIkDrTBNRbQ4GPt9mJA+crVdigXtmPOkLKa+PDM72AzOOOd9Fz6nSuRRinw//zVUA
	w2rZ/NUuqOPv/ZpCAhsetCG/tooySzRnfnwICaBddzd8kwCV7UtnlfKgb5U6ZZEsmPfInLGa6nOTc
	IAb9RTU6ryfpV0GExK/t/W+v7XQep8jx8ukKUmbsTDh6RhG5CTvKor+m3Hy8ptidcwtbX1o/m0L9P
	FWfuhMCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTHYL-00000003RbO-2EOT;
	Fri, 26 Jan 2024 08:27:09 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTHYH-00000003RYQ-345H
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jan 2024 08:27:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706257610; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OubxRhjwNGhCCbE8VFK57pWqQqenz4a+XmgUQSGoBsU=;
	b=tw+QP1INQvQHmc9m7dPyhdZvsYf/JuBJS5JknIeXIxt2s9jwyytBSoPT5lzX8ZylBYyQvUGqzEK42/olKbLmLs980lqXx3tillKm++VQG3naihBVay5/8kVHedp38MxcajwuzNiZCSQ85kn8lfQMEXbSIzbtDgPVNcnCIg4j86c=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W.NCIkP_1706257604;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W.NCIkP_1706257604)
          by smtp.aliyun-inc.com;
          Fri, 26 Jan 2024 16:26:48 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet-tcp: fix nvme tcp ida memory leak
Date: Fri, 26 Jan 2024 16:26:43 +0800
Message-ID: <20240126082643.37656-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240126_002705_945427_62DC9156 
X-CRM114-Status: UNSURE (   6.97  )
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

The nvmet_tcp_queue_ida should be destroy when the nvmet-tcp module
exit.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 6a1e6bb80062..6b6062883b8e 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2216,6 +2216,7 @@ static void __exit nvmet_tcp_exit(void)
 	flush_workqueue(nvmet_wq);
 
 	destroy_workqueue(nvmet_tcp_wq);
+	ida_destroy(&nvmet_tcp_queue_ida);
 }
 
 module_init(nvmet_tcp_init);
-- 
2.43.0


