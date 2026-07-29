Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA69C54F51
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 11:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=h8ZCfIZromw0b/lZhdCClgGtextmdl1nFvg2HQuVt9c=; b=JgICXSbjD+yj/wi1pYIKiWm01d
	Y8iAprwKekk9NrEz+A+7H8aYdLXSjVHLwKxiQ3gZ1kmJyuawDRvXhAh2vVbJ3lDL781ssxG7eYokX
	yc52D1Pn2BelSBtxzNNYT9J/OfjnA9KDDo1OLZGR62/QyVIGglhq8bNMkmLjtVkT8c75PD1JiAA2R
	RCttHZDxkkoMqFQ8So0V2VZyFZRkubh7ugR0kYpXAHYF02nwwE8pYIGa9W5FQrrafUu5d7j585vH3
	+GDsNoLx49lE1U4D60z6hZCxo+KVeJJTnGUaZXYMSpuT7cNnEYNXpDO2CUDijzKRj7dFUn+n3Leeo
	DlfiDItQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp23k-00000007foM-0ts1;
	Wed, 29 Jul 2026 11:02:48 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp23h-00000007fmm-0Av6
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 11:02:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785322960; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=h8ZCfIZromw0b/lZhdCClgGtextmdl1nFvg2HQuVt9c=;
	b=OzvpJaHkcVebanVq2KUIUPpffIeCWUgOk5Wm+6YpluAkHSa4K5tOBmlRr6slG9GBKjyaeNHZgW7a4i/8WVTr4IGJgFS5QXJhfPVr8ZkNs+Y+p10kkD0yie5ctFIP3/vVdlSXIPaIQqk+cqeWdU603G4T6BWxPyblDdHLQnR5R3o=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X82024h_1785322956;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X82024h_1785322956 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Jul 2026 19:02:36 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Aurelien Aptel <aaptel@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 4/4] nvmet: reject out-of-range mdts values in configfs store
Date: Wed, 29 Jul 2026 19:02:31 +0800
Message-ID: <20260729110231.1406432-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_040245_243518_6A969FA0 
X-CRM114-Status: GOOD (  11.48  )
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

nvmet_param_mdts_store() accepts any integer that kstrtoint() can parse
and stores it directly into port->mdts. The value is only range-checked
later, when the port is enabled: nvmet_enable_port() silently resets
port->mdts to 0 if it is negative or greater than NVMET_MAX_MDTS.

As a result, writing e.g. "mdts=1000" succeeds and reading the attribute
back returns 1000, yet enabling the port quietly turns it into 0. This
is confusing and hides the invalid input from the user.

Validate the value against [0, NVMET_MAX_MDTS] in the store handler and
reject anything out of range with -EINVAL, so the error is reported at
write time and port->mdts never holds a value the port cannot use.

Fixes: 0a5a94648627 ("nvmet: introduce new mdts configuration entry")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/configfs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 2b69ffcfc8df..413ee2d16d29 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -312,15 +312,17 @@ static ssize_t nvmet_param_mdts_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
-	int ret;
+	int ret, mdts;
 
 	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
-	ret = kstrtoint(page, 0, &port->mdts);
-	if (ret) {
-		pr_err("Invalid value '%s' for mdts\n", page);
+	ret = kstrtoint(page, 0, &mdts);
+	if (ret || mdts < 0 || mdts > NVMET_MAX_MDTS) {
+		pr_err("Invalid value '%s' for mdts, should be 0-%d\n",
+		       page, NVMET_MAX_MDTS);
 		return -EINVAL;
 	}
+	port->mdts = mdts;
 	return count;
 }
 
-- 
2.43.7


