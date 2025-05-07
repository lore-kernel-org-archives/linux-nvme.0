Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31239C3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 12:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ADb8iLJRdW0Ry1V+6OuVQg+LI4dcsJlwmeD1ojicEdE=; b=A6oBLmLYLP1uF6BZ8wXRYIoU/b
	OhIMetaD3sW929F9BWfi7P25HJrflgTVnKVbZTpzzX0O4k6qH2ML0IfdPQO2yoSsE3hWdsEqB3uv3
	U1zzw9f3Z2uVwQ1WYtqGjH2No4g1aqeGzYKoXAbQuCzd79wCxQ+FRx2+yVLS8Ws2xM1CrTLYH95us
	u0tzts9T6A++HOEGXj/u44+qG/1cmO802DJBe46kU7pLel4LppR6LtCbPaVkCnQcfYy8laGh8Eki2
	jj03vNbfrPXYoJzG5OWj3x/v8qAlY005wFOi+D8BAYN2ETpVREQBg7FnSBQwJno1r2G9Y7Wtx3R7z
	E1x9zHPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdno-0000000FMmz-235N;
	Wed, 07 May 2025 12:23:08 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdnm-0000000FMm6-2VkJ
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 12:23:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B3DDF629D6;
	Wed,  7 May 2025 12:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F027DC4CEEB;
	Wed,  7 May 2025 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746620585;
	bh=jEKbG5pfx1l0nP/U7lRUSa0XqnGWbsgWmnMw8er6V34=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JDVYH5OSvHrHuHWyeu4oC6KasDrRjMjAHTjM5s2tW+q3xjpCWjaz5JBb5fARtu6To
	 f+3enFNz4pbSye06rxYGULNcYFuC0JnNxWHMLD3F284fXnq7ZIW+0MYR/7DWhXTm0X
	 1d4TwlT9WY9zNGXKPZKksacH5JSFd1/ihXVbOYnvHrTQXJcBhNqPpC+MjAjI9pNn2f
	 1HwETJJjUaR+M4ngAaNJetvrhMi7mE5xAND4scBlZLb4LtWtjDCIfGoNIEE4fg4yMk
	 oRDR9op8Oa2CKEE0AFeb3dtZKYJTiYIPPpsrRKW9OG12q4hicYBV+Hi+WmWgNlKiLI
	 vuHdB+UvNlvBQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 07 May 2025 14:22:57 +0200
Subject: [PATCH v6 01/14] nvmet-fcloop: track ref counts for nports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-nvmet-fcloop-v6-1-ca02e16fb018@kernel.org>
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

A nport object is always used in association with targerport,
remoteport, tport and rport objects. Add explicit references for any of
the associated object. This ensures that nport is not removed too early
on shutdown sequences.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 133 +++++++++++++++++++++++++++++--------------
 1 file changed, 90 insertions(+), 43 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 641201e62c1bafa13986642c6c4067b35f784edd..2b23e43ef4403fa4d70c66263f7750165d2ddc72 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1047,8 +1047,14 @@ static void
 fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 {
 	struct fcloop_rport *rport = remoteport->private;
+	unsigned long flags;
 
 	flush_work(&rport->ls_work);
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	rport->nport->rport = NULL;
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
 	fcloop_nport_put(rport->nport);
 }
 
@@ -1056,8 +1062,14 @@ static void
 fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 {
 	struct fcloop_tport *tport = targetport->private;
+	unsigned long flags;
 
 	flush_work(&tport->ls_work);
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	tport->nport->tport = NULL;
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
 	fcloop_nport_put(tport->nport);
 }
 
@@ -1184,6 +1196,37 @@ __wait_localport_unreg(struct fcloop_lport *lport)
 	return ret;
 }
 
+static struct fcloop_nport *
+__fcloop_nport_lookup(u64 node_name, u64 port_name)
+{
+	struct fcloop_nport *nport;
+
+	list_for_each_entry(nport, &fcloop_nports, nport_list) {
+		if (nport->node_name != node_name ||
+		    nport->port_name != port_name)
+			continue;
+
+		if (fcloop_nport_get(nport))
+			return nport;
+
+		break;
+	}
+
+	return NULL;
+}
+
+static struct fcloop_nport *
+fcloop_nport_lookup(u64 node_name, u64 port_name)
+{
+	struct fcloop_nport *nport;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	nport = __fcloop_nport_lookup(node_name, port_name);
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	return nport;
+}
 
 static ssize_t
 fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
@@ -1365,6 +1408,8 @@ __unlink_remote_port(struct fcloop_nport *nport)
 {
 	struct fcloop_rport *rport = nport->rport;
 
+	lockdep_assert_held(&fcloop_lock);
+
 	if (rport && nport->tport)
 		nport->tport->remoteport = NULL;
 	nport->rport = NULL;
@@ -1377,9 +1422,6 @@ __unlink_remote_port(struct fcloop_nport *nport)
 static int
 __remoteport_unreg(struct fcloop_nport *nport, struct fcloop_rport *rport)
 {
-	if (!rport)
-		return -EALREADY;
-
 	return nvme_fc_unregister_remoteport(rport->remoteport);
 }
 
@@ -1387,8 +1429,8 @@ static ssize_t
 fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct fcloop_nport *nport = NULL, *tmpport;
-	static struct fcloop_rport *rport;
+	struct fcloop_nport *nport;
+	struct fcloop_rport *rport;
 	u64 nodename, portname;
 	unsigned long flags;
 	int ret;
@@ -1397,24 +1439,24 @@ fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	spin_lock_irqsave(&fcloop_lock, flags);
-
-	list_for_each_entry(tmpport, &fcloop_nports, nport_list) {
-		if (tmpport->node_name == nodename &&
-		    tmpport->port_name == portname && tmpport->rport) {
-			nport = tmpport;
-			rport = __unlink_remote_port(nport);
-			break;
-		}
-	}
+	nport = fcloop_nport_lookup(nodename, portname);
+	if (!nport)
+		return -ENOENT;
 
+	spin_lock_irqsave(&fcloop_lock, flags);
+	rport = __unlink_remote_port(nport);
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
-	if (!nport)
-		return -ENOENT;
+	if (!rport) {
+		ret = -ENOENT;
+		goto out_nport_put;
+	}
 
 	ret = __remoteport_unreg(nport, rport);
 
+out_nport_put:
+	fcloop_nport_put(nport);
+
 	return ret ? ret : count;
 }
 
@@ -1465,6 +1507,8 @@ __unlink_target_port(struct fcloop_nport *nport)
 {
 	struct fcloop_tport *tport = nport->tport;
 
+	lockdep_assert_held(&fcloop_lock);
+
 	if (tport && nport->rport)
 		nport->rport->targetport = NULL;
 	nport->tport = NULL;
@@ -1475,9 +1519,6 @@ __unlink_target_port(struct fcloop_nport *nport)
 static int
 __targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
 {
-	if (!tport)
-		return -EALREADY;
-
 	return nvmet_fc_unregister_targetport(tport->targetport);
 }
 
@@ -1485,8 +1526,8 @@ static ssize_t
 fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct fcloop_nport *nport = NULL, *tmpport;
-	struct fcloop_tport *tport = NULL;
+	struct fcloop_nport *nport;
+	struct fcloop_tport *tport;
 	u64 nodename, portname;
 	unsigned long flags;
 	int ret;
@@ -1495,24 +1536,24 @@ fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	spin_lock_irqsave(&fcloop_lock, flags);
-
-	list_for_each_entry(tmpport, &fcloop_nports, nport_list) {
-		if (tmpport->node_name == nodename &&
-		    tmpport->port_name == portname && tmpport->tport) {
-			nport = tmpport;
-			tport = __unlink_target_port(nport);
-			break;
-		}
-	}
+	nport = fcloop_nport_lookup(nodename, portname);
+	if (!nport)
+		return -ENOENT;
 
+	spin_lock_irqsave(&fcloop_lock, flags);
+	tport = __unlink_target_port(nport);
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
-	if (!nport)
-		return -ENOENT;
+	if (!tport) {
+		ret = -ENOENT;
+		goto out_nport_put;
+	}
 
 	ret = __targetport_unreg(nport, tport);
 
+out_nport_put:
+	fcloop_nport_put(nport);
+
 	return ret ? ret : count;
 }
 
@@ -1609,8 +1650,8 @@ static int __init fcloop_init(void)
 
 static void __exit fcloop_exit(void)
 {
-	struct fcloop_lport *lport = NULL;
-	struct fcloop_nport *nport = NULL;
+	struct fcloop_lport *lport;
+	struct fcloop_nport *nport;
 	struct fcloop_tport *tport;
 	struct fcloop_rport *rport;
 	unsigned long flags;
@@ -1621,7 +1662,7 @@ static void __exit fcloop_exit(void)
 	for (;;) {
 		nport = list_first_entry_or_null(&fcloop_nports,
 						typeof(*nport), nport_list);
-		if (!nport)
+		if (!nport || !fcloop_nport_get(nport))
 			break;
 
 		tport = __unlink_target_port(nport);
@@ -1629,13 +1670,19 @@ static void __exit fcloop_exit(void)
 
 		spin_unlock_irqrestore(&fcloop_lock, flags);
 
-		ret = __targetport_unreg(nport, tport);
-		if (ret)
-			pr_warn("%s: Failed deleting target port\n", __func__);
+		if (tport) {
+			ret = __targetport_unreg(nport, tport);
+			if (ret)
+				pr_warn("%s: Failed deleting target port\n", __func__);
+		}
 
-		ret = __remoteport_unreg(nport, rport);
-		if (ret)
-			pr_warn("%s: Failed deleting remote port\n", __func__);
+		if (rport) {
+			ret = __remoteport_unreg(nport, rport);
+			if (ret)
+				pr_warn("%s: Failed deleting remote port\n", __func__);
+		}
+
+		fcloop_nport_put(nport);
 
 		spin_lock_irqsave(&fcloop_lock, flags);
 	}

-- 
2.49.0


