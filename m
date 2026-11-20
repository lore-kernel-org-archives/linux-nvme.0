Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCCC60A2637
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vXTSL/O0;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GqkwZTXS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=AfDl09HCOdC6ty2onrha6eMWA47wa+fLuXb2WwM6rSw=; b=vXTSL/O00/TsGH
	LEQ4G9H27tZnk3Q08PHHgtXse2XFhgjRYXN/vLqMrq4a1tAxZJynwZiFmlbgM+fxhzQQ5jHk4pwaP
	9xjywcozYjiuljYpm1FQre/K3gGiPWD7TVKyGXSRQP4rXaHtWQ91xxpLaHKr0+DwWdFpRRnP88L8d
	nsGSunlipKXe3pWYFc34ji1lvBarWGTDLXy6Do/cGWeMG0EKKnqZN3yxx6220C1qQUo7BjOOY6q/z
	hAxUSFw5eHB0L5tgy+IfVTwxMA9i0wwD+E9GZ2kRcNXgp460hqAMAUWfpd0EPeucIgENIfYDepQWL
	eDald5hCCrXQDQT4iQLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMZl-0000000Ekry-3YF2;
	Fri, 20 Nov 2026 11:14:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMZh-0000000EkoO-31mR
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 11:14:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2EBDF60D56;
	Fri, 20 Nov 2026 11:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F511F0093E;
	Fri, 20 Nov 2026 11:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795173277;
	bh=AfDl09HCOdC6ty2onrha6eMWA47wa+fLuXb2WwM6rSw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GqkwZTXS/VvSSegFTnqFSPKP/0HoasBNR8yVVdWZQgXpZZNspD/pL1kgRzqrYNRGT
	 4cRM3wDDt2aqzcp9iu/zidMNEGNAbLPcss3p9ku0ftdvSsgpuUNvQO61+8PDXE6zpT
	 rTgos49nT64iQ88ct+adz42TJQZtBjGnru8uhAvWC7AwU7Y5S8k30R8muWTP9IuGLM
	 Y/UDbpsTENTqAxCld9z43kxPQfsLevNMFbvsb+gAh4gtjadDcMe42lLAhYkwNAKi62
	 pFxyHLV+ed+uTXq2/ugbe++p66gIyzkSnnCqyc87JQxwPfCpdQQkX8rhfeK9qPUgST
	 Wkd1BzUUcZ9bA==
From: Hannes Reinecke <hare@kernel.org>
Date: Fri, 20 Nov 2026 12:14:06 +0100
Subject: [PATCH v4 7/9] nvme-auth: wait for authentication to finish when
 changing keys
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-dhchap-keyring-v4-v4-7-5f8c7d9926ee@kernel.org>
References: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
In-Reply-To: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795173255; l=1812;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=iC5uIetjBmiu+F/MAqTDdLINO5cA+QFsZTQyB9J/JXw=;
 b=472pOmkDTRMcF4MYfGAdKFt9PSahbLRaHfzWZihopwAl24EjPSAFnxpb0WvktRYYs3YeAIP9T
 sm2XC4B2z5RBQhVzO8Yzl29CqPRfeDx66BKWIrTMSgRZadiNCaGaS4d
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 47caed2ce39786848a5acdb1dc50e4b156694086..ce327a018b0d0a24e26a7f9bfce761157aafe871 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -875,7 +875,6 @@ static ssize_t dhchap_secret_store(struct device *dev,
 		if (generated) {
 			dev_dbg(ctrl->dev, "revoke host key %08x\n", key_serial(key));
 			key_revoke(key);
-			synchronize_rcu();
 		}
 		key_put(key);
 		kfree_sensitive(dhchap_secret);
@@ -897,7 +896,7 @@ static ssize_t dhchap_secret_store(struct device *dev,
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
+	flush_work(&ctrl->dhchap_auth_work);
 	return count;
 }
 
@@ -973,7 +972,6 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 		dev_dbg(ctrl->dev, "revoke ctrl key %08x\n",
 			key_serial(old_key));
 		key_revoke(old_key);
-		synchronize_rcu();
 	}
 	ctrl->ctrl_key = key;
 	ctrl->ctrl_key_generated = generated;
@@ -983,7 +981,7 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
+	flush_work(&ctrl->dhchap_auth_work);
 	return count;
 }
 

-- 
2.51.0


