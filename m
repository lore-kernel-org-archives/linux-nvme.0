Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62421C35FFA
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 10:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PuAJDNQRHiMHsEB1n6F21kIGnQ+3gAOnWOq/U0jkd68=; b=HToWofBsdnLS7K7COtBUwiGeFU
	kOxy+OA/IKd3lrZ8jZL65ei8yStmA0KTkF+8SoBmweYk5Amd9GTa8JS2wG0Km96O5UKpbZ4Ep3iMf
	nhtiZ3TW/59b+lzmR7gCSW+2at/8YqhYA2Iz+3y5C2IF8O7h3XU3Ft7wH3eJgTsRbb7O613b9CkCH
	go5zHXLliZ1OMzConp17h1WPPWYxzuvqHN71UsLE4K1U7QsGntg9a4IM8E2u8sgTu48CrwQKUNKfh
	0y0GkzK+TduSaY8yiE8taf98BsC7Yp1ivnOkJ9DzkBr8pFfZ/5NJ9PprKrQbokTW86OHhtnM0VjRI
	w7w7fZHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUMr-00000005XnC-37iQ;
	Tue, 18 Mar 2025 10:40:17 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUMn-00000005XjN-2d4D
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 10:40:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5C55EA48F39;
	Tue, 18 Mar 2025 10:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C685C4CEE3;
	Tue, 18 Mar 2025 10:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294412;
	bh=yMhSDrs3OiLFh+mK5j0FzUg7VsoUovJKryyHxS+INUU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fPsuboOVKslLPgTAgxZ779BswT1cTdehAkdxevcfqLDLOrPxN0uoHU3nNrXFJYtwP
	 CIwNKmvJWM00qrGz4p7r9okxoAebt2scrcNXXKJWurc9jCcRVkUMlGrOxBe9i1JHZp
	 2rTkuR/3T2fxyF9Snznsr8JQSTpiTtXJ/ORRVNdT8nIu53Fi9j9AD9IRRwOfGEGC9f
	 x3xAj3+sCWhD/uZK8dKsG7dKuEWJrH7ntlcBH2Lwd0D4l0CnghOJ/r6RTbENyoXSt8
	 6n4YNxphwT+Hgglsiw3FOIZR3j2lYxphPXshz1KMJfw7dRHbfoJZAVzTJ+0gzBH9nT
	 bicPEor6TQltQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:39:58 +0100
Subject: [PATCH v3 04/18] nvmet-fcloop: refactor fcloop_nport_alloc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-4-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_034013_807979_AF310D8D 
X-CRM114-Status: GOOD (  17.14  )
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

There are many different operations done under the spin lock. Since the
lport and nport are ref counted it's possible to use the spin lock only
for the list insert and lookup.

This allows us to untangle the setup steps into a more linear form which
reduces the complexity of the functions.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 156 +++++++++++++++++++++++--------------------
 1 file changed, 84 insertions(+), 72 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index c6d5a31ce0b5ccb10988e339ae22d528e06d5e2b..245bfe08d91ec81f1979251e8c757a0d46fd09e9 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1027,6 +1027,8 @@ fcloop_nport_put(struct fcloop_nport *nport)
 	list_del(&nport->nport_list);
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
+	if (nport->lport)
+		fcloop_lport_put(nport->lport);
 	kfree(nport);
 }
 
@@ -1189,33 +1191,63 @@ __wait_localport_unreg(struct fcloop_lport *lport)
 	return ret;
 }
 
+static struct fcloop_lport *
+fcloop_lport_lookup(u64 node_name, u64 port_name)
+{
+	struct fcloop_lport *lp, *lport = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	list_for_each_entry(lp, &fcloop_lports, lport_list) {
+		if (lp->localport->node_name != node_name ||
+		    lp->localport->port_name != port_name)
+			continue;
+
+		if (fcloop_lport_get(lp))
+			lport = lp;
+
+		break;
+	}
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	return lport;
+}
+
+static struct fcloop_nport *
+fcloop_nport_lookup(u64 node_name, u64 port_name)
+{
+	struct fcloop_nport *np, *nport = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	list_for_each_entry(np, &fcloop_nports, nport_list) {
+		if (np->node_name != node_name ||
+		    np->port_name != port_name)
+			continue;
+
+		if (fcloop_nport_get(np))
+			nport = np;
+
+		break;
+	}
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	return nport;
+}
 
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
 
@@ -1228,9 +1260,9 @@ fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
 static struct fcloop_nport *
 fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
 {
-	struct fcloop_nport *newnport, *nport = NULL;
-	struct fcloop_lport *tmplport, *lport = NULL;
 	struct fcloop_ctrl_options *opts;
+	struct fcloop_nport *nport;
+	struct fcloop_lport *lport;
 	unsigned long flags;
 	u32 opts_mask = (remoteport) ? RPORT_OPTS : TGTPORT_OPTS;
 	int ret;
@@ -1244,79 +1276,59 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
 		goto out_free_opts;
 
 	/* everything there ? */
-	if ((opts->mask & opts_mask) != opts_mask) {
-		ret = -EINVAL;
+	if ((opts->mask & opts_mask) != opts_mask)
 		goto out_free_opts;
-	}
 
-	newnport = kzalloc(sizeof(*newnport), GFP_KERNEL);
-	if (!newnport)
+	lport = fcloop_lport_lookup(opts->wwnn, opts->wwpn);
+	if (lport) {
+		/* invalid configuration */
+		fcloop_lport_put(lport);
 		goto out_free_opts;
+	}
 
-	INIT_LIST_HEAD(&newnport->nport_list);
-	newnport->node_name = opts->wwnn;
-	newnport->port_name = opts->wwpn;
-	if (opts->mask & NVMF_OPT_ROLES)
-		newnport->port_role = opts->roles;
-	if (opts->mask & NVMF_OPT_FCADDR)
-		newnport->port_id = opts->fcaddr;
-	refcount_set(&newnport->ref, 1);
+	nport = fcloop_nport_lookup(opts->wwnn, opts->wwpn);
+	if (nport && ((remoteport && nport->rport) ||
+		      (!remoteport && nport->tport))) {
+		/* invalid configuration */
+		goto out_put_nport;
+	}
 
-	spin_lock_irqsave(&fcloop_lock, flags);
+	if (!nport) {
+		nport = kzalloc(sizeof(*nport), GFP_KERNEL);
+		if (!nport)
+			goto out_free_opts;
 
-	list_for_each_entry(tmplport, &fcloop_lports, lport_list) {
-		if (tmplport->localport->node_name == opts->wwnn &&
-		    tmplport->localport->port_name == opts->wwpn)
-			goto out_invalid_opts;
+		INIT_LIST_HEAD(&nport->nport_list);
+		nport->node_name = opts->wwnn;
+		nport->port_name = opts->wwpn;
+		refcount_set(&nport->ref, 1);
 
-		if (tmplport->localport->node_name == opts->lpwwnn &&
-		    tmplport->localport->port_name == opts->lpwwpn)
-			lport = tmplport;
+		spin_lock_irqsave(&fcloop_lock, flags);
+		list_add_tail(&nport->nport_list, &fcloop_nports);
+		spin_unlock_irqrestore(&fcloop_lock, flags);
 	}
 
+	if (opts->mask & NVMF_OPT_ROLES)
+		nport->port_role = opts->roles;
+	if (opts->mask & NVMF_OPT_FCADDR)
+		nport->port_id = opts->fcaddr;
+
 	if (remoteport) {
+		lport = fcloop_lport_lookup(opts->lpwwnn, opts->lpwwpn);
 		if (!lport)
-			goto out_invalid_opts;
-		newnport->lport = lport;
-	}
-
-	list_for_each_entry(nport, &fcloop_nports, nport_list) {
-		if (nport->node_name == opts->wwnn &&
-		    nport->port_name == opts->wwpn) {
-			if ((remoteport && nport->rport) ||
-			    (!remoteport && nport->tport)) {
-				nport = NULL;
-				goto out_invalid_opts;
-			}
-
-			fcloop_nport_get(nport);
+			goto out_put_nport;
 
-			spin_unlock_irqrestore(&fcloop_lock, flags);
-
-			if (remoteport)
-				nport->lport = lport;
-			if (opts->mask & NVMF_OPT_ROLES)
-				nport->port_role = opts->roles;
-			if (opts->mask & NVMF_OPT_FCADDR)
-				nport->port_id = opts->fcaddr;
-			goto out_free_newnport;
-		}
+		nport->lport = lport;
 	}
 
-	list_add_tail(&newnport->nport_list, &fcloop_nports);
-
-	spin_unlock_irqrestore(&fcloop_lock, flags);
-
 	kfree(opts);
-	return newnport;
+	return nport;
 
-out_invalid_opts:
-	spin_unlock_irqrestore(&fcloop_lock, flags);
-out_free_newnport:
-	kfree(newnport);
+out_put_nport:
+	fcloop_nport_put(nport);
 out_free_opts:
 	kfree(opts);
-	return nport;
+	return NULL;
 }
 
 static ssize_t

-- 
2.48.1


