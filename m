Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457E4C369A6
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 11:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6fPCuJwEFOktafog0iNkX5vjDHQXYC+XGkzIYyPIPCU=; b=vvynVvGwaphwWXRKcqxHIcVZ2a
	BRHb5eMC7GC6kxWyptqaKPtY5df4gsbQ554H53O6eSyLXqd76QHD/hDb1lTeaNMKkaB06f0QFV9Pt
	smGrQuyoZvlkqCsJUzqnAW4cHStieZ2fva96+38STLXG3f2Zdr8dLtC4nowi7yiip0UmvOEKTUyaB
	WbFzwnjgtyyzSTLb+I8UD808bdkaWIhe4rQQCA/MK50/0+AhMBceitYNTueA43JVkcmhBNFeeDeRc
	VEsRXnipmAMd1eVpbbyr3iJoW4DElNaAyOotnY3MlfBwzyPkujYlL0mQK/aQxrBk6Hzxl9rlgocmw
	ZxRJd5dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2qN1-0000000AM2d-2nse;
	Thu, 10 Apr 2025 11:46:59 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2qHa-0000000AKqC-178U
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 11:41:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C4BB9A4A78D;
	Thu, 10 Apr 2025 11:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7B0C4CEEE;
	Thu, 10 Apr 2025 11:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744285281;
	bh=F6amLIDQUFRoq7o9H5ZznvD/2tad4/3TkumHpgROHvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b3GnRhVHYh8qPegXoQx+EUNzTsbNdojx6k+vSBid2yX7Ct82EOddOc3Hv/NYbc1Ee
	 S/7pzWJieRWVzaUbW52uQ5Z/cX3JojW070pPccBLe6PVYauxmCIEjHdgb00eZF0CtN
	 t9resfh9eVAfj8FIlRbGyvXHPqBQ4R6KdyzjIxKD4AXQB9ht1WooYRvcMwSF1CKyYU
	 t+Ha0/+J5IcDYvuii8mLSaT0TW7069aJN63WwqzjFHfR35TyUGoVoHruRnXFlpstix
	 aEJXtCVR7JeE0f59PdBZ8Vtabe0rnw3Sk6PM7VB9ueILyIWzrgfPULCrF1xygyc0hq
	 25WnzfEPJDB3w==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 10 Apr 2025 13:41:07 +0200
Subject: [PATCH v4 04/14] nvmet-fcloop: refactor fcloop_delete_local_port
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-nvmet-fcloop-v4-4-7e5c42b7b2cb@kernel.org>
References: <20250410-nvmet-fcloop-v4-0-7e5c42b7b2cb@kernel.org>
In-Reply-To: <20250410-nvmet-fcloop-v4-0-7e5c42b7b2cb@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_044122_373365_5F741445 
X-CRM114-Status: GOOD (  11.35  )
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

Use the newly introduced fcloop_lport_lookup instead
of the open coded version.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index a8134127ad8087190d674251a88545da3f8800d7..1a8ae33c1699be3b7a2a7170dff77e324c127ebb 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1256,32 +1256,32 @@ __fcloop_lport_lookup(u64 node_name, u64 port_name)
 	return NULL;
 }
 
+static struct fcloop_lport *
+fcloop_lport_lookup(u64 node_name, u64 port_name)
+{
+	struct fcloop_lport *lport;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	lport = __fcloop_lport_lookup(node_name, port_name);
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	return lport;
+}
+
 static ssize_t
 fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct fcloop_lport *tlport, *lport = NULL;
+	struct fcloop_lport *lport;
 	u64 nodename, portname;
-	unsigned long flags;
 	int ret;
 
 	ret = fcloop_parse_nm_options(dev, &nodename, &portname, buf);
 	if (ret)
 		return ret;
 
-	spin_lock_irqsave(&fcloop_lock, flags);
-
-	list_for_each_entry(tlport, &fcloop_lports, lport_list) {
-		if (tlport->localport->node_name == nodename &&
-		    tlport->localport->port_name == portname) {
-			if (!fcloop_lport_get(tlport))
-				break;
-			lport = tlport;
-			break;
-		}
-	}
-	spin_unlock_irqrestore(&fcloop_lock, flags);
-
+	lport = fcloop_lport_lookup(nodename, portname);
 	if (!lport)
 		return -ENOENT;
 

-- 
2.49.0


