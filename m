Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD3FC77B72
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 20:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uY8LBeth5vJNi2Lzp3GMfyHfSkopsbeWtmhmmgyT3GM=; b=qdu+MYOvsIWxH6fEs1N8crBL0H
	FwMyXkgAJUCR7R7MvcfL0KBgK71GJ++q1FYT66bkaABm9dYmRanslHkSyL5J8hQ78si1dCZdmlnVv
	EzC01+BUZZz5YRCyUs0UIz8xjPzlPDP1+bsPdBJVecREVxRzHX5TS22JdOmUT56uRDoV0ZoVvXf1F
	C5tqlBU5j1TOlx5UQdbwix8f3O2I1jwYIjNwDQTD3tLcIwh5ce413yoVotZpSHFU8Ke4Jg8zfsCQg
	Jrj6/Ve/Huee3G+ouIKn4hN6mtUVYOfc/nAfRkH2AdA7tDI/G3rVQ1ejZzYJZp0FWWSNl/gD6FKQr
	skF8bPrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poVf8-00HYbG-39;
	Mon, 17 Apr 2023 20:41:22 +0000
Received: from smtp-18.smtpout.orange.fr ([80.12.242.18] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVf5-00HYa7-2l
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 20:41:21 +0000
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id oVf0plYozzvWyoVf0pNzt5; Mon, 17 Apr 2023 22:41:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
	s=t20230301; t=1681764076;
	bh=uY8LBeth5vJNi2Lzp3GMfyHfSkopsbeWtmhmmgyT3GM=;
	h=From:To:Cc:Subject:Date;
	b=bgyBqcn/j2enXfq0We5FO0LJwl3YbpRpB8UKfmiOxo89kCIl5sFQm+wFEZWYILNL/
	 WgtA20N8NCK7UXc6DFOug/ah6STLYj/UyNbSBtmF4Yokc+9LFBvGnpJRmdtIsQR2iT
	 I79Sf7tyOJFUFFeru2VRetn1o1dBzwBSYfjU1Q6Lbnnb9MWZhKTgPhVuWnEAEPs/tM
	 4QkVX7bJdKpow3y9Rz5iv8P1mJoR8bYNl5jjsB73GxO1ojLCm+TuEjRTw8YrkBTlPk
	 QKvES/I5i+kRUTYbIMCFFKX+x+zUlfFyS1YOhxHAzuq6pq1btq094g5YnaEPrqyNZo
	 O3LljMigC2TjQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 17 Apr 2023 22:41:16 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet-auth: remove some dead code
Date: Mon, 17 Apr 2023 22:41:13 +0200
Message-Id: <e6f0e506459eaec9dad74946c1e01aac74874054.1681764032.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_134120_336463_B88D607C 
X-CRM114-Status: UNSURE (   8.52  )
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

'status' is known to be 0 at the point.
And nvmet_auth_challenge() return a -E<ERROR_CODE> or 0.
So these lines of code should just be removed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The dead code became obvious after commit be2ada6d0ed0 ("nvmet-auth: fix
return value check in auth receive")
---
 drivers/nvme/target/fabrics-cmd-auth.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 7970a7640e58..038032e46145 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -483,15 +483,6 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 			status = NVME_SC_INTERNAL;
 			break;
 		}
-		if (status) {
-			req->sq->dhchap_status = status;
-			nvmet_auth_failure1(req, d, al);
-			pr_warn("ctrl %d qid %d: challenge status (%x)\n",
-				ctrl->cntlid, req->sq->qid,
-				req->sq->dhchap_status);
-			status = 0;
-			break;
-		}
 		req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_REPLY;
 		break;
 	case NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1:
-- 
2.34.1


