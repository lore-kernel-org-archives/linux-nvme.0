Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A94C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Oct 2023 21:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cYudL/+VuVwczFaR6V/ZH5x7fhb37FxDE0rQ3yQscdQ=; b=kQ+rxNpUQB09+lEw/MZhiprWDu
	1aFsigw+pCrmycqTe4iWGzyzUVFFz/fUxRFkobr+fGXX1N0DappAaZ7BULCnQkWDE0bfFiTiQ6LjM
	HuaJ2I+qRO+UXFMNXrmB4N+/ZOBz1QJvUanzag7ipiJbKZgUYXWw1M1ron+duqHLfAPyUgwbafJH3
	ctMJeoVES/+Q9dVLGCphHJU1T/wvh1JpuqhyIC4DxRrhDskG+M87DM2+96e3kebH8RveD++8oAgkf
	Ia21t3XtGetRGFNz3I7P74XmctddkR4lXiWFlemgN7+7i31WRj4uTJm6Sl74ofzJpe64nifrinMWZ
	88hdisxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxDFY-0028AB-0H;
	Sun, 29 Oct 2023 21:23:12 +0000
Received: from smtp-28.smtpout.orange.fr ([80.12.242.28] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxDFT-00289c-27
	for linux-nvme@lists.infradead.org;
	Sun, 29 Oct 2023 21:23:09 +0000
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id xDFLqNd5aaLS1xDFLqPqM9; Sun, 29 Oct 2023 22:23:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1698614581;
	bh=cYudL/+VuVwczFaR6V/ZH5x7fhb37FxDE0rQ3yQscdQ=;
	h=From:To:Cc:Subject:Date;
	b=i4AF/4kaLpgPF5GFykgjj0Fq6GL8kJ0whYcQI40Za4SZvoG8S7/LPDoVe/T1ldEFo
	 xdJ/j4JtagGl66mjtb3rsd1aN3nbGORUBHisFIFCtlfU9sVGsB/6c1peOaEqggVLZC
	 BmsQQLmLRNTmtC4POzvKQ8U0UuqDCQWJA5JBz1fdacvSUeQMeccHgGrRYa5ZuK06jm
	 bOCkbTHiBuItwotvdlRE8Adk7aPno13mRQi88rdW7QooKrDY7OTCX+zSBdMYbW76Fi
	 zGIrAT9iuCrsODqlvM938TU4e7spCdRAtGuwIlv1uqUNNpiPSPVWhc7Hor55mNe8UY
	 9DUNhvXcUmb3w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 29 Oct 2023 22:23:01 +0100
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-tcp: Fix a memory leak
Date: Sun, 29 Oct 2023 22:22:57 +0100
Message-Id: <f9420cde9afdc5af40bf8a8d5aa9184a9b5da729.1698614556.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231029_142308_123675_A5B1A5C9 
X-CRM114-Status: GOOD (  11.09  )
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

All error handling path end to the error handling path, except this one.
Go to the error handling branch as well here, otherwise 'icreq' and
'icresp' will leak.

Fixes: 2837966ab2a8 ("nvme-tcp: control message handling for recvmsg()")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/nvme/host/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4714a902f4ca..3c35c37112e6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1429,7 +1429,8 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 		if (ctype != TLS_RECORD_TYPE_DATA) {
 			pr_err("queue %d: unhandled TLS record %d\n",
 			       nvme_tcp_queue_id(queue), ctype);
-			return -ENOTCONN;
+			ret = -ENOTCONN;
+			goto free_icresp;
 		}
 	}
 	ret = -EINVAL;
-- 
2.34.1


