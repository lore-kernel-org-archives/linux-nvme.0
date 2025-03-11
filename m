Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE527C28B30
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 10:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2rt6LJ+86lfJWxcUir29SO+qegLo/CQfnAWjVR+M0Y4=; b=nOp7ctH4w7Ev4ku8v4lTQhisHA
	RLZKcnA7Eihy7HhRI5fP/d8j6zLO83fhfol65QuSjKxwLGjI5w4RePSecZlVQKWddWTHMS487to7c
	vp6CuFP+5j976r7xj8CuChdabueVb2RD9crnSZ/mXdPxmXRBehaKXFFEbRWThlf+Mld4eEsK+JQ9t
	wwhyzCGEhTjnT7sf0GFwsonplLN6YweGYA+DR3S8e7VwJX2mzku3T0CcYa6w8aWIhijJR1EsvJfI4
	194zX05nMF9jA0guKNDrr1vX1imxlpOyzhw2SKx7RQJVpendH0SVDivROSR+Aab6g1b6hI59D9CG7
	bgLMpEFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trwaY-00000005G78-406f;
	Tue, 11 Mar 2025 10:11:54 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trwaW-00000005G4i-2GMr
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 10:11:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B3A69A46A5A;
	Tue, 11 Mar 2025 10:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28607C4CEED;
	Tue, 11 Mar 2025 10:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687911;
	bh=ttHsf1Cp3kWkMpKs7Yki9ujpeh8h5ibAcZN4inUerX8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PdI5AykA3Sz5ZzViY4Mh2sRv14UEcF6FBrDx0lkqv/L1OD8FmTjV66KFLoj2LzbEO
	 4kj3Xta3m5GaHaKLsnujVRY/H/s6h/TkmY3SjVLfuCn1ESSG74DdGAmm+U8sTTV97q
	 49mVTCLaFKxxmJNO1eb97kitxXijutyTpCjHbJ96GtpjwRmiRUuBwfAdfdYI2Fagpm
	 mAaHGs6Gt+I6G5o4nfn760T0gHJOpxbkvly4mIF4xGvovlT7Lmj0c/SYG1jK6pUgV7
	 5r4gLfN4Q8lVhnvraYUQCnUBn4gU9NI1PppLFfP7jm7ygbAHo3pxThh65bBfLzmlQC
	 JObIiJihebE/g==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:30 +0100
Subject: [PATCH v2 04/15] nvmet-fcloop: refactor fcloop_nport_alloc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-4-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_031152_709945_AC792A91 
X-CRM114-Status: GOOD (  17.01  )
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
index f02b5d7d9d56f1c91ea8ace254a51654777968b3..6e5408d59141158059cfe6b74c0924763c0c6b1d 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1028,6 +1028,8 @@ fcloop_nport_put(struct fcloop_nport *nport)
 	list_del(&nport->nport_list);
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
+	if (nport->lport)
+		fcloop_lport_put(nport->lport);
 	kfree(nport);
 }
 
@@ -1190,33 +1192,63 @@ __wait_localport_unreg(struct fcloop_lport *lport)
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
 
@@ -1229,9 +1261,9 @@ fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
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
@@ -1245,79 +1277,59 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
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


