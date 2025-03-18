Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA04C35FFB
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 10:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UrBL/aSVbcxbt0rb4qizFw2i+VjqeOCxSQQXKeTirtE=; b=ub1yCvjiCkIE01+FrkT9o7J2XG
	0/yFG24DPL9Ewbg1d8CuZTWGXKRM7oozbUMUa4MhEdAKSu3NVms7AHrWAL4C50A5Hv5zZFt+VeKQr
	4B8y2S2NQsfytyu2quWrQ+yuvn/oIa/IhLm56oLf/b8/hhHZaGFehWoxsmBddnFWOXVfcXqO3msYt
	4boA0fgdEU2OuNB28sIZpxEaCRzvTioDXm0vwxC026iuSI81HIrkPQgGZ4zoRiFt+XVxcBo1BUOmg
	w0wtEyLrv+iPc8zs67FaBRZ8ioSnVyocPE4Kkx5QK0Vv1bH9WtRGLbF+99wlxwzrtRMcBfTi/L8BH
	e2Q5nz3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUMt-00000005Xoi-0X2d;
	Tue, 18 Mar 2025 10:40:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUMp-00000005XlI-30sX
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 10:40:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5412B5C58A1;
	Tue, 18 Mar 2025 10:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71F5C4CEDD;
	Tue, 18 Mar 2025 10:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294415;
	bh=nE75BNgsWEd3wOhWskr3tujrO/j2HRVbU7VVwxBCnRA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jM8uVMWfuJ/wmzcBHIb9WMzbiam2ts8QahN2AOWFbMjeNDN9oeI7iSK26enyzoa78
	 EBilcR6XCgKEcqf+r2YoITjHIZFvD9hB17IZMRpip41z/fk1eWs0K9zRSz8AZ5XHmJ
	 kYH/6oSSgDXNtymA0dfHYYi/q2XVD9VvXH/1BK5JgLCMtDO83RcmI4a7Hbrg39B+H4
	 ni6oU3uWbvn03KwWgy4Zgr8wVCAubOEWhd515Bgi9AQgq2Ma8jTqPfrNSNXS06edo7
	 Z5b5nJBE6s93fjK+u1qvWtrhnddTxTaSuTaEkoPHSlKv9I4Enq7BR4bCjSkWcr7ddM
	 FfGWAESUTq50g==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:39:59 +0100
Subject: [PATCH v3 05/18] nvmet-fcloop: track ref counts for nports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-5-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_034015_854962_89741428 
X-CRM114-Status: GOOD (  16.15  )
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
 drivers/nvme/target/fcloop.c | 106 +++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 43 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 245bfe08d91ec81f1979251e8c757a0d46fd09e9..69121a5f0f280936d1b720e9e994d6e5eb9186ff 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1054,8 +1054,15 @@ static void
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
+	/* nport ref put: rport */
 	fcloop_nport_put(rport->nport);
 }
 
@@ -1063,8 +1070,15 @@ static void
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
+	/* nport ref put: tport */
 	fcloop_nport_put(tport->nport);
 }
 
@@ -1341,6 +1355,7 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
 	struct nvme_fc_port_info pinfo;
 	int ret;
 
+	/* nport ref get: rport */
 	nport = fcloop_alloc_nport(buf, count, true);
 	if (!nport)
 		return -EIO;
@@ -1382,6 +1397,8 @@ __unlink_remote_port(struct fcloop_nport *nport)
 {
 	struct fcloop_rport *rport = nport->rport;
 
+	lockdep_assert_held(&fcloop_lock);
+
 	if (rport && nport->tport)
 		nport->tport->remoteport = NULL;
 	nport->rport = NULL;
@@ -1392,9 +1409,6 @@ __unlink_remote_port(struct fcloop_nport *nport)
 static int
 __remoteport_unreg(struct fcloop_nport *nport, struct fcloop_rport *rport)
 {
-	if (!rport)
-		return -EALREADY;
-
 	return nvme_fc_unregister_remoteport(rport->remoteport);
 }
 
@@ -1402,8 +1416,8 @@ static ssize_t
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
@@ -1412,24 +1426,24 @@ fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
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
 
@@ -1443,6 +1457,7 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
 	struct nvmet_fc_port_info tinfo;
 	int ret;
 
+	/* nport ref get: tport */
 	nport = fcloop_alloc_nport(buf, count, false);
 	if (!nport)
 		return -EIO;
@@ -1480,6 +1495,8 @@ __unlink_target_port(struct fcloop_nport *nport)
 {
 	struct fcloop_tport *tport = nport->tport;
 
+	lockdep_assert_held(&fcloop_lock);
+
 	if (tport && nport->rport)
 		nport->rport->targetport = NULL;
 	nport->tport = NULL;
@@ -1490,9 +1507,6 @@ __unlink_target_port(struct fcloop_nport *nport)
 static int
 __targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
 {
-	if (!tport)
-		return -EALREADY;
-
 	return nvmet_fc_unregister_targetport(tport->targetport);
 }
 
@@ -1500,8 +1514,8 @@ static ssize_t
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
@@ -1510,24 +1524,24 @@ fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
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
 
@@ -1624,8 +1638,8 @@ static int __init fcloop_init(void)
 
 static void __exit fcloop_exit(void)
 {
-	struct fcloop_lport *lport = NULL;
-	struct fcloop_nport *nport = NULL;
+	struct fcloop_lport *lport;
+	struct fcloop_nport *nport;
 	struct fcloop_tport *tport;
 	struct fcloop_rport *rport;
 	unsigned long flags;
@@ -1636,7 +1650,7 @@ static void __exit fcloop_exit(void)
 	for (;;) {
 		nport = list_first_entry_or_null(&fcloop_nports,
 						typeof(*nport), nport_list);
-		if (!nport)
+		if (!nport || !fcloop_nport_get(nport))
 			break;
 
 		tport = __unlink_target_port(nport);
@@ -1644,13 +1658,19 @@ static void __exit fcloop_exit(void)
 
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
2.48.1


