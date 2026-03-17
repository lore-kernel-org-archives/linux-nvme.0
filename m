Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC01AFD8765
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 13:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gz6a+3ccAHFf2w6gedOeJhzpEGs4ftrrYFWscZD4kU4=; b=wa5AT9lpUnABxRRYEMHsCo+6yd
	OeVtCeLTZp/TQVtVtcTMf/cGKUBgN6mXw4Ae9tdC+GRdIfLR+uFn1lkqdWOkUecGdv+uKaDrjGSVn
	qpVIzQOhtp2qT4Vw5QlV+kcWl9VfG51m6B3kRoAlWSJWYdGMZunwQnJM3dkSO/4xk/vgQsa63mAwZ
	TdG+Skfn8IB36pMgwkqXNpLt0HqzEjvgZ6IPXUArMa7zbOJ1J44OdqdD7qScJBjJTiSMkmtUg3fVd
	loSbKSngZRu3JEURL7dcyhd+thD0VWMX8ARKRzezXGW8kEZ2pdr59DdT0k/vOz/rqJjeCvOCyMa8Y
	zMZ2j0Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2U3B-00000006LmF-0hQK;
	Tue, 17 Mar 2026 13:01:33 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2U37-00000006LjP-19Nr
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 13:01:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F3C1444079;
	Tue, 17 Mar 2026 13:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91105C2BCB0;
	Tue, 17 Mar 2026 13:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773752488;
	bh=++9F/kdy/v+bAuwyigINMdEENz8uT0hOUW6z4wRlj20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WIZcsIevj7xRSd+HSTZJ8aUTz8iqjJovUa5xZ9ioGbnTM7NFm+dPNe+H8dz+Mj3aU
	 kW6oRW0l7cTWFg7ymnR8SXR14UeLPMwA/19R/Msrk3Mdff6v2vJgdfsMYcOUobnHmQ
	 ZJ4xXe8rtdlJHGZtB+WxvNwAycvUrBDjGEIKjJAsMYJFEAxw0fymdYkYyYkKL6t0/F
	 0N9vuSarNBhI+kGpzpvQAv5ED/gOfHVhS1uF2+lpgVj6d+RhfKKauaGmjJZe4KfOr8
	 7ht3VjpRhirtEusSqv9uh+sWFf7z4dtz2HETibVNUuqRqFnjmgvoflsbyblIL391nj
	 pHNldL6CSft/A==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 7/8] nvme-auth: wait for authentication to finish when changing keys
Date: Tue, 17 Mar 2026 14:01:02 +0100
Message-ID: <20260317130103.107360-8-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317130103.107360-1-hare@kernel.org>
References: <20260317130103.107360-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_060129_357675_27C9639A 
X-CRM114-Status: GOOD (  10.31  )
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/sysfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 73fd5d65adc7..bb2f6ef9c9e9 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -662,7 +662,6 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		if (generated) {
 			dev_dbg(ctrl->dev, "revoke host key %08x\n", key_serial(key));
 			key_revoke(key);
-			synchronize_rcu();
 		}
 		key_put(key);
 		kfree(dhchap_secret);
@@ -684,7 +683,7 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
+	flush_work(&ctrl->dhchap_auth_work);
 	return count;
 }
 
@@ -761,7 +760,6 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		dev_dbg(ctrl->dev, "revoke ctrl key %08x\n",
 			key_serial(old_key));
 		key_revoke(old_key);
-		synchronize_rcu();
 	}
 	ctrl->ctrl_key = key;
 	ctrl->ctrl_key_generated = generated;
@@ -771,7 +769,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
+	flush_work(&ctrl->dhchap_auth_work);
 	return count;
 }
 
-- 
2.43.0


