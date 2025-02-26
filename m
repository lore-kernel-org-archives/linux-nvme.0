Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC35C021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 18:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cLmBCGQZQlXDWYg+tUH81QnE+r4Hn7sEulMNniY3J70=; b=pRKt4NDESuS9ugcSCucRk+ZQgB
	cG9WB9U5F25rOXjt6Wod7qZrIZFnKVkb8LZ1pmbUngQlEA+cQLrwH9jrXylXOgVdTRUyc3U/D2mPZ
	HCuAGd+gGn3u6xiDjC8UBtTqWmKia+3UvooyXdj40t0rgqAfs/q/2iqd7FwVyEetvnqGOvZKOv3E4
	RW+xs7VDjDA3oeGmFAcnGMUD+PxS5nM38KZm7Cb5odYKMqciCZaR/FNIqx6ZBWAmlUGRlqAqKsA1+
	j7rgxxYtiOXO1PvGoi0w113AHj1q6dZw/0WZ/OPSCwsXmZDVZbe84pvVkLskQNVXhoklIcMJBNLWd
	acggjbdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMQ3-000000050BP-490M;
	Wed, 26 Feb 2025 18:46:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMQ1-0000000508K-2gEr
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 18:46:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B08ED5C74A6;
	Wed, 26 Feb 2025 18:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1380DC4CED6;
	Wed, 26 Feb 2025 18:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595564;
	bh=FE28cHM2Xu+6IwRPzQpF/Y9BjWJU8LBOSYm56nzMorc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LHSb4t8WjHOe36CjKcO4O8TgvN3XrISVlK3/CrJH1N++dPJKNjBlGGu7LO0cQ/eRU
	 BsAe+XJWUk1GORxjKthDQ+iHO1uxT8ZfYonEtkziW3IrhbBLfcZYk1JEs5Atf5wIuH
	 Oj1yEX6/fF8DNrZ3Nosk0hT7L+3E/hTBgh+jgR/0tx9qk/sG6eHgY9yd3P7jwat94J
	 fD2FlMy2uqAwONvzEcZOxLL2lPxUFtp8UVR/Hr5Ht1QldylfATd2h06BC+5PHaiCSz
	 U603RnIaK+cJ4xuLTsDpn3dkVtpPib5h88OmfPiIKSrqBjxADZmwnUwwoAvyIe7wWz
	 fhCmRkY59oXDA==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 26 Feb 2025 19:45:55 +0100
Subject: [PATCH 03/11] nvmet-fcloop: refactor fcloop_nport_alloc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-nvmet-fcloop-v1-3-c0bd83d43e6a@kernel.org>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_104605_769899_8D2E8559 
X-CRM114-Status: GOOD (  17.26  )
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
lport and nport are ref counted it's possible to only use for the list
insert and lookup the spin lock.

This allows us to untangle the setup steps into a more linear form which
reduces the complexity of the functions.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 156 +++++++++++++++++++++++--------------------
 1 file changed, 84 insertions(+), 72 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index ca46830d46ecbaae21f3ee3e69aa7d52905abcae..de1963c34bd88d0335f70de569565740fd395a0a 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1038,6 +1038,8 @@ fcloop_nport_free(struct kref *ref)
 	list_del(&nport->nport_list);
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
+	if (nport->lport)
+		fcloop_lport_put(nport->lport);
 	kfree(nport);
 }
 
@@ -1206,33 +1208,63 @@ __wait_localport_unreg(struct fcloop_lport *lport)
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
 
@@ -1245,9 +1277,9 @@ fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
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
@@ -1261,79 +1293,59 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
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
-	kref_init(&newnport->ref);
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
+		kref_init(&nport->ref);
 
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


