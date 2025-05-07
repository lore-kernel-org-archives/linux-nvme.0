Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0287DC3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 12:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/GRX5Bw1Qi97mlq0KOuGehDr8XaaA7nyrO2rQWBeqX8=; b=IMal9CsXXuhKUpqne4al9hqruO
	70X6gVuFjn201ZDDAeEw1o7AmtqPld6Qm0ApUSCu689Q+F4XfQjrwNsd31qam426PiPxJ3MxnIU0M
	f4N+cNIjZG39liL0drRrYHjOL0Z5dZN5t/vMuUHv6rXI6vlE6oe0PwwbavlldlSRg/Gu4u6ESI2Lo
	5bOuALFiz4/vX/tgu5uWRd13jwCxLCIx8pViTV6AEISyewEFwCbhzZN77Rl1NW3JDr9cIeqHnliC4
	Ej9r9EeSOdoN+dguVyL8FXHGxXDq3h7j8H4/BUEsIrUEQ7DTihbgouXR00DVVsIq48dsjV+0gPaHB
	LA7gzoJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdnt-0000000FMpX-1gF4;
	Wed, 07 May 2025 12:23:13 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdnr-0000000FMos-41ru
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 12:23:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5DABE629D5;
	Wed,  7 May 2025 12:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF540C4CEE7;
	Wed,  7 May 2025 12:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746620591;
	bh=WIyTwsTJp2Ocp62+fElWZqeO7HPFddxPBlIHu9Wp5HQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MfXOhlrJ8/WI8Pe0tCtfCkOX3rzP4GKs5T88RZ8dBczSJFr/akF5FojaCTP/cgPDY
	 CEjTxi7YJvXE01A21awPalFxjxMoJqD5QNkVWzXdBu+ASplCWZS7wmyLdG8i0hhQua
	 6rPwv/zeyCbrtNFUocVCttyDcRGDZNQpKh8aVLt+al+YBOckefvJJ3/JjP+gKXvTXj
	 bVw/gVVPC+1NbzSqeE5vmLbLrMmpSORxoxZ0OrMquddVTJ0ojqYonE6xDCLrUAUEwk
	 6LaZiNb/C/sTwm3x1bRwVMYx+v/VnXh4FyVjnY+wC/2AWjSMoQqVesODZe5WltnVay
	 x/P/pvx+nH12Q==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 07 May 2025 14:22:59 +0200
Subject: [PATCH v6 03/14] nvmet-fcloop: refactor fcloop_nport_alloc and
 track lport
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-nvmet-fcloop-v6-3-ca02e16fb018@kernel.org>
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

The checks for a valid input values are mixed with the logic to insert a
newly allocated nport. Refactor the function so that first the checks
are done.

This allows to untangle the setup steps into a more linear form which
reduces the complexity of the functions.

Also start tracking lport when a lport is assigned to a nport. This
ensures, that the lport is not going away as long it is still referenced
by a nport.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 107 ++++++++++++++++++++++++++-----------------
 1 file changed, 64 insertions(+), 43 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 2cce7649af276528360395b6d58f03183c11da20..a8134127ad8087190d674251a88545da3f8800d7 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1028,6 +1028,9 @@ fcloop_nport_put(struct fcloop_nport *nport)
 	list_del(&nport->nport_list);
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
+	if (nport->lport)
+		fcloop_lport_put(nport->lport);
+
 	kfree(nport);
 }
 
@@ -1234,6 +1237,25 @@ fcloop_nport_lookup(u64 node_name, u64 port_name)
 	return nport;
 }
 
+static struct fcloop_lport *
+__fcloop_lport_lookup(u64 node_name, u64 port_name)
+{
+	struct fcloop_lport *lport;
+
+	list_for_each_entry(lport, &fcloop_lports, lport_list) {
+		if (lport->localport->node_name != node_name ||
+		    lport->localport->port_name != port_name)
+			continue;
+
+		if (fcloop_lport_get(lport))
+			return lport;
+
+		break;
+	}
+
+	return NULL;
+}
+
 static ssize_t
 fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
@@ -1272,8 +1294,8 @@ fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
 static struct fcloop_nport *
 fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
 {
-	struct fcloop_nport *newnport, *nport = NULL;
-	struct fcloop_lport *tmplport, *lport = NULL;
+	struct fcloop_nport *newnport, *nport;
+	struct fcloop_lport *lport;
 	struct fcloop_ctrl_options *opts;
 	unsigned long flags;
 	u32 opts_mask = (remoteport) ? RPORT_OPTS : TGTPORT_OPTS;
@@ -1288,10 +1310,8 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
 		goto out_free_opts;
 
 	/* everything there ? */
-	if ((opts->mask & opts_mask) != opts_mask) {
-		ret = -EINVAL;
+	if ((opts->mask & opts_mask) != opts_mask)
 		goto out_free_opts;
-	}
 
 	newnport = kzalloc(sizeof(*newnport), GFP_KERNEL);
 	if (!newnport)
@@ -1307,60 +1327,61 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
 	refcount_set(&newnport->ref, 1);
 
 	spin_lock_irqsave(&fcloop_lock, flags);
-
-	list_for_each_entry(tmplport, &fcloop_lports, lport_list) {
-		if (tmplport->localport->node_name == opts->wwnn &&
-		    tmplport->localport->port_name == opts->wwpn)
-			goto out_invalid_opts;
-
-		if (tmplport->localport->node_name == opts->lpwwnn &&
-		    tmplport->localport->port_name == opts->lpwwpn)
-			lport = tmplport;
+	lport = __fcloop_lport_lookup(opts->wwnn, opts->wwpn);
+	if (lport) {
+		/* invalid configuration */
+		fcloop_lport_put(lport);
+		goto out_free_newnport;
 	}
 
 	if (remoteport) {
-		if (!lport)
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
-
-			spin_unlock_irqrestore(&fcloop_lock, flags);
-
-			if (remoteport)
-				nport->lport = lport;
-			if (opts->mask & NVMF_OPT_ROLES)
-				nport->port_role = opts->roles;
-			if (opts->mask & NVMF_OPT_FCADDR)
-				nport->port_id = opts->fcaddr;
+		lport = __fcloop_lport_lookup(opts->lpwwnn, opts->lpwwpn);
+		if (!lport) {
+			/* invalid configuration */
 			goto out_free_newnport;
 		}
 	}
 
-	list_add_tail(&newnport->nport_list, &fcloop_nports);
+	nport = __fcloop_nport_lookup(opts->wwnn, opts->wwpn);
+	if (nport) {
+		if ((remoteport && nport->rport) ||
+		    (!remoteport && nport->tport)) {
+			/* invalid configuration */
+			goto out_put_nport;
+		}
 
+		/* found existing nport, discard the new nport */
+		kfree(newnport);
+	} else {
+		list_add_tail(&newnport->nport_list, &fcloop_nports);
+		nport = newnport;
+	}
+
+	if (opts->mask & NVMF_OPT_ROLES)
+		nport->port_role = opts->roles;
+	if (opts->mask & NVMF_OPT_FCADDR)
+		nport->port_id = opts->fcaddr;
+	if (lport) {
+		if (!nport->lport)
+			nport->lport = lport;
+		else
+			fcloop_lport_put(lport);
+	}
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
 	kfree(opts);
-	return newnport;
+	return nport;
 
-out_invalid_opts:
-	spin_unlock_irqrestore(&fcloop_lock, flags);
+out_put_nport:
+	if (lport)
+		fcloop_lport_put(lport);
+	fcloop_nport_put(nport);
 out_free_newnport:
+	spin_unlock_irqrestore(&fcloop_lock, flags);
 	kfree(newnport);
 out_free_opts:
 	kfree(opts);
-	return nport;
+	return NULL;
 }
 
 static ssize_t

-- 
2.49.0


