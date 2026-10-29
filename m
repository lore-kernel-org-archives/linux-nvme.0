Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CF8606A321
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 00:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=d9gZahwm;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehAA92vF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Cc:To:Message-Id:Content-Type:MIME-Version:Subject:
	Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=OQxAwIFM4Dy+JaXQReRXxUOmCNsUI1oyyY7VMdV3wqE=; b=d9gZahwmaPOCA0ufWZPDx8YLYq
	6/p7RGJkR6S0HmMIMsj4sVuHruyerxNHxw5rBDliiW15WkkYsKzeZqv65dKDTTmjm4yRSXByqbjdL
	1cQH1PtSJ47v/fun8dbr+EbV0u7/6Tfe7CKbOzJ2FDQppvPTsdgmB4UjhwMFNALWy8MRT4Twby3bI
	mFMl8OKQVSJdWwpCDQCtIK9TnqHHfz+oXx37aLinzKimjp2sPPdlzrrccVzcZrCnlBrZx+nTHp8cE
	aOocb7Pim3MIRC/vC6CqeJEEnXtai73BlWIIssGPHn2Chawo845cHP7zcVvEjA4u487cwzwMaSk3W
	1Ha7l4YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMEMb-000000087P0-1xUs;
	Thu, 29 Oct 2026 00:51:29 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMEMY-000000087Or-2RfK
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 00:51:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 02E924165E;
	Thu, 29 Oct 2026 00:51:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793235085;
	b=SD+DQfKq7ALdlYwqFyRnn057+CYW7hTxO6psAajBz+Eju2WPVu6C7MbELcdlB/6B8/ig
	 mpyH0Rf33cRwcyRpuVFn/fPwcIS+bdAmgWIKkoepgdcWe9/fFdhatvmcTaf6KFldLNOHh
	 Wew9qQKoFp0C4k+wi+QsdFewutF3l9F58xMV3bQqMSVZHGe2lMv1ACDahRDXgf+RIL20W
	 UtkBY5IOM4HeUTrU7KMfI26AXaUhVi2Xf52WP3/PxIQsU27QnxM7xNTw3Z1T23luPe1pI
	 4T5QBqLNdwmA2s2x9Uzsvx6nE4h4ifd/DIf0srdY/mINyyR8eb7q3QbeTp+GT1HDU0w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793235085;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=OQxAwIFM4Dy+JaXQReRXxUOmCNsUI1oyyY7VMdV3wqE=;
	b=H4e8dVczWMD12G9Q+4Gcy0loLSytfnctwKtgb8faycrQx2GMZqB9AXXJT3jSNw+0efkX
	 TgQsuLx+Vl1CKRXAl/rhs76DPzOJDCvv5stcExVjiCRqZF8cCglGRlUQQ4SfFpLIfbJcu
	 66kkwCgyyJ7Bk7irZdiH+IX8L531jmRzT9Y6VO/FQG3l9m4qVswxCjM2fIyBDxoEbUHqm
	 x9Cj2MPuTkcsBsiB40xkZTBVxn4COHWvYk55DuO1g+OM51NmOg1v7r29grJH2F0hzB1l4
	 OMPR+XxXUZbJ2qj2yvE6FSnmXTi2dA7Rv3xJIxioHUVSXZ0ABYZ8KRMqze6y+aZySpg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 61A701F01825;
	Thu, 29 Oct 2026 00:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793235085;
	bh=OQxAwIFM4Dy+JaXQReRXxUOmCNsUI1oyyY7VMdV3wqE=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ehAA92vFic4byXSAkIPVnwwQYthQyBg9jUpQuOVp86pu3KZP55+xTc/9+JQFKdhoM
	 Eq8pfnLrmt3oUb0ot+OM2JSYoTPgZ69dBvrHYNCvRvN7V+DQbqi7xvCTovrNU/nUEk
	 lvfKNt+xWneyh+xvEkG05VcB/TJBqGuJSxAW0cy0h3302Y/xHlfk51fvfeTa+JzBLi
	 8ZcvKa0qRQteSHa+KGVQPkVZfvN85xAVTZeB7Oww83g9tdv6l7aykp7MkM9SjDcUNr
	 19CVdeskgEMQtWlHJMuK8sjOgwhgsVxHSLHRwNLuvnprgaUku0uXyydO4rEDXidQG9
	 mY4EBEa77cjIA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C5F6C45646;
	Thu, 29 Oct 2026 00:51:23 +0000 (UTC)
From: Daejun Park via B4 Relay <devnull+daejun7.park.samsung.com@kernel.org>
Date: Thu, 29 Oct 2026 09:51:24 +0900
Subject: [PATCH] nvme: unregister when pr_register() is given a zero new
 key
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261029-nvme-pr-unreg-v1-1-b4657ad4e98e@samsung.com>
X-B4-Tracking: v=1; b=H4sIAIuY4moC/x3MQQqAIBBA0avErBtQC4muEi3ExppFJiNJEN49a
 fkW/7+QSZgyzN0LQoUzX7FB9x34w8WdkLdmMMpYrcyEsZyESfCOQjuaMTirQqDBD9CaJBT4+X/
 LWusH5YuPwl8AAAA=
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, 
 Mike Christie <michael.christie@oracle.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Daejun Park <daejun7.park@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793235083; l=1781;
 i=daejun7.park@samsung.com; s=20261006; h=from:subject:message-id;
 bh=mAU8OTdvinewhOZxDTmeXGacEZAsamAJlbTQrV18Lu8=;
 b=c5q4qcV2O2rZi5rHmmEktc3SJVT8gpMB9op5eXzH9YJ52W2Cn/7S9he5kMvOjX8OuAtFmyTey
 Qn9UwWPeegeBs9CcwDecacqBZ51x/r2eHAnpLrCK7rJ69hmU4Jj9jw9
X-Developer-Key: i=daejun7.park@samsung.com; a=ed25519;
 pk=4yUfDqGRZTIj0Ik43z1GoMZRWCNm/rgX6uJuM9dtNIg=
X-Endpoint-Received: by B4 Relay for daejun7.park@samsung.com/20261006 with
 auth_id=1122
X-Original-From: Daejun Park <daejun7.park@samsung.com>
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: daejun7.park@samsung.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daejun Park <daejun7.park@samsung.com>

The block layer PR API defines a zero new_key in pr_register() as
unregistering old_key. nvme_pr_register() sends Replace Reservation
Key with a zero NRKEY instead. The host stays registered with key 0,
and its next registration with another key fails with Reservation
Conflict.

The pNFS SCSI layout client unregisters this way at umount. A later
mount cannot register and sends all I/O through the metadata server.

Send Unregister Reservation Key when new_key is zero.

Fixes: 1d277a637a71 ("NVMe: Add persistent reservation ops")
Cc: stable@vger.kernel.org
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
Tested with IOC_PR_REGISTER on an nvmet nvme-loop namespace and on
dm-linear over it. Registering a new key after unregister now works.
A wrong old_key still gets Reservation Conflict.
---
 drivers/nvme/host/pr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index fe7dbe2648..d8b6ac4d83 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -128,8 +128,12 @@ static int nvme_pr_register(struct block_device *bdev, u64 old_key, u64 new_key,
 	data.crkey = cpu_to_le64(old_key);
 	data.nrkey = cpu_to_le64(new_key);
 
-	cdw10 = old_key ? NVME_PR_REGISTER_ACT_REPLACE :
-		NVME_PR_REGISTER_ACT_REG;
+	if (!new_key)
+		cdw10 = NVME_PR_REGISTER_ACT_UNREG;
+	else if (old_key)
+		cdw10 = NVME_PR_REGISTER_ACT_REPLACE;
+	else
+		cdw10 = NVME_PR_REGISTER_ACT_REG;
 	cdw10 |= (flags & PR_FL_IGNORE_KEY) ? NVME_PR_IGNORE_KEY : 0;
 	cdw10 |= NVME_PR_CPTPL_PERSIST;
 

---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
change-id: 20261028-nvme-pr-unreg-24fa60ffe3c3

Best regards,
-- 
Daejun Park <daejun7.park@samsung.com>



