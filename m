Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45274C5B552
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 14:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9myAt55nzTVZPeL1+I0UGO3/SR7EVnV5COz+1M/JMVo=; b=cpdHwLZBIfds7hgVX3ZHk32pdv
	sATwsVhvzIBzgB5VeFhVgQeWg+Bil3zwLI9jXLEH/xr3x8XJHwXMPOrKQs7+enN+lm9en9cBBOLXM
	WMef1k6T/8eDVAKBU/dRcbr3zIGPyjcCEEKwvVicntoQXGUuKbX+y+FZ1vc4sKZQs5ML73tmefmvn
	lVTxE4/Vb1jIVzlDk5+wbDD3kz5WlHBQ/R63cijNifRPTtuBmaqULuZeOhSX6kpPJThwxO7GZaWdx
	IWovFpSTSUxPgSUHVVuzUtcgCZxNAUel8D2CrmE5kZnk6KPwtX4mAn+a/SP9/kGioj5SjvhD4hnrT
	2g94ZhKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKHdJ-0000000DN57-2ppb;
	Wed, 28 May 2025 14:19:53 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKHSY-0000000DKRe-0ml5
	for linux-nvme@lists.infradead.org;
	Wed, 28 May 2025 14:08:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D49224AC0B;
	Wed, 28 May 2025 14:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64389C4CEEF;
	Wed, 28 May 2025 14:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748441325;
	bh=64tMaHQVZmU6/xnCGFbf7xVR48dbcuyk/d1/AtWHPNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cc3yQrbAV9jOTUjT24vCr+riFckRoo2QcYLP10D8l0eM86amW07e0liYAZXRhKVu9
	 SdhIMwc87rbY0fhamtKdaQiOJbd3yAHkfBv1KgSw2+qt8TTAzxjkM4HU77sXlLjqBO
	 L4kfPcT+9lQHlWflrmfQj6/p2cwFk9fGxm5K+6W/EadnJFxm3A+2Zh+0xHUhd9EsDj
	 o7sPF4SbCoh3sg1HR7SzzaK7tfZNUuH24dx3wAwGjrZWPmfVxJFESjZpitPYpMplOC
	 1oXMU4+7lo7B5mfuiqOsu/tEvGDeQ/1nmXSnltNWA96cXDk/BGZXvDD8lKlksxdY5x
	 EjRiTUYAkiGhQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 7/9] nvme-auth: wait for authentication to finish when changing keys
Date: Wed, 28 May 2025 16:05:15 +0200
Message-Id: <20250528140517.3284-8-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250528140517.3284-1-hare@kernel.org>
References: <20250528140517.3284-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250528_070846_244681_7F96514A 
X-CRM114-Status: GOOD (  10.41  )
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

When changing DH-HMAC-CHAP keys in sysfs we need to wait for authentication
to complete on all queues. Otherwise the user might change the keys while
authentication is in progress, causing the authentication to fail and
I/O to be interrupted.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/sysfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index f1ab165c1f86..3ca10db0653c 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -656,7 +656,7 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
+	flush_work(&ctrl->dhchap_auth_work);
 	return count;
 }
 
@@ -721,7 +721,6 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		if (generated) {
 			dev_dbg(ctrl->dev, "revoke key %08x\n", key_serial(key));
 			key_revoke(key);
-			synchronize_rcu();
 		}
 		key_put(key);
 		kfree(dhchap_secret);
@@ -733,7 +732,6 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		dev_dbg(ctrl->dev, "revoke key %08x\n",
 			key_serial(old_key));
 		key_revoke(old_key);
-		synchronize_rcu();
 	}
 	ctrl->ctrl_key = key;
 	ctrl->ctrl_key_generated = generated;
@@ -743,7 +741,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
+	flush_work(&ctrl->dhchap_auth_work);
 	return count;
 }
 
-- 
2.35.3


