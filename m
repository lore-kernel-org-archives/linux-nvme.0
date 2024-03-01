Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B1FC5475B
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Mar 2024 11:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XzxKWsA+pMn+9H9zVri8/b5VUyoJiu22Fofr9X+aq+4=; b=3bikxJ/Bef5YtjofUt0tWbmBhF
	dq/0+GKQG/93rgqRXIErZRmgvGyg40uDkAtYwsrRhe3P+7FEqZgmSKNT2De+8pMSQHfPag+pe+UfQ
	XALJGO/jsXbo6H7K/shcefzpONVi2M5BNJC9vidJnp9+gAsipTo9Yjr618HGsQYArGSH0R+OCaqHa
	M2DWnn78DQdDLSyUfV1Q1Csu7rqV5SQzG6WNur3hUYQZShDqIvXUqXdoQ4BLkgfQnKwjkHZ2NXjFf
	kA2mp6BQFBWUXyggpNJ1/EPTyftH6cIATtBz7Yoey3A5yBUuW0v52hiFzz3PtbpXtPitBAnurt7WW
	GYtPm8vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg14A-0000000HZaE-2oGc;
	Fri, 01 Mar 2024 11:28:38 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg146-0000000HZY4-4AYu
	for linux-nvme@lists.infradead.org;
	Fri, 01 Mar 2024 11:28:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6FC4560FD1;
	Fri,  1 Mar 2024 11:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B519DC433C7;
	Fri,  1 Mar 2024 11:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709292514;
	bh=bqcXdeUZX0j9X8LT5EJJY4dpF/pA9uj/Egm9D87/Vvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tfRfFG8fGdg0Rihu0N3HY9wciEjzPxmks99zeCVoWzO8zJC9oKSCJPu6W/bdc1zIS
	 1WlinVlyVj8NcjxHEFW0GDh9paBUnAKoswBibaEc0HdFkpVke/KPx77qdzpo77GE+3
	 xQHS58fZdUtbPjwBZJ1UcIMqMpGLOAFMYJmGO2MP22vkI4vtY+hJjm+c7IGIFQuqOv
	 mh30fXUGvFOO3E2yNTu3Smz9vop+SBgGKPYUcJn+qId5oRr9cZAYnDj9mSpd+xuLqu
	 PaAiXfp3gDOJDFtzskw2QGpyXWR+mW5+dAlyniuM9rJRpJDp5vJkvJ8S8zG3W1gyoF
	 ChU5EV24lnCgQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/4] nvmet: lock config semaphore when accessing DH-HMAC-CHAP key
Date: Fri,  1 Mar 2024 12:28:21 +0100
Message-Id: <20240301112823.132570-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240301112823.132570-1-hare@kernel.org>
References: <20240301112823.132570-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240301_032835_113906_CD25A8C9 
X-CRM114-Status: GOOD (  13.24  )
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

When the DH-HMAC-CHAP key is accessed via configfs we need to
take the config semaphore as a reconnect might be running at
the same time.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/auth.c     |  2 ++
 drivers/nvme/target/configfs.c | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 3ddbc3880cac..9afc28f1ffac 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -44,6 +44,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 	dhchap_secret = kstrdup(secret, GFP_KERNEL);
 	if (!dhchap_secret)
 		return -ENOMEM;
+	down_write(&nvmet_config_sem);
 	if (set_ctrl) {
 		kfree(host->dhchap_ctrl_secret);
 		host->dhchap_ctrl_secret = strim(dhchap_secret);
@@ -53,6 +54,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		host->dhchap_secret = strim(dhchap_secret);
 		host->dhchap_key_hash = key_hash;
 	}
+	up_write(&nvmet_config_sem);
 	return 0;
 }
 
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 2482a0db2504..92756fca0005 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1962,11 +1962,17 @@ static struct config_group nvmet_ports_group;
 static ssize_t nvmet_host_dhchap_key_show(struct config_item *item,
 		char *page)
 {
-	u8 *dhchap_secret = to_host(item)->dhchap_secret;
+	u8 *dhchap_secret;
+	ssize_t ret;
 
+	down_read(&nvmet_config_sem);
+	dhchap_secret = to_host(item)->dhchap_secret;
 	if (!dhchap_secret)
-		return sprintf(page, "\n");
-	return sprintf(page, "%s\n", dhchap_secret);
+		ret = sprintf(page, "\n");
+	else
+		ret = sprintf(page, "%s\n", dhchap_secret);
+	up_read(&nvmet_config_sem);
+	return ret;
 }
 
 static ssize_t nvmet_host_dhchap_key_store(struct config_item *item,
@@ -1990,10 +1996,16 @@ static ssize_t nvmet_host_dhchap_ctrl_key_show(struct config_item *item,
 		char *page)
 {
 	u8 *dhchap_secret = to_host(item)->dhchap_ctrl_secret;
+	ssize_t ret;
 
+	down_read(&nvmet_config_sem);
+	dhchap_secret = to_host(item)->dhchap_ctrl_secret;
 	if (!dhchap_secret)
-		return sprintf(page, "\n");
-	return sprintf(page, "%s\n", dhchap_secret);
+		ret = sprintf(page, "\n");
+	else
+		ret = sprintf(page, "%s\n", dhchap_secret);
+	up_read(&nvmet_config_sem);
+	return ret;
 }
 
 static ssize_t nvmet_host_dhchap_ctrl_key_store(struct config_item *item,
-- 
2.35.3


