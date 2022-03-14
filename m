Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A852C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 10:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VbAkAaFOKAV4hqPZxU7T8bXZoKoEozt7kYVwQPrl0F4=; b=0CR4460uG2V4q3aYw1+eVMIK1s
	i/5LI+cDPOa8fah+0o0+sEkxIVo0vd0uUjDcZC1rBOu3XLc3+Xd2qIFkKHJX4XtBJ1niId/9ihL0G
	YrGTQlwXyiuDvpiHFMV2EoP0exVttTCw072LarBErCWhpqdLs4i0sCGKOyuAId4WiW/r5wqMrY2RO
	K2NMq7ztSgDe7LeH5FzIjCN3+KA6GW/1XaWzw8bHaakRlcCrl+voRdiwcZ5g/UzjRjtR+6No5Zncs
	AKcnHl3c1FaeHcYjDGVgUzo2VtIl9SXQd3ZcxABwZdLINzC+D+ApQgaavWMZM6RwQszcFWxwVUjs+
	nxfsCDdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTiKl-00537R-Du; Mon, 14 Mar 2022 10:53:51 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTiKX-00531e-E1
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 10:53:38 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 537BB210FC;
 Mon, 14 Mar 2022 10:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647255215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VbAkAaFOKAV4hqPZxU7T8bXZoKoEozt7kYVwQPrl0F4=;
 b=J1F8MnONeYl7ykovXVqD3kKdh7qUh1i5m4KE19IrkEOq/yCVaTQRtUISTOnG7vc7eAwEVP
 SR9aPThc7eGX4kjfVp2OYCRUKFQOhRvlW7KnhKq7rOK5OZLOcnyPoRyfr7y6TAX4va6Mz8
 MoecZ9pz2R5vwDkQ19q9EMikzIVoKHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647255215;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VbAkAaFOKAV4hqPZxU7T8bXZoKoEozt7kYVwQPrl0F4=;
 b=JxP+nBzqIVRurGNTVYfymEzaThOfsv2J1333sjLn8M+nI2VfmFRn9E7IIOsaVhuo10jlbI
 SmsZNVg2KkhhqHCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 25B6EA3B89;
 Mon, 14 Mar 2022 10:53:34 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 5415F51936AF; Mon, 14 Mar 2022 11:53:34 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/3] nvmet: restrict setting of discovery_nqn to discovery
 subsystem
Date: Mon, 14 Mar 2022 11:53:32 +0100
Message-Id: <20220314105333.56714-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220314105333.56714-1-hare@suse.de>
References: <20220314105333.56714-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_035337_644192_A6D81383 
X-CRM114-Status: GOOD (  15.98  )
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

Changing the discovery NQN only makes sense for the discovery subsystem,
as any other subsystem can only have one (fixed) subsystem NQN.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 9b94af2444b2..58124abdbf62 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1310,6 +1310,12 @@ CONFIGFS_ATTR(nvmet_subsys_, attr_model);
 static ssize_t nvmet_subsys_attr_discovery_nqn_show(struct config_item *item,
 			char *page)
 {
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	/* Only the discovery subsystem can have a different subsystem NQN */
+	if (subsys != nvmet_disc_subsys)
+		return -EBUSY;
+
 	return snprintf(page, PAGE_SIZE, "%s\n",
 			nvmet_disc_subsys->subsysnqn);
 }
@@ -1318,9 +1324,17 @@ static ssize_t nvmet_subsys_attr_discovery_nqn_store(struct config_item *item,
 			const char *page, size_t count)
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
+	struct nvmet_port *port;
+	struct nvmet_subsys_link *p;
 	char *subsysnqn;
 	int len;
 
+	/*
+	 * Can only change the discovery NQN for the discovery subsystem
+	 */
+	if (subsys != nvmet_disc_subsys)
+		return -EBUSY;
+
 	len = strcspn(page, "\n");
 	if (!len)
 		return -EINVAL;
@@ -1330,13 +1344,21 @@ static ssize_t nvmet_subsys_attr_discovery_nqn_store(struct config_item *item,
 		return -ENOMEM;
 
 	/*
-	 * The discovery NQN must be different from subsystem NQN.
+	 * The discovery NQN must be different from other subsystem NQNs.
+	 *
+	 * This is a tad convoluted, but avoids having to do a
+	 * listdir() from the kernel.
 	 */
-	if (!strcmp(subsysnqn, subsys->subsysnqn)) {
-		kfree(subsysnqn);
-		return -EBUSY;
-	}
 	down_write(&nvmet_config_sem);
+	list_for_each_entry(port, &nvmet_ports_list, global_entry) {
+		list_for_each_entry(p, &port->subsystems, entry) {
+			if (!strcmp(subsysnqn, p->subsys->subsysnqn)) {
+				up_write(&nvmet_config_sem);
+				kfree(subsysnqn);
+				return -EBUSY;
+			}
+		}
+	}
 	kfree(nvmet_disc_subsys->subsysnqn);
 	nvmet_disc_subsys->subsysnqn = subsysnqn;
 	up_write(&nvmet_config_sem);
-- 
2.29.2


