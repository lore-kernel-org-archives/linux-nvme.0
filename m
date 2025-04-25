Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BB2C369D1
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 11:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bwn6UitqwxKJSroV8ef7AJKSVEs0h8lKSuURnsCw/uY=; b=sUXvu8dy97PWa5zerIBlfdNjr3
	TVX7vY2Sp3z4EshsRtuD06UxeVFVBX7FcI2QXC8Z9ARd5+zrGzo/V/+9VsuAT4LOCCNTFvy02qaY/
	uAfquI8MFPV+95w02h/BkJWUuTDPwtkn6kXpNJzsGGQywuwtdKYwSFfxKC0mDc1BCmG3NCRqqshKI
	RFs3+dhHssGUntlM2po1eUCsdZkWwW4oTos+G2XgVdRb560PK41lvCEcnJVUdXJCGffjI0tIEvboF
	uZ1L0rX++i8iA97FQJKFHuiNEp3ig8iCbrBco/PhLrSle7msa1MHO1mbJVkGDbTkkkpMU6tak7tuh
	IqBZTeGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8H0Z-0000000GtcZ-3LJO;
	Fri, 25 Apr 2025 11:14:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Fh4-0000000GbvP-0r6F
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 09:50:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 54B2F60007;
	Fri, 25 Apr 2025 09:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25420C4CEEC;
	Fri, 25 Apr 2025 09:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745574601;
	bh=+dbWJogcVUnCtPR5T/Hzsq3+SOCBFI+SHivwDvArqJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hlkYwSYZMdVZjaE/V+H/IjLtB4e88vmdF/q3lt8YD2Keaxsw2aPR0qmsuLg9//xj5
	 2c4CiwDX/uAD3nzrmUYFFXTJNAHmVXSFvD/DVwoZRTLIT/fJtSvC8z1sejnuEzmUcy
	 Nr5tb999IgEh5Rwc7I8RYvi/I9Ya/th4o1MB8lEfGq+1MIDDaxxuK+NumekvwhQm3C
	 I7pwgKCXBn8UytAQfSXcdFBV+yjigwAoq4qY1ksTy5o2qqxMqkJz7hpspaDDNRtDtD
	 4Hxq/lZpPbZv00g7Qe3yZ8xhmJeFMaVehEIQDHWMwzzASrOrzaEL6sY4pEkWyZhfCS
	 LW69LjgyPm0yQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 11/12] nvme-auth: wait for authentication to finish when changing keys
Date: Fri, 25 Apr 2025 11:49:26 +0200
Message-Id: <20250425094927.102656-12-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250425094927.102656-1-hare@kernel.org>
References: <20250425094927.102656-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 0f0f0608d6c8..db4474dda64c 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -649,7 +649,7 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
+	flush_work(&ctrl->dhchap_auth_work);
 	return count;
 }
 
@@ -714,7 +714,6 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		if (generated) {
 			dev_dbg(ctrl->dev, "revoke key %08x\n", key_serial(key));
 			key_revoke(key);
-			synchronize_rcu();
 		}
 		key_put(key);
 		kfree(dhchap_secret);
@@ -726,7 +725,6 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		dev_dbg(ctrl->dev, "revoke key %08x\n",
 			key_serial(old_key));
 		key_revoke(old_key);
-		synchronize_rcu();
 	}
 	ctrl->ctrl_key = key;
 	ctrl->ctrl_key_generated = generated;
@@ -736,7 +734,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
+	flush_work(&ctrl->dhchap_auth_work);
 	return count;
 }
 
-- 
2.35.3


