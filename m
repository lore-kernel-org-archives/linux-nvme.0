Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB16C6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Sep 2022 06:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=y7YjEuVtYrFAyaORXlPbHTOlUnYaSwijT48u7GMY5Bs=; b=BkaQJEbMzA8XrzTm9+uNEt/MKH
	QebhRFB6Ttc9Vh1H5i7RY6GxvGluOB1O9sE+JuCc7eaArn8saHOb6jeB0wrpZu2X6YsO1z6s+NDEk
	j/ccIyyIjGUVUvHFdB/FX/i6y/ng2Ye1SUEjsz07GznZTny9JgyiCHUgVLMoEbc0vrJxmkqc7xNZ1
	BrnLbpOVagbewqBtC2NE/HNHIXjv6OtGJQpKCL2KBzoIArIqwYegdzQ8T+kzef49FlLLBYAyqhb49
	OtVcJCAnkiR/VvNxXEkkFofoNORVJVePY5gOrK5JngoOyjPUGkRjJs3lbCJeeqCECbAUjWRoVgcjp
	zPc87g1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXzca-00392e-2O; Tue, 13 Sep 2022 06:42:12 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXzcW-0038yk-Hq
	for linux-nvme@lists.infradead.org; Tue, 13 Sep 2022 06:42:10 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id AF7AB5BE34;
	Tue, 13 Sep 2022 06:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1663051324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=y7YjEuVtYrFAyaORXlPbHTOlUnYaSwijT48u7GMY5Bs=;
	b=yKpr3dTzZ1IWZ9WMxcqoFeOoEC6cb21HP8hH5RmRVTKz3mILoqWiNqddQZQuFHYKNkPL1T
	ZTvHrpp9PM+j+vyjWdlywz1tfY5i8GdwXJ3RdCHWC5E9JLPYB1apE6ohtXEvBtmEzyGSnr
	PIPupYAdmd5rA5nIgAsS8WTkefT83bI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1663051324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=y7YjEuVtYrFAyaORXlPbHTOlUnYaSwijT48u7GMY5Bs=;
	b=9qC8BSTI1w8P1/sQt03BJv4Tw5AuNnPx6NKZ1fxZF+NuduFSLUrXGSSVFeixyBTCgH7Vj9
	ZHSJSEHi2vQp3DBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 7BBE82C141;
	Tue, 13 Sep 2022 06:42:04 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
	id 707AE51AB19E; Tue, 13 Sep 2022 08:42:04 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] nvmet: fix port check in nvmet_subsys_attr_qid_max_show
Date: Tue, 13 Sep 2022 08:42:03 +0200
Message-Id: <20220913064203.133536-1-dwagner@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220912_234208_807654_3F40EB4F 
X-CRM114-Status: GOOD (  12.41  )
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

The item passed into nvmet_subsys_attr_qid_max_show is not a member of
struct nvmet_port, it is part of nvmet_subsys. Because we don't a link
from the subsystem to a port we have to iterate over all ports and see
if any of the ports are linked to the subsystem to figure out if the
subsystem is in use.

Fixes: 2c4282742d04 ("nvmet: Expose max queues to configfs")
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/configfs.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e34a2896fedb..e3711b1331ee 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1290,11 +1290,21 @@ static ssize_t nvmet_subsys_attr_qid_max_show(struct config_item *item,
 static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
 					       const char *page, size_t cnt)
 {
-	struct nvmet_port *port = to_nvmet_port(item);
+	struct nvmet_subsys *subsys = to_subsys(item);
+	struct nvmet_subsys_link *s;
+	struct nvmet_port *port;
 	u16 qid_max;
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
+	down_write(&nvmet_config_sem);
+	list_for_each_entry(port, nvmet_ports, global_entry) {
+		list_for_each_entry(s, &port->subsystems, entry) {
+			if (s->subsys != subsys)
+				continue;
+			up_write(&nvmet_config_sem);
+			return -EACCES;
+		}
+	}
+	up_write(&nvmet_config_sem);
 
 	if (sscanf(page, "%hu\n", &qid_max) != 1)
 		return -EINVAL;
@@ -1303,7 +1313,7 @@ static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
 		return -EINVAL;
 
 	down_write(&nvmet_config_sem);
-	to_subsys(item)->max_qid = qid_max;
+	subsys->max_qid = qid_max;
 	up_write(&nvmet_config_sem);
 	return cnt;
 }
-- 
2.35.3


