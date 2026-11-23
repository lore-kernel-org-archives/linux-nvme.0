Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394E5606A337
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=k9majUYf;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GqtXFiBy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=f6ce599FqRwONEOFMSTbCk4vIAmHrI8jxl4vZPZrkIA=; b=k9majUYfIiQRie
	tJ/KTCN8hPCupyaW6+G8zwz+ZyqTrEE815YpRMPdMKsRvhq6XjucpL0+BBPVB9hcoz8UlsVuzof+2
	gmFd7eI+2IBaKVm86VpGqzlQqGy4JE3dFf9sghE5v2Vr20nlgfkahzehvQJg4E5d32eslU/WDaR/1
	aP9ZOTDwW/kEe/56Bv8wMVyG7eFQuNVCjuDY0bOtSHWWoMzMgIsWZZEwsWLwO66sSQwcoENqkoXZZ
	DWkllcnT8Ty/7+nHTdnSr0znv8jSOywurIOKnwPxMs3QFubzkYKmGDzgX2EEpWdHCR883xzDr6mte
	shHOfOm3PDRE/d+Ehd7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVSx6-00000003JZq-1EtQ;
	Mon, 23 Nov 2026 12:15:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVSx4-00000003JXa-0AvJ
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 12:15:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 78D53620D8;
	Mon, 23 Nov 2026 12:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0261F000D8;
	Mon, 23 Nov 2026 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795436117;
	bh=f6ce599FqRwONEOFMSTbCk4vIAmHrI8jxl4vZPZrkIA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GqtXFiBy/cfer8tHBB0USDia4XQYgBVYd1LB5PgtTp1MnMtHOAA0fxTJ+BlVenZJU
	 +tjMIj5JKU2048N+0lwXI8R3udQmj8Qz4IDIhnp1Lk5RQMWQIOMlAa1/agXH6yhfT1
	 Qf2TDLOl+g+5Ml0EVuNr1nuUcV+RDj7qO+vu3olopsdcOPw4p+wl43IMRNyKmYrKig
	 5F0MvOZKW7mqvKjnsXApOHt5y9atnItjDxYLp/vOgdikenvCQPdyIVRYX8opyptfuy
	 SgWojH66JhrQaKCSEso1ZCojSK94NqwoNAAwAhbnuUCAsXVgbHgX+L5TYYDccXLOVC
	 /MiaPtJs/6bSg==
From: Hannes Reinecke <hare@kernel.org>
Date: Mon, 23 Nov 2026 13:14:52 +0100
Subject: [PATCH v5 7/9] nvme-auth: wait for authentication to finish when
 changing keys
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-dhchap-keyring-v4-v5-7-81eefb4c0724@kernel.org>
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
In-Reply-To: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795436094; l=1263;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=NQce0gsvHAsFMbR5yZxOTBCHXhB5o++ZAHZpRUDmz+w=;
 b=rv4zNgGBMYhxy04qFi//NHnwYKRSrzUKCdXhIdfQvJ0qbJSe6z0eOx/geZ2GrjtcmcV8ZNMmj
 1w6wcy5GrqgBvWLGXTHc5HO8hye2sP+lgzsdEDScvl/FNTumfETtrIp
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
 drivers/nvme/host/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index e6d42da84e1688110eb81e59161dc7c497bd0627..33f78914e8b5e6331e3a82f6bafa3c0bdc0b8ea6 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -903,7 +903,7 @@ static ssize_t dhchap_secret_store(struct device *dev,
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
+	flush_work(&ctrl->dhchap_auth_work);
 	return count;
 }
 
@@ -995,7 +995,7 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
+	flush_work(&ctrl->dhchap_auth_work);
 	return count;
 }
 

-- 
2.51.0


