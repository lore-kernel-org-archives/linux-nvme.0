Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1758C369D1
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 13:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D0PglTRE8NpygpXy8/TXLWs6osqOl+/ceOAmtNzWX2E=; b=HhXp9xDkhKjXXPpS8Elv7DQ2Ui
	dRb+x8401Es4WCAx9DROuilD0a9dHGZgpUUCz6ruod/zJwFL7xWP8sxISV/KbzsTe4cdbXCfrRXhV
	OraG2raU0RW2a2jjbAAFUNAOMMOq1xUcHgpshR2dQgTVhom40gVnI5hGpwD45vgft027hfxvlfXvJ
	GDu0ub5hKamRbXmZ185ixkZoPhye6zJKC1orlkmROzFlsNJ+aT2igjZ/49o1WGcyGN7VVENKJjdUP
	tzsRJmIt74SDK71LCU2rNOwURAZUo3pwxrq+1ikf8y6P6kwaQx5RcUI8+zzAXZ+IzTmDvEn+KmDnF
	pQF/LfJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7aXR-0000000Ahs3-3i8O;
	Wed, 23 Apr 2025 13:53:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7a3Q-0000000Aan0-2gaF
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 13:22:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C0E5A44E2C;
	Wed, 23 Apr 2025 13:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6528C4CEEB;
	Wed, 23 Apr 2025 13:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745414540;
	bh=TzcGZfdwmdfAFPVttrRv4/p72KsoezPGz0D2QH9DrFQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NkzzeHvSffX8EV4RRVX60fGVqrkaMNDBoeokXbDeo3hht+Q7VS9796luhryr6x0qL
	 o1PZj6iEghGK0uvRx8xPcE92K5o4rwyTQSFgC+nw3kWoUKpcrm+/73AxpjxTiVl/3e
	 U/DcecGxhiYCtZNlmZHGqk8ZeOqGN2ngmbmNBYQqbtwjenoBBAZchKRK/A3KQOHyZp
	 NpzWwBoMhnXMytqKkyxb7eAMCooNE3QN7Qdxrn64zzhyz4lucl0ebRISKamIMGslhd
	 X4d9HKvBFE848Up8STUI8+eUrCR/AYsbfhik5A0lthiv5I+f3cusyOyc70V8lDjQfS
	 Ke46iCbRa1LRA==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 23 Apr 2025 15:21:53 +0200
Subject: [PATCH v5 10/14] nvmet-fcloop: don't wait for lport cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-nvmet-fcloop-v5-10-3d7f968728a5@kernel.org>
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
In-Reply-To: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_062220_722448_688204CC 
X-CRM114-Status: GOOD (  12.71  )
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

The lifetime of the fcloop_lsreq is not tight to the lifetime of the
host or target port, thus there is no need anymore to synchronize the
cleanup path anymore.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 47ce51183a66b4b37fc850cced2ddf70be2cdb42..ca11230bffedb0f2313a99e24e54e892daf0d644 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -207,7 +207,6 @@ static LIST_HEAD(fcloop_nports);
 struct fcloop_lport {
 	struct nvme_fc_local_port *localport;
 	struct list_head lport_list;
-	struct completion unreg_done;
 	refcount_t ref;
 };
 
@@ -1083,9 +1082,6 @@ fcloop_localport_delete(struct nvme_fc_local_port *localport)
 	struct fcloop_lport_priv *lport_priv = localport->private;
 	struct fcloop_lport *lport = lport_priv->lport;
 
-	/* release any threads waiting for the unreg to complete */
-	complete(&lport->unreg_done);
-
 	fcloop_lport_put(lport);
 }
 
@@ -1238,18 +1234,9 @@ fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
 }
 
 static int
-__wait_localport_unreg(struct fcloop_lport *lport)
+__localport_unreg(struct fcloop_lport *lport)
 {
-	int ret;
-
-	init_completion(&lport->unreg_done);
-
-	ret = nvme_fc_unregister_localport(lport->localport);
-
-	if (!ret)
-		wait_for_completion(&lport->unreg_done);
-
-	return ret;
+	return nvme_fc_unregister_localport(lport->localport);
 }
 
 static struct fcloop_nport *
@@ -1332,7 +1319,7 @@ fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
 	if (!lport)
 		return -ENOENT;
 
-	ret = __wait_localport_unreg(lport);
+	ret = __localport_unreg(lport);
 	fcloop_lport_put(lport);
 
 	return ret ? ret : count;
@@ -1776,7 +1763,7 @@ static void __exit fcloop_exit(void)
 
 		spin_unlock_irqrestore(&fcloop_lock, flags);
 
-		ret = __wait_localport_unreg(lport);
+		ret = __localport_unreg(lport);
 		if (ret)
 			pr_warn("%s: Failed deleting local port\n", __func__);
 

-- 
2.49.0


