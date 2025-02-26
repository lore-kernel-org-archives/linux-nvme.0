Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3EDC19776
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BBX1TlICFaSDasc43xNgc6kZU8wBmUyBPhnGoWCBxK4=; b=QOpUpwlO4qsdrsXWaYRx0Zbo2I
	pJZfDvwx1ESxf3rcJl0UbdL2X3CEpk68dShFNAxaKSZOB1SgXzrstLcrh3xo3gVc9ZoLqp1c4zPF+
	G9zOTWDc5iPrBu/RRkMEq26MhWyc3MXR3JPIrgPA1MSydO+W4LGpdX3Lbh8ifLmH8sVsOMZ/7PeT9
	Vq2PWfMGr1xectGEJ9Bp99jIzceiowkQanSy2KTjZbhysUwQphtFVsR2o4rXnrQq2Vb1B4rFdISMe
	+EeIegLB0tvvQbl7vqkt1HStOjKnlMsqwPwcDqiNLl7+ewkVXFZ4r+tfqPsWHQ17gwYiP68WodhuT
	AIJmZkPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMQ8-000000050GO-0aeB;
	Wed, 26 Feb 2025 18:46:12 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMQ6-000000050Ea-2A2J
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 18:46:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0F8DF61518;
	Wed, 26 Feb 2025 18:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F5AC4CED6;
	Wed, 26 Feb 2025 18:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595569;
	bh=gdFyyvV3CV/ZqFGdzKB4cfzAhMwvR9qpkHzsViZuBwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AGpRrc29TsfXPoD+d4Y4asIqjRm2j2QzRzi+azZgP3pKM8/h/fwIDmznZd95p0+Vh
	 FmlNGR31+G47egARQWq4/F9sMWvyhK2G8DxAAdapPdYN5XgMW6Zc46+lcRHTBxJzwP
	 VXLmQpZQpfwT4carjghoGjaVLQx5az0Uf3MFXHTHL7XEO6jGsWMAzO6iQTaToxUaUF
	 qZChoyjb6bXiA1pL+xkuAgWSMyFmXQUJsnxuDnCtrGC7MvJOV2hbLww0/s6ifX1dR0
	 QyUJutZ2UYcr3kBhW+wkNZN92DTE7LdZSY8zyICNF+Fq4R04ytbt7l6F1D1Vu4gJhJ
	 I6lIvqpdjz1+Q==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 26 Feb 2025 19:45:57 +0100
Subject: [PATCH 05/11] nvmet-fcloop: track tport with ref counting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-nvmet-fcloop-v1-5-c0bd83d43e6a@kernel.org>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
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

The tport object is created via nvmet_fc_register_targetport and freed
via nvmet_fc_unregister_targetport. That means after the port is
unregistered nothing should use it. Thus ensure with refcounting
that there is no user left before the unregister step.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 52 +++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 80693705c069dd114b2d4f15d0482dd2d713a273..2269b4d20af2ef9bb423617b94a5f5326ea124bd 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -233,8 +233,12 @@ struct fcloop_tport {
 	spinlock_t			lock;
 	struct list_head		ls_list;
 	struct work_struct		ls_work;
+	struct kref			ref;
 };
 
+static int fcloop_tport_get(struct fcloop_tport *tport);
+static void fcloop_tport_put(struct fcloop_tport *tport);
+
 struct fcloop_nport {
 	struct fcloop_rport *rport;
 	struct fcloop_tport *tport;
@@ -426,6 +430,7 @@ fcloop_tport_lsrqst_work(struct work_struct *work)
 		spin_lock(&tport->lock);
 	}
 	spin_unlock(&tport->lock);
+	fcloop_tport_put(tport);
 }
 
 static int
@@ -444,12 +449,16 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 	tls_req->lsreq = lsreq;
 	INIT_LIST_HEAD(&tls_req->ls_list);
 
+	if (!tport)
+		return -ECONNABORTED;
+
 	if (!tport->remoteport) {
 		tls_req->status = -ECONNREFUSED;
 		spin_lock(&tport->lock);
 		list_add_tail(&tls_req->ls_list, &tport->ls_list);
 		spin_unlock(&tport->lock);
-		queue_work(nvmet_wq, &tport->ls_work);
+		if (queue_work(nvmet_wq, &tport->ls_work))
+			fcloop_tport_get(tport);
 		return ret;
 	}
 
@@ -481,7 +490,8 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 		spin_lock(&tport->lock);
 		list_add_tail(&tport->ls_list, &tls_req->ls_list);
 		spin_unlock(&tport->lock);
-		queue_work(nvmet_wq, &tport->ls_work);
+		if (queue_work(nvmet_wq, &tport->ls_work))
+			fcloop_tport_get(tport);
 	}
 
 	return 0;
@@ -1496,6 +1506,8 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
 
 	/* success */
 	tport = targetport->private;
+	kref_init(&tport->ref);
+
 	tport->targetport = targetport;
 	tport->remoteport = (nport->rport) ?  nport->rport->remoteport : NULL;
 	if (nport->rport)
@@ -1526,21 +1538,30 @@ __unlink_target_port(struct fcloop_nport *nport)
 	return tport;
 }
 
-static int
-__targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
+static void
+fcloop_targetport_unreg(struct kref *ref)
 {
-	int ret;
+	struct fcloop_tport *tport =
+		container_of(ref, struct fcloop_tport, ref);
+	struct fcloop_nport *nport;
 
-	if (!tport) {
-		ret = -EALREADY;
-		goto out;
-	}
+	nport = tport->nport;
+	nvmet_fc_unregister_targetport(tport->targetport);
 
-	ret = nvmet_fc_unregister_targetport(tport->targetport);
-out:
 	/* nport ref put: targetport */
 	fcloop_nport_put(nport);
-	return ret;
+}
+
+static int
+fcloop_tport_get(struct fcloop_tport *tport)
+{
+	return kref_get_unless_zero(&tport->ref);
+}
+
+static void
+fcloop_tport_put(struct fcloop_tport *tport)
+{
+	kref_put(&tport->ref, fcloop_targetport_unreg);
 }
 
 static ssize_t
@@ -1576,8 +1597,7 @@ fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
 	if (!nport)
 		return -ENOENT;
 
-	ret = __targetport_unreg(nport, tport);
-
+	fcloop_tport_put(tport);
 	fcloop_nport_put(nport);
 
 	return ret ? ret : count;
@@ -1696,9 +1716,7 @@ static void __exit fcloop_exit(void)
 
 		spin_unlock_irqrestore(&fcloop_lock, flags);
 
-		ret = __targetport_unreg(nport, tport);
-		if (ret)
-			pr_warn("%s: Failed deleting target port\n", __func__);
+		fcloop_tport_put(tport);
 
 		ret = __remoteport_unreg(nport, rport);
 		if (ret)

-- 
2.48.1


