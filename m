Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E128C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 06:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hstt5B1GnL78iy7P9RSNmkgsiD1eeHU4L5GAbGdNt0A=; b=1EpGi4KSbi78+tp+xEiv2U/078
	BTNKq+7qAfD9cc3mhP2Fv/VrEekwDYPpizbf/IJifVHyI2PLtDX7/J8agau1NSIFWHBFlC+z4Lyys
	X3yUWJTkQ+alUcdWTDZ/TTyLUGrAu5kcSPhEwbvh/4uFOwe4C8pQrFwGIfoHYlhW9XygFrgjrO8FM
	i1lX7oug2zAIUpMJZF+i6E5d3bXLtfeiNfBCe2sLx5t0Kt8J4ED/wij5SV9BzFj8IC5XC6ZGwTsZC
	PeMDw2NnVvQ2aid9uemcAiyOjbR9yNXyQDQBJKxEl1MVNTJ/HiFyPKJ2sJJfi2EfYu1NHygg4dm7i
	BU9IDFPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDIoD-00DnDg-19;
	Wed, 13 Dec 2023 06:33:29 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDIoA-00DnBZ-37
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 06:33:28 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VyP5LIC_1702449199;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VyP5LIC_1702449199)
          by smtp.aliyun-inc.com;
          Wed, 13 Dec 2023 14:33:23 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 5/5] nvmet: return invalid filed when check fctype fails
Date: Wed, 13 Dec 2023 14:32:52 +0800
Message-Id: <1702449172-8920-6-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com>
References: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_223327_155032_7D90379A 
X-CRM114-Status: UNSURE (   8.01  )
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

Return invalid filed status code when check fctype fails in
nvmet_parse_connect_cmd().

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/fabrics-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 9cffb64..d6e6db2 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -361,7 +361,7 @@ u16 nvmet_parse_connect_cmd(struct nvmet_req *req)
 		pr_debug("invalid capsule type 0x%x on unconnected queue.\n",
 			cmd->fabrics.fctype);
 		req->error_loc = offsetof(struct nvmf_common_command, fctype);
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 	}
 
 	if (cmd->connect.qid == 0)
-- 
1.8.3.1


