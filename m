Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F448C3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 12:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OmPH3KW8Ie+h6qmovvK3faMO3O9A5b/FpA3sobTf8/k=; b=n/vWhPIAb7KnfvXxys/fYnq0aR
	cM7EqBrXZWzNDkrrvYPnNyrBM4jGfIMVdMDG49VmJRoPkI4lf+Z+ym9gI7nROmB7TSTNvEFatHqge
	+Np0K5xwSOolLSEtWyTKjSLdy4mc/+GpS58m7OHYalutC6tXyMMcNqBIWLF/t0PsTGPAVg1UomtYp
	GWRzjymSvsGX7WmuEw/7AqbFl+9UKOjKTe+9QNNN/Dyo1GL2+HoWhAj5fXjXuQWs3kwn5gI+vVqbW
	ziLVNre7LGU/ZLEKGSiKiXWaON41g/BYtjFs/hXwj/Z3gRGwhZn2wf0Hxc0UklGXNrauk/Z8yxLyX
	H/HruDOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdoD-0000000FN92-0MUA;
	Wed, 07 May 2025 12:23:33 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdoB-0000000FN7Y-44cE
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 12:23:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 63138629D5;
	Wed,  7 May 2025 12:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C386AC4CEEE;
	Wed,  7 May 2025 12:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746620611;
	bh=wstjbJH1UyMo+LF5FaHWTbfkuXNTo5rZRqDKY0yRXBc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fuqAz+XlOwDRClCaVi0ae1tzr2c+cpR6MsX8wyU+WblgbDTwOp7DwrMvS6v9IrF2W
	 B5BDTJNTwXLOgBa/6d1LEjUbiPD9zGFn58+MtOChaaUnGJIXzXcKmXFwvEOXiJLFc8
	 kAD0++8S//6JUSfXGBIxLoR3BAzNLowEbCt+LCAJkmZSZYexeKJdxyWPtqDeZfdqKb
	 YAZPGHW/2RYoXkoFZJV4d6L9TCtDBVNWqNoD5e5AvxUpAV4cHK5jjWtWUDVRdCA6Xi
	 MmwqsMaPvIWn8qr5A3kIuIKdc+rcc7rucgUR4iyJtvr9eRZnpVOnfTwunrCBTVLZNO
	 fw8th/0B6o2yw==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 07 May 2025 14:23:06 +0200
Subject: [PATCH v6 10/14] nvmet-fcloop: don't wait for lport cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-nvmet-fcloop-v6-10-ca02e16fb018@kernel.org>
References: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
In-Reply-To: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
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
index f999bd6513c19b19af64e0ea547db26b627aab69..fc10d380c17e77ed35706ddd7690e6f6a8d268c6 100644
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
 
@@ -1234,18 +1230,9 @@ fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
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
@@ -1328,7 +1315,7 @@ fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
 	if (!lport)
 		return -ENOENT;
 
-	ret = __wait_localport_unreg(lport);
+	ret = __localport_unreg(lport);
 	fcloop_lport_put(lport);
 
 	return ret ? ret : count;
@@ -1772,7 +1759,7 @@ static void __exit fcloop_exit(void)
 
 		spin_unlock_irqrestore(&fcloop_lock, flags);
 
-		ret = __wait_localport_unreg(lport);
+		ret = __localport_unreg(lport);
 		if (ret)
 			pr_warn("%s: Failed deleting local port\n", __func__);
 

-- 
2.49.0


